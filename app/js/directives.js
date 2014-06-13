'use strict';

/* Directives */


angular.module('quoteApp.directives', [])

  .directive('appVersion', ['version', function(version) {
    return function(scope, elm, attrs) {
      elm.text(version);
    };
  }])

  .directive('descriptionPopup', ['descriptions', '$sce', function(descriptions, $sce) {
    return {
    	restrict : 'A',
    	replace : true,
      scope: {
        item : '=item'
      },
      controller : 'MainController',
    	templateUrl : window.location.origin+'/wp-content/themes/health/ng/app/partials/description-popup.html',
      link : function(scope, element, attrs){
        var filteredTitle = descriptions.title(scope.item.type);
        scope.item.slug = scope.createSlug(filteredTitle);
        scope.item.desc = $sce.trustAsHtml(descriptions[attrs.type](scope.item.slug));
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
