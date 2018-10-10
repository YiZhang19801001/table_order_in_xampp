<?php echo $header;?>
<div class="fullWidthWrapper1">
	<div class="fullWidthWrapper2">
		<div class="fullWidthWrapper3">
			<div class="takeawayNavWrapper1">
				<div class="takeawayNavWrapper2">
					<div class="takeawayNavWrapper3">
						<div class="breadCrumbs">
						<?php foreach ($breadcrumbs as $breadcrumb) { ?>
						<a href="<?php echo $breadcrumb['href'];?>"><?php echo $breadcrumb['text'];?></a><span class="icon-forward">
						<?php }?>
					   </span>My Details</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="content">
	<div class="minor contentBody">
		<div id="core-ajaxForm" class="core-ifhBlock">
			<form action="<?php echo $action;?>" method="post" class="myDetails core-ajaxForm">
				<fieldset>
					<h1>My Details</h1>
					<div class="column">
						<div class="section">
							<h2>Login details</h2>
							<div class="formField">
								<?php if($error_password){?><div id="message_password" class="message"><span class="error"><?php echo $error_password;?></span></div><?php }?>								
								<?php if($error_newPassword2){?><div id="message_newPassword2" class="message"><span class="error"><?php echo $error_newPassword2;?></span></div><?php }?>
								<!-- <div id="message_currentPassword" class="message"><span class="error">Please enter your current password</span></div> -->
								<label for="currentPassword" class="fieldTitle">Current password</label>
								<input id="currentPassword" name="password" type="password" value="<?php echo $password;?>" autocomplete="off">
								<p class="passwordInfo smallSpaceAbove"><a href="#" id="forgotPassword">Forgot your password?</a></p>
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<?php if($error_newPassword3){?><div id="message_password" class="message" ><span class="error"><?php echo $error_newPassword3;?></span></div><?php } ?>
								<?php if($error_newPassword1){?><div id="message_newPassword1" class="message" ><span class="error"><?php echo $error_newPassword1;?></span></div><?php }?>
								<label for="password" class="fieldTitle">New password</label>
								<input id="password" name="newPassword" type="password" value="<?php echo $newPassword;?>" autocomplete="off">
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_passwordCheck"></div>
								<label for="passwordCheck" class="fieldTitle">Confirm new password</label>
								<input id="passwordCheck" name="passwordCheck" type="password" value="<?php echo $passwordCheck;?>" autocomplete="off">
								<div class="contentEnd"></div>
							</div>
							<p class="smallText passwordInfo">(Only enter a new password if you wish to change your current one)</p>
							<div class="section">
							</div>
							<h2>Contact Details</h2>
							<div class="formField">
								<div id="message_firstName"></div>
								<label for="firstName" class="fieldTitle">First name</label>
								<input id="firstName" name="firstname" type="text" value="<?php echo $firstname;?>">
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_lastName"></div>
								<label for="lastname" class="fieldTitle">Last name</label>
								<input id="lastname" name="lastname" type="text" value="<?php echo $lastname;?>">
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_alias"></div>
								<label for="alias" class="fieldTitle">Name for ratings</label>
								<input id="alias" name="alias" type="text" value="<?php echo $alias;?>">
								<div class="contentEnd"></div>
							</div>
							<div class="formField">

								<?php if($error_email) {?><div id="message_emailAddress" class="message"><span class="error"><?php echo $error_email;?></span></div><?php }?>
								<?php if($error_exists) {?><div id="message_emailWarning" class="message"><span class="error"><?php echo $error_exists;?></span></div><?php }?>
								<label for="email" class="fieldTitle">Email address<span class="required">*</span></label>
								<input id="email" name="email" type="text" value="<?php echo $email;?>">
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_phoneNumber"></div>
								<label for="telephone" class="fieldTitle">Phone number</label>
								<input id="telephone" name="telephone" type="text" value="<?php echo $telephone;?>">
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_mobileNumber"></div>
								<label for="fax" class="fieldTitle">Mobile number</label>
								<input id="fax" name="fax" type="text" value="<?php echo $fax;?>">
								<div class="contentEnd"></div>
							</div>
						</div>
					</div>
					<div class="column">
						<div class="section">
							<h2>Upload a photo</h2>
							<div class="formField">
								<div id="message_userPhoto" class="message"><span class="error"></span></div>
								<label for="userPhoto" class="fieldTitle">Photo</label>
								<div id="userPhoto" style="padding: 2px;color: #797876;background: #fff;border: 1px solid #ccc;line-height: 24px;    display: inline-block;    cursor: pointer;">Choose File</div>
								<div style="display: inline-block;" id="photoName"><?php echo $file_name;?></div>
								<input id="upload_id" value="<?php echo $upload_id;?>" type="hidden" name="upload_id">
								<div class="contentEnd"></div>
							</div>
							<div class="section">
							</div>
							<h2>Delivery address</h2>
							<div class="formField">
								<div id="message_takeawayCountryId"></div>
								<label for="takeawayCountryId" class="fieldTitle">Country</label>
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
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_takeawayStateId"></div>
								<label for="takeawayStateId" class="fieldTitle">State</label>
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
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_takeawaySuburbId"></div>
								<label for="takeawaySuburbId" class="fieldTitle">Suburb</label>
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
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_streetNumber"></div>
								<label for="takeawayStreetNumber" class="fieldTitle">Address</label>
								<div class="core-inFieldLabel" style="float: left;">
									<input id="takeawayStreetNumber" name="address_1" type="text" value="<?php if($address_1){echo $address_1;}?>" placeholder="Unit/Street Number">
								</div>
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_takeawayAddressLine1"></div>
								<label for="takeawayAddressLine1" class="fieldTitle">&nbsp;</label>
								<div class="core-inFieldLabel" style="float: left;">
									<input id="takeawayAddressLine1" name="address_2" type="text" value="<?php if($address_2){echo $address_2;}?>" class="jsStreetSuggest" spellcheck="false" autocomplete="off" placeholder="Street Name">
								</div>
								<div class="contentEnd"></div>
							</div>
							<div class="formField">
								<div id="message_takeawayNearestCrossStreet"></div>
								<label for="takeawayNearestCrossStreet" class="fieldTitle">Nearest cross street</label>
								<input id="takeawayNearestCrossStreet" name="address_3" type="text" value="<?php if($address_3){echo $address_3;}?>" class="jsStreetSuggest" spellcheck="false" autocomplete="off" placeholder="Nearest cross street">
								<div class="contentEnd"></div>
							</div>
							<div class="formField" style="margin-left: 150px">
								<input id="sendNewsletter" class="smallSpaceAbove" name="newsletter" type="checkbox" value="1" <?php if($newsletter) {?>checked="checked"<?php }?>>
								<label for="sendNewsletter" class="checkbox fieldTitle">Send Newsletters</label>
								<div class="contentEnd"></div>
							</div>
							<?php if($success){ ?>
							<div id="message_successMessage" class="core-message successMessageBox message"><span class="success">Your details have been updated</span></div>
							<?php }?>
							<div class="contentEnd"></div>
							<div class="core-dialogueButtons">
								<div class="core-right">
									<input type="submit" class="button updateButton" value="UPDATE">
								</div>
							</div>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
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

<script>
$('div[id^=\'userPhoto\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				success: function(json) {

					if (json['error']) {
						$('#message_userPhoto>span').html(json['error']);
					} else {
						$('#upload_id').val(json['upload_id']);
						$('#message_userPhoto>span').html("");
						$('#photoName').html(json['name']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
</script>
<?php echo $footer;?>
