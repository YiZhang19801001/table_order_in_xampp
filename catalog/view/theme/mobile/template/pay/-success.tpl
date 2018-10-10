<?php echo $header; ?>
<div class="content">
    <div class="contentBody">
        <div class="tACheckoutCompletePage">
            <div class="confirmationLeft">
                <div class="flex-container topText orderSubmittedMessage module">
                    <div class="flex-item">
                        <i class="fa fa-check-circle" aria-hidden="true"></i>
                    </div>
                    <div class="flex-item">
                        <h1>All done, <?php echo $firstname." ".$lastname;?>!</h1>
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
                                        <img src="<?php $location_info['image'];?>" width="75px">
                                    </div>
                                    <div class="flex-item content">
                                        <p><strong><?php echo $location_info['name'];?></strong>
                                            <br><?php echo $location_info['address'];?>
                                        </p>
                                        <p>For any changes to your order, please contact
                                            <br>them directly by phone on
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
                                        <td>Order number: </td>
                                        <td class="result">Z7NPXVQ</td>
                                    </tr>
                                    <tr>
                                        <td>Order total: </td>
                                        <td class="result"><?php echo $total_text;?></td>
                                    </tr>
                                    <tr>
                                        <td>Payment method: </td>
                                        <td class="result">Cash</td>
                                    </tr>
                                    <tr>
                                        <td>Requested time: </td>
                                        <td class="result">18:30 on Saturday 15 April</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="flex-item">
                            <h3>Delivery address</h3>
                            <p>
                                <?php echo $firstname." ".$lastname;?>
                                <br><?php echo $comment;?>, <?php echo $payment_country;?>
                                <br>
                            </p>
                        </div>
                    </div>
                </div>
<!--                 <div class="module review">
                    <div class="heading">
                        <h2>Review restaurants you've ordered from</h2>
                    </div>
                    <div class="main">
                        <table class="reviewTable">
                            <tbody>
                                <tr class="even">
                                    <td class="logo"><img src="//www.menulog.com.au/generated_content/venue_images/venue_info_thumb/179118_8bfe091a19b0d05ea1bdb79caf44f5e9/Doytao-Thai.png"></td>
                                    <td class="details">
                                        <div class="name">Doytao Thai Restaurant Croydon</div>
                                        <div class="date">Order date 15/04/17</div>
                                    </td>
                                    <td class="reviewButton">
                                        <a href="/doytao-thai-restaurant-croydon/takeaway/rate/?referenceCode=Z7NPXVQ" class="button" title="add your review">Add your review</a>
                                    </td>
                                </tr>
                                <tr class="odd">
                                    <td class="logo"><img src="//www.menulog.com.au/generated_content/venue_images/venue_info_thumb/179118_8bfe091a19b0d05ea1bdb79caf44f5e9/Doytao-Thai.png"></td>
                                    <td class="details">
                                        <div class="name">Doytao Thai Restaurant Croydon</div>
                                        <div class="date">Order date 10/04/17</div>
                                    </td>
                                    <td class="reviewButton">
                                        <a href="/doytao-thai-restaurant-croydon/takeaway/rate/?referenceCode=Z7NPXKL" class="button" title="add your review">Add your review</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div> -->
                <div class="module share-your-experience">
                    <div class="heading">
                        <h2>Share your experience</h2>
                    </div>
                    <div class="main" id="shareYourExperience">
                        <div class="left">
                            <h3>Tell your friends</h3>
                            <a href="https://www.facebook.com/sharer.php?u=https://www.menulog.com.au/doytao-thai-restaurant-croydon" class="social facebook"><span>Share on Facebook</span></a>
                            <a href="https://twitter.com/intent/tweet?text=I+just+placed+an+order+at+Doytao+Thai+Restaurant+Croydon+%40menulog.+Check+them+out.&amp;url=https%3A%2F%2Fwww.menulog.com.au%2Fdoytao-thai-restaurant-croydon" class="social twitter"><span>Share on Twitter</span></a>
                            <a href="https://plus.google.com/share?url=https://www.menulog.com.au/doytao-thai-restaurant-croydon" class="social google-plus"><span>Share on Google Plus!</span></a>
                        </div>
                        <div class="right">
                            <h3>Share your meal on Instagram</h3>
                            <div class="social instagram"><span>Share on Instgram</span></div>
                            <p>When your food arrives, take a photo and tag it <strong class="hashtag">#menulog</strong></p>
                        </div>
                    </div>
                </div>
                <div class="module quicklink">
                    <a href="/takeaway/ashfield/alcohol-only"><h2 class="noSpaceBelow">Thirsty? Click here to accompany your meal with alcohol.</h2></a>
                    <p>Any orders including alcoholic items will require you to show photo ID to the delivery driver.</p>
                </div>
                <div class="module while-you-wait">
                    <div class="heading">
                        <h2>While you wait...</h2>
                    </div>
                    <div class="columnize columns-2 main" id="connectWithMenulogBox">
                        <div>
                            <h3>Follow Menulog</h3>
                            <iframe allowtransparency="true" frameborder="0" scrolling="no" src="//platform.twitter.com/widgets/follow_button.html?show_count=false&amp;screen_name=menulog" style="width:64px; height:20px;"></iframe>
                            <iframe src="//www.facebook.com/plugins/follow.php?href=https%3A%2F%2Fwww.facebook.com%2FMenulog.com.au&amp;width&amp;height=21&amp;colorscheme=light&amp;layout=button_count&amp;show_faces=true&amp;appId=478795322196325" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:64px; height:20px;" allowtransparency="true"></iframe>
                            <!-- Place this tag in your head or just before your close body tag. -->
                            <script src="https://apis.google.com/js/platform.js" async="" defer=""></script>
                            <!-- Place this tag where you want the widget to render. -->
                            <div class="g-follow" data-annotation="none" data-height="20" data-href="https://plus.google.com/105250872482074561424" data-rel="publisher"></div>
                            <div class="sml-fav-restaurant">
                                <h3>Favourite restaurant missing?</h3>
                                <form action="/suggest.php" method="get" class="suggest-restaurant-form">
                                    <div class="suggest-a-restaurant">
                                        <input type="text" name="restaurantName" placeholder="Suggest a restaurant...">
                                        <input class="button suggest-submit" type="submit" value="Send">
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div>
                            <h3>Like us on Facebook</h3>
                            <iframe id="fbIframe" src="//www.facebook.com/plugins/likebox.php?href=http%3A%2F%2Fwww.facebook.com%2FMenulog.com.au&amp;width=250&amp;height=200&amp;colorscheme=light&amp;show_faces=true&amp;header=false&amp;stream=false&amp;show_border=false&amp;appId=198322736874280"></iframe>
                        </div>
                    </div>
                </div>
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
                                <span class="text2">You receive an SMS with delivery time.</span>
                            </div>
                            <div class="flex-item">
                                <span class="counter">03</span>
                                <span class="text3">Food is delivered to your door.</span>
                            </div>
                        </div>
                        <!-- .flex-container -->
                    </div>
                </div>
            </div>
            <div class="confirmationRight">
                <div class="mobileapp">
                    <h2>Download our <br>FREE MOBILE APP!</h2>
                    <h3>Order takeaway anywhere, anytime!</h3>
                    <a href="/apps.php">
                        <img src="//www.menulog.com.au/images/general/download_app_thumbnail_v3.png">
                    </a>
                    <h3>We can <strong>SMS</strong> you the link to our app...</h3>
                    <div id="core-ajaxForm-b163777ad154075d1af6ab48a4f4a3e5" class="core-ifhBlock">
                        <form action="https://www.menulog.com.au/ajax_sms.php" method="post" class="core-ajaxForm send-app-link-form" id="send-app-link-form">
                            <input type="submit" value="" class="core-hiddenSubmit">
                            <div class="send-app-link">
                                <input type="hidden" name="smsType" value="customer">
                                <input type="text" name="phoneNumber" value="18346653480" readonly="">
                                <input type="hidden" name="message" value="Download the free Menulog App https://m.menulog.com.au/apps.php">
                                <input type="hidden" name="country" value="Australia">
                                <input name="CSRFToken" type="hidden" value="58eaf411d397b6.40896061">
                                <input class="button suggest-submit" type="submit" value="SEND">
                            </div>
                        </form>
                    </div>
                    <script type="text/javascript">
                    $(function() {
                        var $ajaxForms = $("#core-ajaxForm-b163777ad154075d1af6ab48a4f4a3e5").find(".core-ajaxForm");
                        if (!$ajaxForms.first().data("ajaxForm"))
                            $ajaxForms.ajaxForm().first().data("ajaxForm").processJsonResponse([
                                ["g", "default"]
                            ]);
                    });
                    </script>
                    <h4>Or download from the app stores:</h4>
                    <div class="icon">
                        <a href="http://ad.apps.fm/QAzSyqQvhMdrFTKrwwSY5fE7og6fuV2oOMeOQdRqrE25PHT4cAtafJbPR4qrXvpkuu-ENBsPWBc0oG5VA0o6psZW-aZt7fHVHKGyjinLV07i_WYzqxJluATc7vPnlHi-aDdtGuWnWf-50f3YX7laWnTLeIHWt3Jtqy5TGcUuHAzoLfrOy57wsePYtH4ezJ-3"><img src="//www.menulog.com.au/images/general/badge_app_store@2x.png"></a>
                        <a href="https://ad.apps.fm/tDafrm4f5YbbCDQYkno9tl5KLoEjTszcQMJsV6-2VnHFDLXitVHB6BlL95nuoNYfOrNSOSR3EuoB_IIEsY7_bfZO-OrtcRMLZ9zxTg4WeyGXdGf4SAjyWGGuHqkBN7lN"><img src="//www.menulog.com.au/images/general/badge_play_store@2x.png"></a>
                    </div>
                </div>
            </div>
            <div class="contentEnd"></div>
            <iframe src="/conversion-pixels?noDisplayHTMLHeader=1&amp;noDisplayHTMLFooter=1&amp;noDisplayHeader=1&amp;noDisplayFooter=1" width="0" height="0" frameborder="0"></iframe><img src="http://campaigns.empoweredcomms.com.au/ml/imgs/com/b80659NTYzMDpjb206cHJv/blank.gif" height="1" width="1" alt="">
            <img src="https://jumboaffiliates.com/sl/pid=177&amp;ot=59.40&amp;on=Z7NPXVQ&amp;cid=57/sl.gif" width="1" height="1">
            <img src="https://ssl.rewardscentral.com.au/autoclaim.aspx?sid=TVEKNK&amp;oid=Z7NPXVQ&amp;amt=59.40" height="1" width="1" border="0">
        </div>
    </div>
    <?php echo $footer; ?>