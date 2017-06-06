'use strict';

module.exports = () => {

	// Replace element with an other one.
	// ex: old.replaceWith(new);
	Element.prototype.replaceWith = function(newElement = null) {
		return this.parentNode.replaceChild(newElement, this);
	};

};
