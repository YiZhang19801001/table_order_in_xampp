<?php echo $header;?>
<div class="fullWidthWrapper1">
    <div class="fullWidthWrapper2">
        <div class="fullWidthWrapper3">
            <div class="takeawayNavWrapper1">
                <div class="takeawayNavWrapper2">
                    <div class="takeawayNavWrapper3">
                        <div class="breadCrumbs"><a href="https://www.menulog.com.au/">HOME</a> <span class="icon-forward"></span>My Details</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="content">
    <div class="minor contentBody">
        <div id="core-ajaxForm-299a1573c0a07ab006121a4046212b4b" class="core-ifhBlock">
            <form action="https://www.menulog.com.au/accounts/ajax_my_details.php" method="post" class="myDetails core-ajaxForm">
                <input type="submit" value="" class="core-hiddenSubmit">
                <fieldset>
                    <h1>My Details</h1>
                    <div class="column">
                        <div class="section">
                            <h2>Login details</h2>
                            <div class="formField">
                                <div id="current_password"></div>
                                <label for="currentPassword" class="fieldTitle">Current password</label>
                                <input id="currentPassword" name="currentPassword" type="password" value="" autocomplete="off">
                                <p class="passwordInfo smallSpaceAbove"><a href="#" id="forgotPassword">Forgot your password?</a></p>
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_password"></div>
                                <label for="password" class="fieldTitle">New password</label>
                                <input id="password" name="password" type="password" value="" autocomplete="off">
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_passwordCheck"></div>
                                <label for="passwordCheck" class="fieldTitle">Confirm new password</label>
                                <input id="passwordCheck" name="passwordCheck" type="password" value="" autocomplete="off">
                                <div class="contentEnd"></div>
                            </div>
                            <p class="smallText passwordInfo">(Only enter a new password if you wish to change your current one)</p>
                            <div class="section">
                            </div>
                            <h2>Contact Details</h2>
                            <div class="formField">
                                <div id="message_firstName"></div>
                                <label for="firstName" class="fieldTitle">First name</label>
                                <input id="firstName" name="firstName" type="text" value="">
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_lastName"></div>
                                <label for="lastName" class="fieldTitle">Last name</label>
                                <input id="lastName" name="lastName" type="text" value="">
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_alias"></div>
                                <label for="alias" class="fieldTitle">Name for ratings</label>
                                <input id="alias" name="alias" type="text" value="">
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_emailAddress"></div>
                                <label for="emailAddress" class="fieldTitle">Email address<span class="required">*</span></label>
                                <input id="emailAddress" name="emailAddress" type="text" value="richad521@hotmail.com">
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_phoneNumber"></div>
                                <label for="phoneNumber" class="fieldTitle">Phone number</label>
                                <input id="phoneNumber" name="phoneNumber" type="text" value="">
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_mobileNumber"></div>
                                <label for="mobileNumber" class="fieldTitle">Mobile number</label>
                                <input id="mobileNumber" name="mobileNumber" type="text" value="">
                                <div class="contentEnd"></div>
                            </div>
                        </div>
                    </div>
                    <div class="column">
                        <div class="section">
                            <h2>Upload a photo</h2>
                            <div class="formField">
                                <div id="message_userPhoto"></div>
                                <label for="userPhoto" class="fieldTitle">Photo</label>
                                <input id="userPhoto" name="userPhoto" type="file" value="">
                                <div class="contentEnd"></div>
                            </div>
                            <div class="section">
                            </div>
                            <h2>Delivery address</h2>
                            <div class="formField">
                                <div id="message_takeawayCountryId"></div>
                                <label for="takeawayCountryId" class="fieldTitle">Country</label>
                                <select id="takeawayCountryId" name="takeawayCountryId">
                                    <option value="">-- Please select your country</option>
                                    <option value="6" selected="selected">Australia</option>
                                    <option value="106">New Zealand</option>
                                </select>
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_takeawayStateId"></div>
                                <label for="takeawayStateId" class="fieldTitle">State</label>
                                <select id="takeawayStateId" name="takeawayStateId">
                                    <option value="">-- Please select your state</option>
                                    <option value="94">Australian Capital Territory</option>
                                    <option value="95">New South Wales</option>
                                    <option value="96">Northern Territory</option>
                                    <option value="97">Queensland</option>
                                    <option value="98">South Australia</option>
                                    <option value="99">Tasmania</option>
                                    <option value="100">Victoria</option>
                                    <option value="101">Western Australia</option>
                                </select>
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_takeawaySuburbId"></div>
                                <label for="takeawaySuburbId" class="fieldTitle">Suburb</label>
                                <select id="takeawaySuburbId" name="takeawaySuburbId" disabled="disabled">
                                    <option value="">-- Please select your suburb</option>
                                </select>
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_streetNumber"></div>
                                <label for="takeawayStreetNumber" class="fieldTitle">Address</label>
                                <div class="core-inFieldLabel" style="float: left;">
                                    <label for="takeawayStreetNumber">Unit/Street Number</label>
                                    <input id="takeawayStreetNumber" name="takeawayStreetNumber" type="text" value="">
                                </div>
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_takeawayAddressLine1"></div>
                                <label for="takeawayAddressLine1" class="fieldTitle">&nbsp;</label>
                                <div class="core-inFieldLabel" style="float: left;">
                                    <label for="takeawayAddressLine1">Street Name</label>
                                    <input id="takeawayAddressLine1" name="takeawayAddressLine1" type="text" value="" class="jsStreetSuggest" spellcheck="false" autocomplete="off">
                                </div>
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField">
                                <div id="message_takeawayNearestCrossStreet"></div>
                                <label for="takeawayNearestCrossStreet" class="fieldTitle">Nearest cross street</label>
                                <input id="takeawayNearestCrossStreet" name="takeawayNearestCrossStreet" type="text" value="" class="jsStreetSuggest" spellcheck="false" autocomplete="off">
                                <div class="contentEnd"></div>
                            </div>
                            <div class="formField" style="margin-left: 150px">
                                <input id="sendNewsletter" class="smallSpaceAbove" name="sendNewsletter" type="checkbox" checked="">
                                <label for="sendNewsletter" class="checkbox fieldTitle">Send Newsletters</label>
                                <div class="contentEnd"></div>
                            </div>
                            <script type="text/javascript">
                            $(".jsStreetSuggest").coreAjaxSuggest({
                                url: "https://www.menulog.com.au/takeaway/ajax_suggest_street_names.php",
                                onBeforeSend: function(extraParams) {
                                    extraParams.suburbId = $("#takeawaySuburbId").val();
                                    return extraParams;
                                },
                                useCache: false
                            });
                            </script>
                            <div id="message_successMessage" class="core-message successMessageBox message" style="display: none;"></div>
                            <div class="contentEnd"></div>
                            <div class="core-dialogueButtons">
                                <div class="core-right">
                                    <input type="submit" class="button updateButton" value="UPDATE">
                                </div>
                                <div class="core-right">
                                    <div class="core-pleaseWait" style="display: none;">Please wait</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </form>
            <div class="forgottenPassword">
                <h3>Password Reset</h3>
                <form class="forgottenPasswordForm core-ajaxForm" method="post" action="/accounts/ajax_forgotten_password.php">
                    <input type="submit" value="" class="core-hiddenSubmit">
                    <input type="hidden" name="action" value="resetPassword">
                    <input type="hidden" name="uniqueId" value="UzTOy2xD">
                    <fieldset>
                        <p>Submit your e-mail address below to receive a password reset link.</p>
                        <div class="core-inFieldLabel">
                            <input type="text" value="richad521@hotmail.com" name="emailAddress" id="emailAddressFPW" readonly="">
                        </div>
                        <div class="message" id="message_emailAddress"></div>
                        <div class="message" id="message_inactiveUserFPW"></div>
                        <div class="core-dialogueButtons">
                            <div class="core-left">
                                <button type="submit" class="resetPassword">RESET PASSWORD</button>
                            </div>
                            <div class="core-left">
                                <div class="core-pleaseWait" style="display: none;">Please wait</div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
            <script type="text/javascript">
            $(document).ready(function() {
                $('#link_forgotPassword')
                    .bind('click', function() {
                        $('.forgottenPassword').slideDown();
                        return false;
                    });
            });
            </script>
        </div>
        <script type="text/javascript">
        $(function() {
            var $ajaxForms = $("#core-ajaxForm-299a1573c0a07ab006121a4046212b4b").find(".core-ajaxForm");
            if (!$ajaxForms.first().data("ajaxForm"))
                $ajaxForms.ajaxForm().first().data("ajaxForm").processJsonResponse([
                    ["g", "default"],
                    ["x2", "                            $(\"#forgotPassword\").on(\"click\", function() {\n                                $.createPopover(\n                                    {\n                                        content: $(\".forgottenPassword\").html()\n                                    },\n                                    {\n                                        attachTo: $(this),\n                                        applyDraggable: true,\n                                        width: 300,\n                                        stylingClass: 'myDetailsPasswordResetWrapper'\n                                    }\n                                );\n                            });$.ajax ({ url: \"\/accounts\/ajax_populate_takeaway_locations.php?takeawayCountryId=6&takeawayStateId=0&takeawaySuburbId=0\", success: $.core.processAjaxResponse });"]
                ]);
        });
        </script>
    </div>
</div>
<?php echo $footer;?>
