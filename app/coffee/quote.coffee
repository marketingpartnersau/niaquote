$ ->
	interactions = ->

		$('.popup.input [type="text"]').on 'keydown', (e) ->
			if e.keyCode is 13 or e.keyCode is 27 then $('.popup:visible, .hide-popup').fadeOut()
			else if e.keyCode is 9
				e.preventDefault()
				parent = $ '.popup:visible'
				parentID = parent.attr 'id' 
				label = $ "[href*='#open-" + parentID + "']"

				links = $ '.quote-form p a:visible'
				nextIndex = $('.quote-form p a:visible').index label
				nextLabel = links.eq nextIndex+1
				nextPopup = $ nextLabel.attr('href').replace 'open-',''

				$('.popup:visible, .hide-popup').fadeOut()
				nextLabel.click()
				nextPopup.find('input').focus()

		$('.quote .popup, .show-cpl, .quote .hide-popup').hide()
		$('.popup.input input').forceNumericOnly()

		$("[href*='#open-']").on 'click', (e) ->
			e.preventDefault()
			$('.hide-popup').show()
			$('.popup:visible').fadeOut()

			formOffset = $('.quote-form').offset()
			quoteOffset = $('.quote.partial').offset().top
			quoteHeight = $('.quote.partial').height() + 120
			offsetTop  = $(this).offset().top - formOffset.top - 140
			quoteRowMargin = $('#quote-row').offset().left

			offsetLeft = $(this).offset().left - quoteRowMargin


			popup = $ $(this).attr('href').replace('open-', '')
			popup.css({top: offsetTop, left: offsetLeft})
			popup.fadeIn().find('input').focus()

			$('.hide-popup').css
				top: quoteOffset
				height: quoteHeight

		$('.popup button, .popup label').on 'click', (e) ->
			if $(this).is('button')
				e.preventDefault()
			else 
				$(this).prev('input').prop 'checked', 'checked'

			parent = $ '.popup:visible'
			parent.fadeOut()
			
			$('.hide-popup').hide()

		$('.hide-popup').on 'click', ->
			$('.popup:visible').fadeOut()
			$(this).hide()

		$('.leavemynumber').hide()
		$('[href="#leavenumber"]').on 'click', (e) ->
			e.preventDefault()
			$('.leavemynumber').slideDown()

	interactions()

$.fn.isOnScreen = ->
	win = $ window
	viewport =
		top: win.scrollTop()
		left: win.scrollLeft()

	viewport.right = viewport.left + win.width()
	viewport.bottom = viewport.top + win.height()

	bounds = this.offset()
	bounds.right = bounds.left + this.outerWidth()
	bounds.bottom = bounds.top + this.outerHeight()

	onscreen = viewport.right < bounds.left or viewport.left > bounds.right or viewport.bottom < bounds.top or viewport.top > bounds.bottom

	return !onscreen

$.fn.forceNumericOnly = ->
	return this.each ->
		$(this).keydown (e) ->
			key = e.charCode || e.keyCode || 0
			return key == 8 || key == 9 || key == 13 || key == 46 || key == 110 || key == 190 || (key >= 35 && key <= 40) || (key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 65 && e.ctrlKey == true)


# tmpls = {}
	# urlQuery = {}
	# window.info = {}
	# promises = []
	# window.allProducts = []
	# window.products = []
	# window.product = null
	# window.prevQuote = null
	# sliderAPI = null
	# domain = "http://niahealthdata.com"
	# t = 0

	# if $('.quote.partial').length
	# 	tmpls = 
	# 		product: Handlebars.compile $('#product-tmpl').html()
	# 		extra: Handlebars.compile $('#extra-tmpl').html()
	# 		hospital: Handlebars.compile $('#hospital-tmpl').html()
	
	# $.whenall = (arr) -> return $.when.apply $, arr

	# checkForIncomplete = -> if !$('form.quote-form .incomplete:visible').length then $('#get-quote').removeClass 'disabled'

		# $('.quote-form .button.disabled').on 'mouseenter', (e) ->
		# 	alert('click')
		# 	$('.quote-form a.incomplete').addClass 'animated tada'

		
		# $('#get-quote').on 'click', getQuote

			# $('.hide-popup:visible').hide()
			# checkForIncomplete()

 		#	parentID = parent.attr 'id'
 		#	label = $ "[href*='#open-" + parentID + "']"
 
# 			if $(this).is 'label'
# 				val = $(this).text()
# 			else if $(this).is 'button'
# 				val = $(this).prev('input').val()
 
# 			if parentID is 'sgl-income' or parentID is 'cpl-income'
# 				val = '$' + addCommas val

#			label.text(val).removeClass('incomplete')
#			label.removeClass('incomplete')
			
# 			if parentID is 'marital'
# 				$('#get-quote:visible').addClass 'disabled'
# 				marital = $('[name="quote-marital"]:checked').val().toLowerCase()
# 				hide = if marital is 'sgl' then 'cpl' else 'sgl'
 				
# 				$('form.quote-form .show-'+hide).hide().find('a').addClass('incomplete')
# 				$('form.quote-form .show-' + marital).show()

		



		# $('.popup.input input').on 'keyup', (e) ->

		# 	parent = $ '.popup:visible'
		# 	parentID = parent.attr 'id' 
		# 	label = $ "[href*='#open-" + parentID + "']"
		# 	str = $(this).val()

		# 	if !str
		# 		return
# 			if label.hasClass('income')
# 				str = '$'+addCommas str
 
# 			label.removeClass('incomplete').text str



		# $(window).on 'scroll', ->
			# if $('.quote.partial').length and $('.quote.partial + div').isOnScreen() and !$('.popup:visible').length and !$('[href*="open-"]:not(.incomplete):visible').length
			# 	$('.quote-form p a').eq(0).addClass 'animated tada'
			# 	setTimeout ->
			# 		$('.quote-form p a').eq(0).removeClass 'animated tada'
			# 	, 3000

		# $(' [name="excess"], [name="frequency"]', '#policyDetails').on 'change', ->
		# 	window.info.excess = $('.policyDetails [name="excess"]:checked').val()
		# 	window.info.frequency = $('.policyDetails [name="frequency"]:checked').val()

		# 	$('.productHeader .price .freq').text window.info.frequency

		# 	updatePolicyDetails()

		

		# $(document).on 'click', '[href="#buy-now"]', (e) ->
		# 	e.preventDefault()
			# cookieQuoteDetails()
			# preSignup()

	#  sliderInteractions = ->
		# $('#productsInsert').royalSlider
		# 	autoHeight: true
		# 	navigateByClick: false
		
		# sliderAPI = $('#productsInsert').data 'royalSlider'
		# log 'slider initiated'

		# $('#productsInsert').on 'click', '.upgrade-product', (e) ->
		# 	#this cheeky function checks what's being viewed, and scrolls to that product with extras.
		# 	e.preventDefault()
		# 	slug = getSlug( $(this).parents('.product').find('.product-head h3').text() ).replace 'hospital', ''
		# 	$.each $('.slider-nav a:not(.active)'), (i,t) ->
		# 		if $(t).attr('class').indexOf slug >= 0
		# 			sliderAPI.goTo i - 2


		# $('.productInformation .navigation .next').on 'click', (e) ->
		# 	e.preventDefault()
		# 	sliderAPI.next()
		# $('.productInformation .navigation .prev').on 'click', (e) ->
		# 	e.preventDefault()
		# 	sliderAPI.prev()

		# $('#quote-nav').on 'click', 'a', (e) ->
		# 	e.preventDefault()
		# 	sliderAPI.goTo $(this).index()

		# sliderAPI.ev.on 'rsAfterSlideChange', onSeek


	# getQuote = (e) ->
	# 	resetForm()
	# 	e.preventDefault()
	# 	$(this).addClass 'disabled'
	# 	$('#quote-loader').fadeIn 300

	# 	marital = $('[name="quote-marital"]:checked').val()
	# 	kids = $('[name="quote-has-kids"]:checked').val()
	# 	getRebateMarital = getPolicyType marital, kids
	# 	age1 = $('[name="quote-age1"]').val()
	# 	age2 = $('[name="quote-age2"]').val()
	# 	sglIncome = $('[name="quote-sgl-income"]').val()
	# 	cplIncome = $('[name="quote-cpl-income"]').val()
	# 	postcode = $('[name="quote-postcode"]').val()
	# 	state = getState postcode
	# 	marital_url = getPolicyType marital, kids
	# 	age = if age1 > age2 then age1 else age2
	# 	income = if cplIncome isnt '' then cplIncome else sglIncome
	# 	highestAge = if age1 < age2 then age2 else age1
	# 	priority = $('[name="quote-priority"]:checked').val()

	# 	window.info = 
	# 		marital : marital
	# 		policy : getPolicyType marital, kids
	# 		kids : kids
	# 		age : age
	# 		age1 : age1
	# 		age2 : age2
	# 		income : income
	# 		sglIncome : sglIncome
	# 		cplIncome : cplIncome
	# 		priority : priority
	# 		frequency : 'weekly'
	# 		state : state
	# 		postcode : postcode
	# 		highestAge : highestAge
	# 		excess : 500
	# 		debitPenalty: false
	# 		applyLHC: false
	# 		lhcPercentage: getLHC age
	# 		rebatePercentage: getRebate age, getRebateMarital, income
	# 		applyRebate: true

	# 	Cookie.set 'oscInput', window.info, 243234132

	# 	url = getProductDataUrl()

	# 	log url, 'Prepped to fire AJAX request: '

	# 	#if window.productData.length and window.info then filterProducts window.productData

	# 	if window.prevQuote? and window.prevQuote.state is window.info.state and window.prevQuote.policy is window.info.policy
	# 		filterProducts window.oldProducts
	# 	else $.getJSON url, filterProducts

	# moveToShowQuote = ->
	# 	$('#get-quote').removeClass 'disabled'
	# 	$('.showQuote').fadeIn 600
	# 	quoteOffset = $('.showQuote').offset().top - 50
	# 	$('body, html').animate {scrollTop: quoteOffset}, 600

	# 	debugger

	# 	if window.info.policy is "Fam" or window.info.policy is "SPFam" then $('.kids-excess.panel').removeClass 'hide'
	# 	else if window.info.policy is "Sgl" or window.info.policy is "Cpl" then $('.kids-excess.panel').addClass 'hide' 

	# 	$('.row.showQuote').animate
	# 		opacity: 1
	# 	, 300

	# returnToQuote = ->
	# 	# window.quote = Cookie.get 'oscInput'
	# 	if window.quote?
	# 		window.info = {}
	# 		window.info.state = window.quote.state
	# 		window.info.marital = window.quote.policy
	# 		window.info.excess = window.quote.excess

	# 	#$.getJSON getProductDataUrl(), (data) -> 
	# 		#window.productData = data

	# 	if $('.quote.partial').length and window.quote?

	# 		marital = getSlug window.quote.marital
	# 		hide = if marital is 'sgl' then 'cpl' else 'sgl'
			
	# 		$('form.quote-form .show-'+hide).hide().find('a').addClass('incomplete')
	# 		$('form.quote-form .show-' + marital).show()

	# 		if hide is 'sgl'
	# 			$('.quote.partial #age2 input').val window.quote.age2
	# 			$('.quote.partial #cpl-income input').val window.quote.cplIncome
	# 			$('[href=#open-age2]').removeClass('incomplete').text window.quote.age2
	# 			$('[href=#open-cpl-income]').removeClass('incomplete').text '$' + addCommas window.quote.cplIncome
	# 		else if hide is 'cpl'
	# 			$('.quote.partial #sgl-income input').val window.quote.sglIncome
	# 			$('[href=#open-sgl-income]').removeClass('incomplete').text '$' + addCommas window.quote.sglIncome

	# 		#input popups
	# 		$('.quote.partial #postcode input').val window.quote.postcode
	# 		$('[href=#open-postcode]').removeClass('incomplete').text window.quote.postcode

	# 		$('.quote.partial #age1 input').val window.quote.age1
	# 		$('[href=#open-age1]').removeClass('incomplete').text window.quote.age1

	# 		#choice popups
	# 		kids = window.quote.kids.replace ' ', '_'
			
	# 		$('#mar-'+marital).prop 'checked', 'checked'
	# 		$('#'+kids).prop 'checked', 'checked'
	# 		$('#priority-' + window.quote.priority).prop 'checked', 'checked'

	# 		priority_val = $('#priority-'+window.quote.priority+' + label').text()
	# 		kids_val = if kids is "hasnt_kids" then "no kids" else "kids"
	# 		marital_val = if marital is "sgl" then "single" else "couple"

	# 		$('[href="#open-priority"]').removeClass('incomplete').text priority_val
	# 		$('[href="#open-has-kids"]').removeClass('incomplete').text kids_val
	# 		$('[href="#open-marital"]').removeClass('incomplete').text marital_val
 
	# 		checkForIncomplete()

	# deepLink = ->


	# resetForm = ->
	# 	window.oldProducts = window.allProducts

	# 	window.prevQuote = 
	# 		state : window.info.state
	# 		policy : window.info.policy
		
	# 	if sliderAPI? then sliderAPI.destroy()
	# 	sliderAPI = null
	# 	window.product = null
	# 	window.products = []
	# 	window.allProducts = []
	# 	promises = []
	# 	window.info = {}
	# 	t = 0

	# 	$('.slider-nav, #productsInsert').html('')

	# 	$('.productInformation .navigation .next, .productInformation .navigation .prev').off 'click'
	# 	$('#quote-nav').off 'click', 'a'
	# 	$('#weekly, #excess500', '#policyDetails').prop 'checked', 'checked'

	# 	$('.row.showQuote').animate
	# 		opacity: .5
	# 	, 300

	# filterProducts = (data) ->
	# 	log 'Ajax request successful.'

	# 	window.allProducts = data

	# 	prodsToExtract = getRecommendedProducts()

	# 	log prodsToExtract
	# 	log data

	# 	if prodsToExtract.length
	# 		if window.info.kids is "has kids" or window.info.marital is "Fam" or window.info.marital is "SPFam" or window.info.priority is "kids"
	# 			se = prodsToExtract.indexOf "SE60"
	# 			v = prodsToExtract.indexOf "V65"

	# 			if se > 0 then prodsToExtract.splice se, 1
	# 			if v > 0 then prodsToExtract.splice v, 1

	# 	products = []

	# 	$.each prodsToExtract, (i, group) ->
	# 		$.each data, (n, obj) ->
	# 			if obj.code2 is group then products.push obj

	# 	buildProducts products

	# buildProducts = (data) ->
	# 	log 'Products filtered to recommendations.'
	# 	$('.slider-nav, .productsInsert').html ''

	# 	moveToShowQuote()
	# 	sliderInteractions()

	# 	log 'prepped for building single product'
	# 	$.each data, buildSingleProduct

	# 	#could use event drive views for this.. that would be awesome
	# 	$('.replace-marital').text parseMarital window.info.policy
	# 	$('.replace-state').text window.info.state
	# 	$('.replace-age').text window.info.age
	# 	$('.replace-income').text '$'+addCommas window.info.income

	# 	if window.info.marital is 'Sgl'
	# 		rebateText = "This is based on you being " + window.info.age1 + " years old, with an income of $" + addCommas(window.info.sglIncome) + '.'
	# 	else if window.info.marital is "Cpl"
	# 		rebateText = "This is based on you and your partner's age of "+window.info.age1+" & " + window.info.age2 + ", and your combined income of $" + addCommas(window.info.cplIncome) + '.'

	# 	$('li.rebate .tooltop').text rebateText

	# 	scrollableIndex =  if getAgeRecommendation() > sliderAPI.numSlides then sliderAPI.numSlides else getAgeRecommendation()

	# 	log scrollableIndex
		
	# 	$.whenall(promises).done ->
	# 		sliderAPI.goTo scrollableIndex
	# 		$('#excess-loading').fadeOut()

	# 	$('#quote-loader').fadeOut 300
		#initCompare()

	# buildSingleProduct = (i, p, addToScrollable) ->
	# 	log 'building single product '+p.id

	# 	window.products.push {}
	# 	window.products[i][500] = p

	# 	getProductPDFURL p, i

	# 	url = domain+'/state/'+window.info.state+'/policy_type/'+window.info.policy+'/group/'+p.code2+'/?callback=?';

	# 	def = new $.Deferred()
	# 	promise = $.getJSON url, (excesses) ->
	# 		if excesses.length
	# 			log 'excesses for '+p.name+' successfully added to products object'
	# 			$.each excesses, (n,e) ->
	# 				window.products[i][e.excess] = e

	# 			def.resolve excesses
	# 			return excesses

	# 	promises.push def

	# 	slug = getSlug p.name
	# 	extras_back = p.extra_back
	# 	if extras_back < 1 then extras_back = null

	# 	content = 
	# 		id: p.id
	# 		product_title: p.name
	# 		product_description: p.description
	# 		slug: slug
	# 		back_on_extras: extras_back
	# 		total_extras: p.extras_value

	# 	navItem = '<a href="#product-'+p.id+'" class="'+slug+'"><span>'+p.name+'</span></a>'

		# html = $ tmpls.product content
		# html.data('id', p.id)

		# sliderAPI.appendSlide html
		# $('.slider-nav').append navItem

		# $.getJSON domain+'/id/'+p.id+'/details/?callback=?', buildProductDetails

		# t++

	# buildProductDetails = (prod) ->
	# 	log 'retrieved product extras and hospitals for '+prod.name

	# 	extraTable = $ '#product-'+prod.id+' .extras ul.items'
	# 	hospitalCovered = $ '#product-'+prod.id+' .hospital ul.hcovered'
	# 	hospitalRestricted = $ '#product-'+prod.id+' .hospital ul.hrestricted'
	# 	hospitalNot = $ '#product-'+prod.id+' .hospital ul.hnot'
	# 	extraTable.next('.loading-table').hide()
	# 	hospitalNot.next('.loading-table').hide()

	# 	if prod.extras.length
	# 		$.each prod.extras, (i,extra) ->
	# 			ename = filterTitle extra.type
	# 			extraSlug = getSlug ename

				# extraContent = 
				# 	name: ename
				# 	slug: extraSlug
				# 	allowance: extra.allowance
				# 	description: getExtraDescription extraSlug
				# extraHTML = tmpls.extra extraContent

				# extraTable.append extraHTML

		# if prod.hospitals.length
		# 	$.each prod.hospitals, (i,h) ->
		# 		hcover = getSlug h.cover
		# 		hname = filterTitle h.type
		# 		hospitalSlug = getSlug hname

				# hospitalContent = 
				# 	name: hname
				# 	cover: hcover
				# 	slug: hospitalSlug
				# 	description: getHospitalDescription hospitalSlug
				# hospitalHTML = tmpls.hospital hospitalContent

				# switch hcover
				# 	when "covered" then hospitalCovered.append hospitalHTML
				# 	when "restrictedcover" then hospitalRestricted.append hospitalHTML
				# 	when "notcovered" then hospitalNot.append hospitalHTML

			# if prod.name.indexOf('Middle') >= 0
			# 	pregnancy = hospitalCovered.find '.pregnancy, .reproductiveservices'
			# 	pregnancy.remove().clone().insertAfter '#product-'+prod.id+' .hcovered .thead'

			# log 'extras and hospitals built for '+prod.name

	# onSeek = (e) ->
	# 	currentProductId = sliderAPI.currSlideId
	# 	maxSliderSize = sliderAPI.numSlides - 1
	# 	window.product = window.products[currentProductId]

	# 	$('.navigation .button:hidden').show()
	# 	if currentProductId is 0 
	# 		$('#less-coverage').hide()
	# 		log currentProductId
	# 	if currentProductId is maxSliderSize then $('#more-coverage').hide()

	# 	log currentProductId, maxSliderSize

	# 	product = getActiveProduct()
	# 	slug = getSlug product.name

	# 	log 'switched to ' + product.name + ' slider'

	# 	updatePolicyDetails()

	# 	$('.productHeader h3 .productName').text product.name
	# 	$('#input_19_4').val product.name
	# 	$('#quote-fine-print .extraBack').text product.extra_back
	# 	$('#quote-fine-print .featuresGuide').text(product.name+' Features Guide').attr 'href', window.product.pdf
	# 	$('.slider-nav a.active').removeClass 'active'
	# 	$('.slider-nav a').eq(currentProductId).addClass 'active'

	# cookieQuoteDetails = ->
	# 	quoteCookie = window.info
	# 	quoteCookie.product = getActiveProduct()
	# 	quoteCookie.basePrice = calculateValueWithFrequency getActiveProduct().rate.price
	# 	quoteCookie.rebateValue = calculateRebate()
	# 	quoteCookie.lhcValue = calculateValueWithFrequency calculateLHC()
	# 	log JSON.stringify quoteCookie
	# 	Cookie.set 'quote_cookie', quoteCookie, 243234132
	# 	log Cookie.get 'quote_cookie'
	# 	log 'Quote cookie set'

	# preSignup = ->
	# 	# $.fancybox.open $ '#pre-signup'
	# 	$('#input_2_6', '#pre-signup').val window.info.state
	# 	$('#input_2_7', '#pre-signup').val window.info.policy
	# 	$('#input_2_8', '#pre-signup').val getActiveProduct().name
	# 	$('#input_2_9', '#pre-signup').val getActiveProduct().excess

	# 	$(document).on 'gform_confirmation_loaded', (e,f) ->
	# 		$('body').fadeOut()
	# 		window.location.href = 'http://'+window.location.hostname+'/sign-up'

	# updateSliderHeight = ->
	# 	sliderAPI.updateSliderSize()
	# 	$slide = $ sliderAPI.currSlide.content[0]

	# updatePolicyDetails = ->

	# 	log 'updating sidebar policy details'

	# 	priceToShow = applyDiscountLHCRebate()
	# 	window.info.rebateValue = calculateRebate()

	# 	$('.price .dollars').text '$' + priceToShow
	# 	$('.product-head .price .frequency').text window.info.frequency
	# 	$('.rebate strong', '#policyDetails').text '$' + window.info.rebateValue.toFixed 2

	# 	$('[for*="excess"]').hide()

	# 	$.each window.product, (i,p) ->
	# 		$('[for="excess'+p.excess+'"]').show()

	# findMarital = (status, kids) ->
	# 	if status is 'couple' and kids is 'has kids' then return "Fam"
	# 	else if status is 'couple' and kids is 'no kids' then return "Cpl"
	# 	else if status is 'single' and kids is 'has kids' then return "SPFam"
	# 	else if status is 'single' and kids is 'no kids' then return 'Sgl'

	# parseMarital = (marital) ->
	# 	switch marital
	# 		when "Sgl" then return "Single"
	# 		when "Cpl" then return "Couple"
	# 		when "SPFam" then return "Single Parent"
	# 		when "Fam" then return "Family"

	# getActiveProduct = ->
	# 	if window.product[window.info.excess]? 
	# 		return window.product[window.info.excess]
	# 	else return window.product[500]

	# getSlug = (title) ->
	# 	return title.replace(/[^a-zA-Z0-9\s]/g,"").toLowerCase().replace(/\s/g, '')

	# getProductDataUrl = ->
	# 	return domain + '/state/' + window.info.state + '/policy_type/' + window.info.policy + '/excess/' + window.info.excess + '/?callback=?'

	# getProductPDFURL = (product, i) ->
	# 	url = WP_AJAX.ajaxurl
	# 	data = 
	# 		action: 'get-product-pdf'
	# 		code: product.code2
	# 	$.post url, data, (response) ->
	# 		log response
	# 		window.products[i].pdf = response
	# 		$('.product').eq(i).find('.pdf-link').attr 'href', response

	# getRecommendedProducts = ->
	# 	if window.info.age < 31 then age = 25
	# 	else if window.info.age < 38 then age = 31
	# 	else if window.info.age < 55  then age = 38
	# 	else if window.info.age > 55 then age = 55
		
	# 	productMatrix = 
	# 		25 : 
	# 			tax: ['BH', 'SE60', 'B65', 'BM75', 'HP65', 'MB65']
	# 			family: ['MB65', 'MB75', 'M65', 'M75', 'H65', 'H75']
	# 			coverage: ['HP75', 'MB65', 'M85', 'H65', 'H75']
	# 			cheapest: ['BH', 'SE60', 'B65', 'BM65', 'BM75']
	# 		31 : 
	# 			tax: ['BH', 'B65', 'HP65', 'HP75', 'M65']
	# 			family: ['MB65', 'M65', 'M75', 'H65', 'H75']
	# 			coverage: ['B65', 'BM75', 'M65', 'H65', 'H75']
	# 			cheapest: ['BH', 'B65', 'BM65', 'HP65', 'M65', 'M75']
	# 		38 : 
	# 			tax: ['BM65', 'HP65', 'MB65', 'M65', 'H65', 'H75']
	# 			family: ['HP65', 'M65', 'M75', 'H65', 'H75']
	# 			coverage: ['BM65', 'HP65', 'M65', 'H65', 'H75']
	# 			cheapest: ['BH', 'B65', 'BM65', 'HP65']
	# 		55 : 
	# 			tax: ['BH', 'HP65', 'MB65', 'M65', 'HH', 'V65', 'H65']
	# 			kids: ['HP65', 'M65', 'M75', 'H65', 'H75', 'H85']
	# 			coverage: ['M75', 'V65', 'H65', 'H75', 'H85']
	# 			cheapest: ['BH', 'MB65', 'V65', 'H65', 'H75']

	# 	return productMatrix[age][window.info.priority]

	# getAgeRecommendation = ->
	# 	age = window.info.age
	# 	priority = window.info.priority
	# 	kids = window.info.kids
		
	# 	if kids is 'has kids' then kidgroup = 1 else kidgroup = 2
		
	# 	if age < 31 then agegroup = 1
	# 	else if age > 30 and age < 39 then agegroup = 2
	# 	else if age > 38 and age < 56 then agegroup = 3
	# 	else if age > 55 then agegroup = 4
		
	# 	#priority > age > kids
		
	# 	recommendations = 
	# 		tax :
	# 			1 : 2
	# 			2 : 1
	# 			3 : 2
	# 			4 : 3
	# 		family : 
	# 			1 : 2
	# 			2 : 2
	# 			3 : 2
	# 			4 : 2
	# 		coverage : 
	# 			1 : 3
	# 			2 : 3
	# 			3 : 3
	# 			4 : 3
	# 		cheapest : 
	# 			1 : 0
	# 			2 : 0
	# 			3 : 0
	# 			4 : 0

	# 	recommendation = recommendations[priority][agegroup]
	# 	if kidgroup is 1 
	# 		if priority is 'tax' and agegroup is 1
	# 			recommendations--
	# 			log 'drop recommendations 1 because kids'
	# 		else if priority is 'coverage' and agegroup is 4
	# 			recommendations--
	# 			log 'drop recommendations 1 because kids'
	# 	log recommendation
	# 	return recommendation

	# getPolicyType = (status, kids) ->
	# 	if status is 'Cpl'
	# 		if kids is 'has kids'
	# 			policy = "Fam"
	# 		else
	# 			policy = "Cpl"
	# 	if status is 'Sgl'
	# 		if kids is 'has kids'
	# 			policy = "SPFam"
	# 		else
	# 			policy = "Sgl"
	# 	return policy

	# getState = (postcode) ->
	# 	ranges = 
	# 		'NSW' : [1000, 1999, 2000, 2599, 2619, 2898, 2921, 2999]
	# 		'ACT' : [200, 299, 2600, 2618, 2900, 2920]
	# 		'VIC' : [3000, 3999, 8000, 8999]
	# 		'QLD' : [4000, 4999, 9000, 9999]
	# 		'SA' : [5000, 5999]
	# 		'WA' : [6000, 6797, 6800, 6999]
	# 		'TAS' : [7000, 7999]
	# 		'NT' : [800, 999]
		
	# 	exceptions = 
	# 		872 : 'NT'
	# 		2540 : 'NSW'
	# 		2611 : 'ACT'
	# 		2620 : 'NSW'
	# 		3500 : 'VIC'
	# 		3585 : 'VIC'
	# 		3586 : 'VIC'
	# 		3644 : 'VIC'
	# 		3707 : 'VIC'
	# 		2899 : 'NSW'
	# 		6798 : 'WA'
	# 		6799 : 'WA'
	# 		7151 : 'TAS'
		
	# 	postcode = parseInt postcode
	# 	return exceptions[postcode]	if postcode of exceptions
	# 	for state of ranges
	# 		range = ranges[state]
	# 		c = range.length
	# 		i = 0
	
	# 		while i < c
	# 			min = range[i]
	# 			max = range[i + 1]
	# 			return state	if postcode >= min and postcode <= max
	# 			i += 2

	# getLHC = (age) ->
	# 	yearsWithoutCover = age-31
	# 	if yearsWithoutCover > 0 then return parseInt yearsWithoutCover*2
	# 	else return 0

	# getRebate = (age, marital, income) ->
	# 	tier1 = 88000
	# 	tier2 = 102000
	# 	tier3 = 136000
	# 	age1 = 65
	# 	age2 = 70

		# smartass
		# base = 9.68
		# incr = 4.84
		# rebates = 
		# 	0 :
		# 		0 : base+(incr*6)
		# 		1 : base+(incr*5)
		# 		2 : base+(incr*4)
		# 	1 :
		# 		0 : base+(incr*4)
		# 		1 : base+(incr*3)
		# 		2 : base+(incr*2)
		# 	2 :
		# 		0 : base+(incr*2)
		# 		1 : base+incr
		# 		2 : base

		# rebates = 
		# 	0 :
		# 		0 : 38.72
		# 		1 : 33.88
		# 		2 : 29.04
		# 	1 :
		# 		0 : 29.04
		# 		1 : 24.20
		# 		2 : 19.36
		# 	2 :
		# 		0 : 19.36
		# 		1 : 14.52
		# 		2 : 9.68
		
		# if marital is "Cpl" or marital is "Fam" or marital is "SPFam"
		# 	tier1 += tier1
		# 	tier2 += tier2
		# 	tier3 += tier3
		
		# if income < tier1 then incomer = 0
		# else if income > tier1 and income < tier2 then incomer = 1
		# else if income > tier2 and income < tier3 then incomer = 2	
		# else return rebate = 0
			
		# if age < age1 then ager = 2
		# else if age >= age1 and age < age2 then ager = 1
		# else if age >= age2 then ager = 0
		
		# return rebates[incomer][ager]

	# calculateValueWithFrequency = (raw) ->
	# 	switch window.info.frequency
	# 		when 'yearly' then return raw
	# 		when 'monthly' then return parseFloat(raw / 52 * 4.3333)
	# 		when 'weekly' then return parseFloat(raw / 52)
	# 		when 'daily' then return parseFloat(raw / 365)

	# calculateLHC = ->
	# 	if window.info.lhcPercentage > 0 and window.info.applyLHC is true
	# 		gross = calculateValueWithFrequency getActiveProduct().rate.hospital_premium / 100
	# 		lhc = gross * window.info.lhcPercentage
	# 		return parseFloat calculateValueWithFrequency lhc
	# 	else return 0

	# calculateRebate = ->
	# 	if window.info.applyRebate is true
	# 		gross = calculateValueWithFrequency getActiveProduct().rate.price / 100
	# 		rebate = gross * window.info.rebatePercentage
	# 		rebateRounded = Math.ceil(rebate*20 - 0.05) / 20
	# 		return parseFloat rebateRounded
	# 	else return 0

	# calculateDebit = ->
	# 	if window.info.debitPenalty
	# 		gross = getActiveProduct().rate.price / 96
	# 		discount = gross * 4
	# 		return parseFloat calculateValueWithFrequency discount
	# 	else return 0

	# applyDiscountLHCRebate = ->
	# 	#must be used with annual values
	# 	basePrice = parseFloat calculateValueWithFrequency getActiveProduct().rate.price

	# 	log getActiveProduct().rate.price

	# 	lhcValue = 0
	# 	rebateValue = 0
	# 	debitValue = 0

	# 	if window.info.applyLHC then lhcValue = calculateLHC()
	# 	if window.info.applyRebate then rebateValue = calculateRebate()
	# 	if window.info.debitPenalty then debitValue = calculateDebit()

	# 	log window.info.state, 'State: '
	# 	log window.info.policy, 'Policy type: '
	# 	log basePrice, 'Base price: '
	# 	log lhcValue, 'LHC: '
	# 	log getActiveProduct().rate.hospital_premium, 'Hospital premium: '
	# 	log getActiveProduct().rate.price, 'Premium: '
	# 	log rebateValue, 'Rebate: '

	# 	s = basePrice + lhcValue - rebateValue
	# 	return parseFloat(s + debitValue).toFixed 2

	# filterTitle = (title) ->
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
	
	# getExtraDescription = (extra) ->
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
		
	# getHospitalDescription = (hospital) ->
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

	# misc = ->
	# 	$('[name="apply-lhc"]').on 'change', (e) ->
	# 		if $(this).prop('checked')
	# 			window.info.applyLHC = false
	# 			window.info.lhc = 0
	# 		else
	# 			window.info.applyLHC = true
	# 			window.info.lhc = getLHC()

	# 	$('.quote-form [type="text"]').forceNumericOnly()

	# 	$('.features').on 'hover', ->
	# 		$(this).next('.actions').css
	# 			opacity: .5
	# 	, ->
	# 		$(this).next('.actions').css
	# 			opacity: 1

	# 	$('.open-other').toggle ->
	# 		$('+ul', this).fadeIn 150
	# 	, ->
	# 		$('+ul', this).fadeOut 150

	# 	$('[href="#top"]').on 'click', (e) ->
	# 		e.preventDefault()
	# 		resetForm()

	
	#returnToQuote() 

# addCommas = (str) ->
# 	str += ''
# 	x = str.split('.')
# 	x1 = x[0]
# 	x2 = if x.length > 1 then '.'+x[1] else ''
# 	rgx = /(\d+)(\d{3})/
# 	while rgx.test(x1)
# 		x1 = x1.replace rgx, '$1'+','+'$2'
# 	return x1 + x2

# log = (str, desc = '') -> if debug is true then console.log desc, str

