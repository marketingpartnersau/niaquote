'use strict';


// Declare app level module which depends on filters, and services
angular.module('quoteApp', [
  'ngRoute',
  'ipCookie',
  'quoteApp.filters',
  'quoteApp.services',
  'quoteApp.directives',
  'quoteApp.controllers',
  'angular-flexslider'
])

.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.timeout = 5000;
}])
