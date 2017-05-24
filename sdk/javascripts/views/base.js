'use strict';

/**
*	Component class
*	author: @dvinciguerra
*/
module.exports = class ViewBase {

	// constructor
	constructor(args = {}){
		this._el = args.el || document.createElement('div');
		this._config = args.config || {};
	}

	el() { return this._el }

	config(){ return this._config }
}

