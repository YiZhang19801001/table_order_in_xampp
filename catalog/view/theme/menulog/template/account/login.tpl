<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>
		<?php echo $title; ?>
	</title>
	<base href="<?php echo $base; ?>" />
	<?php if ($description) { ?>
	<meta name="description" content="<?php echo $description; ?>" />
	<?php } ?>
	<?php if ($keywords) { ?>
	<meta name="keywords" content="<?php echo $keywords; ?>" />
	<?php } ?>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<?php if ($icon) { ?>
	<link href="<?php echo $icon; ?>" rel="icon" />
	<?php } ?>
	<link href="/catalog/view/theme/menulog/stylesheet/office_free_lunch.v1.css" rel="stylesheet">
	<link href="/catalog/view/theme/menulog/stylesheet/frontend.css" rel="stylesheet">
	<link href="/catalog/view/theme/menulog/stylesheet/theme.css" rel="stylesheet">
	<link href="/catalog/view/theme/menulog/stylesheet/style.css" rel="stylesheet">
	<link href="/catalog/view/theme/menulog/stylesheet/new.css" rel="stylesheet">
	<script type="text/javascript" src="/catalog/view/theme/menulog/script/vue.js"></script>
	<script type="text/javascript" src="/catalog/view/theme/menulog/script/jquery.js"></script>
	<!--jq-ui-->
	<link type="text/javascript" href="/catalog/view/theme/menulog/script/jquery-ui-1.12.1/jquery-ui.min.css" />
	<script src="/catalog/view/theme/menulog/script/jquery-ui-1.12.1/jquery-ui.min.js"></script>
	<style>
	#template_myAccountNavs {
		z-index: 10000;
		position: absolute;
		top: 74px;
		left: 1273px;
		background-color: #fff;
		padding: 20px;
		border: 1px solid #797876;
		line-height: 20px;
	}
	
	#template_myAccountNavs li a {
		color: #797876
	}
	</style>
	<script>
	$(function() {
		$('#link_myAccount').click(function() {
			$('#template_myAccountNavs').slideToggle();
		})
		$('#link_login').click(function() {
			$('.linkLogin').addClass('in');
		});
		$('.linkLogin .core-closeX').click(function() {
			$('.linkLogin').removeClass('in');
			$('.forgottenPassword').hide();
		})

		$('#link_loginForgottenPassword').click(function() {
			$('.forgottenPassword').slideDown();
		})

		$("#bestPricePolicyWrapper").hover(function(){
			$(".bestPricePolicy").addClass('in');
		},function(){
			$(".bestPricePolicy").removeClass('in');
		});

		//登陆
		$('#login').click(function() {
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
							location.href = "<?php echo $home;?>";
						}
					}
				)
			}
		})
	});
	</script>

</head>

<body>
<div id="loading">
	<img src="/catalog/view/theme/menulog/image/ajax-loader.gif" width="100px" alt="loading">
</div>
<div class="core-popoverBox core-popoverNoTitle core-popoverHelper  core-popover bestPricePolicy" style="z-index: 10000; max-width: 275px; width: 275px; position: absolute; top: 74px; left: 1060px;">
	<a class="core-closeX"></a>
	<div class="core-contentBox core-contentBoxNoTitle">
    		<h2>You'll never pay more with Online Order.</h2>
    		<p>If you order with us, but find the same item advertised by the same restaurant at a better price within 24 hours, we'll credit you the difference plus an additional $10.00 for that order.</p>
	</div>
</div>
<?php if (!$logged) { ?>
<div class="core-popoverBox core-popoverNoTitle core-popoverHelper  core-popover core-popoverFocused linkLogin ui-draggable ui-draggable-handle core-popoverDraggable in" style="z-index: 10000; position: absolute; width: 234px; top: 30%; left: 42%; display: block;">
	<a class="core-closeX"></a>
	<div class="core-contentBox core-contentBoxNoTitle">
		<div class="core-ifhBlock" style="display: block;">
			<div class="core-ifhBlock">
				<fieldset>
					<div class="loginLHS">
						<input id="emailAddress" type="text" placeholder="Email address" value="">
						<input id="password" type="password" placeholder="Password" value="">
						<div class="contentEnd"></div>
						<div id="message_login" class="message" style="display: none;"><span class="error">Your login details were incorrect.  Please try again</span></div>
					</div>
					<div>
						<button type="submit" value="LOG IN" id="login">LOG IN</button>
					</div>
					<div>
						<a id="link_loginForgottenPassword" href="javascript:void(0)" class="forgottenPasswordLink">Forgot your password?</a>
					</div>
				</fieldset>
				<div class="forgottenPassword">
					<div class="loginLHS">
						<p id ="forgottenPassword">We have e-mailed you a password reset link. Please check your spam folder if you can't find it in the inbox.</p>
						<fieldset id="forgetpwd_hiden">
							<p>Submit your e-mail address below to receive a password reset link.</p>
							<input id="emailAddress_F"  type="text" placeholder="Email address" value="">
							<div class="contentEnd"></div>
							<div class="core-dialogueButtons">
								<div class="core-left">
								<button type="submit">RESET PASSWORD</button>
								</div>
								<div class="core-left">
									<div class="core-pleaseWait" style="display: none;">Please wait</div>
								</div>
							</div>
						</fieldset>
				 	</div>
				</div>
			</div>
		</div>
	</div>
</div>
<?php }?>
<div id="takeawayPage" class="pageBody">
	<div class="fullWidthWrapper1 header" id="takeawayHeader">
		<div class="fullWidthWrapper2">
			<div class="fullWidthWrapper3">
				<div class="flex-container flex-container-center headerTop" id="takeawayHeaderTop">
					<div class="flex-item logoTakeaway"><a href="<?php echo $home;?>"><span class="icon-logoWide"></span></a></div>
					<div class="flex-item">
						<div class="flex-container flex-container-center">
							<div class="flex-item">
								<div id="bestPricePolicyWrapper">
									<a href="#" id="bestPricePolicyIconLink"><img src="//www.menulog.com.au/images/icons/icon_bestPrice.png">&nbsp;Best price guaranteed&nbsp;<i class="fa fa-caret-down" aria-hidden="true"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</div>
							</div>
							<div class="flex-item">
								<style type="text/css">
								.navUser li {
									display: inline-block;
								}
								</style>
								<ul class="navUser">
									<li style="padding-right:12px">
										<a href="#">
											<span style="width: 24px; display: inline-block; vertical-align: middle;">
												<svg viewBox="0 0 100 100" style="display: inline-block;"><path id="Icon-help" fill="white" d="M56.083,75.164l0,-9.619c0,-0.468 -0.15,-0.852 -0.451,-1.153c-0.301,-0.3 -0.685,-0.451 -1.152,-0.451l-9.619,0c-0.468,0 -0.852,0.151 -1.153,0.451c-0.3,0.301 -0.451,0.685 -0.451,1.153l0,9.619c0,0.468 0.151,0.852 0.451,1.152c0.301,0.301 0.685,0.451 1.153,0.451l9.619,0c0.467,0 0.851,-0.15 1.152,-0.451c0.301,-0.3 0.451,-0.684 0.451,-1.152Zm12.826,-33.668c0,-2.939 -0.927,-5.661 -2.781,-8.166c-1.854,-2.505 -4.167,-4.442 -6.939,-5.812c-2.772,-1.369 -5.611,-2.054 -8.517,-2.054c-8.116,0 -14.312,3.557 -18.587,10.672c-0.501,0.801 -0.368,1.503 0.401,2.104l6.613,5.01c0.234,0.2 0.551,0.301 0.952,0.301c0.534,0 0.952,-0.201 1.252,-0.602c1.771,-2.271 3.207,-3.807 4.309,-4.609c1.136,-0.802 2.572,-1.202 4.309,-1.202c1.603,0 3.031,0.434 4.283,1.302c1.253,0.869 1.879,1.854 1.879,2.956c0,1.269 -0.334,2.288 -1.002,3.056c-0.668,0.769 -1.804,1.52 -3.407,2.255c-2.104,0.935 -4.033,2.38 -5.786,4.334c-1.754,1.953 -2.631,4.049 -2.631,6.287l0,1.804c0,0.467 0.151,0.851 0.451,1.152c0.301,0.301 0.685,0.451 1.153,0.451l9.619,0c0.467,0 0.851,-0.15 1.152,-0.451c0.301,-0.301 0.451,-0.685 0.451,-1.152c0,-0.635 0.359,-1.461 1.077,-2.48c0.718,-1.019 1.628,-1.846 2.731,-2.48c1.068,-0.601 1.887,-1.077 2.455,-1.428c0.567,-0.351 1.336,-0.935 2.304,-1.754c0.969,-0.818 1.712,-1.619 2.23,-2.404c0.517,-0.785 0.985,-1.796 1.402,-3.031c0.418,-1.236 0.627,-2.589 0.627,-4.059Zm19.238,9.62c0,6.98 -1.72,13.418 -5.16,19.313c-3.44,5.896 -8.108,10.563 -14.003,14.004c-5.895,3.44 -12.333,5.16 -19.314,5.16c-6.981,0 -13.418,-1.72 -19.314,-5.16c-5.895,-3.441 -10.562,-8.108 -14.003,-14.004c-3.44,-5.895 -5.16,-12.333 -5.16,-19.313c0,-6.981 1.72,-13.419 5.16,-19.314c3.441,-5.895 8.108,-10.563 14.003,-14.003c5.896,-3.44 12.333,-5.16 19.314,-5.16c6.981,0 13.419,1.72 19.314,5.16c5.895,3.44 10.563,8.108 14.003,14.003c3.44,5.895 5.16,12.333 5.16,19.314Z" style="fill-rule:nonzero;"></path></svg>
											</span> Help
										</a>
									</li>
									<li><a  id="link_login" href="javascript:void(0)" class="jsLoginPopover">Login</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- #headerTop -->
			</div>
			<!-- .fullWidthWrapper3 -->
		</div>
		<!-- .fullWidthWrapper2 -->
	</div>

<?php echo $footer;?>