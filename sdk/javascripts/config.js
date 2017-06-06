'use strict';

// configurations
console.warn('WARN: development is point to devlibre.eokoe.com domain');
const _configs = {

	// development env
	development: {
		base: '//devlibre.eokoe.com',
		assets: {
			button: '/assets/sdk/v1.0/img/lbr-button-image.svg'
		}
	},

	// production env
	production: {
		base: '//midialibre.com.br',
		assets: {
			button: '/assets/sdk/v1.0/img/lbr-button-image.svg'
		}
	}
};


/**
* Configuration class
*/
module.exports = class Config {
	static env(name = 'production'){
		return _configs[name] || {}
	}
}

