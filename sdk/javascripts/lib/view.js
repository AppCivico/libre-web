// requires
const Session = require('lib/session.js');

/**
 *	Component class
 *	This is a base class for component views
 *	author: @dvinciguerra
 */
module.exports = class ViewBase {

	constructor(args = {}) {
		this._el = (args.el != null) ? args.el : document.createElement('div');
		this._config = (args.config != null) ? args.config : {}
	}

	/* accessors */

	el() {
		return this._el
	}

	config() {
		return this._config
	}

	// return the current or a new session
	session() {
		return Session.load()
	}

	/* methods */
}

