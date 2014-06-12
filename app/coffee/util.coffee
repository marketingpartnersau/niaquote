window.Util = 
	getPolicyType : (status, kids) ->
		# take couple or single and kids or no kids and determine policy type

		if status is 'Cpl' and kids is 'has kids' then return "Fam"
		else if status is 'Cpl' and kids is 'no kids' then return "Cpl"
		else if status is 'Sgl' and kids is 'has kids' then return "SPFam"
		else if status is 'Sgl' and kids is 'no kids' then return "Sgl"

	parseMarital : (policy) ->
		# take policy type and convert it to human readable version
		switch policy
			when "Sgl" then return "Single"
			when "Cpl" then return "Couple"
			when "SPFam" then return "Single Parent"
			when "Fam" then return "Family"

	getSlug : (str) ->
		# slugify string
		return str.replace(/[^a-zA-Z0-9\s]/g,"").toLowerCase().replace(/\s/g, '')

	getRecommendedProducts : (age, priority) ->
		if age < 31 then agegroup = 25 
		else if age < 38 then agegroup = 31
		else if age < 55  then agegroup = 38
		else if age > 55 then agegroup = 55
		
		productMatrix = 
			25 : 
				tax: ['SE60', 'B65', 'B75', 'BM65'] 
				family: ['HB65', 'HB75', 'HM65']
				coverage: ['HM65', 'HM75', 'H65', 'H75', 'H85']
				cheapest: ['E50', 'BH', 'SE60']
			31 : 
				tax: ['B65', 'HCB65', 'HCB75', 'HCM65', 'HCM75']
				family: ['HB65', 'HB75', 'HM65']
				coverage: ['HM65', 'HM75', 'H65', 'H75', 'H85']
				cheapest: ['BH', 'B65', 'BM65']
			38 : 
				tax: ['BM75', 'HCB65', 'HCB75', 'HCM65', 'HCM75']
				family: ['HB65', 'HB75', 'HM65']
				coverage: ['HB75', 'HB75', 'HM65', 'HM75', 'H65']
				cheapest: ['E50', 'BH', 'B65']
			55 : 
				tax: ['BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65']
				family: ['HM65', 'HM75', 'H65', 'H75']
				coverage: ['HM65', 'HM75', 'H65', 'H75']
				cheapest: ['BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65']
		return productMatrix[agegroup][priority]

	getExtendedRecommendedProducts : (age, priority) ->
		if age < 31 then agegroup = 25  
		else if age < 38 then agegroup = 31
		else if age < 55  then agegroup = 38
		else if age > 55 then agegroup = 55
		
		productMatrix = 
			25 : 
				tax: ['BH', 'SE60', 'B65', 'B75', 'BM65', 'BM75', 'HCB65', 'HCB75'] 
				family: ['HH', 'HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85']
				coverage: ['HH', 'HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85'] 
				cheapest: ['E50', 'BH', 'SE60', 'B65', 'B75', 'BM65', 'BM75']
			31 : 
				tax: ['BH', 'B65', 'HCB65', 'HCB75', 'HCM65', 'HCM75', 'HH']
				family: ['HH', 'HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85']
				coverage: ['HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85']
				cheapest: ['BH', 'B65', 'BM65', 'HCB65', 'HCM65']
			38 : 
				tax: ['BH', 'B65', 'B75', 'BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65', 'HCM75', 'HH']
				family: ['HH', 'HB65', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85']
				coverage: ['HH', 'HB75', 'HB75', 'HM65', 'HM75', 'H65', 'H75', 'H85']
				cheapest: ['E50', 'BH', 'B65', 'BM65', 'HCB65', 'HCM75']
			55 : 
				tax: ['BH', 'B65', 'B75', 'BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65', 'V65', 'HH']
				family: ['V65', 'HH', 'HB65', 'HM65', 'HM75', 'H65', 'H75', 'H85']
				coverage: ['V65', 'HH', 'HB65', 'HM65', 'HM75', 'H65', 'H75', 'H85']
				cheapest: ['BH', 'B65', 'B75', 'BM65', 'BM75', 'HCB65', 'HCB75', 'HCM65', 'HCM75', 'V65']

		return productMatrix[agegroup][priority]

	getAgeRecommendation : (age, priority, kids) ->
		
		if kids is 'has kids' then kidgroup = 1 else kidgroup = 2
		
		if age < 31 then agegroup = 1
		else if age > 30 and age < 39 then agegroup = 2
		else if age > 38 and age < 56 then agegroup = 3
		else if age > 55 then agegroup = 4
		
		#priority > age > kids
		
		recommendations = 
			tax :
				1 : 2
				2 : 1
				3 : 2
				4 : 3
			family : 
				1 : 2
				2 : 2
				3 : 2
				4 : 2
			coverage : 
				1 : 3
				2 : 3
				3 : 3
				4 : 3
			cheapest : 
				1 : 0
				2 : 0
				3 : 0
				4 : 0

		recommendation = recommendations[priority][agegroup]

		if kidgroup is 1 
			if priority is 'tax' and agegroup is 1
				recommendations--
				console.log 'drop recommendations 1 because kids'
			else if priority is 'coverage' and agegroup is 4
				recommendations--
				console.log 'drop recommendations 1 because kids'
		return recommendation

	getState : (postcode) ->
		ranges = 
			'NSW' : [1000, 1999, 2000, 2599, 2619, 2898, 2921, 2999]
			'ACT' : [200, 299, 2600, 2618, 2900, 2920]
			'VIC' : [3000, 3999, 8000, 8999]
			'QLD' : [4000, 4999, 9000, 9999]
			'SA' : [5000, 5999]
			'WA' : [6000, 6797, 6800, 6999]
			'TAS' : [7000, 7999]
			'NT' : [800, 999]
		
		exceptions = 
			872 : 'NT'
			2540 : 'NSW'
			2611 : 'ACT'
			2620 : 'NSW'
			3500 : 'VIC'
			3585 : 'VIC'
			3586 : 'VIC'
			3644 : 'VIC'
			3707 : 'VIC'
			2899 : 'NSW'
			6798 : 'WA'
			6799 : 'WA'
			7151 : 'TAS'
		
		postcode = parseInt postcode
		return exceptions[postcode]	if postcode of exceptions
		for state of ranges
			range = ranges[state]
			c = range.length
			i = 0
	
			while i < c
				min = range[i]
				max = range[i + 1]
				return state	if postcode >= min and postcode <= max
				i += 2

	getLHC : (age) ->
		# get lifetime health cover loading percentage.
		# 2% of hospital_premium for every year over 31.

		yearsWithoutCover = age-31
		if yearsWithoutCover > 0 then return parseInt yearsWithoutCover*2
		else return 0

	getRebate : (age, marital, income) ->
		tier1 = 88000
		tier2 = 102000
		tier3 = 136000
		age1 = 65
		age2 = 70

		# f*cked up rebate percentages
		rebates = 
			0 :
				0 : 38.72
				1 : 33.88
				2 : 29.04
			1 :
				0 : 29.04
				1 : 24.20
				2 : 19.36
			2 :
				0 : 19.36
				1 : 14.52
				2 : 9.68
		
		# double the tier if couple, family or single parent
		if marital is "Cpl" or marital is "Fam" or marital is "SPFam"
			tier1 += tier1
			tier2 += tier2
			tier3 += tier3
		
		if income < tier1 then incomer = 0
		else if income > tier1 and income < tier2 then incomer = 1
		else if income > tier2 and income < tier3 then incomer = 2	
		else return rebate = 0
			
		if age < age1 then ager = 2
		else if age >= age1 and age < age2 then ager = 1
		else if age >= age2 then ager = 0
		
		return rebates[incomer][ager]

	calculateValueWithFrequency : (raw, frequency) ->
		switch frequency
			when 'yearly' then return raw
			when 'monthly' then return parseFloat(raw / 52 * 4.3333)
			when 'fortnightly' then return parseFloat(raw / 52 * 4.3333 *2)
			when 'weekly' then return parseFloat(raw / 52)
			when 'daily' then return parseFloat(raw / 365)

	calculateLHCValue : (hospitalPremium, lhcPercentage) ->
		hospital = calculateValueWithFrequency hospitalPremium / 100
		lhc = hospital * lhcPercentage
		return parseFloat calculateValueWithFrequency lhc

	calculateRebate : (grossPremium, rebatePercentage) ->
		price = calculateValueWithFrequency grossPremium / 100
		rebate = gross * rebatePercentage
		rebateRounded = Math.ceil(rebate*20 - 0.05) / 20
		return parseFloat rebateRounded
 
	# filterTitle : (title) ->
	# 	switch title
	# 		when 'Drugs' then return "Travel Vaccines"
	# 		when 'Other Services' then return "Services Medicare doesn't cover"
	# 		when 'Cardiac Services' then return "Cardiothoracic Services"
	# 		when 'Cataract Removal' then return "Cataracts and eye lens procedures"
	# 		when 'Major Joint Replacement' then return "Joint replacement, including spine, with prostheses"
	# 		when 'Kidney Dialysis' then return "Dialysis for Chronic Kidney Failure"
	# 		when 'Cardiac Services' then return "Cardiothoracic Services"
	# 		when 'Tonsils, Adenoid, Appendix' then return "Tonsils and Adenoids"
	# 		when 'Physio' then return "Physio, Chiro and Osteopathy"
	# 		when 'Health & Wellbeing' then return "Health Maintenance"
	# 		when 'Outpatient Psychology' then return "Psychology"
	# 		when 'Shoulder & Back Surgery' then return "Shoulder Arthroscopy" 
	# 		else return title;
	
	# getExtraDescription : (extra) ->
	# 	switch extra
	# 		when "dental" then return 'We cover all dental proceedures; <strong>Preventative</strong>: Fillings, Scaling and Cleaning. <strong>Major Dental</strong>: Endodontics, Periodontics, Crowns/Dentures, Bridges, Root Canales. <strong>Orthodontics</strong>: Braces, Retainers. Some sublimits may apply. Call us for more info.'
	# 		when 'optical' then	return 'We will help pay for your perscription glasses and contact lenses.'
	# 		when 'physiochiroandosteopathy' then return 'We will contribute to your sports & spinal physiotherapy, clinical pilates, a visit to a chiropractor and an osteopath.'
	# 		when 'remedialmassage' then return 'We’ll chip in for the cost of your remedial massages.'
	# 		when 'naturaltherapy' then return 'Our cover will help pay for acupuncture, herbalism, Chinese medicine, naturopathy, Kinesiology and Myotherapy.'
	# 		when 'travelvaccines' then return 'You’ll be covered up to an annual limit for travel vaccines and non-PBS subscriptions (HeartPlus products & above) <strong>After you pay the first $36.90</strong>.'
	# 		when 'healthmaintenance' then return 'We believe in good all-round health, so we’ll kick in towards gym membership, weight loss programs and quit smoking programs. You will need a letter from your GP.'
	# 		when 'psychology' then return 'We’ll help pay for your outpatient psychology needs. '
	# 		when 'speechtherapy' then return 'We can kick in and help pay for any speech therapy you need. '
	# 		when 'podiatry' then return 'If you need to see a podiatrist, we’ll help you out with the costs.'
	# 		when 'dietetics' then return 'If you need to see a dietician, we’ll help cover the cost. '
	# 		when 'eyetherapy' then return 'For additional eye therapies, we’ll contribute to the cost. '
	# 		when 'healthcareappliances' then return 'We’ll help with additional appliances by paying a rebate on wheelchairs and hearing aids.';
	# 		when 'healthscan' then return 'Need a health screen? We’ve got you covered.'
	# 		when 'occupationaltherapy' then return 'Treatements to develop, maintain or recover daily living and work from injury or illness.'
		
	# getHospitalDescription : (hospital) ->
	# 	switch hospital
	# 		when 'treatmentforaccidents' then return 'We cover you for any hospital treatment you may need if you have an accident after you join. '
	# 		when 'tonsilsandadenoids' then return 'We cover you if you need your tonsils or adenoids removed.'
	# 		when 'wisdomteeth' then return 'Your hospital bills if you have your wisdom teeth removed in hospital are covered. '
	# 		when 'appendix' then return 'We cover you if you need your appendix removed'
	# 		when 'shoulderarthroscopy' then return 'We cover shoulder reconstructions. '
	# 		when 'kneereconstruction' then return 'We cover knee reconstruction surgery.'
	# 		when 'dentalsurgery' then return 'Your hospital bills are covered if you have your teeth removed or another dental operation. '
	# 		when 'psychiatricservices' then return 'Coverage for psychiatric treatments carried out in hospital. '
	# 		when 'rehabilitation' then return 'Hospital treatment for rehabilitation services. '
	# 		when 'cardiothoracicservices' then return 'This means heart and lung related services.'
	# 		when 'pregnancy' then return 'This includes childbirth and pregnancy related services. '
	# 		when 'reproductiveservices' then return 'This means IVF, GIFT and other fertility treatments. '
	# 		when 'cataractsandeyelensprocedures' then return 'Includes cataract removal and lens procedures.'
	# 		when 'dialysisforchronickidneyfailure' then return 'Renal dialysis for chronic renal failure. '
	# 		when 'jointreplacementincludingspinewithprostheses' then return 'Hip, knee and other joint replacements including revisions. '
	# 		when 'bariatricsurgery' then return 'Weight loss surgery like lap band is excluded.'
	# 		when 'cosmeticsurgery' then return ''
	# 		when 'otherservices' then return ''
	# 		when 'achillestendonsurgery' then return 'Surgery for the treatment of achilles tendon injuries.'
	# 		when 'palliativecare' then return 'Care provided to people who have a progressive terminal  illness.'

	addCommas : (str) ->
		str += ''
		x = str.split('.')
		x1 = x[0]
		x2 = if x.length > 1 then '.'+x[1] else ''
		rgx = /(\d+)(\d{3})/
		while rgx.test(x1)
			x1 = x1.replace rgx, '$1'+','+'$2'
		return x1 + x2

	validateForm : ->
		$('.incomplete:visible').removeClass 'animated tada'
		if $('.incomplete:visible').length 
			$('.incomplete:visible').addClass 'animated tada' 
			return false
		else return true


	preSignup : ->
		$.fancybox.open $ '#pre-signup'
		#$('#input_2_6', '#pre-signup').val window.info.state
		#$('#input_2_7', '#pre-signup').val window.info.policy
		#$('#input_2_8', '#pre-signup').val getActiveProduct().name
		#$('#input_2_9', '#pre-signup').val getActiveProduct().excess

		$(document).on 'gform_confirmation_loaded', (e,f) ->
			$('body').fadeOut()
			window.location.href = 'http://'+window.location.hostname+'/sign-up'

 
















