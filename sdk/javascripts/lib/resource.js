'use strict';

module.exports = class Resource {
	constructor(args = {}) {
		this._url = '';
		this._rootURL = '//localhost';
	}

	url(url = null) {
		if(url !== null) this._url = url;
		return this._url;
	}

	load() {
		console.warn('Resource#load method isnt implemented');
	}

	find() {
		console.warn('Resource#load method isnt implemented');
	}

	create() {
		console.warn('Resource#create method isnt implemented');
	}

	update() {
		console.warn('Resource#update method isnt implemented');
	}

	remove() {
		console.warn('Resource#remove method isnt implemented');
	}

}
