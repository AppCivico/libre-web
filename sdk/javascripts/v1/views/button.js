'use strict';

// requires
const ViewBase = require('../../lib/view.js');

/**
*	Button component class
*	author: @dvinciguerra
*/
module.exports = class ButtonView extends ViewBase {

	isRendered() {
		return this._rendered;
	}


	// constructor
	constructor(args = {}) {
		super(args);

		//this._el = document.createElement('a');
		//this._el.className = 'lbr-sdb-button'
		//this._rendered = false;
		this._el.style.margin = '0px';
		this._el.style.padding = '0px';
		this._el.style.width = '1px';
	}


	onClickButton(event) {
		event.preventDefault();
		alert('Em desenvolvimento');
	}


	// bind events to element
	bind() {
		this.el().querySelectorAll('.lbr-sdk-button').forEach((x) => {
			x.addEventListener('submit', this.onClickButton);
		});
	}


	// render component
	render(){
		console.log(this.el());
		if(!this.isRendered()) {
			let tmpl = this.template({config: this.config()});
			this.el().innerHTML = tmpl;
			this.bind();
			this._rendered = true;
		}
		return this.el()
	}


	// template
	template(stash = {}){
		return `
			<!-- iframe src="//midialibre.com.br/sdk/libre/button" frameborder="0" vertical-align: bottom; width: 150px; height: 24px;></iframe -->
			<form class="lbr-sdk-button" href="#" style="">
				<button type="submit" style="margin:0px;padding:0px;border:0px;">
					<img src="${stash.config.base + stash.config.assets.button}"
						height="30px" title="Gostou? Valorize, dê um Libre" />
				</button>
			</form>
		`
	}
}

