<?php echo $header;?>
<div class="content">
	<div class="contentBody" itemscope="" itemtype="http://schema.org/FoodEstablishment">
		<div class="venueTakeawayPage">
			<!-- #conditionsScheduleInfo -->
			<div id="blockTakeawayRatings" class="blockReviews" style="margin-top: 80px;">
				<div class="_reviews-container">
					<div class="_overall">
						<div class="_left" style="background-color: <?php echo $info['color'];?>">
							<div class="_rate-num"><?php echo $info['total_rating'];?></div>
							<div class="_divider"></div>
							<div class="_v10">10</div>
						</div>
						<div class="_right">
							<div class="_rv-item-holder">
								<div class="_item"><span class="_label">Food</span>
									<div class="_pbar">
										<div class="_inner"></div>
										<div class="_bar" style="width:<?php echo $info['rating']*10;?>%"></div>
									</div>
									<div class="_val"><?php echo $info['rating'];?></div>
								</div>
								<div class="_item"><span class="_label">Value</span>
									<div class="_pbar">
										<div class="_inner"></div>
										<div class="_bar" style="width:<?php echo $info['rating1']*10;?>%"></div>
									</div>
									<div class="_val"><?php echo $info['rating1'];?></div>
								</div>
								<div class="_item"><span class="_label">Speed</span>
									<div class="_pbar">
										<div class="_inner"></div>
										<div class="_bar" style="width:<?php echo $info['rating2']*10;?>%"></div>
									</div>
									<div class="_val"><?php echo $info['rating2'];?></div>
								</div>
							</div>
							<div class="_sub-text">Based on <?php echo $total_reviews;?> user reviews</div>
						</div>
					</div>
					<div class="_orderby-holder">
					</div>
					<div class="_user-reviews">
					<?php foreach($reviews as $review){?>
						<div class="_review-item _has-comment ">
							<div class="_user-info">
								<div class="_cap"><?php if($review['name']){echo substr($review['name'], 0, 1);}?></div>
								<div class="_name"><?php if($review['name']){echo $review['name'];}?></div>
								<div class="_review-cnt "><a href="<?php echo $review['review_url'];?>"><?php echo $review['total_reviews'];?> reviews</a></div>
							</div>
							<div class="_detail">
								<div class="_date"><?php echo $review['date_add'];?></div>
								<div class="_values">
									<div class="_left" style="background-color: <?php echo $review['color'];?>"><?php echo $review['total_rating'];?></div>
									<div class="_right">
										<div class="_rv-item-holder">
											<div class="_item"><span class="_label">Food</span>
												<div class="_pbar">
													<div class="_inner"></div>
													<div class="_bar" style="width:<?php echo $review['rating']*10;?>%"></div>
												</div>
												<div class="_val"><?php echo $review['rating'];?></div>
											</div>
											<div class="_item"><span class="_label">Value</span>
												<div class="_pbar">
													<div class="_inner"></div>
													<div class="_bar" style="width:<?php echo $review['rating1']*10;?>%"></div>
												</div>
												<div class="_val"><?php echo $review['rating1'];?></div>
											</div>
											<div class="_item"><span class="_label">Speed</span>
												<div class="_pbar">
													<div class="_inner"></div>
													<div class="_bar" style="width:<?php echo $review['rating2']*10;?>%"></div>
												</div>
												<div class="_val"><?php echo $review['rating2'];?></div>
											</div>
										</div>
									</div>
								</div>
								<div style="clear: both"></div>
								<div class="_review-text  <?php if(!$review['text']){?>_hidden <?php }?>">
									<div class="_triangle"></div>
									<div class="_triangle2"></div>
									<div class="_text">
									<?php echo $review['text'];?>
									</div>
								</div>
							</div>
							<div style="clear: both"></div>
							<div></div>
						</div>
						<?php }?>
					</div>
				</div>
				<div class="forms">
					<a href="/" id="viewMenu">GO BACK TO MENU</a>
					<div class="newRating">
						<div id="newTakeawayRating">
							<div class="addReview box1">
							<?php if($is_review) {?>

								<h2>Add a review</h2>
								<p>Our records show that you did not order from this restaurant or a review has already been submitted for your last completed order from this restaurant and only one review per received order is allowed.</p>

							<?php }else{ ?>
							
								<div class="core-ifhBlock" id= "from_confirm" style="display: none;"><h2>Review Complete</h2><p>Thank you for submitting your rating.  All ratings need to pass through quality control,  please allow 2-3 days before your rating is visible on the site.</p></div>
								
								<div id="core-ajaxForm" class="core-ifhBlock ratingForm core-ajaxForm">
										<fieldset>
											<h2>Add a review</h2>
											<ul class="ratingLabels">
												<li class="bad">Poor</li>
												<li class="good">Excellent</li>
												<li class="avg">Average</li>
											</ul>
											<div class="contentEnd"></div>
											<div class="ruler"><span id="rulerStart">▮</span><span>|</span><span>|</span><span>|</span><span>|</span><span>|</span><span>|</span><span>|</span><span>|</span><span id="rulerEnd">▮</span></div>
											<ul class="ratingCriteriaList">
												<li>
													<div class="title">FOOD</div>
													<div id="message_ratingCriteria0_LcRecXLQ" class="core-message"></div>
													<input type="hidden" name="rating" />
													<div class="ratingReadable" id="ratingReadable"></div>
												</li>
												<li>
													<div class="title">VALUE</div>
													<div id="message_ratingCriteria0_LcRecXLQ2" class="core-message"></div>
													<input type="hidden" name="rating1" />
													<div class="ratingReadable" id="ratingReadable2"></div>
												</li>
												<li>
													<div class="title">SPEED</div>
													<div id="message_ratingCriteria0_LcRecXLQ3" class="core-message"></div>
													<input type="hidden" name="rating2" />
													<div class="ratingReadable" id="ratingReadable3"></div>
												</li>
											</ul>
											<label for="comment_X4jR0BVN" class="title">YOUR EXPERIENCE</label>
											<div class="contentEnd"></div>
											<textarea id="comment_X4jR0BVN" name="text" placeholder="To make your review more relevant consider adding restaurant name, cuisine and food item to your review"></textarea>
											<div class="core-dialogueButtons">
												<div class="core-left">
													<input type="hidden" name="location_id" value="<?php echo $location_id;?>">
													<input type="hidden" name="name" value="<?php echo $name;?>">
													<input type="hidden" name="order_id" value="<?php echo $order_id;?>">
													<input type="submit" class="button addReviewButton" name="" value="ADD REVIEW" id="button-review">
												</div>
											</div>
											<div class="contentEnd"></div>
											<p class="smallSpaceAbove conditions">Only comments directly related to your restaurant experience will be published. Swearing, personal attacks or competitor comparisons will not be published. Only one review per received order is allowed.</p>
											<p class="conditions">By clicking the ADD REVIEW button, you confirm that you have understood and agree to our <a href="#" target="_blank">Privacy Policy</a> and <a href="#" target="_blank">Terms of Use</a>.</p>
										</fieldset>
								</div>

							<?php }?>

							</div>
						</div>
					</div>
				</div>
				<div class="contentEnd"></div>
				<?php echo $pagination; ?>
			</div>
		</div>
		<script>
		$(function() {
			$("#message_ratingCriteria0_LcRecXLQ").slider({
				range: "min",
				min: 1,
				max: 10,
				value: 5,
				slide: function(event, ui) {
					$("input[name='rating']").val(ui.value);
					$("#ratingReadable").text(ui.value);
				}
			});
			$("input[name='rating']").val($("#message_ratingCriteria0_LcRecXLQ").slider("value"));
			$("#ratingReadable").text($("#message_ratingCriteria0_LcRecXLQ").slider("value"));

			$("#message_ratingCriteria0_LcRecXLQ2").slider({
				range: "min",
				min: 1,
				max: 10,
				value: 5,
				slide: function(event, ui) {
					$("input[name='rating1']").val(ui.value);
					$("#ratingReadable2").text(ui.value);
				}
			});
			$("input[name='rating1']").val($("#message_ratingCriteria0_LcRecXLQ2").slider("value"));
			$("#ratingReadable2").text($("#message_ratingCriteria0_LcRecXLQ2").slider("value"));

			$("#message_ratingCriteria0_LcRecXLQ3").slider({
				range: "min",
				min: 1,
				max: 10,
				value: 5,
				slide: function(event, ui) {
					$("input[name='rating2']").val(ui.value);
					$("#ratingReadable3").text(ui.value);
				}
			});
			$("input[name='rating2']").val($("#message_ratingCriteria0_LcRecXLQ3").slider("value"));
			$("#ratingReadable3").text($("#message_ratingCriteria0_LcRecXLQ3").slider("value"));
		});

		$('#button-review').on('click', function() {
			var name = $('[name=name]').val();
			var location_id = $('[name=location_id]').val();
			var order_id = $('[name=order_id]').val();
			var rating2 = $('[name=rating2]').val();
			var rating1 = $('[name=rating1]').val();
			var rating = $('[name=rating]').val();
			var text = $('#comment_X4jR0BVN').val();
			$.ajax({
				url: 'index.php?route=shop/reviews/write&product_id=<?php echo $location_id; ?>',
				type: 'post',
				dataType: 'json',
				data: {name:name,rating2:rating2,rating1:rating1,rating:rating,text:text,location_id:location_id,order_id:order_id},
				beforeSend: function() {
					$('#loading').show();
				},
				complete: function() {
					$('#loading').hide();
				},
				success: function(json) {
					$('#from_confirm').show();
					$('#core-ajaxForm').hide();
				}
			});
		});
		</script>
		<?php echo $footer;?>
