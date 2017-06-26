"use strict";

// requires
const Config = require("config.js");
const ButtonView = require("v1/views/button.js");


/**
* Libre SDK class
*/
class SDK {
	constructor(args = {}) {
		this.name = args.n || "none";
		this.version = args.v || 0;
	}

	dom() {
		return document;
	}

	config(){
		return Config.env();
	}

	render() {
		let button = new ButtonView({ config: this.config() });
		this.dom().querySelectorAll(".lbr-button").forEach((b) => {
			new ButtonView({ el: b, config: this.config() }).render();
		});
	}
}


/**
 * Libre SDK Bootstrap
 * author: @dvinciguerra
 */
const Libre = {
	start(args = {}){
		return (new SDK(args)).render();
	}
};


/**
 * Single point entry
 */
try {
	Libre.start({n:"libre-sdk", v:"1.0"});
}
catch(e) {
	new Error(`Libre SDK Exception: ${e.message}`);
}
