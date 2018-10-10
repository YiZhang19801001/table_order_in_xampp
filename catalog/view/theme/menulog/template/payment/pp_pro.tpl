<html xmlns="http://www.w3.org/1999/xhtml" id="mainform">

<head id="head">
    <title>
        Online Order Secure Payment Gateway
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link type="text/css" href="/catalog/view/theme/menulog/stylesheet/WebStyleSheet.css" rel="StyleSheet">
    <meta name="viewport" content="width=1024">
</head>

<body onunload="">
    <div id="pnlWrapperNoApp" class="headerWrapper">
        <div class="content">
            <div class="menulogIcon">
                <span>C</span>
            </div>
            <div class="bestPriceGuaranteed">
                <span></span>
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
                                    <div class="DisplayTopText DisplayTextMobileNoStack"><span id="CreditCardTokenization1_PayPal1_lblReferenceCode">Z7JCMTX</span></div>
                                    <div class="contentEnd"></div>
                                </div>
                            </div>
                            <div class="Outer">
                                <div class="borderM">
                                    <div class="DisplayTitle"><span id="CreditCardTokenization1_PayPal1_Amount">Your Order</span></div>
                                    <div class="DisplayTopText DisplayTextMobileNoStack"><span id="CreditCardTokenization1_PayPal1_lblAmount"></span></div>
                                    <div class="contentEnd"></div>
                                </div>
                            </div>
                            <div class="Outer">
                                <div class="NoborderM">
                                    <div class="DisplayTitle"><b><span id="CreditCardTokenization1_PayPal1_Charge">You Pay</span></b></div>
                                    <div class="DisplayTopText DisplayTextMobileNoStack"><b><span id="CreditCardTokenization1_PayPal1_lblTotalAmount"></span></b></div>
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
<div class="sectionTitle">
        Payment Details
    </div>
    <p></p>
   <div class="contentEnd"></div>
   <form method="post" id="form1" enctype="multipart/form-data">

<div class="aspNetHidden">
</div>
        <div class="container">

            <div class="contentEnd"></div>
            <div class="menulogErrorText">
                <span id="lblErrCreditCardType" style="display: none;"></span>
            </div>
            <div class="contentEnd"></div>



            <!--credit card information -->
            <div class="OuterIF">
                <div class="borderM">
                    <div class="DisplayTitleIF">
                        <span id="CardType">Card Type</span>
                    </div>

                    <div class="DisplayTextIF">
                               <select name="cc_type" id="input-cc-type" class="form-control">
		          <?php foreach ($cards as $card) { ?>
		          <option value="<?php echo $card['value']; ?>"><?php echo $card['text']; ?></option>
		          <?php } ?>
		        </select>
                        
                    </div>

                    <div class="contentEnd"></div>

                    <div class="contentEnd"></div>

                    <div class="contentEnd"></div>

                    <div class="contentEnd"></div>
                </div>
            </div>



            <p></p>
            <div class="OuterIF">
                <div class="borderM">
                    <div class="contentEnd"></div>
                    <div class="DisplayTitleIF">
                        <span id="LblCardholderName">Name on Card</span>
                    </div>
                    <div class="DisplayTextIF">
                        <input name="CardHolderName" type="text" id="CardHolderName" class="inputTextStandard">
                    </div>
                    <div class="contentEnd"></div>
                </div>
            </div>


            <p></p>
            <div class="OuterIF">
                <div class="borderM">
                    <div class="menulogErrorText">
                        <span id="lblErrorCreditCardNumber" style="display: none;"></span>
                    </div>
                    <div class="contentEnd"></div>
                    <div class="DisplayTitleIF">
                        <span id="LblCardNumber">Card Number</span>
                    </div>
                    <div class="DisplayTextIF">
                        <!-- mandatory field for PaymentExpress TxFusion -->
                        <input name="CardNumber" type="text" maxlength="20" id="CardNumber" class="inputTextStandard" autocomplete="off">
                    </div>
                    <div class="contentEnd"></div>
                </div>
            </div>
            <p></p>

            <div class="OuterIF">
                <div class="borderM">
                    <div class="menulogErrorText">
                    </div>
                    <div class="contentEnd"></div>
                    <div class="DisplayTitleIF">
                        <span id="ExpiryDate">Expiry date (MM/YYYY)</span>
                    </div>
                    <div class="DisplayTextIF">
                        <div class="refineSearch">
                            <div class="SmallOut">
		<select name="cc_start_date_month" id="input-cc-start-date" class="form-control">
		          <?php foreach ($months as $month) { ?>
		          <option value="<?php echo $month['value']; ?>"><?php echo $month['text']; ?></option>
		          <?php } ?>
		        </select>
                                /
                                        <select name="cc_start_date_year" class="form-control">
          <?php foreach ($year_valid as $year) { ?>
          <option value="<?php echo $year['value']; ?>"><?php echo $year['text']; ?></option>
          <?php } ?>
        </select>
                            </div>
                        </div>
                    </div>
                    <div class="contentEnd"></div>
                </div>
            </div>
            <div class="OuterIF">
                <div class="borderM">
                    <div class="menulogErrorText">
                        <span id="lblErrorCIC" style="display: none;"></span>
                    </div>
                    <div class="contentEnd"></div>
                    <div class="DisplayTitleIF">
                        <span id="CardSecurityCode">CCV Code</span>
                    </div>
                    <div class="DisplayTextIF">
                        <input name="Cvc2" type="text" maxlength="5" id="Cvc2" class="inputTextStandard" onkeypress="return numbersonly(this,event);">
                    </div>
                    <div class="contentEnd"></div>
                </div>
            </div>
            <p></p>
            <div class="OuterIF">
                <div class="NoborderM">
                    <div class="DisplayBlankTitle">&nbsp; </div>
                    <div class="DisplayTextIF" id="divCheckBox">
                        <span class="checkboxstyle"><input id="chkSaveCCData" type="checkbox" name="chkSaveCCData" checked="checked"><label for="chkSaveCCData">Remember my card details.</label></span>
                    </div>
                </div>
                <div id="divTokenText" class="DisplayTitleFullWidth DisplayInfoText" style="margin-top: 10px; margin-bottom: 10px">
                    Online Order never saves any credit card details on its servers. Only a reference to the data securely managed by a PCI Compliant payment provider is recorded.
                </div>
            </div>
            <p></p>
            <input type="hidden" name="SelectedCardType" id="SelectedCardType" value="Visa">
            <input type="hidden" name="ExpiryMonth" id="ExpiryMonth">
            <input type="hidden" name="ExpiryYear" id="ExpiryYear">
            <input type="hidden" name="SessionId" id="SessionId">
            <input type="hidden" name="Amount" id="Amount" value="20.50">
            <input type="hidden" name="Action" value="Add">
            <input type="hidden" name="Object" value="DpsPxPay">
            <input type="hidden" name="stripeKeyAU" id="stripeKeyAU" value="pk_live_2TuimToC5RyENyE1n85rGDN4">
            <input type="hidden" name="stripeKeyNZ" id="stripeKeyNZ" value="pk_live_n2CMm9u2iv2UcNZvGeXCu4LH">            
            <input type="hidden" name="CurrentProvider" id="CurrentProvider" value="stripe">
            <input type="hidden" name="PXFusionAuthUrl" id="PXFusionAuthUrl" value="https://sec.paymentexpress.com/pxmi3/pxfusionauth">
            
                <br>
                <br>
                <br>
                <br>
                <div class="menulogText">
                    <div class="DisplayTitleIF">
                        <input type="button" id="btnBackToOrder" class="MenuLogBackToOrderWeb" value="Back To Order" onclick="parentRedirection();">
                    </div>
                    <div class="DisplayTopText">
                        <input name="btnSave" type="button" id="btnSave" class="MenuLogContinueWeb" value="Pay Now" onclick="fnSubmitPayment()">&nbsp;
                    </div>
                    <!-- Raju 13-03-2013 MLCCH-15
        <div class="DisplayTextIF DisplayTextIFMobilePadded"><img src="/Images/dps-logo.gif" alt="DPS Payment Express"
        width="245" height="24" /></div>
        -->

                </div>
            
            


        </div>
    </form>
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
        <div class="FooterLogo">
            <div>
                <div class="smallTextMenulogInfo">
                    Online Order Pty Ltd | ABN 76 120 943 615 | 1300 664 335
                    <br> Level 23, 227 Elizabeth Street, Sydney NSW 2000
                    <br> Copyright © 2017 Online Order. All rights reserved
                </div>
            </div>
        </div>
        <div class="FooterBorder"></div>
    </div>
</body>

</html>
