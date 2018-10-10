<?php echo $header; ?>
<style>
    #selectCountrySection, #selectStateSection, #selectSuburbSection
    {
        display: flex;
    }
    select
    {
        width: 100%;
        border: none;
        appearance:none;
        -moz-appearance:none;
        -webkit-appearance:none;
    }
</style>
<div class="topBodyWrapWidth m-container myDetails" style="">
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
                    <ul class="dropdown-menu nav pull-right semiBoldFont">
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

        <div class="pageHeader headerWithRhsText  info-bar clearfix myDetails">
            <div id="myDetailsPageHeader" class="pageHeader">
                <div class="boldFont pageTitle">My Details</div>
                <div class="contentEnd"></div>
            </div>
        </div>
    </div>


    <div class="myDetailsForm">
        <form action="<?php echo $action;?>" method="post" class="myDetails" id="myDetailsForm">
            <div class="mm-title">
                Change password
                <?php if($error_password){?><div class="normError messageSpacing currentPassword"><?php echo $error_password;?></div><?php }?>	
                <?php if($error_newPassword2){?><div class="normError messageSpacing currentPassword"><?php echo $error_newPassword2;?></div><?php }?>
            </div>

            <div class="mm-section">
                <div class="mm-section-item">
                    <label class="inputFieldLabel regularFont" for="firstName">Current</label>
                    <span class="inputFieldSpan">
                    <input id="currentPassword" name="password" type="password" value="<?php echo $password;?>" autocomplete="off">
                </span>
                </div>
            </div>
            <div class="mm-title forgotten-password">
                <!--<a href="#" onclick="account.forgotPassword();">Forgot your password?</a>-->
            </div>
            <?php if($error_newPassword3){?><div class="normError messageSpacing newPassword"><?php echo $error_newPassword3;?></div><?php } ?>
            <?php if($error_newPassword1){?><div class="normError messageSpacing newPassword"><?php echo $error_newPassword1;?></div><?php }?>
            <div class="mm-section">
                <div class="mm-section-item">
                    <label class="inputFieldLabel regularFont" for="newPassword">New Password</label>
                    <span class="inputFieldSpan">
                    <input id="newPassword" name="newPassword" type="password" value="<?php echo $newPassword;?>"  autocomplete="off">
                </span>
                </div>
                <div class="mm-section-item">
                    <label class="inputFieldLabel regularFont" for="confirmPassword">Confirm</label>
                    <span class="inputFieldSpan">
                    <input id="confirmPassword" name="passwordCheck" type="password" value="<?php echo $passwordCheck;?>" placeholder="Enter it again"
                           value="" autocomplete="off">
                </span>
                </div>
            </div>
            <div class="mm-title">
                YOUR CONTACT INFORMATION
                <div class="normError messageSpacing emailAddress firstName lastName phoneNumber company"></div>
            </div>
            
            <?php if($error_email) {?><div class="normError messageSpacing newPassword"><?php echo $error_email;?></div><?php }?>
            <?php if($error_exists) {?><div class="normError messageSpacing newPassword"><?php echo $error_exists;?></div><?php }?>
            <div class="mm-section">
                <div class="mm-section-item">
                    <label for="firstName" class="inputFieldLabel regularFont">First name</label>
                    <span class="inputFieldSpan">
                    <input id="firstName" name="firstname" type="text" value="<?php echo $firstname;?>">
                </span>
                </div>
                <div class="mm-section-item">
                    <label for="lastName" class="inputFieldLabel regularFont">Last name</label>
                    <span class="inputFieldSpan">
                    <input type="text" id="lastName" name="lastname" value="<?php echo $lastname;?>">
                </span>
                </div>
                <div class="mm-section-item">
                    <label for="mobileNumber" class="inputFieldLabel regularFont">Mobile</label>
                    <span class="inputFieldSpan">
                    <input type="tel" id="mobileNumber" name="telephone" value="<?php echo $telephone;?>">
                </span>
                </div>
                <div class="mm-section-item">
                    <label for="emailAddress" class="inputFieldLabel regularFont">Email</label>
                    <span class="inputFieldSpan">
                    <input type="email" id="emailAddress"name="email" value="<?php echo $email;?>">
                </span>
                </div>
            </div>
            <div class="mm-title">NAME USED FOR RATINGS</div>
            <div class="mm-section">
                <div class="mm-section-item">
                    <label for="alias" class="inputFieldLabel regularFont"></label>
                    <span class="inputFieldSpan">
                    <input id="alias" name="alias" type="text" value="<?php echo $alias;?>">
                </span>
                </div>
            </div>
            <div class="mm-title">
                DELIVERY ADDRESS
            </div>
            <div class="mm-section">
                <div class="mm-section-item" id="selectCountrySection">
                    <label for="takeawayCountryId" class="inputFieldLabel regularFont inlineBlock">Country</label>
                    <!--<span id="selectedCountryName">Australia</span>-->
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
                    <!--<input type="hidden" name="takeawayCountryId" id="takeawayCountryId" value="6">-->
                    <!--<div class="openInfoArrow"></div>-->
                    <div class="contentEnd"></div>
                </div>
                <div class="mm-section-item" id="selectStateSection">
                    <label for="takeawayStateId" class="inputFieldLabel regularFont inlineBlock">State</label>
                    <!--<input type="hidden" name="takeawayStateId" id="takeawayStateId" value="0">-->
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
                    <!--<div class="selectedTextWrapper"><span id="selectedStateName"></span></div>-->
                    <!--<div class="openInfoArrow"></div>-->
                    <div class="contentEnd"></div>
                </div>
                <div class="mm-section-item" id="selectSuburbSection">
                    <label for="takeawaySuburbId" class="inputFieldLabel regularFont inlineBlock">Suburb</label>
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
                    <!--<div class="searchWrapper" style="float: left">
                        <input type="text" class="suburb" name="suburb" autocomplete="off" autocorrect="off" value="">
                        <input type="submit" value="submit" class="hiddenSubmitButton">
                    </div>-->
                    <div class="contentEnd"></div>
                </div>
                <div class="mm-section-item">
                    <label for="takeawayStreetNumber" class="inputFieldLabel regularFont">Unit/Street No.</label>
                    <span class="inputFieldSpan"><input name="address_1" type="text" value="<?php if($address_1){echo $address_1;}?>" placeholder="Unit/Street Number"></span>
                </div>
                <div class="mm-section-item">
                    <label for="takeawayAddressLine1" class="inputFieldLabel regularFont">Street</label>
                    <span class="inputFieldSpan"><input type="text" name="address_2"  value="<?php if($address_2){echo $address_2;}?>" class="jsStreetSuggest" spellcheck="false" autocomplete="off" placeholder="Street Name"></span>
                </div>
                <div class="mm-section-item">
                    <label for="takeawayNearestCrossStreet" class="inputFieldLabel regularFont" style="font-size:14px;">Nearest
                        Cross St.</label>
                    <span class="inputFieldSpan"><input type="text" name="address_3" value="<?php if($address_3){echo $address_3;}?>" class="jsStreetSuggest" spellcheck="false" autocomplete="off" placeholder="Nearest cross street"></span>
                </div>
                <div class="mm-section-item">
                    <label for="sendNewsletter" class="inputFieldLabel regularFont" style="font-size:14px;">Send Newsletter</label>
                    <span class="inputFieldSpan" style="overflow: visible;"><input name="newsletter" id="sendNewsletter" type="checkbox" <?php if($newsletter) {?>checked="checked"<?php }?>></span>
                </div>
            </div>
            <?php if($success){ ?>
            <div class="normError messageSpacing newPassword" style="color:26BF22">Your details have been updated</div>
            <?php }?>
            <div class="mm-section gray" style="padding:20px 0 0 0;">
                <div id="checkoutRemind">
                    <!--<a href="#" class="jsSubmitForm button regularFont" id="myDetailsUpdateButton">
                        Update my details
                        <div class="openInfoArrow"></div>
                    </a>-->
                    <button type="submit" class="jsSubmitForm button regularFont" id="myDetailsUpdateButton" style="border: 0px;">Update my details<div class="openInfoArrow"></div>
                    </button>
                </div>
                <div class="contentEnd"></div>
            </div>
            <div class="mm-section gray">&nbsp;</div>
        </form>
    </div>
    <div id="modalContainer" style="display:none;" class="modal"></div>
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

$('#m-top-dropdownmenu').click(function (even)
{
    $('.dropdown-menu, .dropdown-backdrop').show();
    even.preventDefault();
})
$('.dropdown-backdrop').click(function ()
{
    $('.dropdown-menu, .dropdown-backdrop').hide();
})
//--></script>
<?php echo $footer; ?>