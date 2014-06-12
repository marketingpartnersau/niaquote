(function() {
  window.Util = {
    getPolicyType: function(status, kids) {
      if (status === 'Cpl' && kids === 'has kids') {
        return "Fam";
      } else if (status === 'Cpl' && kids === 'no kids') {
        return "Cpl";
      } else if (status === 'Sgl' && kids === 'has kids') {
        return "SPFam";
      } else if (status === 'Sgl' && kids === 'no kids') {
        return "Sgl";
      }
    },
    parseMarital: function(policy) {
      switch (policy) {
        case "Sgl":
          return "Single";
        case "Cpl":
          return "Couple";
        case "SPFam":
          return "Single Parent";
        case "Fam":
          return "Family";
      }
    },
    getSlug: function(str) {
      return str.replace(/[^a-zA-Z0-9\s]/g, "").toLowerCase().replace(/\s/g, '');
    },
    getRecommendedProducts: function(age, priority) {
      var agegroup, productMatrix;
      if (age < 31) {
        agegroup = 25;
      } else if (age < 38) {
        agegroup = 31;
      } else if (age < 55) {
        agegroup = 38;
      } else if (age > 55) {
        agegroup = 55;
      }
      productMatrix = {
        25: {
          tax: ['SE60', 'B65', 'B75', 'BM65'],
          family: ['HB65', 'HB75', 'HM65'],
          coverage: ['HM65', 'HM75', 'H65', 'H75', 'H85'],
          cheapest: ['E50', 'BH', 'SE60']
        },
        31: {
          tax: ['B65', 'HCB65', 'HCB75', 'HCM65', 'HCM75'],
          family: ['HB65', 'HB75', 'HM65'],
          coverage: ['HM65', 'HM75', 'H65', 'H75', 'H85'],
          cheapest: ['BH', 'B65', 'BM65']
        },
        38: {
          tax: ['BM75', 'HCB65', 'HCB75', 'HCM65', 'HCM75'],
          family: ['HB65', 'HB75', 'HM65'],
          coverage: ['HB75', 'HB75', 'HM65', 'HM75', 'H65'],
          cheapest: ['E50', 'BH', 'B65']
        },
        55: {
          tax: ['BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65'],
          family: ['HM65', 'HM75', 'H65', 'H75'],
          coverage: ['HM65', 'HM75', 'H65', 'H75'],
          cheapest: ['BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65']
        }
      };
      return productMatrix[agegroup][priority];
    },
    getExtendedRecommendedProducts: function(age, priority) {
      var agegroup, productMatrix;
      if (age < 31) {
        agegroup = 25;
      } else if (age < 38) {
        agegroup = 31;
      } else if (age < 55) {
        agegroup = 38;
      } else if (age > 55) {
        agegroup = 55;
      }
      productMatrix = {
        25: {
          tax: ['BH', 'SE60', 'B65', 'B75', 'BM65', 'BM75', 'HCB65', 'HCB75'],
          family: ['HH', 'HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85'],
          coverage: ['HH', 'HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85'],
          cheapest: ['E50', 'BH', 'SE60', 'B65', 'B75', 'BM65', 'BM75']
        },
        31: {
          tax: ['BH', 'B65', 'HCB65', 'HCB75', 'HCM65', 'HCM75', 'HH'],
          family: ['HH', 'HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85'],
          coverage: ['HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85'],
          cheapest: ['BH', 'B65', 'BM65', 'HCB65', 'HCM65']
        },
        38: {
          tax: ['BH', 'B65', 'B75', 'BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65', 'HCM75', 'HH'],
          family: ['HH', 'HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85'],
          coverage: ['HH', 'HB75', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85'],
          cheapest: ['E50', 'BH', 'B65', 'BM65', 'HCB65', 'HCM75']
        },
        55: {
          tax: ['BH', 'B65', 'B75', 'BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65', 'V65', 'HH'],
          family: ['V65', 'HH', 'HB65', 'HM65', 'HM75', 'H65', 'H75', 'H85'],
          coverage: ['V65', 'HH', 'HB65', 'HM65', 'HM75', 'H65', 'H75', 'H85'],
          cheapest: ['BH', 'B65', 'B75', 'BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65', 'HCM75', 'V65']
        }
      };
      return productMatrix[agegroup][priority];
    },
    getAgeRecommendation: function(age, priority, kids) {
      var agegroup, kidgroup, recommendation, recommendations;
      if (kids === 'has kids') {
        kidgroup = 1;
      } else {
        kidgroup = 2;
      }
      if (age < 31) {
        agegroup = 1;
      } else if (age > 30 && age < 39) {
        agegroup = 2;
      } else if (age > 38 && age < 56) {
        agegroup = 3;
      } else if (age > 55) {
        agegroup = 4;
      }
      recommendations = {
        tax: {
          1: 2,
          2: 1,
          3: 2,
          4: 3
        },
        family: {
          1: 2,
          2: 2,
          3: 2,
          4: 2
        },
        coverage: {
          1: 3,
          2: 3,
          3: 3,
          4: 3
        },
        cheapest: {
          1: 0,
          2: 0,
          3: 0,
          4: 0
        }
      };
      recommendation = recommendations[priority][agegroup];
      if (kidgroup === 1) {
        if (priority === 'tax' && agegroup === 1) {
          recommendations--;
          console.log('drop recommendations 1 because kids');
        } else if (priority === 'coverage' && agegroup === 4) {
          recommendations--;
          console.log('drop recommendations 1 because kids');
        }
      }
      return recommendation;
    },
    getState: function(postcode) {
      var c, exceptions, i, max, min, range, ranges, state;
      ranges = {
        'NSW': [1000, 1999, 2000, 2599, 2619, 2898, 2921, 2999],
        'ACT': [200, 299, 2600, 2618, 2900, 2920],
        'VIC': [3000, 3999, 8000, 8999],
        'QLD': [4000, 4999, 9000, 9999],
        'SA': [5000, 5999],
        'WA': [6000, 6797, 6800, 6999],
        'TAS': [7000, 7999],
        'NT': [800, 999]
      };
      exceptions = {
        872: 'NT',
        2540: 'NSW',
        2611: 'ACT',
        2620: 'NSW',
        3500: 'VIC',
        3585: 'VIC',
        3586: 'VIC',
        3644: 'VIC',
        3707: 'VIC',
        2899: 'NSW',
        6798: 'WA',
        6799: 'WA',
        7151: 'TAS'
      };
      postcode = parseInt(postcode);
      if (postcode in exceptions) {
        return exceptions[postcode];
      }
      for (state in ranges) {
        range = ranges[state];
        c = range.length;
        i = 0;
        while (i < c) {
          min = range[i];
          max = range[i + 1];
          if (postcode >= min && postcode <= max) {
            return state;
          }
          i += 2;
        }
      }
    },
    getLHC: function(age) {
      var yearsWithoutCover;
      yearsWithoutCover = age - 31;
      if (yearsWithoutCover > 0) {
        return parseInt(yearsWithoutCover * 2);
      } else {
        return 0;
      }
    },
    getRebate: function(age, marital, income) {
      var age1, age2, ager, incomer, rebate, rebates, tier1, tier2, tier3;
      tier1 = 88000;
      tier2 = 102000;
      tier3 = 136000;
      age1 = 65;
      age2 = 70;
      rebates = {
        0: {
          0: 38.72,
          1: 33.88,
          2: 29.04
        },
        1: {
          0: 29.04,
          1: 24.20,
          2: 19.36
        },
        2: {
          0: 19.36,
          1: 14.52,
          2: 9.68
        }
      };
      if (marital === "Cpl" || marital === "Fam" || marital === "SPFam") {
        tier1 += tier1;
        tier2 += tier2;
        tier3 += tier3;
      }
      if (income < tier1) {
        incomer = 0;
      } else if (income > tier1 && income < tier2) {
        incomer = 1;
      } else if (income > tier2 && income < tier3) {
        incomer = 2;
      } else {
        return rebate = 0;
      }
      if (age < age1) {
        ager = 2;
      } else if (age >= age1 && age < age2) {
        ager = 1;
      } else if (age >= age2) {
        ager = 0;
      }
      return rebates[incomer][ager];
    },
    calculateValueWithFrequency: function(raw, frequency) {
      switch (frequency) {
        case 'yearly':
          return raw;
        case 'monthly':
          return parseFloat(raw / 52 * 4.3333);
        case 'fortnightly':
          return parseFloat(raw / 52 * 4.3333 * 2);
        case 'weekly':
          return parseFloat(raw / 52);
        case 'daily':
          return parseFloat(raw / 365);
      }
    },
    calculateLHCValue: function(hospitalPremium, lhcPercentage) {
      var hospital, lhc;
      hospital = calculateValueWithFrequency(hospitalPremium / 100);
      lhc = hospital * lhcPercentage;
      return parseFloat(calculateValueWithFrequency(lhc));
    },
    calculateRebate: function(grossPremium, rebatePercentage) {
      var price, rebate, rebateRounded;
      price = calculateValueWithFrequency(grossPremium / 100);
      rebate = gross * rebatePercentage;
      rebateRounded = Math.ceil(rebate * 20 - 0.05) / 20;
      return parseFloat(rebateRounded);
    },
    addCommas: function(str) {
      var rgx, x, x1, x2;
      str += '';
      x = str.split('.');
      x1 = x[0];
      x2 = x.length > 1 ? '.' + x[1] : '';
      rgx = /(\d+)(\d{3})/;
      while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
      }
      return x1 + x2;
    },
    validateForm: function() {
      $('.incomplete:visible').removeClass('animated tada');
      if ($('.incomplete:visible').length) {
        $('.incomplete:visible').addClass('animated tada');
        return false;
      } else {
        return true;
      }
    },
    preSignup: function() {
      $.fancybox.open($('#pre-signup'));
      return $(document).on('gform_confirmation_loaded', function(e, f) {
        $('body').fadeOut();
        return window.location.href = 'http://' + window.location.hostname + '/sign-up';
      });
    }
  };

}).call(this);
