<html xmlns="http://www.w3.org/1999/xhtml" id="mainform">

<head id="head">
	<title>
        Online Order Secure Payment Gateway
	</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link type="text/css" href="/catalog/view/theme/menulog/stylesheet/WebStyleSheet.css" rel="StyleSheet">
	<meta name="viewport" content="width=1024">
    <style>
        #CreditCardTokenization1_PayPal1_btnBackToOrder, #CreditCardTokenization1_PayPal1_btnSave
        {
            background-color: <?php echo $_SESSION['color1'];?>!important;
        }
    </style>
</head>

<body onunload="">
	<div id="pnlWrapperNoApp" class="headerWrapper" style="background-color: <?php echo $_SESSION['color'];?>!important;">
		<div class="content">
			<div class="menulogIcon" style="padding-top: 0px;">
				<img src="/image/logo.png">
			</div>
		</div>
	</div>
	<div class="outerHolder">
		<div class="container">
			<div id="CreditCardTokenization1_PayPal1_panel1">
				<div class="container">
					<div class="contentEnd"></div>
					<div class="sectionTitle">Payment Summary </div>
					<p></p>
					<div class="Outer">
						<div class="borderM">
							<div class="DisplayTitle"><span id="CreditCardTokenization1_PayPal1_ReferenceCode">Order Number</span></div>
							<div class="DisplayTopText DisplayTextMobileNoStack"><span id="CreditCardTokenization1_PayPal1_lblReferenceCode"><?php echo $order_id;?></span></div>
							<div class="contentEnd"></div>
						</div>
					</div>
					<div class="Outer">
						<div class="borderM">
							<div class="DisplayTitle"><span id="CreditCardTokenization1_PayPal1_Amount">Your Order</span></div>
							<div class="DisplayTopText DisplayTextMobileNoStack"><span id="CreditCardTokenization1_PayPal1_lblAmount"><?php echo $total_text;?></span></div>
							<div class="contentEnd"></div>
						</div>
					</div>
					<div class="Outer">
						<div class="NoborderM">
							<div class="DisplayTitle"><b><span id="CreditCardTokenization1_PayPal1_Charge">You Pay</span></b></div>
							<div class="DisplayTopText DisplayTextMobileNoStack"><b><span id="CreditCardTokenization1_PayPal1_lblTotalAmount"><?php echo $total_text;?></span></b></div>
							<div class="contentEnd"></div>
						</div>
					</div>
					<p></p>
					<div class="contentEnd"></div>

					<div class="menulogText" id="spnLoadingProcess" style="display:none">
						<div>
							<font class="menulogText"><strong><font color="red"><span id="CreditCardTokenization1_PayPal1_Label1">Redirecting to PayPal...</span></font></strong></font>
							<img src="/Images/processing.gif" alt="Please Wait">
						</div>
					</div>
					<div class="contentEnd"></div>
					<br>
					<!-- information -->
					<form action="<?php echo $action; ?>" method="post">
						<input type="hidden" name="cmd" value="_cart" />
						<input type="hidden" name="upload" value="1" />
						<input type="hidden" name="business" value="<?php echo $business; ?>" />
						<?php $i = 1; ?>
						<?php foreach ($products as $product) { ?>
						<input type="hidden" name="item_name_<?php echo $i; ?>" value="<?php echo $product['name']; ?>" />
						<input type="hidden" name="item_number_<?php echo $i; ?>" value="<?php echo $product['model']; ?>" />
						<input type="hidden" name="amount_<?php echo $i; ?>" value="<?php echo $product['price']; ?>" />
						<input type="hidden" name="quantity_<?php echo $i; ?>" value="<?php echo $product['quantity']; ?>" />
						<input type="hidden" name="weight_<?php echo $i; ?>" value="<?php echo $product['weight']; ?>" />
						<?php $j = 0; ?>
						<?php foreach ($product['option'] as $option) { ?>
						<input type="hidden" name="on<?php echo $j; ?>_<?php echo $i; ?>" value="<?php echo $option['name']; ?>" />
						<input type="hidden" name="os<?php echo $j; ?>_<?php echo $i; ?>" value="<?php echo $option['value']; ?>" />
						<?php $j++; ?>
						<?php } ?>
						<?php $i++; ?>
						<?php } ?>
						<?php if ($discount_amount_cart) { ?>
						<input type="hidden" name="discount_amount_cart" value="<?php echo $discount_amount_cart; ?>" />
						<?php } ?>
						<input type="hidden" name="currency_code" value="<?php echo $currency_code; ?>" />
						<input type="hidden" name="first_name" value="<?php echo $first_name; ?>" />
						<input type="hidden" name="last_name" value="<?php echo $last_name; ?>" />
						<input type="hidden" name="address1" value="<?php echo $address1; ?>" />
						<input type="hidden" name="address2" value="<?php echo $address2; ?>" />
						<input type="hidden" name="address_override" value="0" />
						<input type="hidden" name="email" value="<?php echo $email; ?>" />
						<input type="hidden" name="invoice" value="<?php echo $invoice; ?>" />
						<input type="hidden" name="country" value="<?php echo $country; ?>" />
						<input type="hidden" name="lc" value="<?php echo $lc; ?>" />
						<input type="hidden" name="rm" value="2" />
						<input type="hidden" name="no_note" value="1" />
						<input type="hidden" name="no_shipping" value="1" />
						<input type="hidden" name="charset" value="utf-8" />
						<input type="hidden" name="return" value="<?php echo $return; ?>" />
						<input type="hidden" name="notify_url" value="<?php echo $notify_url; ?>" />
						<input type="hidden" name="cancel_return" value="<?php echo $cancel_return; ?>" />
						<input type="hidden" name="paymentaction" value="<?php echo $paymentaction; ?>" />
						<input type="hidden" name="custom" value="<?php echo $custom; ?>" />
						<input type="hidden" name="bn" value="OpenCart_2.0_WPS" />
						<div class="menulogText">
							<a id="CreditCardTokenization1_PayPal1_btnBackToOrder" class="MenuLogBackToOrderWeb" href="<?php echo $cancel_return;?>" style="text-decoration:none;">Back To Order</a>
							<input type="submit" name="CreditCardTokenization1$PayPal1$btnSave" value="Submit Order" id="CreditCardTokenization1_PayPal1_btnSave" class="MenuLogContinueWeb">
						</div>
						<div>
							<div style="width:50%;float:left;">
								&nbsp;
							</div>
							<div style="width:50%;float:right;text-align:right;">
								<span style="font-size:10px">You will be redirected to PayPal to complete the payment </span>
							</div>
						</div>
						<br>
						<br>
						<br>
						<img src="https://www.paypalobjects.com/webstatic/en_AU/mktg/logo/bdg_payments_by_pp_2line_163x44.png" alt="PayPal Logo" style="display:block;margin-left:auto;margin-right:auto">
						<div class="contentEnd"></div>
						<p></p>
						<div>
							<span class="bold"></span>
						</div>
						<p></p>
						<div class="smallText" visible="false">
						</div>
				</div>
			</div>
		</div>
		<p></p>
		<div class="container">
		</div>
		</form>
		<div id="divPaymentExpressWeb" class="container" style="text-align: center">
			<img class="provider-logo">
		</div>
		<br>
		<br>
		<!--<div class="FooterLogo">-->
			<!--<div>-->
				<!--<div class="smallTextMenulogInfo">-->
                    <!--Online Order Pty Ltd | ABN 76 120 943 615 | 1300 664 335-->
					<!--<br> Level 23, 227 Elizabeth Street, Sydney NSW 2000-->
					<!--<br> Copyright © 2017 Online Order. All rights reserved-->
				<!--</div>-->
			<!--</div>-->
		<!--</div>-->
		<div class="FooterBorder"></div>
	</div>
</body>

</html>
