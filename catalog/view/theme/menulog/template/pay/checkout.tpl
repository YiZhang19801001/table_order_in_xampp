<?php echo $header;?>
<style>
#w23SignUpBtn {
    font-family: inherit;
    font-size: 16px;
    height: 45px;
    width: 200px;
    position: relative;
    padding: 0px;
    padding-left: 10px;
}

#w23LoginBth {
    background-color: rgb(255, 255, 255);
    color: rgb(121, 120, 118);
    border-width: 1px;
    border-style: solid;
    border-color: rgb(194, 192, 192);
    border-image: initial;
    font-family: inherit;
    font-size: 16px;
    height: 45px;
    width: 200px;
    position: relative;
    padding: 0px;
}
</style>
<div class="content">
    <div id="exposeMask" style="position: absolute; top: 0px; left: 0px; width: 1903px; height: 2719px; display: none; opacity: 0.7; z-index: 9998;"></div>
    <div class="contentBody">
        <div class="takeawayCheckoutFormWrapper">
            <div id="checkoutAlmostThere" style="margin-bottom: 10px;">Almost there</div>
            <?php if(!$isLogged){?>
            <div id="w23LoginLinks" style="border: 1px solid #E1E1E1;padding: 16px 10px 10px 10px;margin-bottom: 10px;text-align: center" class="_popup">
                <button id="w23SignUpBtn" class="_btn _face"><span>☺</span>Sign Up
                </button>
                <span style="margin-left: 18px;margin-right: 18px;">or</span>
                <button id="w23LoginBth" class="_btn _white">Log in
                </button>
                <div style="color: #adadad;font-size: 12px;padding-top: 16px;">You can also just checkout as a guest, but you'll be missing out on
                    <br>sweet loyalty offers, reordering, faster checkout and more!
                </div>
                <div class="_underlay"></div>
                <div class="_modal" style="height: auto; text-align: left">
                    <div class="_close"></div>
                    <div class="_title">Sign-up for faster orders, discounts and more!</div>
                    <div>
                        <div id="w23FormMsg" class="_msg"></div>
                        <input id="w23email" type="text" placeholder="Your email address">
                        <div id="w23emailMsg" class="_msg">Please enter your email address</div>
                        <input id="w23Password" type="password" placeholder="Password">
                        <div id="w23PasswordMsg" class="_msg">Please enter a password 4 or more digits long
                        </div>
                        <input id="w23ConfirmPassword" type="password" placeholder="Confirm Password">
                        <div id="w23ConfirmPasswordMsg" class="_msg" style="display: none;">Password and confirm password doesn't match
                        </div>
                    </div>
                    <div>
                        <button id="w23SignUpSubmit">Sign Up</button>
                    </div>
                </div>
            </div>
            <?php }?>
            <div class="contentEnd"></div>
            <div id="underMaintenance"></div>
            <div id="core-ajaxForm" class="core-ifhBlock">
                <form method="post" class="takeawayCheckout core-ajaxForm noLoginOnTop">
                    <fieldset id="timeSection">
                        <?php if($delivery_method == "Delivery"){?>
                        <legend><span>1. Where should we deliver?</span>
                            <?php if($ship_info){?><i class="icon-edit" id="ship_info"></i>
                            <?php }?>
                        </legend>
                        <?php }else{?>
                        <legend><span>1. Pickup info</span>
                            <?php if($ship_info){?><i class="icon-edit" id="ship_info"></i>
                            <?php }?>
                        </legend>
                        <?php }?>
                        <div class="summary" <?php if(!$ship_info){?>style="display:none;"
                            <?php }?> id="ship-hide">
                            <div>
                                <?php if($shipping_orderWhen=="now"){?>
                                <p>
                                    <?php echo $delivery_method;?> <strong> ASAP</strong></p>
                                <?php }else{?>
                                <?php if($delivery_method == "Delivery") { ?>
                                <p>
                                    <?php echo $delivery_method;?> on
                                    <?php echo $shipping_orderDate;?> at
                                    <?php echo $shipping_orderTime;?> 
                                    to:
                                </p>
                                <p><b><?php echo $shipping_address_1;?>,<?php echo $shipping_address_2;?></b></p>
                                <?php } else {?>
                                <p>
                                    <?php echo $delivery_method;?> on
                                    <?php echo $shipping_orderDate;?> at
                                    <?php echo $shipping_orderTime;?> 
                                </p>
                                <?php }?>
                                <?php }?>
                                <?php if(!$comment){?>
                                <p>No Comments/Instructions</p>
                                <?php }else{?>
                                <p>
                                    <?php echo $comment;?>
                                </p>
                                <?php }?>
                            </div>
                        </div>
                        <div class="" <?php if($ship_info){?>style="display:none;"
                            <?php }?> id="ship-show">
                            <div id="orderWhenBlock">
                                <?php if($error_orderWhen){?>
                                <div id="message_orderWhen" class="core-message message"><span class="error"><?php echo $error_orderWhen;?></span></div>
                                <?php }?>
                                <?php if($now_day){?>
                                <div id="message_nowday" class="core-message message" style="display: block;">
                                    <span class="error">The restaurant isn't currently available please select a later time</span>
                                </div>
                                <?php }?>
                                <?php if($delivery_method == "Delivery"){?>
                                <label class="noClick fieldTitle">Delivery Time</label>
                                <?php }else{ ?>
                                <label class="noClick fieldTitle">Pick Up Time</label>
                                <?php }?>
                                <input id="orderWhen_now" name="shipping_orderWhen" type="radio" value="now" <?php if($shipping_orderWhen=="now" ){?>checked="checked"
                                <?php }?> class="radio">
                                <?php if($delivery_method == "Delivery"){?>
                                <label for="orderWhen_now" class="radio">DELIVER ASAP</label>
                                <?php }else{?>
                                <label for="orderWhen_now" class="radio">PICKUP ASAP</label>
                                <?php }?>
                                <input id="orderWhen_later" name="shipping_orderWhen" type="radio" value="later" class="radio" <?php if($shipping_orderWhen!="now" ){?>checked="checked"
                                <?php }?>>
                                <?php if($delivery_method == "Delivery"){?>
                                <label for="orderWhen_later" class="radio">DELIVER LATER</label>
                                <?php }else{ ?>
                                <label for="orderWhen_later" class="radio">PICKUP LATER</label>
                                <?php }?>
                                <div id="orderDateTimeBlock" <?php if($shipping_orderWhen=="now" ){?>style="display: none;"
                                    <?php }else{ ?>style="display:block;"
                                    <?php }?> class="orderDateTimeBlock">
                                    <label for="orderDateText" class="dateLabel">Date</label>
                                    <div class="orderDateTextWrap ">
                                        <input id="datepicker" name="shipping_orderDate" type="text" value="<?php echo $shipping_orderDate;?>" class="textInput orderDateText checkoutOrderDateText">
                                        <img class="ui-datepicker-trigger sprite calendar_icon2x datepicker">
                                    </div>
                                    <label for="shipping_orderTime" class="timeLabel">Time</label>
                                    <div class="orderTimeDiv">
                                        <select id="orderTime" name="shipping_orderTime" class="shipping_orderTime">
                                            <option value="0">--</option>
                                            <?php if($times_array){foreach($times_array as $time){?>
                                            <option value="<?php echo $time;?>" <?php if($shipping_orderTime == $time){?>selected="selected" <?php }?>>
                                                <?php echo $time;?>
                                            </option>
                                            <?php }}?>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="contentEnd"></div>
                            <input type="hidden" name="delivery_method" value="<?php echo $delivery_method;?>">
                            <?php if($delivery_method == "Delivery"){?>
                            <div id="deliveryAddressBlock">
                                <?php if($error_shipping_address_1){?>
                                <div id="message_deliveryAddress_1" class="core-message message" style="display: block;">
                                    <span class="error"><?php echo $error_shipping_address_1;?></span>
                                </div>
                                <?php } ?>
                                <?php if($error_shipping_address_2){?>
                                <div id="message_deliveryAddress_2" class="core-message message" style="display: block;">
                                    <span class="error"><?php echo $error_shipping_address_2;?></span>
                                </div>
                                <?php }?>
                                <label for="unitAndStreetNumber" class="fieldTitle">Delivery Address
                                    <span>*</span>
                                </label>
                                <div class="core-inFieldLabel">
                                    <label for="unitAndStreetNumber"></label>
                                    <input id="unitAndStreetNumber" placeholder="Street No." name="shipping_address_1" type="text" class="textInput" value="<?php echo $shipping_address_1;?>">
                                </div>
                                <div class="core-inFieldLabel">
                                    <label for="addressLine1"></label>
                                    <input id="addressLine1" placeholder="Street Name" name="shipping_address_2" type="text" value="<?php echo $shipping_address_2;?>" class="textInput jsStreetSuggest" spellcheck="false" autocomplete="off">
                                </div>
                                <?php if($suburb_info){?>
                                <div class="contentEnd"></div>
                                <label class="fieldTitle" for="suburbIndo">Suburb</label> <span id="suburbInfo"><?php echo $suburb_info['name'];?></span>
                                <?php }?>
                                <div class="contentEnd"></div>
                            </div>
                            <?php }?>
                            <label for="comment" class="fieldTitle commentFieldTitle">Comments/ Instructions</label>
                            <div class="core-inFieldLabel">
                                <label for="comment"></label>
                                <textarea id="comment" placeholder="Leave any instructions about your meal, or delivery informationhere." name="comment"><?php echo $comment;?></textarea>
                            </div>
                            <div class="contentEnd"></div>
                        </div>
                    </fieldset>
                    <fieldset id="contactSection">
                        <legend class="edit"><span>2. What are your contact details?</span>
                            <?php if($info_finish){?><i class="icon-edit" id="user_info"></i>
                            <?php }?>
                        </legend>
                        <div class="summary" <?php if(!$info_finish){?>style="display:none;"
                            <?php }?> id="user-hide">
                            <div>
                                <p><strong><?php echo $shipping_firstname;?> <?php echo $shipping_lastname;?> </strong></p>
                                <p id="mobileAndPhone"><i class="fa fa-envelope-o"></i><strong><?php echo $shipping_email;?></strong> <i class="fa fa-phone"></i><strong><?php echo $shipping_telephone;?></strong></p>
                            </div>
                        </div>
                        <div class="" <?php if($info_finish){?>style="display:none;"
                            <?php }?> id="user-show">
                            <?php if($error_firstname){?>
                            <div id="message_firstName" class="message"><span class="error"><?php echo $error_firstname;?></span></div>
                            <?php }?>
                            <label for="firstname" class="fieldTitle">First Name<span>*</span></label>
                            <input id="firstname" name="shipping_firstname" type="text" value="<?php echo $shipping_firstname;?>" class="textInput">
                            <div class="contentEnd"></div>
                            <?php if($error_lastname){?>
                            <div id="message_lastName" class="message"><span class="error"><?php echo $error_lastname;?></span></div>
                            <?php }?>
                            <label for="lastname" class="fieldTitle">Last Name<span>*</span></label>
                            <input id="lastname" name="shipping_lastname" type="text" value="<?php echo $shipping_lastname;?>" class="textInput">
                            <div class="contentEnd"></div>
                            <?php if($error_email){?>
                            <div id="message_orderEmailAddress" class="message"><span class="error">Please enter a valid email address</span></div>
                            <?php }?>
                            <label for="orderEmailAddress" class="fieldTitle">Email Address<span>*</span></label>
                            <input id="orderEmailAddress" name="shipping_email" type="text" value="<?php echo $shipping_email;?>" class="textInput">
                            <div class="contentEnd"></div>
                            <?php if($error_telephone){?>
                            <div id="message_mobileNumber" class="core-message message">
                                <span class="error">Please enter your mobile number</span>
                            </div>
                            <?php }?>
                            <label for="mobileNumber" class="fieldTitle">Mobile Number<span>*</span></label>
                            <div class="core-inFieldLabel">
                                <label for="mobileNumber"></label>
                                <input id="mobileNumber" placeholder="(For sms confirmation)" rel="#mobileNumberTooltip" name="shipping_telephone" type="text" value="<?php echo $shipping_telephone;?>" class="textInput">
                            </div>
                            <div class="contentEnd"></div>
                        </div>
                    </fieldset>
                    <fieldset id="paymentSection">
                        <legend>3. How would you like to pay?</legend>
                        <div id="message_paymentMethodId" class="core-message message" style="display: none;"></div>
                        <div class="paymentMethodsWrapper" style="display: block;">
                            <div class="paymentMethods">
                                <!--<input id="paymentMethodId3" name="payment_method" type="radio" value="1" checked="checked" class="radio">-->
                                <!--<label for="paymentMethodId3" class="radio" data-type="Visa">-->
                                    <!--<img class="payment-method-icon" src="/catalog/view/theme/menulog/image/Visa.svg">Visa-->
                                <!--</label>-->
                                <!--<input id="paymentMethodId2" name="payment_method" type="radio" value="2" class="radio">-->
                                <!--<label for="paymentMethodId2" class="radio" data-type="Master Card">-->
                                    <!--<img class="payment-method-icon" src="/catalog/view/theme/menulog/image/Master Card.svg">Master Card-->
                                <!--</label>-->
                                <!--<input id="paymentMethodId4" name="payment_method" type="radio" value="3" class="radio">-->
                                <!--<label for="paymentMethodId4" class="radio" data-type="AMEX">-->
                                    <!--<img class="payment-method-icon" src="/catalog/view/theme/menulog/image/AMEX.svg">AMEX-->
                                <!--</label>-->
<!--                                 <input id="paymentMethodId19" name="payment_method" type="radio" value="4" class="radio">
                                <label for="paymentMethodId19" class="radio" data-type="Visa Checkout">
                                    <img class="payment-method-icon" src="/catalog/view/theme/menulog/image/Visa Checkout.svg">Visa Checkout
                                </label>
                                <input id="paymentMethodId17" name="payment_method" type="radio" value="5" class="radio">
                                <label for="paymentMethodId17" class="radio" data-type="Masterpass">
                                    <img class="payment-method-icon" src="/catalog/view/theme/menulog/image/Masterpass.svg">Masterpass
                                </label> -->
                                <input id="paymentMethodId16" name="payment_method" type="radio" value="6" class="radio" checked="checked">
                                <label for="paymentMethodId16" class="radio" data-type="PayPal">
                                    <img class="payment-method-icon" src="/catalog/view/theme/menulog/image/PayPal.svg">Paypal / Credit Card
                                </label>
                                <input id="paymentMethodId1" name="payment_method" type="radio" value="7" class="radio">
                                <label for="paymentMethodId1" class="radio" data-type="Cash">
                                    <img class="payment-method-icon" src="/catalog/view/theme/menulog/image/Cash.svg">Cash
                                </label>
                            </div>
                            <div class="contentEnd"></div>
                            <div class="voucherInfo">
                                <label for="voucherCode" class="fieldTitle">Voucher code?</label>
                                <input id="voucherCode" name="voucherCode" type="text" value="" maxlength="10">
                                <!--<div class="voucherConds conditions">(Vouchers are not redeemable with cash payments.-->
                                    <!--<a id="link_terms" class="green-link" href="#">Terms and Conditions</a>)-->
                                <!--</div>-->
                            </div>
                            <?php if($first_warring){?>
                            <p class="message attention">
                                <input type="hidden" name="first_warring" value="<?php echo $first_warring;?>">
                                <span id="ccardSignCheck">
                                    <?php echo $warring_info;?>
                                </span>
                            </p>
                            <?php }?>

                        </div>
                        <div id="template_terms" class="template">
                            <div class="popoverTitle">Online Order Voucher Terms and Conditions</div>
                            <ol>
                                <li>Only Online Order issued vouchers are accepted.</li>
                                <li>Online Order facilitates the discount and pays the full amount directly to the restaurant.
                                </li>
                                <li>Vouchers are not redeemable with cash payments.</li>
                                <li>Must be used before its expiry date.</li>
                                <li>Vouchers can only be used in full (ie. no change is given).</li>
                                <li>Voucher code to be entered at end of checkout process</li>
                                <li><b>Final amount owing after voucher applied will be shown at the top of the credit
									card entry page.</b></li>
                                <li>Online Order reserves the right to charge the value of the voucher to your allotted credit card if we determine that the voucher was redeemed contrary to the terms of use.
                                </li>
                            </ol>
                        </div>
                        <div id="message_inactiveAccount" class="core-message message" style="display: none;"></div>
                        <div id="message_checkoutIsBanned" class="core-message message" style="display: none;"></div>
                        <div id="message_discountInfo" class="core-message message" style="display: none;"></div>
                        <div class="core-dialogueButtons">
                            <div class="core-left">
                                <button type="submit" name="pay" class="checkoutButton">Place my order</button>
                            </div>
                            <div class="core-right">
                                <div class="core-pleaseWait" style="display: none;">Please wait</div>
                            </div>
                        </div>
                        <div class="contentEnd"></div>
                        <!--<div id="agree_terms_conditions">-->
                            <!--<p>By clicking the Checkout button you confirm that you agree to our <a href="javascript:void(0);" onclick="window.open('//www.menulog.com.au/menulog_terms_of_use?noDisplayFooter=1&amp;noDisplayHeader=1', 'TermsofUse', 'width=550,height=400,scrollbars=yes,top=3000,status=0,resizable=1');">Terms-->
								<!--of Use</a> and <a href="javascript:void(0);" onclick="window.open('//www.menulog.com.au/menulog_privacy?noDisplayFooter=1&amp;noDisplayHeader=1', 'Privacy', 'width=550,height=400,scrollbars=yes,top=3000,status=0,resizable=1');">Privacy</a>-->
                            <!--</p>-->
                        <!--</div>-->
                    </fieldset>
                </form>
            </div>
        </div>
        <div class="takeawayCheckoutCartSummary">
            <div class="cartTitle">Your order summary</div>
            <div id="summaryCartType"><i class="icon-delivery"></i><span><?php echo $delivery_method;?></span></div>
            <div id="cartSummary" class="shoppingCart">
                <div id="cartSummaryBox" class="box1">
                    <?php if($order_id){?>
                    <p id="cartReorderCheck"><strong>Please re-check your order as items and prices may have changed since your last order.</strong></p>
                    <?php }?>
                    <div class="contentEnd"></div>
                    <div class="cartContent">
                        <div></div>
                        <?php if(!$cart){?>
                        <div class="cartEmpty">There are no items in your cart.</div>
                        <?php }else{?>
                        <div class="cartItems">
                            <?php foreach($cart as $product) {?>
                            <div class="row">
                                <div class="details">
                                    <div class="namePrice foodItem">
                                        <div class="name">
                                            <?php echo $product['name'];?>
                                        </div>
                                        <div class="itemQty">
                                            <?php echo $product['quantity'];?>
                                        </div>
                                        <div class="value">
                                            <?php echo $product['price'];?>
                                        </div>
                                        <div class="contentEnd"></div>
                                    </div>
                                    <?php if($product['option']){?>
                                    <div class="namePrice">
                                        <div class="name">
                                            <?php echo $product['option']['name'];?>
                                        </div>
                                        <div class="itemQty"></div>
                                        <div class="value"></div>
                                        <div class="contentEnd"></div>
                                    </div>
                                    <?php }?>
                                    <?php if(isset($product['exts'])){?>
                                    <?php if(isset($product['exts'])){?>
                                    <?php foreach($product['exts'] as $k=>$r){?>
                                    <?php foreach($r['exts'] as $rr){?>
                                    <div class="namePrice choice">
                                        <div class="name">
                                            <?php echo $k;?> :
                                            <?php echo $rr['name'];?>
                                        </div>
                                        <div class="itemQty"></div>
                                        <div class="value">
                                            <?php if($r['type']){echo $rr['price'];}?>
                                        </div>
                                        <div class="contentEnd"></div>
                                    </div>
                                    <?php }?>
                                    <?php }?>
                                    <?php }?>
                                    <?php }?>
                                </div>
                                <div class="contentEnd"></div>
                            </div>
                            <?php }?>
                        </div>
                        <?php }?>
                        <div class="subTotalSection">
                            <div class="row">
                                <div class="name subTotal">Subtotal</div>
                                <div class="value" id="subTotalValue">
                                    <?php echo $productPrice;?>
                                </div>
                                <div class="contentEnd"></div>
                            </div>
                        </div>
                        <?php if($coupon_id){?>
                        <?php if(!$first_warring){?>
                        <div class="discountSection">
                            <div class="discountSectionTitle">Choose a bonus</div>
                            <div class="discounts">
                                <div class="row">
                                    <?php if(isset($type) && $type==3){?>
                                    <?php if($times){?>
                                    <label>Your loyalty credit
                                        <br><span class="loyaltyProgressMsg"><?php echo $currentPrice;?> this order;<?php echo $price;?> total; <?php echo $times;?> orders to go</span></label>
                                    <?php }else {?>
                                    <label> Your loyalty credit
                                        <?php echo $price;?> total can be redeemed for this order</label>
                                    <?php }?>
                                    <?php }else{?>
                                    <label>
                                        <div class="name discountName">
                                            <?php echo $coupon_name;?>
                                        </div>
                                        <div class="value discountValue" style="width: 100px;">
                                            <?php if( empty($discount_comment) && $type !=2 ){
											echo "-".$couponPrice;
										}else{ 
											echo $discount_comment;
										}?>
                                        </div>
                                        <div class="contentEnd"></div>
                                    </label>
                                    <?php }?>
                                </div>
                            </div>
                        </div>
                        <?php }?>
                        <?php }?>
                    </div>
                    <div class="cartTotals">
                        <?php if(!$is_free) {?>
                        <div class="row" id="deliveryFeeRow">
                            <div class="name">Delivery</div>
                            <div class="value">
                                <?php echo $deliveryPrice;?>
                            </div>
                            <div class="freeDeliveryForOrderOver text" style="display: none;"></div>
                        </div>
                        <?php }else{?>
                        <div id="amountLeftForMinimumCost"></div>
                        <div class="row freeDelivery" style="display: none;">
                            <div id="freeDeliveryText">Free Delivery
                                <div class="contentEnd"></div>
                            </div>
                        </div>
                        <?php }?>
                        <?php if($is_consume) {?>
                        <div id="amountLeftForMinimumCost">
                            <div class="row">
                                <div class="name">
                                    <?php echo $consume?> min</div>
                                <div class="value">
                                    <?php echo $remaining;?> remaining</div>
                                <progress max="<?php echo $consume_text?>" value="<?php echo $productPrice_text;?>"></progress>
                            </div>
                        </div>
                        <?php }?>
                        <div class="row total">
                            <div class="name">Total</div>
                            <div class="value">
                                <?php echo $total;?>
                            </div>
                            <div class="includingGST">Including GST</div>
                        </div>
                    </div>
                    <?php if($order_id){?>
                    <p id="cartChangeOrder"><a href="<?php echo $change;?>">Change my order</a></p>
                    <?php }?>
                </div>
            </div>
        </div>
        <div class="contentEnd"></div>
    </div>
</div>
<script>
$('#ship_info').click(function() {
    $('#ship-hide').hide();
    $('#ship-show').show();
    $('#ship_info').hide();
})
$('#user_info').click(function() {
    $('#user-hide').hide();
    $('#user-show').show();
    $('#user_info').hide();
})

$('#w23SignUpBtn').click(function() {
    $('#w23LoginLinks').addClass('show');
    $('._underlay').fadeIn();
});
$('._underlay, ._close').click(function() {
    $('#w23LoginLinks').removeClass('show');
    $('._underlay').fadeOut();
});

$('#w23LoginBth, .w23LoginBth').click(function() {
    $('#exposeMask, #link_login').fadeIn();
    $('.linkLogin').css({
        'position': 'fixed',
        'top': '50%',
        'left': '50%',
        'transform': 'translate(-50%, -50%)'
    });
    $('.linkLogin').addClass('in');
})
$('.linkLogin .core-closeX, #exposeMask').click(function() {
    $('#exposeMask, #popoverBox').fadeOut();
})

$('#orderWhen_now').click(function() {
    $('#orderDateTimeBlock').hide();
})
$('#orderWhen_later').click(function() {
    $('#orderDateTimeBlock').show();
})

//    jq-ui
$(function() {

    var date = new Date(),
        m = date.getMonth() + 2,
        d = date.getDate();
    date.setMonth(m);
    date.setDate(0);
    var Plusdate = date.getDate() - d,
        maxDate = '+1M +' + Plusdate + '';
    $("#datepicker").datepicker({
        minDate: 0,
        maxDate: maxDate,
        defaultDate: '-1M',
        dateFormat: "D, d M y",
        beforeShowDay: nonWorkingDates
    });

    function nonWorkingDates(date)
    {

        var day = date.getDay(),
            closedDays = <?php echo json_encode($days);?>,
            closeDate = <?php echo json_encode($unavailable)?>;


        var newDate = new Date();
        for (var i in closeDate)
        {
            var start = closeDate[i][0],
                end = closeDate[i][1];

            if (date.getDate() >= new Date(start * 1000).getDate() && date.getDate() <= new Date(end * 1000).getDate() && date.getDate())
            {
                return [false];
            }
        }

        for (var i in closedDays)
        {
            if (closedDays[i] == day) return [true];
        }

        return [false];
    }
    $('.sprite').off().click(function() {
        $("#datepicker").focus();
    })

    $('#orderTime').focus(function() {
        var _this = $(this);
        $.post(
            '/index.php?route=shop/time', {
                location_id: <?php echo $location_id;?>,
                day: new Date($("#datepicker").val()).getDay(),
                isp: <?php echo $isp;?>
            },
            function(data) {
                var html = '';
                for (var i in data) {
                    html += '<option value="' + data[i] + '">' + data[i] + '</option>';
                }
                _this.html(html);
            }
        )
    })
})

//    注册
$('#w23SignUpSubmit').click(function() {
    $('#w23email').val() == '' ? $('#w23emailMsg').show() : $('#w23emailMsg').hide();
    $('#w23Password').val() == '' ? $('#w23PasswordMsg').show() : $('#w23PasswordMsg').hide();
    $('#w23Password').val() != $('#w23ConfirmPassword').val() ? $('#w23ConfirmPasswordMsg').show() : $('#w23ConfirmPasswordMsg').hide();

    if ($('#w23emailMsg').css('display') != 'block' && $('#w23PasswordMsg').css('display') != 'block' && $('#w23ConfirmPasswordMsg').css('display') != 'block') {
        $.post(
            '/index.php?route=checkout/register/save', {
                customer_group_id: 1,
                email: $('#w23email').val(),
                password: $('#w23Password').val(),
                confirm: $('#w23ConfirmPassword').val()
            },
            function(data) {
                if (data.error) {
                    if (data.error.email) {
                        $('#w23emailMsg').text(data.error.email).show();
                    } else if (data.error.password) {
                        $('#w23emailMsg').text(data.error.password).show();
                    } else if (data.error.confirm) {
                        $('#w23emailMsg').text(data.error.confirm).show();
                    } else if (data.error.warning) {
                        $('#w23FormMsg').html(data.error.warning).show();
                    }
                } else if (data.length == '') {
                    $('#loading').show();
                    location.reload();
                }
            }
        )
    }
})
</script>
<?php echo $footer;?>