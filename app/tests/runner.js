"use strict";

(function(){
	return _.chain(require.list())
		.filter(function(m){ if(m.match(/\.spec\.coffee$/i)){ return m }  })
		.map(function(m){ require(m) });
})();

