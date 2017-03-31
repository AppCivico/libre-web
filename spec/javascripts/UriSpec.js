
/*
 * URI helper
 */

(function() {
  describe('URIHelper', function() {
    var uri;
    uri = null;
    beforeEach(function() {
      return uri = URI.init('https://www.google.com');
    });
    it('does uri defined', function() {
      return expect(uri).toBeDefined();
    });
    return it('does uri location defined', function() {
      expect(uri._location).toEqual("https://www.google.com");
      return expect(uri.absolute()).toEqual("https://www.google.com");
    });
  });

}).call(this);
