'use strict';

// configurations
const _configs = {

	// development env
	development: {
		base: '//localhost:4567',
		assets: {
			button: '/assets/sdk/v1.0/img/lbr-button-image.svg'
		}
	},

	// production env
	production: {
		base: '//192.168.1.151:4567',
		assets: {
			button: '/assets/sdk/v1.0/img/lbr-button-image.svg'
		}
	}
};


/**
* Configuration class
*/
module.exports = class Config {
	static env(name = 'development'){
		return _configs[name] || {}
	}
}

