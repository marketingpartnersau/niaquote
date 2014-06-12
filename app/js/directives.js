'use strict';

/* Directives */


angular.module('quoteApp.directives', [])

  .directive('appVersion', ['version', function(version) {
    return function(scope, elm, attrs) {
      elm.text(version);
    };
  }])

  .directive('descriptionPopup', ['descriptions', function(descriptions) {
    return {
    	restrict : 'A',
    	replace : true,
    	template : '<div class="description" ng-show="desc"><p>{{ desc }}</p></div>',
      scope : {},
      link : function(scope, element, attrs){
        scope.desc = descriptions[attrs.type](attrs.rel);
      }
    };
  }])
  
 .directive('fancybox', function ($compile, $http) {
	return {
		restrict: 'A',

		controller: function($scope) {
			 $scope.openFancybox = function (url) {

				$http.get(url).then(function(response) {
					if (response.status == 200) {

						var template = angular.element(response.data);
						var compiledTemplate = $compile(template);
						compiledTemplate($scope);

						$.fancybox.open({ content: template, type: 'html' });
					}
				});
			};
		}
	};
 })

  
;
