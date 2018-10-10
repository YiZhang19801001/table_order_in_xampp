<?php echo $header; ?>

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
                    <a class="dropdown-toggle" id="m-top-dropdownmenu" role="button" href="javascript:void (0);"
                        data-toggle="dropdown" data-target="#">
                        <div class="burgerMenu icon-hamburgerMenu"></div>
                    </a>
                    <div class="dropdown-backdrop" style="display: none"></div>
                    <ul class="dropdown-menu nav pull-right semiBoldFont" role="menu" aria-labelledby="m-top-dropdownmenu">
                        <li><a href="/" style="border-top:0;">Home</a></li>
                        <?php if($isLogged){ ?>
                        <li><a href="<?php echo $order;?>">Re-order</a></li>
                        <li><a href="<?php echo $detail;?>">My Details</a></li>
                        <li><a href="<?php echo $logout;?>">Log out</a></li>
                        <?php } else { ?>
                        <li><a class="accountLink" href="javascript:void(0)">Log in</a></li>
                        <?php }?>
                    </ul>
                </div>
            </div>
            <div class="toolbarMiddle">
                <a href="/" class="toolbarHomebutton "><span class="icon-logoWide"></span></a>
            </div>
        </div>
    </div>
    <div style="text-align: center;">
        <img src="/index.php?route=pay/checkout/qrCode&message=<?php echo $url_message;?>" style="width:50%" />
    </div>
    <!--登陆-->
    <div id="login" class="modal in" aria-hidden="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
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
                                <div class="forgottenPassword"><a class="forgotPassword" id="message_login" style="display:none;">Your
                                        login details were incorrect. Please try again</a></div>
                                <div class="footTextContentWrapper">
                                    <div class="GreyText">Don't have an account? Your account will be created the first
                                        time you complete an order.
                                    </div>
                                </div>
                            </div>
                            <input class="hiddenSubmitButton" type="submit" value="login" name="submit">
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="modal-footer-button-box">
                        <a data-dismiss="modal" href="javascript:void (0);" class="close modal-footer-button modal-footer-cancel regularFont"
                            onclick="return false;">Cancel</a>
                        <a id="accountLoginButton" class="modal-footer-button modal-footer-continue semiBoldFont"
                            onclick="return false;">Log In</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#error_paymentMethodId').click(function () {
        $('#login, .modal-backdrop').show();
    })
    $('.close').click(function () {
        $('#login, .modal-backdrop').hide();
    })
    $('.info-edit').click(function () {
        $('#takeawaySectionCompleted, .info-edit').hide();
        $('.edit-address-details').show();
    })
    $('#accountLoginButton').click(function () {
        event.preventDefault();
        if ($('#emailAddress').val() != '' && $('#password') != '') {
            $.post(
                '/index.php?route=checkout/login/save', {
                    email: $('#emailAddress').val(),
                    password: $('#password').val()
                },
                function (data) {
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

    $('#m-top-dropdownmenu').click(function (even) {
        $('.dropdown-menu, .dropdown-backdrop').show();
        even.preventDefault();
    })
    $('.dropdown-backdrop').click(function () {
        $('.dropdown-menu, .dropdown-backdrop').hide();
    })
    $('#orderWhen_now').click(function () {
        $('#orderDateTimeBlock').hide();
    })
    $('#orderWhen_later').click(function () {
        $('#orderDateTimeBlock').show();
    })
    $('#user_info').click(function () {
        $('#user-hide').hide();
        $('#user-show').show();
        $('#user_info').hide();
    })
    $('.accountLink').click(function() {
        $('#login').show();
        $('.dropdown-menu, .dropdown-backdrop').hide();
    })
</script>
<!-- <script src="/catalog/view/theme/mobile/script/checkout.js" defer="defer"></script> -->
<?php echo $footer; ?>