<?php echo $header; ?>
<div class="fullWidthWrapper1">
    <div class="fullWidthWrapper2">
        <div class="fullWidthWrapper3">
            <div class="takeawayNavWrapper1">
                <div class="takeawayNavWrapper2">
                    <div class="takeawayNavWrapper3">
                        <div class="breadCrumbs"><a href="https://www.menulog.com.au/">HOME</a> <span class="icon-forward"></span>Sign Up</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="content">
    <div class="minor contentBody">
        <div class="sign_up">
            <div class="top">
                <div class="left">
                    <div class="title">
                        <h1>Sign up, See &amp; Eat</h1>
                        <h2>We're all about takeaway, and we know you are too</h2>
                    </div>
                    <div class="graph"><img src="//www.menulog.com.au/images/general/devices_backdrop.v2.png"></div>
                </div>
                <div class="right">
                    <div id="core-ajaxForm-b44945909a2b584ee7dda22120b9631c" class="core-ifhBlock">
                        <form action="https://www.menulog.com.au/accounts/ajax_sign_up.php" method="post" class="signUp core-ajaxForm">
                            <input type="submit" value="" class="core-hiddenSubmit">
                            <fieldset>
                                <input id="newEmailAddress" name="newEmailAddress" type="text" value="" placeholder="Email address">
                                <div class="contentEnd"></div>
                                <select id="takeawayCountryId" name="takeawayCountryId">
                                    <option value="">-- Please select your country</option>
                                    <option value="6" selected="selected">Australia</option>
                                    <option value="106">New Zealand</option>
                                </select>
                                <div id="message_takeawayStateId"></div>
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
                                <div id="message_takeawaySuburbId"></div>
                                <select id="takeawaySuburbId" name="takeawaySuburbId" disabled="disabled">
                                    <option value="">-- Please select your suburb</option>
                                </select>
                                <div class="contentEnd"></div>
                                <input id="password" name="password" type="password" value="" placeholder="Password">
                                <div class="contentEnd"></div>
                                <input id="passwordConfirm" name="passwordConfirm" type="password" value="" placeholder="Confirm password">
                                <div class="contentEnd"></div>
                            </fieldset>
                            <fieldset>
                                <input type="submit" id="signUpSubmit" class="btnGrey" value="SIGN UP">
                                <div class="core-right">
                                    <div class="core-pleaseWait" style="display: none;">Please wait</div>
                                </div>
                                <div class="text">When you sign up for a Menulog account you will automaticallly be added to receive our newsletters.</div>
                            </fieldset>
                        </form>
                    </div>
                    <script type="text/javascript">
                    $(function() {
                        var $ajaxForms = $("#core-ajaxForm-b44945909a2b584ee7dda22120b9631c").find(".core-ajaxForm");
                        if (!$ajaxForms.first().data("ajaxForm"))
                            $ajaxForms.ajaxForm().first().data("ajaxForm").processJsonResponse([
                                ["f", "emailAddress"],
                                ["g", "default"],
                                ["x2", "$.ajax ({ url: \"\/accounts\/ajax_populate_takeaway_locations.php?takeawayCountryId=6&takeawayStateId=&takeawaySuburbId=\", success: $.core.processAjaxResponse });"]
                            ]);
                    });
                    </script>
                </div>
                <div class="contentEnd"></div>
            </div>
            <div class="contentEnd"></div>
            <div class="iconstitle">
                <h2>Sign up for a Menulog account and receive:</h2>
            </div>
            <ul class="columnize columns-5 icons">
                <li class="newsletters">
                    <img src="//www.menulog.com.au/images/general/jumbo_icon_newsletters@2x.png">
                    <h3>Newsletters</h3>
                    <span class="text">Receive newsletters<br>from Menulog</span>
                </li>
                <li class="exclusive">
                    <img src="//www.menulog.com.au/images/general/jumbo_icon_exclusives@2x.png">
                    <h3>Exclusives</h3>
                    <span class="text">Secret specials &amp;<br>exclusive discounts</span>
                </li>
                <li>
                    <img src="//www.menulog.com.au/images/general/jumbo_icon_trends@2x.png">
                    <h3>Trends</h3>
                    <span class="text">Keep up with the<br>latest food trends</span>
                </li>
                <li class="insider">
                    <img src="//www.menulog.com.au/images/general/jumbo_icon_insider_tips@2x.png">
                    <h3>Insider Tips</h3>
                    <span class="text">Find the hottest new<br>places in your area</span>
                </li>
                <li class="events">
                    <img src="//www.menulog.com.au/images/general/jumbo_icon_events@2x.png">
                    <h3>Events</h3>
                    <span class="text">Be informed of<br>upcoming events</span>
                </li>
            </ul>
            <div class="as_seen_in">
                <div class="title">
                    <h5>AS SEEN IN...</h5>
                </div>
                <div class="media">
                    <img src="//www.menulog.com.au/images/general/websites@2x.png" width="980px">
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
