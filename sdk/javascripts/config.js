// configurations
const _configs = {
	development: {
		base: "//devlibre.eokoe.com",
		assets: {
			button: "/assets/sdk/v1.0/img/lbr-button-image.svg"
		}
	},

	production: {
		base: "//devlibre.eokoe.com",
		assets: {
			button: "/assets/sdk/v1.0/img/lbr-button-image.svg"
		}
	}
};


/**
* Configuration class
*/
module.exports = class Config {
	static getEntry(key) {
		return _configs[key] || {};
	}

	static env(name = 'production'){
		return getEntry(name);
	}
}

