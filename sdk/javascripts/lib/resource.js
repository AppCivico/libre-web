/**
 * Resources base class
 * author: dvinciguerra
 */
module.exports = class Resource {
	constructor(args = {}) {
		this._url = "";
		this._rootURL = "//localhost";
	}

	url(url = null) {
		if(url !== null) {
			this._url = url;
		}
		return this._url;
	}

	load() {
		throw new Error("Resource#load method isnt implemented");
	}

	find() {
		throw new Error("Resource#find method isnt implemented");
	}

	create() {
		throw new Error("Resource#create method isnt implemented");
	}

	update() {
		throw new Error("Resource#update method isnt implemented");
	}

	remove() {
		throw new Error("Resource#remove method isnt implemented");
	}

}
