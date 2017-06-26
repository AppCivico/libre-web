// requires
const Guid = require("lib/data/guid.js");
const Utils = require("lib/utils.js");

/**
 * Session class
 * This class handle the user session data
 * author: dvinciguerra
 */
module.exports = class Session {

	constructor() {
		this.setDefaultAttributes();
	}

	// load current user session
	static load() {
		let session = new Session();
		let data = JSON.parse(session.getAdapter().getItem(session.getSessionKey()));

		if (!Utils.isEmpty(data)) {
			session.setAttributes(data);
			session.id = (Utils.has(data, "id")) ? data.id : session.id;
		}

		return session;
	}

	/* accessors */

	setDefaultAttributes() {
		return this._attributes = {
			"api_key": null,
			"roles": [],
			"user_id": 0,
			"timestamp": new Date().getTime()
		};
	}

	getAdapter() {
		this._adapter = this._adapter || localStorage;
		return this._adapter;
	}

	getSessionKey() {
		this._sessionKey = this._sessionKey || "libre-session";
		return this._sessionKey;
	}

	getId() {
		this._id = this._id || Guid.generate();
		return this._id;
	}

	getAttr(key = null) {
		return (this._attributes[key]) ? this._attributes[key] : null;
	}

	setAttr(key = null, value = null, options = {}) {
		if (key != null) {
			return this._attributes[key] = value;
		}
	}

	getAttributes(options = {}) {
		return this._attributes || {};
	}

	setAttributes(value = null, options = {}) {
		if (!Utils.isNull(value)) {
			return this._attributes = value;
		}
	}

	isAuth(session = null) {
		session = (session !== null) ? session : this;
		return (session.getAttributes()).api_key ? true : false;
	}


	// get params from storage
	getItem(key = null) {
		let data = JSON.parse(this.getAdapter().getItem(this.getSessionKey()));
		this.setAttributes(data);
		return (key != null) ? this.getAttr(key) : null;
	}

	// set params and persist to storage
	setItem(key = null, value = null, duration = null) {
		let data = JSON.parse(this.getAdapter().getItem(this.getSessionKey()));
		this.setAttributes(data);

		if (key != null && typeof key === "string") {
			this._attributes[key] = value;
		}
		else if (key != null && typeof key === "object") {
			this.setAttributes(key);
		}

		return this.save();
	}

	// persist data attributes to storage
	save(data = {}) {
		let attr = this.getAttributes();
		attr.id = this.getId();
		return this.getAdapter().setItem(this.getSessionKey(), JSON.stringify(attr));
	}

	// clear current session
	clear() {
		return this.getAdapter().setItem(
			this.getSessionKey(), JSON.stringify(this.setDefaultAttributes())
		);
	}
}
