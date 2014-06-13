'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('quoteApp.services', [])


	.value('version', '0.1')

	.value('excess', 500)

	.factory('quoteData',function($http, $q){
		window.$http = $http;
		return {
		  //apiPath:'http://health.dev/api',
		  apiPath:'http://niahealthdata.com/api',
		  getQuote: function(postData){
			var deferred = $q.defer();
			// state/NSW/policy_type/Sgl
			var url = this.apiPath+'/state/'+postData.state+'/policy_type/'+postData.policy_type;
			$http.get(url).success(function(data){			
				  deferred.resolve(data);
			  }).error(function(){
				deferred.reject("An error occured while fetching items");
			  });
			  return deferred.promise; 
		   },
		   getPDFs: function(product_list){
			var deferred = $q.defer();
			$http({
				method : 'POST',
				url : PDF_AJAX.url, 
				params : { action: 'get-product-pdfs', products : product_list.join() }
			})
			.success(function(data){
				deferred.resolve(data);
			})
			.error(function(){
				deferred.reject("An error occured while fetching items");
			  });
			  return deferred.promise;
		   }
		}
	})

	.factory('priorityLabels', function(){
		var priorityLabels = []
		priorityLabels['tax'] = 'to save on tax'
		priorityLabels['family'] = 'to have more kids'
		priorityLabels['coverage'] = 'the best coverage'
		priorityLabels['cheapest'] = 'the cheapest insurance'
		return priorityLabels
	})

	.factory('descriptions', function(){
		return {
			title : function(title){
				switch (title) {
			        case 'Drugs':
			          return "Non-PBS Prescriptions";
			        case 'Other Services':
			          return "Services Medicare doesn't cover";
			        case 'Cardiac Services':
			          return "Cardiothoracic Services";
			        case 'Cataract Removal':
			          return "Cataracts and eye lens procedures";
			        case 'Major Joint Replacement':
			          return "Joint replacement, including spine, with prostheses";
			        case 'Kidney Dialysis':
			          return "Dialysis for Chronic Kidney Failure";
			        case 'Cardiac Services':
			          return "Cardiothoracic Services";
			        case 'Tonsils, Adenoid, Appendix':
			          return "Tonsils";
			        case 'Physio':
			          return "Physio, Chiro and Osteopathy";
			        case 'Health & Wellbeing':
			          return "Health Maintenance";
			        case 'Outpatient Psychology':
			          return "Psychology";
			        case 'Shoulder & Back Surgery':
			          return "Shoulder Reconstruction";
			        case 'Health Scan' :
			          return "Health Screening";
			        case 'Podiatric Services' : 
			          return "Podiatric Surgery";
			        default:
			          return title;
			    }
			},
			extra : function(title){
				switch (title) {
		        case "dental":
		          return 'We cover all dental proceedures; <strong>Preventative</strong>: Fillings, Scaling and Cleaning. <strong>Major Dental</strong>: Endodontics, Periodontics, Crowns/Dentures, Bridges, Root Canales. <span class="ortha"><strong>Orthodontics</strong>: Braces, Retainers.</span> Some sublimits may apply. Call us for more info.';
		        case 'optical':
		          return 'We will help pay for your perscription glasses and contact lenses.';
		        case 'physiochiroandosteopathy':
		          return 'We will contribute to your sports & spinal physiotherapy, clinical pilates, a visit to a chiropractor and an osteopath.';
		        case 'remedialmassage':
		          return 'We’ll chip in for the cost of your remedial massages.';
		        case 'naturaltherapy':
		          return 'Our cover will help pay for acupuncture, herbalism, Chinese medicine, naturopathy, Kinesiology and Myotherapy.';
		        case 'nonpbsprescriptions':
		          return 'You’ll be covered up to an annual limit for travel vaccines and non-PBS subscriptions <strong>After you pay the first $36.90</strong>.';
		        case 'healthmaintenance':
		          return 'We believe in good all-round health, so we’ll kick in towards gym membership, weight loss programs and quit smoking programs. You will need a letter from your GP.';
		        case 'psychology':
		          return 'We’ll help pay for your outpatient psychology needs. ';
		        case 'speechtherapy':
		          return 'We can kick in and help pay for any speech therapy you need. ';
		        case 'podiatry':
		          return 'If you need to see a podiatrist, we’ll help you out with the costs.';
		        case 'dietetics':
		          return 'If you need to see a dietician, we’ll help cover the cost. ';
		        case 'eyetherapy':
		          return 'For additional eye therapies, we’ll contribute to the cost. ';
		        case 'healthcareappliances':
		          return 'We’ll help with additional appliances by paying a rebate on wheelchairs and hearing aids.';
		        case 'healthscreening':
		          return 'Need a health screen? We’ve got you covered.';
		        case 'occupationaltherapy':
		          return 'Treatements to develop, maintain or recover daily living and work from injury or illness.';
		        case 'generaldental':
		        	return '';
		       	case 'majordental':
		        	return '';
		       	case 'orthodontic':
		        	return '';
		       	case 'travelvaccines':
		        	return '';
		       	case 'prescriptionbenefits':
		        	return 'Our cover will help pay for acupuncture, herbalism, Chinese medicine, naturopathy, Kinesiology and Myotherapy. We’ll also chip in for the cost of your remedial massages.';
		       	case 'naturaltherapiesandremedialmassage'
		         default : return title;
		      }
			},

			hospital : function(title){
				switch (title) {
				case 'treatmentforaccidents':
				  return 'We cover you for any hospital treatment you may need if you have an accident after you join. ';
				case 'tonsils':
				  return 'We cover you if you need your tonsils removed.';
				case 'wisdomteeth':
				  return 'Your hospital bills if you have your wisdom teeth removed in hospital are covered. ';
				case 'appendix':
				  return 'We cover you if you need your appendix removed';
				case 'shoulderreconstructions':
				  return 'We cover shoulder reconstructions. ';
				case 'kneereconstruction':
				  return 'We cover knee reconstruction surgery.';
				case 'dentalsurgery':
				  return 'Your hospital bills are covered if you have your teeth removed or another dental operation. ';
				case 'psychiatricservices':
				  return 'Coverage for psychiatric treatments carried out in hospital. ';
				case 'rehabilitation':
				  return 'Hospital treatment for rehabilitation services. ';
				case 'cardiothoracicservices':
				  return 'This means heart and lung related services.';
				case 'pregnancy':
				  return 'This includes childbirth and pregnancy related services. ';
				case 'reproductiveservices':
				  return 'This means IVF, GIFT and other fertility treatments. ';
				case 'cataractsandeyelensprocedures':
				  return 'Includes cataract removal and lens procedures.';
				case 'dialysisforchronickidneyfailure':
				  return 'Renal dialysis for chronic renal failure. ';
				case 'jointreplacementincludingspinewithprostheses':
				  return 'Hip, knee and other joint replacements including revisions. ';
				case 'bariatricsurgery':
				  return 'Weight loss surgery like lap band is excluded.';
				case 'achillestendonsurgery':
				  return 'Surgery for the treatment of achilles tendon injuries.';
				case 'palliativecare':
				  return 'Care provided to people who have a progressive terminal  illness.';
				case 'achillestendonsurgery':
		        	return '';
		       	case 'surgicalpodiatry':
		        	return '';
		       	case 'sterilityreversal':
		        	return '';
		       	case 'assistedreproductiveservices':
		        	return '';
		       	case 'spinalfusion':
		        	return '';
		       	case 'podiatricsurgery':
		        	return '';
		       	
				}
			}
		}
	})















