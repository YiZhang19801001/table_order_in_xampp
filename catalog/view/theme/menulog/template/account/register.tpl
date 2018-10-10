<?php echo $header;?>
<div class="fullWidthWrapper1">
	<div class="fullWidthWrapper2">
		<div class="fullWidthWrapper3">
			<div class="takeawayNavWrapper1">
				<div class="takeawayNavWrapper2">
					<div class="takeawayNavWrapper3">
						<div class="breadCrumbs">						
						<?php foreach ($breadcrumbs as $breadcrumb) { ?>
						<a href="<?php echo $breadcrumb['href'];?>"><?php echo $breadcrumb['text'];?></a><span class="icon-forward"></span>
						<?php }?>Sign Up</div>
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
				<!--<div class="left">-->
					<!--<div class="title">-->
						<!--<h1>Sign up, See &amp; Eat</h1>-->
						<!--<h2>We're all about takeaway, and we know you are too</h2>-->
					<!--</div>-->
					<!--<div class="graph"><img src="/catalog/view/theme/menulog/image/devices_backdrop.v2.png"></div>-->
				<!--</div>-->
				<div class="right">
					<div id="core-ajaxForm" class="core-ifhBlock">
						<form action="<?php echo $action;?>" method="post" class="signUp core-ajaxForm">
							<input type="submit" value="" class="core-hiddenSubmit">
							<fieldset>
								<?php if($error_email){?>
								<div id="message_newEmailAddress" class="message"><span class="error"><?php echo $error_email;?></span></div>
								<?php }?>
								<?php if($error_warning){?>
								<div id="message_newEmailAddress" class="message"><span class="error"><?php echo $error_warning;?></span></div>
								<?php }?>
								<input id="newEmailAddress" name="email" type="text" value="<?php echo $email?>" placeholder="Email address">
								<select id="takeawayCountryId" name="country_id">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($countries as $country) { ?>
									<?php if ($country['country_id'] == $country_id) { ?>
									<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
								<?php if($error_state){?>
								<div id="message_takeawayStateId" class="message"><span class="error"><?php echo $error_state;?></span></div>
								<?php }?>
								<select id="takeawayStateId" name="state_id" <?php if(!$country_id){?>disabled="disabled"<?php }?>>
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($states as $state) { ?>
									<?php if ($state['state_id'] == $state_id) { ?>
									<option value="<?php echo $state['state_id']; ?>" selected="selected"><?php echo $state['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $country['state_id']; ?>"><?php echo $state['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
								<?php if($error_suburb){?>
								<div id="message_takeawaySuburbId" class="message"><span class="error"><?php echo $error_suburb;?></span></div>
								<?php }?>
								<select id="takeawaySuburbId" name="suburb_id" <?php if(!$state_id){?>disabled="disabled"<?php }?>>
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($suburbs as $suburb) { ?>
									<?php if ($suburb['suburb_id'] == $suburb_id) { ?>
									<option value="<?php echo $suburb['suburb_id']; ?>" selected="selected"><?php echo $suburb['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $suburb['suburb_id']; ?>"><?php echo $suburb['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
								<?php if($error_password){?>
								<div id="message_password" class="message"><span class="error"><?php echo $error_password;?></span></div>
								<?php }?>
								<input id="password" name="password" type="password" value="<?php echo $password;?>" placeholder="Password">
								<?php if($error_confirm){?>
								<div id="message_confirm" class="message"><span class="error"><?php echo $error_confirm;?></span></div>
								<?php }?>
								<input id="passwordConfirm" name="confirm" type="password" value="<?php echo $confirm?>" placeholder="Confirm password">
							</fieldset>
							<fieldset>
								<input type="submit" id="signUpSubmit" class="btnGrey" value="SIGN UP">
								<div class="core-right">
									<div class="core-pleaseWait" style="display: none;">Please wait</div>
								</div>
								<!--<div class="text">When you sign up for a Online Order account you will automaticallly be added to receive our newsletters.</div>-->
							</fieldset>
						</form>
					</div>
				</div>
				<div class="contentEnd"></div>
			</div>
			<div class="contentEnd"></div>
			<!--<div class="iconstitle">-->
				<!--<h2>Sign up for a Online Order account and receive:</h2>-->
			<!--</div>-->
			<!--<ul class="columnize columns-5 icons">-->
				<!--<li class="newsletters">-->
					<!--<img src="/catalog/view/theme/menulog/image/jumbo_icon_newsletters@2x.png">-->
					<!--<h3>Newsletters</h3>-->
					<!--<span class="text">Receive newsletters<br>from Online Order</span>-->
				<!--</li>-->
				<!--<li class="exclusive">-->
					<!--<img src="/catalog/view/theme/menulog/image/jumbo_icon_exclusives@2x.png">-->
					<!--<h3>Exclusives</h3>-->
					<!--<span class="text">Secret specials &amp;<br>exclusive discounts</span>-->
				<!--</li>-->
				<!--<li>-->
					<!--<img src="/catalog/view/theme/menulog/image/jumbo_icon_trends@2x.png">-->
					<!--<h3>Trends</h3>-->
					<!--<span class="text">Keep up with the<br>latest food trends</span>-->
				<!--</li>-->
				<!--<li class="insider">-->
					<!--<img src="/catalog/view/theme/menulog/image/jumbo_icon_insider_tips@2x.png">-->
					<!--<h3>Insider Tips</h3>-->
					<!--<span class="text">Find the hottest new<br>places in your area</span>-->
				<!--</li>-->
				<!--<li class="events">-->
					<!--<img src="/catalog/view/theme/menulog/image/jumbo_icon_events@2x.png">-->
					<!--<h3>Events</h3>-->
					<!--<span class="text">Be informed of<br>upcoming events</span>-->
				<!--</li>-->
			<!--</ul>-->
			<!--<div class="as_seen_in">-->
				<!--<div class="title">-->
					<!--<h5>AS SEEN IN...</h5>-->
				<!--</div>-->
				<!--<div class="media">-->
					<!--<img src="/catalog/view/theme/menulog/image/websites@2x.png" width="980px">-->
				<!--</div>-->
			<!--</div>-->
		</div>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=account/account/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#takeawaySuburbId').prop('disabled',true);
			$('#takeawaySuburbId').html('<option value=""><?php echo $text_select; ?></option>');
			$('#loading').show();   
		},
		complete: function() {
			$('#loading').hide();   
		},
		success: function(json) {

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['state'] && json['state'] != '') {
				for (i = 0; i < json['state'].length; i++) {
					html += '<option value="' + json['state'][i]['state_id'] + '"';

					if (json['state'][i]['state_id'] == '<?php echo $state_id; ?>') {
						html += ' selected="selected"';
					}

					html += '>' + json['state'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			$('select[name=\'state_id\']').prop('disabled',false);
			$('select[name=\'state_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});
//--></script>

<script type="text/javascript"><!--
$('select[name=\'state_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=account/account/state&state_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#loading').show();
		},
		complete: function() {
			$('#loading').hide();
		},
		success: function(json) {

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['suburb'] && json['suburb'] != '') {
				for (i = 0; i < json['suburb'].length; i++) {
					html += '<option value="' + json['suburb'][i]['suburb_id'] + '"';

					if (json['suburb'][i]['suburb_id'] == '<?php echo $suburb_id; ?>') {
						html += ' selected="selected"';
					}

					html += '>' + json['suburb'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			$('select[name=\'suburb_id\']').prop('disabled',false);
			$('select[name=\'suburb_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});
//--></script>
<?php echo $footer;?>
