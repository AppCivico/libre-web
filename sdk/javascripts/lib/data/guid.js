/**
 * Guid class - simple random pseudo guid generator (from backbone.localStorage)
 *  @author dvinciguerra
 */
module.exports = class Guid {

	// generate 4 random chars
	static s4() {
		return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
	}

	// generate pseudo guid
	static generate() {
		return (`${this.s4()+this.s4()}-${this.s4()}-${this.s4()}-${this.s4()}-${this.s4()+this.s4()+this.s4()}`).toUpperCase()
	}
}

