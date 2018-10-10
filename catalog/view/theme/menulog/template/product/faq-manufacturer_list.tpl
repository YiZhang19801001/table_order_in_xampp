<?php echo $header; ?>
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
    <div class="show_page contentBody">
        <div id="show_page_faq">
            <style type="text/css">
            .show_page_faq {
                width: 100%;
            }
            
            .show_page_faq h1 {
                font-size: 36px;
            }
            
            .show_page_faq h2 {
                color: #26BF22;
                font-family: 'robotoregular', Arial;
                font-size: 22px;
                margin-bottom: 10px;
            }
            
            dl.faq-list {
                margin: 0 0 30px;
                line­-height: 1.2;
                border-bottom: 1px solid #eee;
            }
            
            dl.faq-list dt,
            dl.faq-list dd {
                padding­-left: 30px;
            }
            
            dl.faq-list dt {
                border-top: 1px solid #EEE;
                background: url(/catalog/view/theme/menulog/image/faq_plus.v2.png) 0 9px no-repeat;
                font­-size: 16px;
                font­-weight: normal;
                padding: 12px 0 10px 30px;
            }
            
            dl.faq-list dt.visible {
                background-image: url(/images/icons/faq_minus.png);
            }
            
            dl.faq-list dd {
                font­-family: 'proxima_nova_regular', Arial;
                font­-size: 14px;
                margin: 0;
                margin-bottom: 20px;
            }
            
            dl.faq-list dd a {
                font­-weight: normal;
                font­-family: 'proxima_nova_semibold', Arial;
                color: #a1c742;
            }
            </style>
            <script type="text/javascript">
            $(function() {
                $('.faq-list dt')
                    .css('cursor', 'pointer')
                    .next('dd')
                    .hide(0); // hide via JS so that FAQ page is still usable without JS

                $('.faq-list dt').on('click', function(evt) {
                    var $term = $(this);
                    var $def = $term.next();
                    var visible = $def.is(":visible");
                    $def['slide' + (visible ? 'Up' : 'Down')]('fast');
                    $term
                        .attr('class', '')
                        .addClass((visible ? 'hidden' : 'visible'));
                });
            });
            </script>
            <!--­­ FAQ PAGE CONTENT ­­-->
            <div class="show_page_faq">
                <h1>Frequently Asked Questions</h1>
                <h2>I paid online but my order was cancelled. How do I get my refund?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">I paid online but my order was cancelled. How do I get my refund?</dt>
                    <dd style="display: none;">Cancelled orders are automatically refunded overnight and the funds will be back into your account in 2-3 business days, depending on your bank. PayPal refunds can take longer. We try and make sure that our orders are accepted as we know how disappointing it is to be hungry without an order!</dd>
                </dl>
                <h2>My order is late.</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">My order is late.</dt>
                    <dd style="display: none;">Our restaurant partners try their best to deliver every order on time, but unexpected situations can occur. If your hunger grows by the minute give the restaurant a call. If you have no luck, give us a call on 1300 664 335 and we can look into this for you.</dd>
                </dl>
                <h2>How Menulog Works</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">How does Menulog work?</dt>
                    <dd style="display: none;">Menulog is an online food delivery service that connects you to thousands of local restaurants, anywhere around the country! Forget the hassle of cooking yourself, and let someone else make the food and deliver it straight to your door. Simply log onto our app or website and place your order. We'll send you a text to confirm what your delivery/pick up time is, and soon enough you'll have a delicious stress­free meal (with tonnes less washing up too!)</dd>
                </dl>
                <h2>How do I place a review?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">How do I place a review?</dt>
                    <dd style="display: none;">If you’ve received an order and want to let your fellow Menuloggers know about your experience, check out the review section via the link in the follow­up email which you’ll receive after ordering, or by checking out your “past orders” on the site.</dd>
                </dl>
                <h2>Nothing is showing up in my suburb, or my favourite local restaurant is not listed?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">Nothing is showing up in my suburb, or my favourite local restaurant is not listed?</dt>
                    <dd style="display: none;">We try our best to get your local gems on Menulog, but if we missed your favourite, let us know and we'll try and get them on board. <a href="https://www.menulog.com.au/suggest.php">Click here to add a suggestion</a></dd>
                </dl>
                <h2>What payment types do you accept?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">What payment types do you accept?</dt>
                    <dd style="display: none;">Getting your food to you should be easy, so paying for your food needs to be easy too. We accept all the major online payment methods. This means you can use VISA, MasterCard, American Express and PayPal. Some restaurants even offer you the good old fashion route and pay by Cash. Delivery and pick up options available. Keep in mind that it always comes down to what the restaurant accepts, so double check when you place your order.</dd>
                </dl>
                <h2>How are you protecting my details?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">How are you protecting my details?</dt>
                    <dd style="display: none;">We take the security of our customers very seriously. Our high-­tech security system ensures that your card details aren't shared with anyone else including the restaurant. You can read more about what steps we take to protect you as our valued customer in our privacy policy.</dd>
                </dl>
                <h2>How do I know my order has gone through?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">How do I know my order has gone through?</dt>
                    <dd style="display: none;">You'll get an SMS within 5-­10 minutes of ordering that will give you an estimated time of your order completion.</dd>
                </dl>
                <h2>I haven’t received a confirmation email from Menulog</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">I haven’t received a confirmation email from Menulog</dt>
                    <dd style="display: none;">We bet it was gremlins, but it could be that we don’t have your correct email address. You should probably call us on 1300 787 955 so we can check it out.</dd>
                </dl>
                <h2>My confirmation SMS advising the restaurant has received but my order hasn’t
arrived.</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">My confirmation SMS advising the restaurant has received but my order hasn’t arrived.</dt>
                    <dd style="display: none;">It could simply be that the restaurant is super busy and hasn’t quite got to accepting your order yet. If you’re worried, dont fret, log in to your account and double check that we have the right phone number (so that someone else isn’t getting your confirmations texts) and then give us a buzz on 1300 664 335 if we’ve got the wrong number or you need any more help.</dd>
                </dl>
                <h2>Once I’ve placed my order, can I contact the restaurant directly?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">Once I’ve placed my order, can I contact the restaurant direct?
                    </dt>
                    <dd style="display: none;">Of course you can! Check your confirmation sms for the number and give them a call. Our team could also help you out, and are always happy to help out if you’ve not been able to get through to the restaurant.</dd>
                </dl>
                <h2>I have just placed my order but need to change something (add or remove an item, change
delivery to collection etc).</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">I have just placed my order but need to change something (add or remove an item, change delivery to collection etc).</dt>
                    <dd style="display: none;">Got your confirmation SMS/Email? You’d better give the restaurant a quick call to see if they can help out before they start making your food. If you haven’t got the SMS yet, or you can’t get through to the restaurant, give us a shout out on 1300 664 335 so we can assist you.
                    </dd>
                </dl>
                <h2>I need to cancel my order.</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">I need to cancel my order.</dt>
                    <dd style="display: none;">We understand that sometimes plans change and cancelling is your only option. We can cancel your order if the restaurant hasn't started preparing it yet, and if they have they may be able to give you a refund or credit. Best way to find out? Call the restaurant, if you can’t get through to the restaurant​,​ ​g​ive us call on 1300 664 335​ so we can assist you.​</dd>
                </dl>
                <h2>I received my order but I’m not happy with it.</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">I received my order but I’m not happy with it.</dt>
                    <dd style="display: none;">Have a quick look at the email we sent containing your order details and make sure it's correct. If there is a difference please give the restaurant a call and see how they can fix up the mistake. Or call us on 1300 664 335 and we can help too!</dd>
                </dl>
                <h2>There is a price difference between your website and the restaurants pricing/and or the
restaurant is asking me to pay extra?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">There is a price difference between your website and the restaurants pricing/and or the restaurant is asking me to pay extra?</dt>
                    <dd style="display: none;">We need our partner restaurants to let us know when prices change, but we understand that they’re busy creating scrumptious food for you to enjoy. If you notice a price difference please call us on 1300 664 335 or email us at <a target="_blank" href="mailto:enquiries@menulog.com.au">enquiries@menulog.com.au</a> so we can look into it. Menulog offers a best price policy so we would love the opportunity to investigate any discrepancies.</dd>
                </dl>
                <h2>I have received my order but it’s not what I requested.</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">I have received my order but it’s not what I requested.</dt>
                    <dd style="display: none;">Quick, double check the confirmation email! Maybe the computer gremlins threw in some extra sides for themselves? If there is a difference between what’s on the email and what you received, please call the restaurant straight away to let them know. Of course, our team are also always happy to help you out if you’re not able to resolve this directly with the restaurant call us on 1300 664 335 and we can help too!</dd>
                </dl>
                <h2>How do I unsubscribe or delete my account?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">How do I unsubscribe or delete my account?</dt>
                    <dd style="display: none;">We’ll miss you! But if you need to, just log in to your profile and under My Details, and untick "Send Newsletters".</dd>
                </dl>
                <h2>I have an allergy, how do I communicate with the restaurant?</h2>
                <dl class="faq-list">
                    <dt style="cursor: pointer;">I have an allergy, how do I communicate with the restaurant?</dt>
                    <dd style="display: none;">In the even that you have an allergy and wish to confirm any meal ingredients we suggest that you contact the restaurant directly prior to ordering your meal</dd>
                    <dd>
                    </dd>
                </dl>
            </div>
            <!--­­ END FAQ PAGE CONTENT ­­-->
        </div>
    </div>
</div>
<?php echo $footer; ?>
