<?php echo $header; ?>
<div class="content">
	<div class="contentBody">
		<div class="tACheckoutCompletePage">
			<div class="confirmationLeft" style="float: none; margin: 0 auto; width: 650px;">
				<div class="flex-container topText orderSubmittedMessage module">
					<div class="flex-item">
						<i class="fa fa-check-circle" aria-hidden="true"></i>
					</div>
					<div class="flex-item">
						<h1>All done,<?php echo $order_info['firstname']?> <?php echo $order_info['lastname'];?> !</h1>
						<h1>Your order is submitted.</h1>
					</div>
				</div>
				<div class="module your-order">
					<div class="heading">
						<h2>Your order</h2>
					</div>
					<div class="main">
						<div class="top">
							<div>
								<h3>You ordered from:</h3>
								<div class="flex-container">
									<div class="flex-item image">
										<img src="<?php echo $logo;?>" width="75px">
									</div>
									<div class="flex-item content">
										<p><strong><?php echo $location_info['name'];?></strong>
											<br><?php echo $location_info['address'];?>
										</p>
										<p>For any changes to your order, please contact 
											<br>us directly by phone on
											<span class="number"><strong><?php echo $location_info['telephone'];?></strong></span></p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="module">
					<div class="flex-container">
						<div class="flex-item">
							<h3>Order details</h3>
							<table class="details">
								<tbody>
									<tr>
										<td>Order number:</td>
										<td class="result"><?php echo $order_id;?></td>
									</tr>
									<tr>
										<td>Order total:</td>
										<td class="result"><?php echo $order_info['total'];?></td>
									</tr>
									<tr>
										<td>Payment method:</td>
										<td class="result"><?php echo $order_info['shipping_method'];?></td>
									</tr>
									<tr>
										<td>Requested time:</td>
										<td class="result"><?php echo $order_info['shipping_orderTime']?> on <?php echo $order_info['shipping_orderDate'];?></td>
									</tr>
								</tbody>
							</table>
						</div>
						<?php if($order_info['shipping_method'] == 'Delivery') {?>
						<div class="flex-item">
							<h3>Delivery address</h3>
							<p>
								<?php echo $order_info['firstname']?> <?php echo $order_info['lastname'];?>
								<br><?php echo $order_info['shipping_address_1']?>, <?php echo $order_info['shipping_address_2']?>
								<br> <?php echo $order_info['telephone'];?>
							</p>
						</div>
						<?php }?>
					</div>
				</div>
				<!--<div class="module share-your-experience">-->
					<!--<div class="heading">-->
						<!--<h2>Share your experience</h2>-->
					<!--</div>-->
					<!--<div class="main" id="shareYourExperience">-->
						<!--<div class="left">-->
							<!--<h3>Tell your friends</h3>-->
							<!--<a href="https://www.facebook.com/sharer.php?u=https://www.menulog.com.au/the-schnitzel-kitchen" class="social facebook"><span>Share on Facebook</span></a>-->
							<!--<a href="https://twitter.com/intent/tweet?text=I+just+placed+an+order+at+The+Schnitzel+Kitchen+%40menulog.+Check+them+out.&amp;url=https%3A%2F%2Fwww.menulog.com.au%2Fthe-schnitzel-kitchen" class="social twitter"><span>Share on Twitter</span></a>-->
							<!--<a href="https://plus.google.com/share?url=https://www.menulog.com.au/the-schnitzel-kitchen" class="social google-plus"><span>Share on Google Plus!</span></a>-->
						<!--</div>-->
						<!--<div class="right">-->
							<!--<h3>Share your meal on Instagram</h3>-->
							<!--<div class="social instagram"><span>Share on Instgram</span></div>-->
							<!--<p>When your food arrives, take a photo and tag it <strong class="hashtag">#Online Order</strong>-->
							<!--</p>-->
						<!--</div>-->
					<!--</div>-->
				<!--</div>-->
				<div class="module what-happens-next margin">
					<div class="main">
						<h2>What happens next?</h2>
						<div class="flex-container flex-container-center">
							<div class="flex-item">
								<span class="counter">01</span>
								<span class="text1">The restaurant receives your order.</span>
							</div>
							<div class="flex-item">
								<span class="counter">02</span>
								<?php if($order_info['shipping_method'] == 'Delivery') {?>
								<span class="text2">You receive an email with delivery time.</span>
								<?php }else{ ?>
								<span class="text2">You receive an email with pick-up time.</span>
								<?php }?>
							</div>
							<div class="flex-item">
								<span class="counter">03</span>
								<?php if($order_info['shipping_method'] == 'Delivery') {?>
								<span class="text3">Food is delivered to your door.</span>
								<?php }else{ ?>
								<span class="text2">Food is ready for pick-up.</span>
								<?php }?>
							</div>
						</div>
						<!-- .flex-container -->
					</div>
				</div>
				<div class="module what-happens-next margin">
					<div class="main">
						<div class="flex-container flex-container-center">
							If you didn’t receive the email confirmation, please check your junk mail box.<br/>
							The preparation time required is minimum <?php echo $times_info['pretime']['delivery'];?> minutes for delivery and <?php echo $times_info['pretime']['pickup'];?> minutes for pickup.<br/>
							* Delivery time may increase during peak hours.<br/>
						</div>
						<!-- .flex-container -->
					</div>
				</div>
			</div>
			<!--<div class="confirmationRight">-->
				<!--<div class="mobileapp">-->
					<!--<h2>Download our <br>FREE MOBILE APP!</h2>-->
					<!--<h3>Order takeaway anywhere, anytime!</h3>-->
					<!--<a href="/apps.php">-->
						<!--<img src="/catalog/view/theme/menulog/image/download_app_thumbnail_v3.png">-->
					<!--</a>-->
					<!--<h3>We can <strong>SMS</strong> you the link to our app...</h3>-->
					<!--<div id="core-ajaxForm-28da6d0e5ddc7f16f77bbfba25562088" class="core-ifhBlock">-->
						<!--<form action="https://www.menulog.com.au/ajax_sms.php" method="post" class="core-ajaxForm send-app-link-form" id="send-app-link-form">-->
							<!--<input type="submit" value="" class="core-hiddenSubmit">-->
							<!--<div class="send-app-link">-->
								<!--<input type="hidden" name="smsType" value="customer">-->
								<!--<input type="text" name="phoneNumber" value="18879007801" readonly="">-->
								<!--<input type="hidden" name="message" value="Download the free Menulog App https://m.menulog.com.au/apps.php">-->
								<!--<input type="hidden" name="country" value="Australia">-->
								<!--<input name="CSRFToken" type="hidden" value="5930c5f5ecb865.11490701">-->
								<!--<input class="button suggest-submit" type="submit" value="SEND">-->
							<!--</div>-->
						<!--</form>-->
					<!--</div>-->
					<!--<h4>Or download from the app stores:</h4>-->
					<!--<div class="icon">-->
						<!--<a href="http://ad.apps.fm/QAzSyqQvhMdrFTKrwwSY5fE7og6fuV2oOMeOQdRqrE25PHT4cAtafJbPR4qrXvpkuu-ENBsPWBc0oG5VA0o6psZW-aZt7fHVHKGyjinLV07i_WYzqxJluATc7vPnlHi-aDdtGuWnWf-50f3YX7laWnTLeIHWt3Jtqy5TGcUuHAzoLfrOy57wsePYtH4ezJ-3"><img src="/catalog/view/theme/menulog/image/badge_app_store@2x.png"></a>-->
						<!--<a href="https://ad.apps.fm/tDafrm4f5YbbCDQYkno9tl5KLoEjTszcQMJsV6-2VnHFDLXitVHB6BlL95nuoNYfOrNSOSR3EuoB_IIEsY7_bfZO-OrtcRMLZ9zxTg4WeyGXdGf4SAjyWGGuHqkBN7lN"><img src="/catalog/view/theme/menulog/image/badge_play_store@2x.png"></a>-->
					<!--</div>-->
				<!--</div>-->
			<!--</div>-->
			<div class="contentEnd"></div>
		</div>
<?php echo $footer; ?>
