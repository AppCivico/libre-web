/**
 *	Utils class
 *	This is a simple class that has some common methods
 *	author: @dvinciguerra
 */
module.exports = class Utils {

	// helpers
	static merge(obj = null, src = null) {
		if (obj == null || src == null) {
			return null;
		}

		if (typeof obj === "object") {
			for (var key in src) {
				obj[key] = src[key];
			}
		}

		return obj;
	}

	static has(obj = null, str) {
		if (obj == null) {
			return false;
		}
		if (typeof obj === "object") {
			return obj.hasOwnProperty(str) ? true : false;
		}
		if (typeof obj === "string") {
			return obj.match(new RegExp(str)) ? true : false;
		}
		return false;
	}


	// validations
	static isEmpty(o = null) {
		if (o === null || o.length === 0) {
			return true
		}
		return (typeof o === "string") && (o === null || o === "" || o.length === 0) ? true : false
	}

	static isNull(o) {
		return (o === null) ? true : false;
	}

	static isString(o = null) {
		return (typeof o === "string") ? true : false;
	}

}

