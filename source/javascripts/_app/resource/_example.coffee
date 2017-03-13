# namespace
App.Resource = App.Resource || {}

# Resource for Diagnosis
class App.Resource.PlanAction extends App.Resource.Base
  # attributes
  @base_api = "#{App.config.API_BASE}/plan"


  # show error messages
  @show_error: (json) ->
    token = json.error or ""
    msg = switch
      when token.match /plan '\d+' not found/
        'Este item não foi encontrado. Talvez ele ja tenha sido removido.'
      when token.match /action_plan not found./
        'Não foi possível carregar os dados da ação deste plano.'
      else
        '[PlanAction] Erro genérico do servidor'

    # show error
    message 'Erro', msg

  # show errors
  @show_validations = (form, json) ->
    $form = form

    # error message list
    error_message = (token) ->
      list =
        missing: 'Campo obrigatório'
        invalid: 'Valor inválido'
        empty_is_invalid: 'Não pode ser vazio'
        repeated: 'Este item já encontra-se cadastrado'
      list[token]

    # reset error messages (removing elements)
    $form.querySelectorAll('.error-message').map (x) ->
      x.parentElement.removeChild(x)

    # if validation errors, show messages
    if json.form_error?
      for key, field of list
        $input = $form.querySelector("input[name=#{key}]")
        $input.parent().classList.add('has-error')
        $input.after """
          <small class='error-message'>#{error_message(field)}</small>
        """

  # get status id by status name
  @state_id_by_name: (state) ->
    switch state
      when "Em Ação" then 1
      when "Atrasada" then 2
      when "Finalizada" then 3


  # remove a specific plan action
  @updateItem: (plan, action) ->
    action = @put {
      endpoint: "/#{plan.id}/action/#{action.id}"
      params: action
    }

    action = $.ajax({
      url: '',
      method: 'PUT'
      params: action
    })


  # remove a specific plan action
  @removeItem: (plan, id) ->
    action = @remove {
      endpoint: "/#{plan.id}/action/#{id}"
    }
    action.fail (res) =>
      @show_error(res.responseJSON)
      # TODO: add troubleshooting


  # remove a specific plan action
  @stateItem: (plan, action, state) ->
    state_id = @state_id_by_name(state)
    action = @put {
      endpoint: "/#{plan.id}/action/#{action}"
      params: { action_plan_status_id: state_id }
    }
    action.fail (res) =>
      @show_error(res.responseJSON)
      # TODO: add troubleshooting


