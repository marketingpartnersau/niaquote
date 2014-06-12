'use strict';

/* Controllers */

angular.module('quoteApp.controllers', [])
  


.controller('MainController', ['$scope', 'ipCookie', 'quoteData', 'priorityLabels', function($scope, ipCookie, quoteData, priorityLabels) {
	//debug 
	window.scope = $scope;
	// some vars
	$scope.viewAll = false
	$scope.currentProduct = {}
	$scope.products = {}
	$scope.pdfs = {}
	$scope.recommendedIndex = 0
	$scope.frequency = 'weekly'
	$scope.excess = 500
	$scope.rebatePercentage = 0
	$scope.price = 0
	$scope.busy = false
	$scope.active = false
	$scope.loading = false
	$scope.policyStr = ''
	$scope.stateStr = ''
	$scope.priorityLabels = priorityLabels || []
	$scope.form = {}

	// SLIDER
	$scope.sliderObj = {}
	$scope.slideshow = {}
	$scope.currentIndex = 0
	$scope.slideshow.recommendedProducts = []
	$scope.slideshow.extendedRecommendedProducts = []
	$scope.slideshow.visibleProducts = []


	$scope.init = function(){

		var values = ipCookie('oscInput') || {};
		if(values !== null){
			if( _.has(values, 'kids') && values.kids == 'hasnt kids') values.kids = 'no kids';
			$scope.form.marital = values.marital;
			$scope.form.kids = values.kids;
			$scope.form.age1 = values.age1;
			$scope.form.age2 = values.age2;
			$scope.form.sglIncome = values.sglIncome;
			$scope.form.cplIncome = values.cplIncome;
			$scope.form.postcode = values.postcode;
			$scope.form.priority = values.priority;
		}

		$(document).on('gform_confirmation_loaded', function(e, f){
			if ( f === 2 ){
				var quoteCookie = $scope.form;
				quoteCookie.policy = $scope.setPolicy()
				quoteCookie.state = $scope.setState()
				quoteCookie.rebatePercentage = $scope.rebatePercentage;
				quoteCookie.product = $scope.currentProduct[1]['_'+$scope.excess];
				quoteCookie.basePrice = $scope.price;
				quoteCookie.rebateValue = $scope.rebateValue;
				quoteCookie.frequency = $scope.frequency;
				quoteCookie.excess = $scope.excess;

				ipCookie.remove('quote_cookie');
				ipCookie( 'quote_cookie', quoteCookie, { expires : 365, path : '/' } );

				console.log(ipCookie('quote_cookie'));

				window.location.href = window.location.origin + '/sign-up';
			}
		});
	}

	$scope.cookieInput = function(){
		// var product = $scope.currentProduct[1];
		// var lhc = Util.getLHC($scope.age);
		// var lhcValue;
		// if(undefined !== product){
		// 	lhcValue = Util.calculateLHCValue(product.rate.hospital_premium, lhc);
		// } else {
		// 	lhcValue = 0;
		// }
		
		var values = {};
		values.marital = $scope.form.marital;
		values.kids = $scope.form.kids;
		values.age1 = $scope.form.age1;
		values.age2 = $scope.form.age2;
		values.sglIncome = $scope.form.sglIncome;
		values.cplIncome = $scope.form.cplIncome;
		values.postcode = $scope.form.postcode;
		values.priority = $scope.form.priority;
		// values.product = product;
		// values.basePrice = $scope.price
		// values.rebateValue = $scope.rebateValue
		// values.lhcValue = lhcValue
		ipCookie.remove('oscInput');
		ipCookie('oscInput', values, {expires : 365, path : '/'});
	}

	// util function used on layout
	$scope.createSlug = function(title){
		return (title) ? title.replace(/[^a-zA-Z0-9\s]/g,"").toLowerCase().replace(/\s/g, '') : ''
	}
	// set some vars on the fly
	$scope.age = function(){
		return $scope.form.marital == 'Cpl' && ($scope.form.age2 > $scope.form.age1) ? $scope.form.age2 : $scope.form.age1
	}
	$scope.income = function(){
		return $scope.form.marital == 'Cpl' ? $scope.form.cplIncome : $scope.form.sglIncome
	}
	$scope.setPolicy = function(){
		$scope.policyStr = Util.getPolicyType($scope.form.marital, $scope.form.kids)
		return $scope.policyStr
	}
	$scope.setPrettyPolicy = function(){
		if( ! $scope.policyStr) return
		$scope.prettyPolicy = Util.parseMarital($scope.policyStr);
		return $scope.prettyPolicy
	}
	$scope.setState = function(){
		if( ! $scope.form.postcode) return
		$scope.stateStr = Util.getState($scope.form.postcode)
		return $scope.stateStr
	}

	$scope.setRebatePercentage = function(){
		if ( !$scope.policyStr ) return
		$scope.rebatePercentage = Util.getRebate($scope.age(), $scope.policyStr, $scope.income());
		return $scope.rebatePercentage;
	}

	$scope.setCurrent = function(){
		// set current index
		if($scope.active){
			$scope.currentIndex = $scope.recommendedIndex = Util.getAgeRecommendation($scope.age(), $scope.form.priority, $scope.form.kids)	
			// set current product	
			$scope.currentProduct = $scope.slideshow.visibleProducts[$scope.currentIndex]
		}
	}

	$scope.upgradeProduct = function(){
		$scope.sliderObj.flexslider($scope.sliderObj.count-1);
	}


	var recommendedMatrix = []
	var exRecommendedMatrix = []

	// slider callbacks
	$scope.slideshow.start = function(slider){
		$scope.sliderObj = slider;
		$scope.calculatePrice()
	}

	$scope.slideshow.after = function (e) {
		// update current undex
		$scope.currentIndex = angular.element('.flex-active-slide').index()
		// 
		$scope.currentProduct = $scope.slideshow.visibleProducts[$scope.currentIndex]
		// active link
		angular.element('.slider-nav a').removeClass('active').eq($scope.currentIndex).addClass('active')
	}
	$scope.slideshow.next = function(){
		if( $scope.currentIndex + 1 < $scope.slideshow.visibleProducts.length)
			$scope.sliderObj.flexslider('next')
	}
	$scope.slideshow.prev = function(){
		if( $scope.currentIndex > 0)
			$scope.sliderObj.flexslider('prev')
	}
	$scope.slideshow.all = function(){
		$scope.busy = true
		if( ! $scope.viewAll){ // show all products
			$scope.viewAll = true
			//$scope.slideshow.recommendedProducts = _.pairs( $scope.products )
			$scope.slideshow.visibleProducts = $scope.slideshow.extendedRecommendedProducts;
		} else { // show recommended only		
			$scope.viewAll = false
			$scope.slideshow.visibleProducts = $scope.slideshow.recommendedProducts;
			$scope.returnToRecommended()
		}
		$scope.busy = false
	}

	$scope.slideshow.allAll = function(){
		$scope.busy = true;
		$scope.viewAll = true;
		$scope.slideshow.visibleProducts = _.pairs( $scope.products )
		$scope.busy = false;
	}


	// retrieve list of products from server
	$scope.getPlans = function(recalculate){

		if( ! Util.validateForm() ) return

		$scope.cookieInput()
		$scope.active = true
		$scope.viewAll = false
		$scope.loading = true
		if( ! $scope.busy){
			$scope.busy = true
			var postData = {
				policy_type : $scope.setPolicy(),
				state : $scope.setState()
			}
		    quoteData.getQuote(postData).then(
				function(data){	
					console.log('postData', postData)
					console.log('receivedData', data)
					$scope.busy = false
					// set reset products list object
			    	$scope.products = data
					// set recommended products and index
					$scope.setProducts()
					$scope.slideshow.visibleProducts = $scope.slideshow.recommendedProducts;

					$scope.loading = false;

					$scope.setCurrent();
					// get pdf urls from WP server									
					quoteData.getPDFs( _.keys($scope.products) ).then( function(pdfs){ $scope.pdfs = pdfs; } )
					// re calculate if needed
					if(recalculate) $scope.calculatePrice()

					var top = $('.showQuote').offset().top - 50;
					$('body,html').animate({scrollTop : top}, 500);
			    },
			    function(errorMessage){
					$scope.busy = false
			     	$scope.error = errorMessage
			    }
			);
		}
	}
	
	
	// pick recommended products for slider
	$scope.setProducts = function(){
		if( ! _.isEmpty($scope.products)){
			// get recommented
			recommendedMatrix = Util.getRecommendedProducts($scope.age(), $scope.form.priority)
			exRecommendedMatrix = Util.getExtendedRecommendedProducts($scope.age(), $scope.form.priority)
			// recommended products
			$scope.slideshow.recommendedProducts = _.pairs( _.pick($scope.products, recommendedMatrix) )
			$scope.slideshow.extendedRecommendedProducts = _.pairs( _.pick ( $scope.products, exRecommendedMatrix ) )
			// recommended index
			$scope.setCurrent()
		}
	}


	// return to recommended products from viewing all
	$scope.returnToRecommended = function(callback){		
		// this is a hack! but works well:) (for now...)
		setTimeout(function(){
			$scope.setCurrent()
			$scope.sliderObj.flexslider(2)
			// run call back if passed			
			if (typeof callback === "function") callback();
		}, 500);
	}

	$scope.priorityHasChanged = function(){
		$scope.setProducts()
		$scope.returnToRecommended()
	}


	// calculate price and set scope var
	$scope.calculatePrice = function(){
		if($scope.slideshow.visibleProducts.length){
			angular.element('aside.policyDetails .variables li label').removeClass('input_tmp_checked')
			var currentProduct = $scope.currentProduct[1]
			var excess = $scope.excess
			// if no rates for excess find new available excess
			if( ! _.has(currentProduct, '_'+excess) || ! _.has(currentProduct['_'+excess], 'rate')){
				excess = _.find([0, 250, 500, 0, 250], function(num){ 
					return _.has(currentProduct, '_'+num) && _.has(currentProduct['_'+num], 'rate'); 
				});
				angular.element('#excess'+excess+'+label').addClass('input_tmp_checked')
			}
			// rate exists
			if( _.has(currentProduct, '_'+excess) && _.has(currentProduct['_'+excess], 'rate')){
				var price = currentProduct['_'+excess].rate.price
				var price_at_frequency = Util.calculateValueWithFrequency(price, $scope.frequency)
				$scope.rebatePercentage = Util.getRebate($scope.age(), $scope.setPolicy(), $scope.income())
				var rebate_value = price_at_frequency / 100 * $scope.rebatePercentage;
				$scope.price = (price_at_frequency - rebate_value).toFixed(2)
				$scope.rebateValue = rebate_value.toFixed(2)
			} else {
				// default error
				$scope.price = (0).toFixed(2)
				$scope.rebateValue = (0).toFixed(2)
			}
		}
	}
	

	// WATCHES
	// trigger new API data on policy change
	$scope.$watchCollection('[form.marital, form.kids]', function(newValues, oldValues){
		// console.log('first:' + oldValues, newValues)
		if( ! $scope.busy && $scope.active){			
			var recalculateIf = function(){
				var oldPolicy = $scope.policyStr
				var newPolicy = $scope.setPolicy()
				if(newPolicy && newPolicy != oldPolicy){
					$scope.getPlans('recalculate')
				}
			}
			return  ( $scope.viewAll )
					? $scope.returnToRecommended(recalculateIf)
					: recalculateIf()
		}
	})
	// trigger new API data on state change
	$scope.$watchCollection('[form.postcode]', function(newValues, oldValues){
		// console.log('second:' + oldValues, newValues)
		if( ! $scope.busy && $scope.active){
			var recalculateIf = function(){
				var oldState = $scope.stateStr
				var newState = $scope.setState()
				if(newState && newState != oldState){
					$scope.getPlans('recalculate')
				}
			}
			$scope.cookieInput
			return  ( $scope.viewAll )
					? $scope.returnToRecommended(recalculateIf)
					: recalculateIf()
		}
	})
	// watch some vars that trigger new recommended products
	$scope.$watchCollection('[form.age1, form.age2, form.priority]', function(newValues, oldValues){
		// console.log('third:' + oldValues, newValues)
		if( ! $scope.busy ) {
			$scope.setProducts()
			if( ! $scope.viewAll){ // show all products
				//$scope.slideshow.recommendedProducts = _.pairs( $scope.products )
				$scope.slideshow.visibleProducts = $scope.slideshow.extendedRecommendedProducts;
			} else { // show recommended only
				$scope.slideshow.visibleProducts = $scope.slideshow.recommendedProducts;
				$scope.returnToRecommended()
			}
			$scope.cookieInput
			return $scope.setCurrent();
		}
	});

	// watch some vars that re-calulate the price
	$scope.$watchCollection('[form.sglIncome, form.cplIncome, excess, currentIndex, frequency]', function(newValues, oldValues){
		// console.log('fourth:' + oldValues, newValues)
		if( ! $scope.busy){
			if( $scope.viewAll){
				if(oldValues[0] != newValues[0] || oldValues[1] != newValues[1]){  // return to recommended if form has changed
					return $scope.returnToRecommended()
				}
			}
			$scope.cookieInput
			return $scope.calculatePrice()
		}
	})


}]);
