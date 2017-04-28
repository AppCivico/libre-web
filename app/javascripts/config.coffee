"use strict"


module.exports = class Config
	@config =
		# route table
		routes:
			'contato': (args...) =>  "/contact"
			'login':   (args...) =>  "/contact"
		# config for development
		development:
			name:     "Libre-App"
			api_base: "https://hapilibre.eokoe.com"
			debug:    true


		# config for production
		production:
			name:     "Libre-App"
			api_base: ""
			debug:    false


	# getting env config
	@env = (name) =>
		conf = if name is 'production' then @config.production else @config.development
		conf.url_for = (token) => @routes[token]
		return conf




