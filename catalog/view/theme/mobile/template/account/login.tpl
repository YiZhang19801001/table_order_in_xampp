<?php echo $header;?>
<script>
$(function() {
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
    //忘记密码
    $('#resetPasswordButton').click(function() {
        event.preventDefault();
        $.post(
            '/index.php?route=account/forgotten/save', {
                email: $('#emailAddress_F').val()
            },
            function(data) {
                if (data.error) {
                    $('#message_forgotten').show();
                }
                if (data.length == '') {
                    $('#passwordEmailSent').show();
                    $('#message_forgotten').hide();
                }
            }
        )
    })
})
</script>
<div id="mlTopToolbar" class="topBodyWrapWidth topToolbar clearfix">
    <div class="websiteTopToolbar clearfix">
        <div class="toolbarLeft toolbarLeftButtons">
            <a href="javascript:history.go(-1);" id="toolbarBackButtonLink">
                <div class="button-back icon-back"></div>
            </a>
        </div>
        <div class="toolbarMiddle">
            <a href="/" class="toolbarHomebutton "><span class="icon-logoWide"></span></a>
        </div>
    </div>
</div>
<!--登陆-->
<div id="loginIn" style="display: block; margin-top: 100px" class="modal in" aria-hidden="false">
    <div class="modal-dialog">
        <div id="login" class="modal-content">
            <div class="modal-header">
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
                            <div class="forgottenPassword">
                                <a href="javascript:void(0);" class="forgotPassword" @click="reg = true">Forgot your
                                    password?</a>
                            </div>
                        </div>
                        <input class="hiddenSubmitButton" type="submit" value="login" name="submit">
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <div class="modal-footer-button-box">
                    <a data-dismiss="modal" href="javascript:history.go(-1);" class="modal-footer-button modal-footer-cancel regularFont"
                    >Cancel</a>
                    <a class="modal-footer-button modal-footer-continue semiBoldFont" onclick="return false;"
                    id="accountLoginButton">Log In</a>
                </div>
            </div>
        </div>
        <div id="reg" class="modal-content" style="display: none">
            <div class="modal-header">
                <button type="button" class="close back" data-dismiss="modal" aria-hidden="true"></button>
                <div class="mm-header-title boldFont">Reset password</div>
            </div>
            <div id="accountContentWrap" class="modal-body mm-body">
                <div id="resendPasswordEmail">
                    <div class="mm-title semiBoldFont">
                        <span style="line-height:18px;">Submit your e-mail address below to receive a password reset link.</span>
                        <div id="message_forgotten" style="display:none;" class="normError messageSpacing">Please enter your current email.
                        </div>
                    </div>

                    <form id="resetPasswordForm" method="POST" class="accountForm">
                        <div class="mm-section" id="accountLoginDetails">
                            <div class="mm-section-item">
                                <div id="resetPasswordError" style="display:none"
                                    class="normError messageSpacing"></div>
                                <label for="emailAddress_F" class="inputFieldLabel regularFont"
                                    style="width:auto; padding-right:10px;">Email</label>
                                <span class="inputFieldSpan">
                                        <input id="emailAddress_F" type="email" name="emailAddress_F" value=""
                                            autocomplete="off">
                                    </span>
                            </div>
                        </div>

                        <input class="hiddenSubmitButton" type="submit" value="login" name="submit">
                    </form>
                </div>

                <div id="passwordEmailSent" style="display:none; padding:10px;" class="hideInResendPasswordPage">
                    <h1>We have e-mailed you a password reset link. Please check your spam folder if you can't find
                        it in the inbox.</h1>
                </div>

            </div>
            <div class="modal-footer">
                <div class="modal-footer-button-box">
                    <a data-dismiss="modal" href="" class="back modal-footer-button modal-footer-cancel regularFont"
                    onclick="return false;">Cancel</a>
                    <a class="modal-footer-button modal-footer-continue semiBoldFont" onclick="return false;"
                    id="resetPasswordButton">Continue</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('.forgotPassword').click(function ()
    {
        $('#login').hide();
        $('#reg').show();
    })
    $('.back').click(function ()
    {
        $('#login').show();
        $('#reg').hide();
    })
</script>