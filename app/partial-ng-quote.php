<?php 
$base = get_bloginfo('template_directory').'/ng/app';
	wp_dequeue_script('quote');
	wp_deregister_script('quote');

 ?>	




<div class="quote partial border-bottom">
	<div class="hide-popup"></div>
		<script>
		var Util;
		var PDF_AJAX = { url : '<?php echo admin_url( "admin-ajax.php" ); ?>' };
	</script>
	<script type='text/javascript' src='<?php echo $base; ?>/js/util.js'></script>
	<script type='text/javascript' src='<?php echo $base; ?>/js/quote.js'></script>
	<script type='text/javascript' src='<?php echo $base; ?>/js/underscore-min.js'></script>
	<link rel="stylesheet" type="text/css" href="<?php echo $base; ?>/bower_components/flexslider/flexslider.css">
	<script src="<?php echo $base; ?>/bower_components/flexslider/jquery.flexslider.js"></script>
	<script src="<?php echo $base; ?>/bower_components/angular/angular.js"></script>
<script src="<?php echo $base; ?>/bower_components/angular-route/angular-route.js"></script>
<script src="<?php echo $base; ?>/bower_components/angular-flexslider/angular-flexslider.js"></script>
<script src="<?php echo $base; ?>/bower_components/angular-cookie/angular-cookie.js"></script>

<script src="<?php echo $base; ?>/js/app.js"></script>
<script src="<?php echo $base; ?>/js/services.js"></script>
<script src="<?php echo $base; ?>/js/controllers.js"></script>
<script src="<?php echo $base; ?>/js/filters.js"></script>
<script src="<?php echo $base; ?>/js/directives.js"></script>




<div class="quoteapp" ng-app="quoteApp" ng-controller="MainController" ng-init="init()" ng-cloak>
  <div class="">
	
	<div class="row" id="quote-row">
		
		<div class="small-12 medium-12 large-12 columns">
			<h1>Get a quote</h1>
			<p>We take into account the important factors in your life, so we can give you the best possible policy. Select each option below, and click “See plans” to see what we’ve got for you. <strong>Please enter all options to get a quote.</strong></p>
		</div>
		
		<div class="small-12 medium-12 large-12 columns oscar">
			<form name="quote-form" method="post" action="#" class="quote-form">
				<div class="popup choice first-row" id="marital">
					<ul>
						<li>
							<input type="radio" ng-model="form.marital" name="quote-marital" value="Sgl" id="mar-sgl">
							<label for="mar-sgl">single</label>
						</li>
						<li>
							<input type="radio" ng-model="form.marital" name="quote-marital" value="Cpl" id="mar-cpl">
							<label for="mar-cpl">couple</label>
						</li>
					</ul>
				</div>
		
				<div class="popup choice first-row" id="has-kids">
					<ul>
						<li>	
							<input type="radio" ng-model="form.kids" name="quote-has-kids" value="no kids" id="hasnt_kids">
							<label for="hasnt_kids">no kids</label>
						</li>
						<li>
							<input type="radio" ng-model="form.kids" name="quote-has-kids" value="has kids" id="has_kids">
							<label for="has_kids">kids</label>
						</li>
					</ul>
				</div>
		
				<div class="popup choice tall" id="priority">
					<ul>
						<li>
							<input type="radio" ng-model="form.priority" name="quote-priority" value="tax" id="priority-tax">
							<label for="priority-tax">{{ priorityLabels['tax'] }}</label>
						</li>
						<li>
							<input type="radio" ng-model="form.priority" name="quote-priority" value="family" id="priority-family">
							<label for="priority-family">{{ priorityLabels['family'] }}</label>
						</li>
						<li>
							<input type="radio" ng-model="form.priority" name="quote-priority" value="coverage" id="priority-coverage">
							<label for="priority-coverage">{{ priorityLabels['coverage'] }}</label>
						</li>
						<li>
							<input type="radio" ng-model="form.priority" name="quote-priority" value="cheapest" id="priority-cheapest">
							<label for="priority-cheapest">{{ priorityLabels['cheapest'] }}</label>
						</li>
					</ul>
				</div>
		
				<div class="popup input check" id="age1">
					<input type="text" ng-model="form.age1" name="quote-age1" placeholder="30" maxlength="2">
					<button>OK</button>
				</div>
		
				<div class="popup input" id="age2">
					<input type="text" ng-model="form.age2" name="quote-age2" placeholder="35" maxlength="2">
					<button>OK</button>
				</div>
		
				<div class="popup input" id="sgl-income">
					<input type="text" ng-model="form.sglIncome" name="quote-sgl-income" placeholder="72,000" maxlength="7">
					<button>OK</button>
				</div>
		
				<div class="popup input" id="cpl-income">
					<input type="text" ng-model="form.cplIncome" name="quote-cpl-income" placeholder="144,000" maxlength="7">
					<button>OK</button>
				</div>
		
				<div class="popup input" id="postcode">
					<input type="text" ng-model="form.postcode" name="quote-postcode" placeholder="3006" maxlength="4">
					<button>OK</button>
				</div>
		
				<p>
					{{ form.marital == 'Cpl' && 'We are a' || 'I am' }}
					<a href="#open-marital" ng-class="{ 'c_maritalStatus validate' : true, 'validate' : true, 'incomplete' : ! form.marital }">{{ form.marital == 'Cpl' && 'couple' || 'single' }}</a> 

					with <a href="#open-has-kids" ng-class="{ 'validate' : true, 'incomplete' : ! form.kids }">{{ form.kids == 'has kids' && 'kids' || 'no kids' }}</a>.

					{{ form.marital == 'Cpl' && 'We are ' || 'I am ' }}
					<a href="#open-age1" ng-class="{ 'validate' : true, 'incomplete' : ! form.age1 }">{{form.age1 || 30 }}</a>
					<span ng-hide="form.marital != 'Cpl'"> and <a href="#open-age2" ng-class="{ 'validate' : true, 'incomplete' : ! form.age2 }">{{form.age2 || 35 }}</a></span>
					 years old.
				</p>
		
				<p>
					{{ form.marital == 'Cpl' && 'We' || 'I' }} earn 
					<a href="#open-sgl-income" ng-show=" ! form.marital || form.marital == 'Sgl'" ng-class="{ 'validate' : true, 'incomplete' : ! form.sglIncome  }">${{ (form.sglIncome|addCommas) || '72,000' }}</a>
					<a href="#open-cpl-income" ng-hide="form.marital != 'Cpl'" ng-class="{ 'validate' : true, 'incomplete' : ! form.cplIncome }">${{ (form.cplIncome|addCommas) || '144,000' }}</a>
					per year. 
					{{ form.marital == 'Cpl' && 'Our' || 'My' }} Postcode is
					<a href="#open-postcode" ng-class="{ 'validate' : true, 'incomplete' : ! form.postcode }">{{ form.postcode || '3006' }}</a>
				</p>

				<p>
					and {{ form.marital == 'Cpl' && 'we' || 'I' }}
					want <a href="#open-priority" ng-class="{ 'validate' : true, 'incomplete' : !form.priority }">{{ form.priority && priorityLabels[form.priority] || priorityLabels['cheapest'] }}</a>.
				</p>
	
				<a ng-class="{ button : true, disabled_btn : (! form.marital || ! form.kids || ! form.age1 || ! form.sglIncome || ! form.priority || ! form.postcode || (form.marital == 'Cpl' && !form.cplIncome) || (form.marital == 'Cpl' && !form.age2)) }" ng-click="getPlans()">See plans</a> 

				<i class="fa fa-2x fa-spinner fa-spin" id="quote-loader" ng-show="{{ busy }}"></i>
				
			</form>
		</div>	
	
	</div>
	
	<div class="row showQuote">
	
		<div ng-show="slideshow.visibleProducts.length">

        		<div class="product-header row">
                    <div class="twelve columns">
                        <hr class="show-for-small-only">
    	        		<h2 class="museo">We recommend...</h2>
    	        		<p class="float-right">Based on you being {{ (form.kids == 'has kids' || form.marital == 'Cpl') && 'a' || '' }} {{ setPrettyPolicy() }}, aged {{ age() }} living in {{ setState() }}.</p>
                        <p class="show-for-small"><strong>Swipe left and right to see products.</strong></p>
                    </div>
        		</div>
        		
        		<div class="slider-nav" id="quote-nav">
        			<a ng-repeat="p in slideshow.visibleProducts" class="{{p.1.info.name.toLowerCase()}}" ng-class="{ active : $index == recommendedIndex }"><span>{{ viewAll && p.0 || p.1.info.name}}</span></a>
        		</div>

        		<div class="row">
            		<div class="productInformation large-9 columns">
            			<p class="navigation show-for-medium-up text-center">
            				<span class="prev small button left" ng-click="slideshow.prev()" ng-class="{fade: sliderObj.currentSlide === 0}"><i class="fa fa-chevron-left"></i>cheaper coverage</span> 
            				<span class="see-more small yellow button" ng-click="slideshow.all()"><i class="fa {{ viewAll && 'fa-eye-slash' || 'fa-eye' }}"></i>See {{ viewAll && 'less' || 'more' }} products</span>
            				<span class="small button" ng-click="slideshow.allAll()">View ALL products</span>
            				<span class="next small button right" ng-click="slideshow.next()" ng-class="{fade: sliderObj.currentSlide === sliderObj.count-1}">better coverage<i class="fa fa-chevron-right"></i></span>
            			</p>
            			<hr>
            			<div class="product-scroller">
                            <div id="excess-loading"><div><i class="fa fa-spin fa-4x fa-spinner"></i></div></div>
    	        			<div class="products" id="productsInsert">

								<style>
									.flexslider {
										margin: 0;
										border: 0;
										-webkit-border-radius: 0;
										-moz-border-radius: 0;
										-o-border-radius: 0;
										border-radius: 0;
										-webkit-box-shadow: none;
										-moz-box-shadow: none;
										-o-box-shadow: none;
										box-shadow: none;
									}
									.button.disabled_btn { background-color: #cccccc; }
									aside.policyDetails .variables li .input_tmp_checked { background: #f6f6f6 !important; }

									.fa.hide{
										display: none!important;
									}
								</style>

								<flex-slider 
									slide="p in slideshow.visibleProducts" 
									animation="slide"
									slideshow="false"
									animation-loop="false"
									start-at="{{recommendedIndex}}"
									start="slideshow.start($slider)"
									direction-nav="false"
									manual-controls=".slider-nav a"
									after="slideshow.after()">
									<li>

										<div class="product {{createSlug(p.1.info.name)}}" id="product-{{p.1.info.id}}">
											<div class="product-head">
												<h3>{{p.1.info.name}}</h3>    	
												<p class="extra-return" ng-show="p.1.info.extra_back"><span>{{p.1.info.extra_back}}</span>% back on your extras</p>
												<div ng-show="p.1.info.description">
													<p class="description">{{p.1.info.description}}</p>
													<p class="hide-for-large-up price-summary price"><span class="dollars">${{ price }}</span> <span class="frequency">{{ frequency }}</span>. <br class="show-for-small"> <a href="#policyDetails">See price breakdown</a></p>
													<p class="product-image"> <i class="fa fa-hospital-o fa-4x"></i> <br class="show-for-small">  <i class="fa fa-plus fa-2x"></i> <br class="show-for-small"><i class="fa fa-heart fa-4x"></i>
												</div>
												<hr>
											</div>
											<div class="row">
								
												<div class="hospital small-12 medium-6 large-6 columns">
													<div ng-show="p.1.info.hospitals.length">
														<h4>Hospital Cover <span>Here's what we'll cover you on:</span></h4>
														<h5>We cover every area except the things with x’s below.</h5>
														<ul class="hcovered">
															<li class="thead">Examples of whats covered</li>
															<li ng-repeat="h in p.1.info.hospitals | filter: { cover: 'Covered' }: true" class="{{createSlug(h.cover)}} {{createSlug(h.type)}}">
																{{h.type | titleFilter}}
																<div description-popup rel="{{ createSlug((h.type | titleFilter)) }}" type="hospital"></div>
															</li>
														</ul>
														<ul class="hrestricted">
															<li class="thead">Covered with restricted benefit</li>
															<li ng-repeat="h in p.1.info.hospitals | filter: { cover: 'Restricted Cover' }: true" class="{{createSlug(h.cover)}} {{createSlug(h.type)}}">
																{{h.type | titleFilter}}
																<div description-popup rel="{{ createSlug((h.type | titleFilter)) }}" type="hospital"></div>
															</li>
														</ul>
														<ul class="hnot" ng-hide="p.1.info.code2 == 'SE60'">
															<li class="thead">Excluded</li>
															<li ng-repeat="h in p.1.info.hospitals | filter: { cover: 'Not Covered' }: true" class="{{createSlug(h.cover)}} {{createSlug(h.type)}}">
																{{h.type | titleFilter}}
																<div description-popup rel="{{ createSlug((h.type | titleFilter)) }}" type="hospital"></div>
															</li>
														</ul>

														<p class="alert-box alert" ng-show="p.1.info.code2 == 'SE60'"><strong>NOTE:</strong> we ONLY cover what is listed above, and nothing else.</p>
														
														
														<hr class="show-for-small">
													</div>
													<div ng-hide="p.1.info.hospitals.length">
														<h4>Extras only has no hospital benefits <span>But click below to upgrade!</span></h4>
														<a class="upgrade-product" ng-click="upgradeProduct()"><strong>+</strong> Give me hospital benefits</a>
													</div>
												</div>
		
												<div class="extras small-12 medium-6 large-6 columns">
													<div ng-show="p.1.info.extra_back">
														<h4>Extra Benefits <span>Worth ${{p.1.info.extras_value}} per year per person</span></h4>
														<h5>We pay <span class="">{{p.1.info.extra_back}}</span>% of your bill up to the annual limits</h5>
														<ul class="items">
															<li class="thead">
																Extra
																<span class="limit">Annual Limit Per Person</span>
															</li>
															<li ng-repeat="e in p.1.info.extras" class="{{createSlug(e.type)}}">
																{{ e.type | titleFilter }}
																<span class="limit">${{e.allowance | number:0}}</span>
																<div description-popup rel="{{ createSlug((e.type | titleFilter)) }}" type="extra"></div>
															</li>												
														</ul>
											
														<p class="ambulance">Emergency Ambulance is covered too!</p>
													</div>
													<div ng-hide="p.1.info.extra_back">
														<h4>Hospital only has no extras <span>But click below to upgrade!</span></h4>
														<a class="upgrade-product" ng-click="upgradeProduct()"><strong>+</strong> Give me extras</a>
													</div>
												</div>
									
												<div class="details small-12 medium-12 large-12 columns">
													<div class="clearfix"></div>
													<p class="guarantee">All of our plans have a 30 Day Money Back Guarantee. All of your premiums back, less any claims we have paid, so you can be sure you're getting the best.</p>
													<div class="row buttons">
														<div class="small-12 medium-4 large-4 columns">
															<a fancybox ng-click="openFancybox('<?php echo $base ?>/partials/quote-fine-print.html')" class="small muted button">show the fine print</a>
														</div>
														<div class="small-12 medium-4 large-4 columns">
															<a fancybox ng-click="openFancybox('<?php echo $base ?>/partials/pre-signup.html')" class="signup_track small yellow button">Buy this cover</a>
														</div>
														<div class="small-12 medium-4 large-4 columns">
															<a ng-href="{{pdfs[currentProduct[0]]}}" class="pdf-link signup_track small muted button" target="_blank">Download PDF</a>
														</div>
													</div>
													<p class="buttons"> </p>
												</div>
									
											</div>
										</div>

									</li>
								</flex-slider>

    		        		</div>
    	        		</div>
            		</div>
            		
            		<aside class="policyDetails large-3 columns" id="policyDetails">
                        <div class="row">
                            <div class="small-12 medium-6 large-12 columns">
                                <div class="panel show-for-large-up kids-excess hide">Zero excess for your kiddies!</div>
                    			<ul class="variables">
                    				<li class="excess">
                    					<span class="tooltop">Click to Change</span>
                    					<input type="radio" ng-model="excess" name="excess" id="excess500" value="500" class="hidden">
                    					<label for="excess500" ng-show="slideshow.visibleProducts[currentIndex][1]._500"><strong>$500</strong> <span>Hospital Excess</span></label>
                    					<input type="radio" ng-model="excess" name="excess" id="excess250" value="250" class="hidden">
                    					<label for="excess250" ng-show="slideshow.visibleProducts[currentIndex][1]._250"><strong>$250</strong> <span>Hospital Excess</span></label>
                    					<input type="radio" ng-model="excess" name="excess" id="excess0" value="0" class="hidden">
                    					<label for="excess0" ng-show="slideshow.visibleProducts[currentIndex][1]._0" class="hidden"><strong>$0</strong> <span>Hospital Excess</span></label>
                    				</li>
                    				
                    				<!--<li class="debit">
                    					<span class="tooltip">Click to Change</span>
                    					
                    					<input type="radio" name="debitdiscount" id="ddebitdiscount" value="0" class="hidden" checked>
                    					<label for="ddebitdiscount"><strong>4%</strong> <span>Direct Debit Discount</span></label>
                    					<input type="radio" name="debitdiscount" id="ccarddiscount" value="4" class="hidden">
                    					<label for="ccarddiscount"><strong></strong><span>Pay with Credit Card</span></label>
                    				</li>-->
                    				
                    				<li class="rebate">	
                    					<span class="tooltop">This is based on you being <span class="replace-age">{{ age() }}</span>, and your income of <span class="replace-income">${{ income() | addCommas }}</span>!</span>
                    					<label><strong class="replace-rebate">${{ rebateValue }}</strong> <span>Government Rebate</span></label>
                    				</li>
                    				
                    				<!--<li class="lhc">
                    					<span class="tooltip">
                    					 I am switching funds so <a href="#lhc">Lifetime Health Cover Loading</a> does not apply to me <input type="checkbox" name="apply-lhc" id="lhc" value="no-lhc"></span>
                    					<label for="lhc"><strong>12% LHC</strong> <span>(may not apply)</span></label>
                    				</li>-->

                                    <div class="price">
                                        <h3 class="productName"></h3>
                                        <span class="dollars">${{price}}</span><br>
                                        
                                        <div class="frequency">
                                            <input type="radio" ng-model="frequency" name="frequency" id="weekly" value="weekly" class="hidden">
                                            <label for="weekly">Weekly</label>
                                            <input type="radio" ng-model="frequency" name="frequency" id="monthly" value="monthly" class="hidden">
                                            <label for="monthly">Monthly</label>
                                            <input type="radio" ng-model="frequency" name="frequency" id="yearly" value="yearly" class="hidden">
                                            <label for="yearly">Yearly</label>
                                        </div>
                                    </div>
                    				
                    			</ul>
                            </div>
                            <div class="small-12 medium-6 large-12 columns">
                    			<div class="panel hide-for-large-up kids-excess hide">Zero kids excess for the kiddies!</div>
                    			
                    			<div class="flag">
                    				<p class="phone-number museo">1300 199 802</p>
                    				<p class="opt2"><a href="#leavenumber">Leave your number</a><div data-id="Te9q_tHkLO" class="livechat_button">live chat loading...</div></p>
                    				<!-- gravityform -->
                    				<div class="leavemynumber" id="leave-number-form">
                    					<?php echo do_shortcode('[gravityform id="1" title="false" description="false" ajax="true"]'); ?>
                    				</div>
                    			</div>
                    			<p class="buttons">
                    				<a fancybox ng-click="openFancybox('<?php echo $base ?>/partials/pre-signup.html')" class="signup_track button yellow">Buy this cover</a>
                    				<!--<a href="#more-products" class="blue" class="view_product_compare">Compare all products</a>-->
                    			</p>

                                <div class="disclaimer">
                                    <p><i class="fa fa-exclamation-triangle"></i> Important information about your quote</p>
                                    <div class="tiptop"><?php echo ot_get_option('quote_disclaimer'); ?></div>
                                </div>
                            </div>
                        </div>
            		</aside>
        		</div>    		

        	</div>	
        	
    </div>
	
  </div>

  <!-- In production use:
<script src="//ajax.googleapis.com/ajax/libs/angularjs/x.x.x/angular.min.js"></script>
-->

</div>
</div>
	




