requirejs.config({
    "baseUrl": "../src",
    "paths": {
      "app": "",
      "jquery": "../lib/jquery",
      "d3": "../lib/d3",
      "sift": "../lib/sift",
      "underscore": "../lib/underscore",
      "async" : "../lib/async",
      "jstat": "../lib/jstat",
      "abba": "../lib/abba",
      "json-stable-stringify": "../lib/json-stable-stringify"
    },
    shim: {
        underscore: {
          exports: "_"
        },
        d3: {
            exports: 'd3'
        },
        sift: {
            exports: 'sift'
        },
        jstat: {
            exports: 'jStat'
        },
        abba: {
            deps: ['jstat'],
            exports: 'computeResults'
        }
      }
});

