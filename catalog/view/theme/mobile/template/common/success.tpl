<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="/catalog/view/theme/menulog/stylesheet/office_free_lunch.v1.css" rel="stylesheet">
    <link href="/catalog/view/theme/menulog/stylesheet/frontend.css" rel="stylesheet">
    <link href="/catalog/view/theme/menulog/stylesheet/theme.css" rel="stylesheet">
    <link href="/catalog/view/theme/menulog/stylesheet/style.css" rel="stylesheet">
    <link href="/catalog/view/theme/menulog/stylesheet/new.css" rel="stylesheet">
    <link href="/catalog/view/theme/mobile/stylesheet/m-mobile.css" rel="stylesheet"/>
    <script src="/catalog/view/theme/mobile/script/jquery.js"></script>
    <title>Your order is submitted</title>
    <style>
        .tACheckoutCompletePage
        {
            margin: 0;
            width: 100%;
        }
        .tACheckoutCompletePage .left, .tACheckoutCompletePage .right, .tACheckoutCompletePage .quicklink p, .tACheckoutCompletePage .your-order, .tACheckoutCompletePage .what-happens-next, .tACheckoutCompletePage .share-your-experience
        {
            width: 100%;
        }

        .tACheckoutCompletePage .what-happens-next .flex-container
        {
            box-sizing: border-box;
        }
        .tACheckoutCompletePage .what-happens-next .flex-container .flex-item:not(:last-of-type)
        {
            margin-bottom: 30px;
            border: none;
        }
        .tACheckoutCompletePage h2, .tACheckoutCompletePage .quicklink p, .tACheckoutCompletePage .your-order, .tACheckoutCompletePage .what-happens-next, .tACheckoutCompletePage .share-your-experience
        {
            text-align: center;
        }
        .websiteTopToolbar
        {
            position: fixed;
            top: 0;
            width: 100%;
            background: #26bf22;
        }
    </style>
</head>
<body>
<div class="websiteTopToolbar clearfix" style="z-index: 999">
    <div class="toolbarLeft toolbarLeftButtons"><a href="javascript:history.go(-1);" id="toolbarBackButtonLink">
        <div class="button-back icon-back"></div>
    </a></div>
    <div class="toolbarRight">
        <div class="dropdown burgerMenuButton"><a id="m-top-dropdownmenu" role="button" href="javascript:void(0);"
                                                  data-toggle="dropdown" data-target="#" class="dropdown-toggle">
            <div class="burgerMenu icon-hamburgerMenu"></div>
        </a>
            <div class="dropdown-backdrop" style="display: none;"></div>
            <ul class="dropdown-menu nav pull-right semiBoldFont" style="display: none;">
                <li><a href="/" style="border-top:0;">Home</a></li>
                <?php if($isLogged){ ?>
                <li><a href="<?php echo $order;?>">Re-order</a></li>
                <li><a href="<?php echo $detail;?>">My Details</a></li>
                <li><a href="<?php echo $logout;?>" >Log out</a></li>
                <?php } else { ?>
                <li><a class="accountLink" @click="login = backdrop = true">Log in</a></li>
                <?php }?>
            </ul>
        </div>
    </div>
    <div class="toolbarMiddle"><a href="/" class="toolbarHomebutton "><span class="icon-logoWide"></span></a></div>
</div>
<div class="content">
    <div class="contentBody">
        <div class="tACheckoutCompletePage">
            <div class="confirmationLeft" style="margin-top: 35px">
                <div class="flex-container topText orderSubmittedMessage module">
                    <div class="flex-item">
                        <i class="fa fa-check-circle" aria-hidden="true"></i>
                    </div>
                    <div class="flex-item">
                        <h1>All done,<?php echo $order_info['firstname']?> <?php echo $order_info['lastname'];?> !</h1>
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
                                    </div>
                                    <div class="flex-item content">
										<p><strong><?php echo $location_info['name'];?></strong>
											<br><?php echo $location_info['address'];?>
										</p>
										<p>For any changes to your order, please contact 
											<br>us directly by phone on
											<span class="number"><strong><?php echo $location_info['telephone'];?></strong></span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="module">
                    <div class="flex-container" style="display: block; text-align: center">
                        <div class="flex-item">
                            <h3>Order details</h3>
                            <table class="details">
                                <tbody>
                                <tr>
                                    <td>Order number: </td>
                                    <td class="result"><?php echo $order_id;?></td>
                                </tr>
                                <tr>
                                    <td>Order total:<?php echo $order_info['total'];?> </td>
                                </tr>
                                <tr>
                                    <td>Payment method: </td>
                                    <td class="result"><?php echo $order_info['shipping_method'];?></td>
                                </tr>
                                <tr>
                                    <td>Requested time: </td>
                                    <td class="result"><?php echo $order_info['shipping_orderTime']?> on <?php echo $order_info['shipping_orderDate'];?></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
						<?php if($order_info['shipping_method'] == 'Delivery') {?>
						<div class="flex-item">
							<h3>Delivery address</h3>
							<p>
								<?php echo $order_info['firstname']?> <?php echo $order_info['lastname'];?>
								<br><?php echo $order_info['shipping_address_1']?>, <?php echo $order_info['shipping_address_2']?>
								<br> <?php echo $order_info['telephone'];?>
							</p>
						</div>
						<?php }?>
                    </div>
                </div>
                <div class="module what-happens-next margin" style="margin-bottom: 0">
                    <div class="main">
                        <h2>What happens next?</h2>
						<div class="flex-container flex-container-center">
							<div class="flex-item">
								<span class="counter">01</span>
								<span class="text1">The restaurant receives your order.</span>
							</div>
							<div class="flex-item">
								<span class="counter">02</span>
								<?php if($order_info['shipping_method'] == 'Delivery') {?>
								<span class="text2">You receive an email with delivery time.</span>
								<?php }else{ ?>
								<span class="text2">You receive an email with pick-up time.</span>
								<?php }?>
							</div>
							<div class="flex-item">
								<span class="counter">03</span>
								<?php if($order_info['shipping_method'] == 'Delivery') {?>
								<span class="text3">Food is delivered to your door.</span>
								<?php }else{ ?>
								<span class="text2">Food is ready for pick-up.</span>
								<?php }?>
							</div>
						</div>
                        <!-- .flex-container -->
                    </div>
                </div>
                <div class="module what-happens-next margin">
					<div class="main">
						<div class="flex-container flex-container-center">
							If you didn’t receive the email confirmation, please check your junk mail box.<br/>
							The preparation time required is minimum <?php echo $times_info['pretime']['delivery'];?> minutes for delivery and <?php echo $times_info['pretime']['pickup'];?> minutes for pickup.<br/>
							* Delivery time may increase during peak hours.<br/>
						</div>
						<!-- .flex-container -->
					</div>
				</div>
            </div>
        </div>
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
</body>
</html>