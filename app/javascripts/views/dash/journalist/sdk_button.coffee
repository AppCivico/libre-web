# requires
Config = require 'config.coffee'
ViewBase = require 'views/base.coffee'
ButtonView = require 'views/button.coffee'
LoadingView = require 'views/loading.coffee'


module.exports = class extends ViewBase
  el: 'section#dash-main'

  # setting template
  template: 'templates/dash/journalist/sdk_button.eco'

  # loading
  loading: new LoadingView

  model: new Backbone.Model()

  # ui elements
  ui:
    'form': 'form#button-form'
    'code': 'div#code-preview'
    'button': 'input#btn-code-gen'

    'buttonSize': 'select#btn-height'
    'buttonTheme': 'select#btn-style'
    'btnPreview': '#btn-preview'

  # events
  events:
    'submit form#button-form': 'generateCode'
    'click input#btn-code-gen': 'generateCode'
    'change input#btn-height' : 'onChangeInputForm'
    'change select#btn-style' : 'onChangeInputForm'

  # event for change input data using
  onChangeInputForm: (event) ->
    event.preventDefault()
    field = event.currentTarget
    @model.set field.id, field.value

    btnPreview = @getUI('btnPreview')
    if field.id == 'btn-height'
      if field.value <= field.max and field.value >= field.min
        btnPreview.attr 'height', field.value
    else if field.id == 'btn-style'
      if field.value == 'black-fg'
        btnPreview.attr 'src', btnPreview.data 'src-'+field.value
      else if field.value == 'white-fg'
        btnPreview.attr 'src', btnPreview.data 'src-'+field.value
      else
        btnPreview.attr 'src', btnPreview.data 'src-default'


  # generate code event
  generateCode: (event) ->
    event.prenventDefault
    @model.set @buttonParams().toJSON()

    @btn = new ButtonView el: @getUI('button')
    @btn.state 'loading', { label: 'Gerando...' }
    setTimeout =>
      @showCode()
    , 500


  # show button code
  showCode: (data = {}) ->
    $el = @getUI('code')
    $codeContainer = $el.find('#codigo')

    # setting session info for model
    s = @session.get() or {}
    @model.set 'user_id', s.user_id || 0

    code = """
      <!-- carrega o libre sdk -->
      <div id="lbr-root"></div>
      <script>(function(d, s, id) {
        var js, ljs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "#{Backbone.Config.env().url_base}/sdk/libre.js#v1.0;";
        ljs.parentNode.insertBefore(js, ljs);
      }(document, 'script', 'libre-sdk'));
      </script>

      <!-- adiciona o botão do libre -->
      <div class="lbr-button"
        data-id="#{@model.get('user_id')}"
        data-style="#{@model.get('style')}"
        data-height="#{@model.get('height')}"
      ></div>
    """

    $el.removeClass 'hide'

    # escape html
    code = code.replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')

    # add code and reload pretty print
    if $codeContainer?
      $codeContainer.html('')
      $codeContainer.append code

      $codeContainer.on 'focus', ->
        this.select()

    # reset button state
    @btn.state 'loaded'


  # event on render
  onRender: ->
    # FIXME: fadein()
    @loading.hide()


  buttonParams: ->
    form = @getUI('form')
    return @params(form).permit 'height', 'style'
