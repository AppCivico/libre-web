'use strict';

// requires
const ViewBase = require('v1/views/base.js');

/**
*	Button component class
*	author: @dvinciguerra
*/
module.exports = class ButtonView extends ViewBase {

	constructor(args = {}) {
		super(args);
	}

	onClickButton(event) {
		event.preventDefault();
		alert('Em desenvolvimento');
	}


	// bind events to element
	bind() {
		this.el().querySelectorAll('a').forEach((x) => {
			addEventListener('click', this.onClickButton);
		});
	}

	// render component
	render(){
		console.log(this.el());
		let tmpl = this.template({config: this.config()});
		this.el().innerHTML = tmpl;
		this.bind();
		return this.el()
	}

	// template
	template(stash = {}){
		return `
		<a href="#">
			<img src="${stash.config.base + stash.config.assets.button}"
				height="30px"
				title="Gostou? Valorize, dê um Libre" />
		</a>
		`
	}
}

