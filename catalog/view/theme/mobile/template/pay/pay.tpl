<html xmlns="http://www.w3.org/1999/xhtml" id="mainform">

<head id="head">
    <title>
        Menulog Secure Payment Gateway
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
        <form method="post" action="/" id="Form1">
            <div class="container">
                <div id="CreditCardTokenization1_PayPal1_panel1">
                    <div class="container">
                        <!-- information -->
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
                                <div class="DisplayTopText DisplayTextMobileNoStack"><span id="CreditCardTokenization1_PayPal1_lblAmount"><?php echo $total[0];?></span></div>
                                <div class="contentEnd"></div>
                            </div>
                        </div>
                        <div class="Outer">
                            <div class="NoborderM">
                                <div class="DisplayTitle"><b><span id="CreditCardTokenization1_PayPal1_Charge">You Pay</span></b></div>
                                <div class="DisplayTopText DisplayTextMobileNoStack"><b><span id="CreditCardTokenization1_PayPal1_lblTotalAmount"><?php echo $total[0];?></span></b></div>
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
                        <div class="menulogText">
                            <input type="submit" name="CreditCardTokenization1$PayPal1$btnBackToOrder" value="Back To Order" id="CreditCardTokenization1_PayPal1_btnBackToOrder" class="MenuLogBackToOrderWeb">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                            <input type="submit" name="CreditCardTokenization1$PayPal1$btnSave" value="Submit Order"  id="CreditCardTokenization1_PayPal1_btnSave" class="MenuLogContinueWeb">
                        </div>
                        <div>
                            <div style="width:50%;float:left;">
                                &nbsp;
                            </div>
                            <div style="width:50%;float:right;text-align:right;">
                                <span style="font-size:10px">You will be redirected to PayPal to complete the payment </span>
                            </div>
                        </div>
                        <br>
                        <br>
                        <br>
                        <img src="https://www.paypalobjects.com/webstatic/en_AU/mktg/logo/bdg_payments_by_pp_2line_163x44.png" alt="PayPal Logo" style="display:block;margin-left:auto;margin-right:auto">
                        <div class="contentEnd"></div>
                        <p></p>
                        <div>
                            <span class="bold"></span>
                        </div>
                        <p></p>
                        <div class="smallText" visible="false">
                        </div>
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
                    Menulog Pty Ltd | ABN 76 120 943 615 | 1300 664 335
                    <br> Level 23, 227 Elizabeth Street, Sydney NSW 2000
                    <br> Copyright © 2017 Menulog. All rights reserved
                </div>
            </div>
        </div>
        <div class="FooterBorder"></div>
