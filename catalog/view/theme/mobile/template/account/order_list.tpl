<?php echo $header; ?>
<div class="topBodyWrapWidth m-container myorders" style="overflow:hidden;">
    <div id="mlTopToolbar" class="topBodyWrapWidth topToolbar clearfix" style="">
        <div class="websiteTopToolbar clearfix">
            <div class="toolbarLeft toolbarLeftButtons">
                <a href="javascript:history.go(-1);" id="toolbarBackButtonLink">
                    <div class="button-back icon-back"></div>
                </a>
            </div>
            <div class="toolbarRight">
                <div class="dropdown burgerMenuButton">
                    <a class="dropdown-toggle" id="m-top-dropdownmenu" role="button" href="" data-toggle="dropdown"
                       data-target="#">
                        <div class="burgerMenu icon-hamburgerMenu"></div>
                    </a>
                    <div class="dropdown-backdrop" style="display: none"></div>
                    <ul class="dropdown-menu nav pull-right semiBoldFont" role="menu"
                        aria-labelledby="m-top-dropdownmenu">
                        <li><a href="/" style="border-top:0;">Home</a></li>
                        <li><a href="<?php echo $order;?>">Re-order</a></li>
                        <li><a href="<?php echo $detail;?>">My Details</a></li>
                        <li><a href="<?php echo $logout;?>" >Log out</a></li>
                    </ul>
                </div>
            </div>
            <div class="toolbarMiddle">
                <a href="/" class="toolbarHomebutton "><span class="icon-logoWide"></span></a>
            </div>
        </div>
        <div class="pageHeader headerWithRhsText  info-bar clearfix myorders">
            <div id="myordersPageHeader" class="pageHeader">
                <div class="boldFont pageTitle">Re-order a previous order</div>
                <div class="contentEnd"></div>
            </div>
        </div>
    </div>
    <div id="reorderDescription">
        <div class="semiBoldFont">You can add &amp; remove items from your cart.</div>
        <div class="semiBoldFont">Please check as price/items may have changed.</div>
    </div>
    <ul class="restaurantList reorderRestaurants" data-list-name="Past Orders">
        <?php foreach($orders as $key => $order):?>
        <li>
            <div class="restaurantLogo">
                <a href="<?php echo $order['store_url'];?>" class="venueLink" >
                <img src="<?php echo $order['store_pic'];?>" class="logoImg lazyloading" alt="logo"></a>
            </div>
            <div class="restaurantInfoArea">
                <span class="restaurantName semiBoldFont">
                    <a href="<?php echo $order['store_url'];?>" class="venueLink"><?php echo $order['store_name'];?></a>
                </span>
                <div class="orderItems regularFont">
                    <span class="orderItem textNoWrap">
                    <?php 
                        foreach($order['products'] as $product) {
                            
                            if($product['option_name']) {

                                echo $product['quantity']." x ".$product['name']."(".$product['option_name'].") , ";
                            } else {
                                echo $product['quantity']." x ".$product['name']." , ";
                            }
                        }
                    ?>
                    </span>
                </div>
                <div class="orderDataLine semiBoldFont">
                    <span class="orderPrice">Total: <?php echo $order['total'];?></span> <span class="orderDate">on <?php echo $order['date_added'];?></span>
                </div>
                <!--<div class="orderReview addYourReview">
                    <a href="#">Add a review</a>
                </div>-->
            </div>
            <div class="contentEnd"></div>
            <a href="<?php echo $order['reorder'];?>" class="boldFont button reorderActionButton venueLink">Order Again<span class="icon-forward"></span></a>
            <div class="contentEnd"></div>
        </li>
        <?php endforeach;?>
    </ul>
    <?php echo $pagination; ?>
    <div style="margin:15px 15px; display:none;">
        <a href="javascript:history.go(-1);" class="fullWidthButton" style="font-size:inherit;">Go Back</a>
    </div>
    <div id="modalContainer" style="display:none;" class="modal"></div>
</div>
<script>
    $('#m-top-dropdownmenu').click(function (even)
    {
        $('.dropdown-menu, .dropdown-backdrop').show();
        even.preventDefault();
    })
    $('.dropdown-backdrop').click(function ()
    {
        $('.dropdown-menu, .dropdown-backdrop').hide();
    })
</script>
<?php echo $footer; ?>