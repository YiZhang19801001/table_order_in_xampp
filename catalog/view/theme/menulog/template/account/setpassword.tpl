<html lang="en-us">

<head>
	<meta charset="utf-8">
	<title>Reset your Online Order Password</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="/catalog/view/theme/menulog/stylesheet/main.css">
</head>

<body>
	<div class="container">
		<header>
			<div class="logo">
				<img src="/img/logo_takeaway@2x.png" alt="Online Order" height="68">
			</div>
			<div class="mktgMessages">
				<span><img src="/img/icon_bestPrice.png" alt="Best Price guaranteed">Best price guaranteed</span>
			</div>
		</header>
		<div class="mainContent">
			<h2>RESET PASSWORD</h2>
			<form method="POST">
				<fieldset>
					<label for="password">Create a new Password
						<br> <span class="helperText">(Minimum 4 characters)</span></label>
					<input type="password" name="password" id="password">
					<br>
					<label for="confirmPassword">Re-enter password</label>
					<input type="password" name="confirmPassword" id="confirmPassword">
					<br>
					<input type="hidden" name="token" value="<?php echo $token;?>">
					<input type="submit" value="Reset Password">
				</fieldset>
			</form>
		</div>
		<!-- .mainContent -->
		<footer>
			<p><a href="http://www.menulog.com.au">Online Order Australia</a> | <a href="http://www.menulog.co.nz">Online Order New Zealand</a> <span class="copyright">Copyright © 2017 Online Order. All rights reserved.</span>
			</p>
			<p>
			</p>
		</footer>
	</div>
	<!--- .container -->
</body>

</html>
