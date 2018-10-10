<?php echo $header; ?>
<link rel="stylesheet" href="/catalog/view/theme/menulog/stylesheet/apps/apps.v5.css">
<div class="fullWidthWrapper1">
    <div class="fullWidthWrapper2">
        <div class="fullWidthWrapper3">
            <div class="takeawayNavWrapper1">
                <div class="takeawayNavWrapper2">
                    <div class="takeawayNavWrapper3">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="content">
    <div class="minor contentBody">
        <div id="appsWrapper">
            <div id="appsTop">
                <div id="appsTopMain">
                    <h1>Order on the go</h1>
                    <p id="message">Tap the app</p>
                    <div id="storesWrapper">
                        <a class="downloadLinks" target="_blank" href="http://ad.apps.fm/j-CNlnwgt0cTv-uztoqNJ_E7og6fuV2oOMeOQdRqrE25PHT4cAtafJbPR4qrXvpkuu-ENBsPWBc0oG5VA0o6psZW-aZt7fHVHKGyjinLV07i_WYzqxJluATc7vPnlHi-NkB31Cexko7REdTzNEm6QbwU-sSu3DyXzAMNrihWNRI"><img src="//www.menulog.com.au/images/general/ios_app_store.png" alt="Download from the app store"></a>
                        <a class="downloadLinks" target="_blank" href="https://ad.apps.fm/cdmpiWi_jwPz5ZZSGR_aYF5KLoEjTszcQMJsV6-2VnHFDLXitVHB6BlL95nuoNYfOrNSOSR3EuoB_IIEsY7_bX0GryzJrdl_VvBFYBYoAv0"><img src="//www.menulog.com.au/images/general/android_play_store.png" alt="Download from the Play store"></a>
                        <a class="downloadLinks" target="_blank" href="http://ad.apps.fm/lsFxwfxlulRJQFVlmR6l0YfwMlclieMpIVDZ5BYWIiVSUDk5UmdmKia9dDijM3BVLMqFW_USAfoCej6XsHEbgurZtbRo335xfEl6UsRxY5VIWgFQSTTIOS7iLaQdR9oI"><img src="//www.menulog.com.au/images/general/windows_phone_app_store@2x.png" alt="Download from the windows app store"></a>
                    </div>
                    <div class="reviewWrapper">
                        <p class="review">
                            By far the best food delivery
                            <br>app going around.
                            <br>
                            <span class="reviewer">Kathlyns40, iOS user</span>
                        </p>
                    </div>
                    <div class="reviewWrapper">
                        <p class="review">
                            Excellent App. All menus at
                            <br>my finger tips.
                            <br>
                            <span class="reviewer">Rhi McKeon, Android user</span>
                        </p>
                    </div>
                </div>
                <!-- #appsTopMain -->
                <div class="appsTopDevices" id="appsTopDevicesAU"></div>
                <div class="contentEnd"></div>
                <div class="smsFormWrapper">
                    <span>Enter your mobile phone number, we'll SMS you the link to our app...</span>
                    <div id="core-ajaxForm-cd736f081c8d280eeba831e22d1e58c7" class="core-ifhBlock">
                        <form action="https://www.menulog.com.au/ajax_sms.php" method="post" class="core-ajaxForm send-app-link-form" id="send-app-link-form">
                            <input type="submit" value="" class="core-hiddenSubmit">
                            <div class="send-app-link">
                                <input type="hidden" name="smsType" value="customer">
                                <input type="text" name="phoneNumber" value="">
                                <input type="hidden" name="message" value="Download the free Menulog App https://m.menulog.com.au/apps.php">
                                <input type="hidden" name="country" value="Australia">
                                <input name="CSRFToken" type="hidden" value="58d32f30eaf200.85762750">
                                <input class="button suggest-submit" type="submit" value="SEND">
                            </div>
                        </form>
                    </div>
                    <script type="text/javascript">
                    $(function() {
                        var $ajaxForms = $("#core-ajaxForm-cd736f081c8d280eeba831e22d1e58c7").find(".core-ajaxForm");
                        if (!$ajaxForms.first().data("ajaxForm"))
                            $ajaxForms.ajaxForm().first().data("ajaxForm").processJsonResponse([
                                ["g", "default"]
                            ]);
                    });
                    </script>
                    <div class="contentEnd"></div>
                </div>
            </div>
            <!-- #appsTop -->
            <div id="appsBottom">
                <h3>We make ordering easy</h3>
                <ul>
                    <li>16000+ specials at your fingertips</li>
                    <li>Pay for your order with cash, credit card or PayPal</li>
                    <li>Re-order from any one of your past meals</li>
                </ul>
                <ul>
                    <li>Compare peer reviews for each restaurant</li>
                    <li>Keep a list of your favourite restaurants</li>
                    <li>SMS confirmation with delivery time</li>
                </ul>
                <ul>
                    <li>Filter by cuisine, name, distance from you or type of special</li>
                    <li>See local restaurants on a map</li>
                    <li>Order for later</li>
                    <li>Sort search results by open now</li>
                </ul>
            </div>
        </div>
        <!--appsWrapper -->
        <script type="text/javascript">
        $(document).ready(function() {
            $('#videoButtonWrapper').on('click', function() {
                $.createPopover({
                    content: '<iframe src="https://www.youtube.com/embed/33pE5w7rhUQ?autoplay=1&rel=0&fs=1&modestbranding=1&showinfo=0&showsearch=0&controls=2&autohide=1&vq=hd1080"  width="335" height="500" frameborder="0" allowfullscreen>'
                }, {
                    template: 'helperNoTitle',
                    stylingClass: 'embedVideo',
                    applyMask: true,
                    maxWidth: 335,
                    height: 500,
                    attachOffsetX: 160,
                    applyDraggable: true,
                    easyClose: true,
                    addCloseX: true,
                    attachTo: '#appsTopMain'
                });
                return false;
            });
        });
        </script>
    </div>
</div>
<?php echo $footer; ?>
