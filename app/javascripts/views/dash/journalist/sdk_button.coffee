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


  # events
  events:
    'click input#btn-code-gen': 'generateCode'

  # event for change input data using
  onChangeInputForm: (event) ->
    event.preventDefault()
    field = event.currentTarget
    @model.set field.id, field.value


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
    $codeContainer = $el.find('pre#codigo')

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
        js.src = "//dev.midialibre.org/sdk/libre.js#v1.0;";
        ljs.parentNode.insertBefore(js, ljs);
      }(document, 'script', 'libre-sdk'));
      </script>

      <!-- adiciona o botão do libre -->
      <div class="lbr-button"
        data-id="#{@model.get('user_id')}"
        data-location="#{@model.get('website')}"
        data-theme="#{@model.get('aparencia')}"
        data-size="#{@model.get('tamanho')}">
      </div>
    """

    $el.removeClass 'hide'

    # escape html
    code = code.replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')

    # add code and reload pretty print
    if $codeContainer?
      $codeContainer.html('')
        .removeClass('prettyprinted')

      $codeContainer.append code
      PR.prettyPrint()

    # reset button state
    @btn.state 'loaded'


  # event on render
  onRender: ->
    # FIXME: fadein()
    @loading.hide()


  buttonParams: ->
    form = @getUI('form')
    return @params(form).permit 'website', 'tamanho', 'aparencia'
