// requires
const Session = require("lib/session.js");

/**
 *	Component class
 *	This is a base class for component views
 *	author: @dvinciguerra
 */
module.exports = class ViewBase {

	constructor(args = {}) {
		this._el = (args.el != null) ? args.el : document.createElement('div');
		this._config = (args.config != null) ? args.config : {};
	}

	el() {
		return this._el;
	}

	config() {
		return this._config;
	}

	session() {
		return Session.load();
	}
}

