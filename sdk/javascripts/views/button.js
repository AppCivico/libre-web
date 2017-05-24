'use strict';

// requires
const ViewBase = require('views/base.js');

/**
*	Button component class
*	author: @dvinciguerra
*/
module.exports = class ButtonView extends ViewBase {

	// render component
	render(){
		let tmpl = this.template({config: this.config()});
		return this.el().innerHTML = tmpl
	}

	// template
	template(stash = {}){
		return `
			<img src="${stash.config.base + stash.config.assets.button}"
				height="30px"
				title="Gostou? Valorize, dê um Libre" />
		`
	}
}

