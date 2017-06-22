###
# I18n class
# @author dvinciguerra
###
module.exports = class I18n

  @property =
    exception:
      default_message: '''
        Ocorreu um erro não esperado no sistema. Uma mensagem ja foi enviada e analisaremos o
        problema.
      '''
      request_message: 'Encontramos um erro ao enviar seus dados para o servidor'

    error:
      forgot_title: 'Ops!'
      forgot_message: 'Encontramos um erro ao enviar seus dados para o servidor'

      reset_title: 'Ops!'
      reset_message: 'Encontramos um erro ao enviar seus dados para o servidor'

    success:
      forgot_title: 'Falta pouco...'
      forgot_message: 'Verifique seu e-mail para prosseguir com a recuperação de senha'

      reset_title: 'Processo concluído!'
      reset_message: 'Sua senha foi alterada co sucesso'


  # Run recusively json nodes using array nodes or string selector path
  # @return <string>
  @t: (nodes) ->
    # param nodes|keys must be  string or array
    unless typeof(nodes) is 'string' or typeof(nodes) is 'object'
      throw new Error 'Node param must be an string or an array variable'

    # recusive func
    findNode = (keys = [], obj) ->
      return obj[keys[0]] if keys.length is 1 or typeof obj[keys[0]] is 'string'
      k = keys.shift()
      return findNode keys, obj[k]

    # prepare nodes|keys
    nodes = nodes.split('/') if typeof nodes is 'string'
    return findNode nodes, @property
