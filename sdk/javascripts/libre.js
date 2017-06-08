// stricted always
'use strict';


// requires
const Config = require('config.js');
const ButtonView = require('v1/views/button.js');


/**
* Libre SDK class
*/
class SDK {

	// constructor
	constructor(args = {}) {
		this.name = args.n || 'none';
		this.version = args.v || 0;
	}

	// dom object
	dom() {
		return document
	}

	// configs
	config(){
		return Config.env()
	}

	// sdk renderer
	render() {
		let button = new ButtonView({ config: this.config() });
		this.dom().querySelectorAll('.lbr-button').forEach((b) => {
			new ButtonView({ el: b, config: this.config() }).render()
		})
	}
}


/**
 * Libre SDK Bootstrap
 * author: @dvinciguerra
 */
const Libre = {
	start(args = {}){
		return (new SDK(args)).render()
	}
};

// single point entry
Libre.start({n:'libre-sdk', v:'1.0'})
