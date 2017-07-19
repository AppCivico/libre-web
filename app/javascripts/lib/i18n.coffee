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

      # error messages
      # TODO: Always check for new error
      # messages on https://github.com/eokoe/libre-api
      'invalid': "é inválido"
      'required': "é obrigatório"
      'empty_is_invalid': "é obrigatório"
      'missing': "é obrigatório"
      'alredy exists': "já está cadastrado"
      'in_fucture': "tem valor muito no futuro"
      'min_invalid': "tem valor muito pequeno"
      'max_invalid': "excede o tamanho máximo"
      'char_invalid': "contém caracteres inválidos"
      'brand_invalid': "deve ser de uma bandeira válida"
      'brand_required': "não compatível com nenhuma bandeira"

    error:
      default_title: 'Erro!'

      header_message: 'Nao foi possível carregar sa informações do dashboard do usuário'

      signin_title: 'Erro!'
      signin_message: 'Usuário ou senha inválidos...'

      forgot_title: 'Ops!'
      forgot_message: 'Encontramos um erro ao enviar seus dados para o servidor'

      reset_title: 'Ops!'
      reset_message: 'Encontramos um erro ao enviar seus dados para o servidor'

      picpay_title: 'Ops!'
      picpay_message: 'Não foi possível obter os dados para completar sua integração com PicPay'

    success:
      signin_title: 'Bem vindo!'
      signin_message: 'Usuário autênticado...'

      forgot_title: 'Falta pouco...'
      forgot_message: 'Verifique seu e-mail para prosseguir com a recuperação de senha'

      reset_title: 'Processo concluído!'
      reset_message: 'Sua senha foi alterada co sucesso'

      picpay_title: 'Redirecionando...'
      picpay_message: """
        Vamos tentar redirecionar você para o site do PicPay para fazer a autorização. Certifique-se
        de que a janela não foi bloqueada pelo seu bloqueador de pop-ups.
      """


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
