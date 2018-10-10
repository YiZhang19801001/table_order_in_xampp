<?php echo $header; ?>
<!--<script src="/catalog/view/theme/mobile/script/checkout.js" defer="defer"></script>-->
<div class="topBodyWrapWidth m-container checkout" id="checkout">
    <div id="mlTopToolbar" class="topBodyWrapWidth topToolbar clearfix">

        <div class="websiteTopToolbar clearfix">

            <div class="toolbarLeft toolbarLeftButtons">
                <a href="javascript:history.go(-1);" id="toolbarBackButtonLink">
                    <div class="button-back icon-back"></div>
                </a>
            </div>

            <div class="toolbarRight">
                <div class="dropdown burgerMenuButton">
                    <a class="dropdown-toggle" id="m-top-dropdownmenu" role="button" href="javascript:void (0);" data-toggle="dropdown"
                       data-target="#">
                        <div class="burgerMenu icon-hamburgerMenu"></div>
                    </a>
                    <div class="dropdown-backdrop" style="display: none"></div>
                    <ul class="dropdown-menu nav pull-right semiBoldFont" role="menu"
                        aria-labelledby="m-top-dropdownmenu">
                        <li><a href="/" style="border-top:0;">Home</a></li>
                        <?php if($isLogged){ ?>
                        <li><a href="<?php echo $order;?>">Re-order</a></li>
                        <li><a href="<?php echo $detail;?>">My Details</a></li>
                        <li><a href="<?php echo $logout;?>" >Log out</a></li>
                        <?php } else { ?>
                        <li><a class="accountLink" @click="login = backdrop = true">Log in</a></li>
                        <?php }?>
                    </ul>
                </div>
            </div>
            <div class="toolbarMiddle">
                <a href="/" class="toolbarHomebutton "><span class="icon-logoWide"></span></a>
            </div>
        </div>
        <!--<div class="pageHeader headerWithRhsText  info-bar clearfix checkout">
            <div id="checkoutPageHeader" class="pageHeader showOrderStatus clearfix">
                <div class="right button">
                    <div class="cartIcon">
                        <div></div>
                    </div>
                    <div class="orderAmtText">Order total: <span id="venuePageCurrentOrderAmt">$13.90</span></div>
                    <span id="countTotalOrderItems" class="orderItemTotal regularFont">2</span>
                </div>
            </div>
        </div>-->
    </div>


    <form name="form01" id="form01" method="POST">
        <div class="checkoutForm">
            <div class="hidden" data-checks="">
                <span data-checks-logged-status="">logged-in</span>
                <span>pickup</span>
                <span>takeaway-info-incomplete</span>
            </div>

            <div id="checkoutForm" class="checkout-form-b">
                <div class="mm-section" id="almostThereSection">
                </div>
                <section id="contactInformation">
                    <!--<div class="logged-out" data-section="login-details">
                        <fieldset class="form-section">
                            <header class="title-wrapper">
                                <h2 class="page-title">Or new to Menulog?</h2>
                                <p>Create an account</p>
                            </header>
                            <label class="inputFieldLabel regularFont">Email *</label>
                            <input type="text" id="orderEmailAddress" name="orderEmailAddress"
                                   value="1878391335@qq.com">

                            <p class="normError messageSpacing HiddenFirst" id="error_orderEmailAddress"></p>

                            <p id="error_orderEmailAddressFound" class="normError messageSpacing HiddenFirst">It looks
                                like you already have an account with us. <a href="#" class="open-login-modal" data-cmd="login">Log in here</a> to
                                continue. Can’t remember your password? <a href="#" class="open-reset-password">Reset it
                                    here.</a></p>
                            <p id="error_orderEmailAddressInvalid" class="normError messageSpacing HiddenFirst">Please
                                enter a valid email address.</p>

                            <label class="inputFieldLabel regularFont">Create a password *</label>
                            <input type="password" id="orderPassword" name="orderPassword" value="">

                            <p class="normError messageSpacing HiddenFirst" id="error_orderPassword"></p>


                        </fieldset>

                    </div>-->
                    <div class="logged-out" data-create-account="" <?php if($info_finish){?>style="display:none;"<?php }?> id="user-show">
                        <fieldset class="form-section">
                            <header class="title-wrapper">
                                <h2 class="page-title">What are your contact details?</h2>
                            </header>
                            <label class="inputFieldLabel regularFont" for="firstName">First Name *</label>
                            <input type="text" id="firstName" name="shipping_firstname" value="<?php echo $shipping_firstname;?>">
                            <?php if($error_firstname){?>
                            <p class="normError messageSpacing " id="error_firstName"><?php echo $error_firstname;?></p>
                            <?php }?>
                            <label class="inputFieldLabel regularFont" for="lastName">Last Name *</label>
                            <input type="text" id="lastName" name="shipping_lastname" value="<?php echo $shipping_lastname;?>">
                            <?php if($error_lastname){?>
                            <p class="normError messageSpacing " id="error_lastName"><?php echo $error_lastname;?></p>
                            <?php }?>
                            <label class="inputFieldLabel regularFont" for="tel">Email Address *</label>
                            <input type="text" id="tel" name="shipping_email" value="<?php echo $shipping_email;?>">
                            <?php if($error_email){?>
                            <p class="normError messageSpacing " id="error_tel">Please enter a valid email address</p>
                            <?php }?>
                            <label class="inputFieldLabel regularFont" for="mobileNumber">Mobile number *</label>
                            <input type="tel" id="mobileNumber" name="shipping_telephone" value="<?php echo $shipping_telephone;?>">
                            <?php if($error_telephone){?>
                            <p class="normError messageSpacing " id="error_mobileNumber">Please enter your mobile number</p>
                            <?php }?>
                        </fieldset>

                    </div>

                    <div class="logged-in" id="user-hide" <?php if(!$info_finish){?>style="display:none;"<?php }?>>
                        <div class="form-section">
                            <div class="title-wrapper">
                                <h2 class="page-title">Your details</h2>
                                <div class="controls">
                                    <a href="#" data-edit-contact-deets=""><span class="icon-edit" id="user_info"></span></a>
                                </div>
                            </div>
                            <div class="closed-section">
                                <p><?php echo $shipping_firstname;?> <?php echo $shipping_lastname;?></p>
                                <p><?php echo $shipping_email;?></p>
                                <p><?php echo $shipping_telephone;?></p>
                            </div>
                        </div>
                    </div>
                </section>
                <section id="delivery-pickup">

                    <div class="delivery-time">
                        <div class="title-wrapper">
                            <?php if($delivery_method == "Delivery"){?>
                            <h2 class="page-title">Delivery time</h2>
                            <?php }else{?>
                            <h2 class="page-title">Pick Up Time</h2>
                            <?php }?>
                        </div>
                        
                        <div class="delivery-time-wrapper">
                            <div class="mm-section-item no-self-padding takeawayTimeOption">
                                <input type="radio" name="shipping_orderWhen" id="orderWhen_now" class="radioButton" value="now" <?php if($shipping_orderWhen=="now" ){?>checked="checked"
                                <?php }?>>
                                <label for="orderWhen_now" class="radioLabel">
                                    <?php if($delivery_method == "Delivery"){?>
                                    <span>DELIVER ASAP</span>
                                    <?php }else{?>
                                    <span>PICKUP ASAP</span>
                                    <?php }?>
                                </label>
                            </div>

                            <div class="mm-section-item no-self-padding takeawayTimeOption" id="item-order-later">
                                <input type="radio" name="shipping_orderWhen" id="orderWhen_later" class="radioButton" value="later" <?php if($shipping_orderWhen!="now" ){?>checked="checked"
                                <?php }?>>
                                <label for="orderWhen_later" class="radioLabel">
                                    <?php if($delivery_method == "Delivery"){?>
                                    <span>DELIVER LATER</span>
                                    <?php }else{ ?>
                                    <span>PICKUP LATER</span>
                                    <?php }?>
                                </label>
                            </div>
                        </div>
                        <?php if($now_day){?>
                        <div id='error_now_day' class='normError messageSpacing'>The restaurant isnt currently available please select a later time</div>
                        <?php }?>
                         <?php if($error_orderWhen){?>
                        <div id="error_orderWhen" class="normError messageSpacing "><?php echo $error_orderWhen;?></div>
                        <?php }?>

                        <div id="orderDateTimeBlock" <?php if($shipping_orderWhen=="now" ){?>style="display: none;"<?php }else{ ?>style="display:block;"<?php }?>>
                            <div class="mm-section">
                                <div  class="mm-section-item" id="selectDaySection">
                                    <span id="selectedDayName" class="remindStrengthen"><?php echo $shipping_orderDate;?></span>
                                    <input type="hidden" value="<?php echo $shipping_orderDate;?>" name="shipping_orderDate" id="selectedDay">
                                    <div class="openInfoArrow"></div>
                                </div>

                                <div  class="mm-section-item" id="selectTimeSection">
                                    <span id="selectedTimeName" class="inlineBlock remindStrengthen"><?php echo $shipping_orderTime;?></span>
                                    <input type="hidden" value="<?php echo $shipping_orderTime;?>" name="shipping_orderTime" id="selectedTime">
                                    <div class="openInfoArrow"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- logged in -->
                    <input type="hidden" name="delivery_method" value="<?php echo $delivery_method;?>">
                    <?php if($delivery_method == "Delivery"){?>
                    <div class="logged-in" style="display: block;">
                        <div class="delivery">
                            <div class="title-wrapper">
                                <h2 class="page-title">Delivery address</h2>
                                <div class="controls">
                                    <a href="#" data-edit-address="" style="display: none;"><span class="icon-edit"></span></a>
                                </div>
                            </div>
                            <div class="edit-address-details" style="">
                                <input placeholder="Street No." type="text" id="streetNumber" name="shipping_address_1" value="<?php echo $shipping_address_1;?>" class="input" autocomplete="off">
                                <?php if($error_shipping_address_1){?>
                                <p id="error_streetNumber" class="normError messageSpacing"><?php echo $error_shipping_address_1;?></p>
                                <?php } ?>
                                <input placeholder="Street Name" type="text" id="addressLine1" name="shipping_address_2" value="<?php echo $shipping_address_2;?>" class="input" autocomplete="off">
                                <?php if($error_shipping_address_2){?>
                                <p id="error_addressLine1" class="normError messageSpacing"><?php echo $error_shipping_address_2;?></p>
                                <?php }?>
                            </div>
                            <?php if($suburb_info){?>
                            <p class="suburb" id="street-address-details"><span><?php echo $suburb_info['name'];?></span></p>
                            <?php }?>
                        </div>
                        <?php }?>

                        <div class="pickup" style="display: block;">

                            <div class="title-wrapper">
                                <?php if($delivery_method == "Delivery"){?>
                                <h2 class="page-title">Delivery Information</h2>
                                <?php }else{?>
                                <h2 class="page-title">Pick-up Information</h2>
                                <?php }?>
                                <span class="edit-pencil info-edit <?php if($ship_info){?>icon-edit<?php }?>"></span>
                            </div>
                            <?php if($ship_info){?>
                            <div id="takeawaySectionCompleted" class="mm-section firstAfterTitle closed-section">
                                <div class="mm-section-item title"></div>
                                <div class="mm-section-item title comments-instructions">Comments/Instructions:</div>
                                <div class="mm-section-item">
                                <?php if(!$comment){?>
                                No Comments/Instructions
                                <?php }else{?>
                                <?php echo $comment;?>
                                <?php }?>
                            </div>
                            <?php }?>

                        </div>

                        <div class="edit-address-details" <?php if($ship_info){?>style="display: none;"<?php }?> id="takeawaySectionNotCompleted">
                            <div class="mm-section">
                                <div class="mm-section-item section-header comments">
                                    <span><label for="comment">Comments/Instructions</label></span>
                                </div>
                                <div class="mm-section-item">
                                    <textarea id="comment" name="comment" placeholder="Leave any instructions about your meal, or delivery information here"><?php echo $comment;?></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <div class="title-wrapper">
                    <h2 class="page-title" data-payment-details="">Payment Information</h2>
                </div>
                <div data-payment-method-container="">
                    <div class="new-card" data-new-card="">

                        <p style="margin-bottom: 16px;"><a href="#" class="green-link hidden back-to" data-switch-card-views="" data-if-saved-cards=""><span class="icon-back"></span>Pay with a saved card</a></p>
                        <input type="radio" name="payment_method" id="paymentMethodId_16" class="new-card-radio" value="6" checked="checked">
                        <label for="paymentMethodId_16" class="payment-label" data-type="PayPal">
                            <img src=" /catalog/view/theme/menulog/image/PayPal.svg">
                            Paypal / Credit Card
                        </label>


                        <input type="radio" name="payment_method" data-payment-name="" id="paymentMethodId_1" class="new-card-radio" value="7">
                        <label for="paymentMethodId_1" class="payment-label">
                            <img src="/catalog/view/theme/menulog/image/Cash.svg">Cash</label>
                        <div class="VoucherSectionWrapper">
                            <div class="mm-section" id="voucherSection">
                                <p class="select-new-heading">Have a voucher code?</p>
                                <input type="text" class="no-border" id="voucherCode" name="voucherCode" value="">
                                <p class="normError messageSpacing HiddenFirst" id="error_voucherCode"></p>
                            </div>
                        </div>

                    </div>
                </div>
                <?php if($first_warring){?>
                <input type="hidden" name="first_warring" value="<?php echo $first_warring;?>">
                <p class="normError messageSpacing" id="error_paymentMethodId"><?php echo $warring_info;?></p><?php }?>

                <div class="mm-section" style="padding:20px 0 0 0;">
                    <div id="checkoutRemind">
                        <button type="submit" name="pay" class="jsSubmitForm button regularFont" id="checkoutPageCheckout" style="border: 0px;text-align: center;">Place my order</button>
                    </div>
                    <div class="normError HiddenFirst messageSpacing" id="error_checkoutIsBanned"
                         style="text-align: left;"></div>
                    <div class="contentEnd"></div>
                </div>
            </div>
        </div>
    </form>

    <!--登陆-->
    <div id="login" style="display: none;" class="modal in" aria-hidden="false">
        <div class="modal-dialog">
            <div v-show="!reg" class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Log in</div>
                </div>
                <div id="accountContentWrap" class="modal-body mm-body">
                    <div class="accountLogin">
                        <form id="loginForm" name="login" method="POST" class="accountForm">
                            <div class="mm-title semiBoldFont">
                                <span>YOUR DETAILS</span>
                                <div id="loginErrorMsg" style="display:none;" class="normError messageSpacing">Incorrect
                                    email or password.
                                </div>
                            </div>

                            <div class="mm-section" id="accountLoginDetails">
                                <div class="mm-section-item">
                                    <label for="emailAddress" class="inputFieldLabel regularFont">Email</label>
                                    <span class="inputFieldSpan">
                                            <input id="emailAddress" type="email" name="emailAddress" value="" autocomplete="off">
                                        </span>
                                </div>
                                <div class="mm-section-item">
                                    <label for="password" class="inputFieldLabel regularFont">Password</label>
                                    <span class="inputFieldSpan">
                                            <input id="password" type="password" name="password" value="" autocomplete="off">
                                        </span>
                                </div>
                            </div>
                            <div class="mm-section gray" style="padding:10px;">
                                <div class="forgottenPassword"><a class="forgotPassword" id="message_login" style="display:none;">Your login details were incorrect.  Please try again</a></div>
                                <div class="footTextContentWrapper">
                                    <div class="GreyText">Don't have an account? Your account will be created the first
                                        time you complete an order.
                                    </div>
                                </div>
                                <!--<div class="forgottenPassword">-->
                                    <!--<a href="javascript:void(0);" class="forgotPassword" @click="reg = true">Forgot your-->
                                        <!--password?</a>-->
                                <!--</div>-->
                            </div>
                            <input class="hiddenSubmitButton" type="submit" value="login" name="submit">
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="modal-footer-button-box">
                        <a data-dismiss="modal" href="javascript:void (0);" class="close modal-footer-button modal-footer-cancel regularFont"
                           onclick="return false;">Cancel</a>
                        <a id="accountLoginButton" class="modal-footer-button modal-footer-continue semiBoldFont" onclick="return false;">Log In</a>
                    </div>
                </div>
            </div>
            <!--<div v-show="reg" class="modal-content">-->
                <!--<div class="modal-header">-->
                    <!--<button @click="reg = false" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>-->
                    <!--<div class="mm-header-title boldFont">Reset password</div>-->
                <!--</div>-->
                <!--<div id="accountContentWrap" class="modal-body mm-body">-->
                    <!--<div id="resendPasswordEmail">-->
                        <!--<div class="mm-title semiBoldFont">-->
                            <!--<span style="line-height:18px;">Submit your e-mail address below to receive a password reset link.</span>-->
                            <!--<div id="message_forgotten" style="display:none;" class="normError messageSpacing">Please enter your current email.-->
                            <!--</div>-->
                        <!--</div>-->

                        <!--<form id="resetPasswordForm" method="POST" class="accountForm">-->
                            <!--<div class="mm-section" id="accountLoginDetails">-->
                                <!--<div class="mm-section-item">-->
                                    <!--<div id="resetPasswordError" style="display:none"-->
                                         <!--class="normError messageSpacing"></div>-->
                                    <!--<label for="emailAddress_F" class="inputFieldLabel regularFont"-->
                                           <!--style="width:auto; padding-right:10px;">Email</label>-->
                                    <!--<span class="inputFieldSpan">-->
                                            <!--<input id="emailAddress_F" type="email" name="emailAddress_F" value=""-->
                                                   <!--autocomplete="off">-->
                                        <!--</span>-->
                                <!--</div>-->
                            <!--</div>-->

                            <!--<input class="hiddenSubmitButton" type="submit" value="login" name="submit">-->
                        <!--</form>-->
                    <!--</div>-->

                    <!--<div id="passwordEmailSent" style="display:none; padding:10px;" class="hideInResendPasswordPage">-->
                        <!--<h1>We have e-mailed you a password reset link. Please check your spam folder if you can't find-->
                            <!--it in the inbox.</h1>-->
                    <!--</div>-->

                <!--</div>-->
                <!--<div class="modal-footer">-->
                    <!--<div class="modal-footer-button-box">-->
                        <!--<a @click="reg = false" data-dismiss="modal" href="" class="modal-footer-button modal-footer-cancel regularFont"-->
                           <!--onclick="return false;">Cancel</a>-->
                        <!--<a id="resetPasswordButton" class="modal-footer-button modal-footer-continue semiBoldFont">Continue</a>-->
                    <!--</div>-->
                <!--</div>-->
            <!--</div>-->
        </div>
    </div>
    <div class="modal-backdrop  in" style="display: none;" ></div>

    <!--选择日期-->
    <div id="modalContainer" class="modal in" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content no-footer">
                <div class="modal-header">
                    <button id="dateHide" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Update Date</div>
                </div>
                <div class="modal-body mm-body">
                    <div class="mm-section" id="timeList">
                        <div class="mm-section-item no-self-padding">
                            <input type="radio" value="" class="radioButton" id="">
                            <label class="radioLabel" for=""><span></span></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--选择时间-->
    <div id="time" class="modal in" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content no-footer">
                <div class="modal-header">
                    <button id="timeHide" type="button" class="close" data-dismiss="modal"
                            aria-hidden="true"></button>
                    <div class="mm-header-title boldFont">Update Time</div>
                </div>
                <div class="modal-body mm-body">
                    <div class="mm-section">
                        <?php if($times_array){foreach($times_array as $k => $time){?>
                        <div class="mm-section-item no-self-padding">
                            <input name="time" type="radio" value="<?php echo $time;?>" class="radioButton" id="<?php echo 'time'.$k;?>" <?php if($shipping_orderTime == $time){?>checked="checked" <?php }?>>
                            <label class="radioLabel" for="<?php echo 'time'.$k;?>"><span><?php echo $time;?></span></label>
                        </div>
                        <?php }}?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#error_paymentMethodId').click(function ()
    {
        $('#login, .modal-backdrop').show();
    })
    $('.close').click(function ()
    {
        $('#login, .modal-backdrop').hide();
    })
    $('.info-edit').click(function ()
    {
        $('#takeawaySectionCompleted, .info-edit').hide();
        $('.edit-address-details').show();
    })
    $('#accountLoginButton').click(function() {
        event.preventDefault();
        if ($('#emailAddress').val() != '' && $('#password') != '') {
            $.post(
                '/index.php?route=checkout/login/save', {
                    email: $('#emailAddress').val(),
                    password: $('#password').val()
                },
                function(data) {
                    if (data.error) {
                        $('#message_login').show();
                    }
                    if (data.length == '') {
                        $('#loading').show();
                        location.reload();
                    }
                }
            )
        }
    })

    $('#m-top-dropdownmenu').click(function (even)
    {
        $('.dropdown-menu, .dropdown-backdrop').show();
        even.preventDefault();
    })
    $('.dropdown-backdrop').click(function ()
    {
        $('.dropdown-menu, .dropdown-backdrop').hide();
    })
    $('#orderWhen_now').click(function() {
        $('#orderDateTimeBlock').hide();
    })
    $('#orderWhen_later').click(function() {
        $('#orderDateTimeBlock').show();
    })
    $('#user_info').click(function() {
        $('#user-hide').hide();
        $('#user-show').show();
        $('#user_info').hide();
    })

    //日期
    $('#selectDaySection').click(function ()
    {
        $('#modalContainer, .modal-backdrop').show();
    })
    $('#dateHide').click(function ()
    {
        $('#modalContainer, .modal-backdrop').hide();
    })
    //时间
    $('#selectTimeSection').click(function ()
    {
        $('#time, .modal-backdrop').show();
    })
    $('#timeHide').click(function ()
    {
        $('#time, .modal-backdrop').hide();
    })

    //获取时间
    var date = new Date()
        dates = [],
        invertedNum = date.toString().indexOf(' 201'),
        week= date.getDay(),
        when = date.toString().slice(0, invertedNum);
    dates.push({week: week, when: when});
    for (var i = 0; i < 30; i++)
    {
        date.setDate(date.getDate() + 1);
        week = date.getDay();
        when = date.toString().slice(0, invertedNum);
        dates.push({week: week, when: when});
    }
    var strVar = "";
    for (var i in dates)
    {
        strVar += "<div class=\"mm-section-item no-self-padding\">\n";
        strVar += "                            <input type=\"radio\" name='date' value=\"\" class=\"radioButton\" id="+ i + dates[i].when +">\n";
        strVar += "                            <label class=\"radioLabel\" for="+ i + dates[i].when +"><span>"+ dates[i].when +"<\/span><\/label>\n";
        strVar += "                        <\/div>\n";
    }

    $('#timeList').html(strVar);

    $('#timeList input[name="date"]').change(function ()
    {
        var val = $(this).next('.radioLabel').find('span').text();
        $('#selectedDayName').text(val);
        $('#selectedDay').val(val);
    })
    $('#time input[name="time"]').change(function ()
    {
        var val = $(this).next('.radioLabel').find('span').text();
        $('#selectedTimeName').text(val);
        $('#selectedTime').val(val);
    })
</script>
<?php echo $footer; ?>