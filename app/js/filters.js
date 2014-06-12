'use strict';

/* Filters */

angular.module('quoteApp.filters', []).
  filter('interpolate', ['version', function(version) {
    return function(text) {
      return String(text).replace(/\%VERSION\%/mg, version);
    };
  }])

  .filter('addCommas', [function(){
  	return function(str) {
      var rgx, x, x1, x2;
  	  if(undefined === str) str = 72000;
      str += '';
      x = str.split('.');
      x1 = x[0];
      x2 = x.length > 1 ? '.' + x[1] : '';
      rgx = /(\d+)(\d{3})/;
      while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
      }
      return x1 + x2;
    }
  }])

  .filter('titleFilter', [function(){
  	return function(title){
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
          return "Tonsils and Adenoids";
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
        default:
          return title;
      }
  	}
  }]);
