//= require govuk_tech_docs
//= require govuk_publishing_components/dependencies
//= require govuk_publishing_components/lib/trigger-event
//= require govuk_publishing_components/lib/cookie-functions
//= require govuk_publishing_components/lib/cookie-settings
//= require govuk_publishing_components/components/cookie-banner
//= require govuk_publishing_components/load-analytics
//= require filter-list

// reworked version of modules.js from govuk_publishing_components
// needed to manually start tech docs gem modules now that we're including
// the modules code from govuk_publishing_components

var renderMermaid = function() {
  import("https://cdn.jsdelivr.net/npm/mermaid@11.11.0/dist/mermaid.esm.min.mjs")
    .then(function(module) {
      const mermaid = module.default;

      mermaid.initialize({
        startOnLoad: false,
        theme: 'default',
        securityLevel: 'loose',
        logLevel: 'debug'
      });

      var elements = document.querySelectorAll('pre.mermaid, div.mermaid');
      console.log('Found Mermaid elements:', elements.length);

      for (var i = 0; i < elements.length; i++) {
        if (elements[i].hasAttribute('data-processed')) {
          console.log('Removing data-processed from:', elements[i]);
          elements[i].removeAttribute('data-processed');
        }
      }

      mermaid.run({
        querySelector: 'pre.mermaid, div.mermaid'
      }).then(function() {
        console.log('Mermaid diagrams rendered successfully');
      }).catch(function(error) {
        console.error('Error rendering Mermaid diagrams:', error);
      });
    })
    .catch(function(error) {
      console.error('Error loading Mermaid:', error);
    });
};

window.renderMermaid = renderMermaid;

var devdocsModulesFind = function() {
  var container = document;
  var moduleSelector = '[data-module]';
  var modules = container.querySelectorAll(moduleSelector);
  var modulesArray = [];
  for (var i = 0; i < modules.length; i++) {
    modulesArray.push(modules[i]);
  }
  if (container !== document && container.getAttribute('data-module')) {
    modulesArray.push(container);
  }
  return modulesArray;
};

var devdocsModulesStart = function() {
  var GOVUK = window.GOVUK;
  var modules = devdocsModulesFind();
  for (var i = 0, l = modules.length; i < l; i++) {
    var element = modules[i];
    var moduleNames = element.getAttribute('data-module').split(' ');
    for (var j = 0, k = moduleNames.length; j < k; j++) {
      var moduleName = camelCaseAndCapitalise(moduleNames[j]);
      var started = element.getAttribute('data-' + moduleNames[j] + '-module-started');
      if (typeof GOVUK.Modules[moduleName] === 'function' && !started) {
        try {
          var module = new GOVUK.Modules[moduleName];
          module.start($(element));
          element.setAttribute('data-' + moduleNames[j] + '-module-started', true);
        } catch (e) {
          console.error('Error starting ' + moduleName + ' component JS: ' + e.message, window.location);
        }
      }
    }
  }
  function camelCaseAndCapitalise(string) {
    return capitaliseFirstLetter(camelCase(string));
  }
  function camelCase(string) {
    return string.replace(/-([a-z])/g, function(g) {
      return g.charAt(1).toUpperCase();
    });
  }
  function capitaliseFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
};

$(document).ready(function() {
  devdocsModulesStart();
  renderMermaid();
});
