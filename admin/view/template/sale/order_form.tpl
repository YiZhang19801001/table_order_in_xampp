<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right"><a href="<?php echo $cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a></div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
			</div>
			<div class="panel-body">
				<form class="form-horizontal">
					<ul id="order" class="nav nav-tabs nav-justified">
						<li class="disabled active"><a href="#tab-customer" data-toggle="tab">1. <?php echo $tab_customer; ?></a></li>
						<li class="disabled"><a href="#tab-cart" data-toggle="tab">2. <?php echo $tab_product; ?></a></li>
						<li class="disabled"><a href="#tab-payment" data-toggle="tab">3. <?php echo $tab_payment; ?></a></li>
						<li class="disabled"><a href="#tab-shipping" data-toggle="tab">4. <?php echo $tab_shipping; ?></a></li>
						<li class="disabled"><a href="#tab-total" data-toggle="tab">5. <?php echo $tab_total; ?></a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-customer">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-store"><?php echo $entry_store; ?></label>
								<div class="col-sm-10">
									<select name="store_id" id="input-store" class="form-control">
										<option value="0"><?php echo $text_default; ?></option>
										<?php foreach ($locations as $location) { ?>
										<?php if ($location['location_id'] == $store_id) { ?>
										<option value="<?php echo $location['location_id']; ?>" selected="selected"><?php echo $location['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $location['location_id']; ?>"><?php echo $location['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-currency"><?php echo $entry_currency; ?></label>
								<div class="col-sm-10">
									<select name="currency" id="input-currency" class="form-control">
										<?php foreach ($currencies as $currency) { ?>
										<?php if ($currency['code'] == $currency_code) { ?>
										<option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-customer"><?php echo $entry_customer; ?></label>
								<div class="col-sm-10">
									<input type="text" name="customer" value="<?php echo $customer; ?>" placeholder="<?php echo $entry_customer; ?>" id="input-customer" class="form-control" />
									<input type="hidden" name="customer_id" value="<?php echo $customer_id; ?>" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-customer-group"><?php echo $entry_customer_group; ?></label>
								<div class="col-sm-10">
									<select name="customer_group_id" id="input-customer-group" class="form-control">
										<?php foreach ($customer_groups as $customer_group) { ?>
										<?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
										<option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-firstname"><?php echo $entry_firstname; ?></label>
								<div class="col-sm-10">
									<input type="text" name="firstname" value="<?php echo $firstname; ?>" id="input-firstname" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-lastname"><?php echo $entry_lastname; ?></label>
								<div class="col-sm-10">
									<input type="text" name="lastname" value="<?php echo $lastname; ?>" id="input-lastname" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
								<div class="col-sm-10">
									<input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
								<div class="col-sm-10">
									<input type="text" name="telephone" value="<?php echo $telephone; ?>" id="input-telephone" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-fax"><?php echo $entry_fax; ?></label>
								<div class="col-sm-10">
									<input type="text" name="fax" value="<?php echo $fax; ?>" id="input-fax" class="form-control" />
								</div>
							</div>
							<?php foreach ($custom_fields as $custom_field) { ?>
							<?php if ($custom_field['location'] == 'account') { ?>
							<?php if ($custom_field['type'] == 'select') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
										<option value=""><?php echo $text_select; ?></option>
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
										<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'radio') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>">
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<div class="radio">
											<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
											<label>
												<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } else { ?>
											<label>
												<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } ?>
										</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'checkbox') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>">
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<div class="checkbox">
											<?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $account_custom_field[$custom_field['custom_field_id']])) { ?>
											<label>
												<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } else { ?>
											<label>
												<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } ?>
										</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'text') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'textarea') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'file') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
									<input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : ''); ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'date') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group date">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'time') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group time">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'datetime') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group datetime">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php } ?>
							<?php } ?>
							<div class="text-right">
								<button type="button" id="button-customer" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-arrow-right"></i> <?php echo $button_continue; ?></button>
							</div>
						</div>
						<div class="tab-pane" id="tab-cart">
							<div class="table-responsive">
								<table class="table table-bordered">
									<thead>
										<tr>
											<td class="text-left"><?php echo $column_product; ?></td>
											<td class="text-left"><?php echo $column_model; ?></td>
											<td class="text-right"><?php echo $column_quantity; ?></td>
											<td class="text-right"><?php echo $column_price; ?></td>
											<td class="text-right"><?php echo $column_total; ?></td>
										</tr>
									</thead>
									<tbody id="cart">
										<?php if ($order_products || $order_vouchers) { ?>
										<?php $product_row = 0; ?>
										<?php foreach ($order_products as $order_product) { ?>
										<tr>
											<td class="text-left"><?php echo $order_product['name']; ?><br />
												<input type="hidden" name="product[<?php echo $product_row; ?>][product_id]" value="<?php echo $order_product['product_id']; ?>" />
												<?php foreach ($order_product['option'] as $option) { ?>
												- <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
												<?php if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'image') { ?>
												<input type="hidden" name="product[<?php echo $product_row; ?>][option][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['product_option_value_id']; ?>" />
												<?php } ?>
												<?php if ($option['type'] == 'checkbox') { ?>
												<input type="hidden" name="product[<?php echo $product_row; ?>][option][<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option['product_option_value_id']; ?>" />
												<?php } ?>
												<?php if ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') { ?>
												<input type="hidden" name="product[<?php echo $product_row; ?>][option][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" />
												<?php } ?>
												<?php } ?></td>
											<td class="text-left">
												<?php foreach($order_product['exts'] as $ext) {?>
													<?php echo $ext['type']?> : <small> <?php echo $ext['name']; ?> : <?php echo $ext['price']; ?></small><br/>
													<input type="hidden" name="product[<?php echo $product_row; ?>][ext][<?php echo $ext['product_ext_id']; ?>]" value="<?php echo $ext['product_ext_id']; ?>">
												<?php }?>
											</td>
											<td class="text-right"><?php echo $order_product['quantity']; ?>
												<input type="hidden" name="product[<?php echo $product_row; ?>][quantity]" value="<?php echo $order_product['quantity']; ?>" /></td>
											<td class="text-right"><?php echo $order_product['price'];?></td>
											<td class="text-right"><?php echo $order_product['total'];?></td>
										</tr>
										<?php $product_row++; ?>
										<?php } ?>
										<?php } else { ?>
										<tr>
											<td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
										</tr>
									</tbody>
									<?php } ?>
								</table>
							</div>
							<ul class="nav nav-tabs nav-justified">
								<li class="active"><a href="#tab-product" data-toggle="tab"><?php echo $tab_product; ?></a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="tab-product">
									<fieldset>
										<legend><?php echo $text_product; ?></legend>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-product"><?php echo $entry_product; ?></label>
											<div class="col-sm-10">
												<input type="text" name="product" value="" id="input-product" class="form-control" />
												<input type="hidden" name="product_id" value="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
											<div class="col-sm-10">
												<input type="text" name="quantity" value="1" id="input-quantity" class="form-control" />
											</div>
										</div>
										<div id="option"></div>
									</fieldset>
									<div class="text-right">
										<button type="button" id="button-product-add" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_product_add; ?></button>
									</div>
								</div>
							</div>
							<br />
							<div class="row">
								<div class="col-sm-6 text-left">
									<button type="button" onclick="$('a[href=\'#tab-customer\']').tab('show');" class="btn btn-default"><i class="fa fa-arrow-left"></i> <?php echo $button_back; ?></button>
								</div>
								<div class="col-sm-6 text-right">
									<button type="button" id="button-cart" class="btn btn-primary"><i class="fa fa-arrow-right"></i> <?php echo $button_continue; ?></button>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-payment">
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-payment-firstname"><?php echo $entry_firstname; ?></label>
								<div class="col-sm-10">
									<input type="text" name="firstname" value="<?php echo $payment_firstname; ?>" id="input-payment-firstname" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-payment-lastname"><?php echo $entry_lastname; ?></label>
								<div class="col-sm-10">
									<input type="text" name="lastname" value="<?php echo $payment_lastname; ?>" id="input-payment-lastname" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-payment-address-1"><?php echo $entry_address_1; ?></label>
								<div class="col-sm-10">
									<input type="text" name="address_1" value="<?php echo $payment_address_1; ?>" id="input-payment-address-1" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-payment-address-2"><?php echo $entry_address_2; ?></label>
								<div class="col-sm-10">
									<input type="text" name="address_2" value="<?php echo $payment_address_2; ?>" id="input-payment-address-2" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-payment-country"><?php echo $entry_country; ?></label>
								<div class="col-sm-10">
									<select name="country_id" id="input-payment-country" class="form-control">
										<option value=""><?php echo $text_select; ?></option>
										<?php foreach ($countries as $country) { ?>
										<?php if ($country['country_id'] == $payment_country_id) { ?>
										<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-payment-state"><?php echo $entry_state; ?></label>
								<div class="col-sm-10">
								<select id="input-payment-state" name="state_id" class="form-control">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($states as $state) { ?>
									<?php if ($state['state_id'] == $payment_state_id) { ?>
									<option value="<?php echo $state['state_id']; ?>" selected="selected"><?php echo $state['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $country['state_id']; ?>"><?php echo $state['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-payment-suburb"><?php echo $entry_suburb; ?></label>
								<div class="col-sm-10">
								<select name="suburb_id" id="input-payment-suburb" class="form-control">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($suburbs as $suburb) { ?>
									<?php if ($suburb['suburb_id'] == $payment_suburb_id) { ?>
									<option value="<?php echo $suburb['suburb_id']; ?>" selected="selected"><?php echo $suburb['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $suburb['suburb_id']; ?>"><?php echo $suburb['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
								</div>
							</div>
							<?php foreach ($custom_fields as $custom_field) { ?>
							<?php if ($custom_field['location'] == 'address') { ?>
							<?php if ($custom_field['type'] == 'select') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
										<option value=""><?php echo $text_select; ?></option>
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<?php if (isset($payment_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $payment_custom_field[$custom_field['custom_field_id']]) { ?>
										<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'radio') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<div class="radio">
											<?php if (isset($payment_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $payment_custom_field[$custom_field['custom_field_id']]) { ?>
											<label>
												<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } else { ?>
											<label>
												<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } ?>
										</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'checkbox') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<div class="checkbox">
											<?php if (isset($payment_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $payment_custom_field[$custom_field['custom_field_id']])) { ?>
											<label>
												<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } else { ?>
											<label>
												<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } ?>
										</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'text') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($payment_custom_field[$custom_field['custom_field_id']]) ? $payment_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'textarea') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($payment_custom_field[$custom_field['custom_field_id']]) ? $payment_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'file') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
									<input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($payment_custom_field[$custom_field['custom_field_id']]) ? $payment_custom_field[$custom_field['custom_field_id']] : ''); ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'date') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group date">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($payment_custom_field[$custom_field['custom_field_id']]) ? $payment_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'time') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group time">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($payment_custom_field[$custom_field['custom_field_id']]) ? $payment_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'datetime') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group datetime">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($payment_custom_field[$custom_field['custom_field_id']]) ? $payment_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php } ?>
							<?php } ?>
							  <div class="form-group required">
						                  <label class="col-sm-2 control-label" for="input-payment-method"><?php echo $entry_payment_method; ?></label>
						                  <div class="col-sm-10">
						                    <div class="input-group">
						                      <select name="payment_method" id="input-payment-method" class="form-control">
						                        <option value=""><?php echo $text_select; ?></option>
						                        <?php if ($payment_code) { ?>
						                        <option value="<?php echo $payment_code; ?>" selected="selected"><?php echo $payment_method; ?></option>
						                        <?php } ?>
						                      </select>
						                      <span class="input-group-btn">
						                      <button type="button" id="button-payment-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_apply; ?></button>
						                      </span></div>
						                  </div>
						                </div>
							<div class="row">
								<div class="col-sm-6 text-left">
									<button type="button" onclick="$('a[href=\'#tab-cart\']').tab('show');" class="btn btn-default"><i class="fa fa-arrow-left"></i> <?php echo $button_back; ?></button>
								</div>
								<div class="col-sm-6 text-right">
									<button type="button" id="button-payment-address" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-arrow-right"></i> <?php echo $button_continue; ?></button>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-shipping">
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-shipping-firstname"><?php echo $entry_firstname; ?></label>
								<div class="col-sm-10">
									<input type="text" name="firstname" value="<?php echo $shipping_firstname; ?>" id="input-shipping-firstname" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-shipping-lastname"><?php echo $entry_lastname; ?></label>
								<div class="col-sm-10">
									<input type="text" name="lastname" value="<?php echo $shipping_lastname; ?>" id="input-shipping-lastname" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-shipping-address-1"><?php echo $entry_address_1; ?></label>
								<div class="col-sm-10">
									<input type="text" name="address_1" value="<?php echo $shipping_address_1; ?>" id="input-shipping-address-1" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-shipping-address-2"><?php echo $entry_address_2; ?></label>
								<div class="col-sm-10">
									<input type="text" name="address_2" value="<?php echo $shipping_address_2; ?>" id="input-shipping-address-2" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-shipping-country"><?php echo $entry_country; ?></label>
								<div class="col-sm-10">
									<select name="country_id" id="input-shipping-country" class="form-control">
										<option value=""><?php echo $text_select; ?></option>
										<?php foreach ($countries as $country) { ?>
										<?php if ($country['country_id'] == $shipping_country_id) { ?>
										<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-shipping-state"><?php echo $entry_state; ?></label>
								<div class="col-sm-10">
								<select id="input-shipping-state" name="state_id" class="form-control">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($states as $state) { ?>
									<?php if ($state['state_id'] == $shipping_state_id) { ?>
									<option value="<?php echo $state['state_id']; ?>" selected="selected"><?php echo $state['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $country['state_id']; ?>"><?php echo $state['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-shipping-suburb"><?php echo $entry_suburb; ?></label>
								<div class="col-sm-10">
								<select name="suburb_id" id="input-shipping-suburb" class="form-control">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($suburbs as $suburb) { ?>
									<?php if ($suburb['suburb_id'] == $shipping_suburb_id) { ?>
									<option value="<?php echo $suburb['suburb_id']; ?>" selected="selected"><?php echo $suburb['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $suburb['suburb_id']; ?>"><?php echo $suburb['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
								</div>
							</div>

<!-- 							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-shipping-zone"><?php echo $entry_state; ?></label>
								<div class="col-sm-10">
									<select name="zone_id" id="input-shipping-zone" class="form-control">
									</select>
								</div>
							</div> -->
							<?php foreach ($custom_fields as $custom_field) { ?>
							<?php if ($custom_field['location'] == 'address') { ?>
							<?php if ($custom_field['type'] == 'select') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
										<option value=""><?php echo $text_select; ?></option>
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<?php if (isset($ashipping_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $shipping_custom_field[$custom_field['custom_field_id']]) { ?>
										<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'radio') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<div class="radio">
											<?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $shipping_custom_field[$custom_field['custom_field_id']]) { ?>
											<label>
												<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } else { ?>
											<label>
												<input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } ?>
										</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'checkbox') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
										<?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
										<div class="checkbox">
											<?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $shipping_custom_field[$custom_field['custom_field_id']])) { ?>
											<label>
												<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } else { ?>
											<label>
												<input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
												<?php echo $custom_field_value['name']; ?></label>
											<?php } ?>
										</div>
										<?php } ?>
									</div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'text') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'textarea') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'file') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
									<input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : ''); ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'date') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group date">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'time') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group time">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php if ($custom_field['type'] == 'datetime') { ?>
							<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
								<label class="col-sm-2 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
								<div class="col-sm-10">
									<div class="input-group datetime">
										<input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
										<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
										</span></div>
								</div>
							</div>
							<?php } ?>
							<?php } ?>
							<?php } ?>
							<div class="row">
								<div class="col-sm-6 text-left">
									<button type="button" onclick="$('a[href=\'#tab-payment\']').tab('show');" class="btn btn-default"><i class="fa fa-arrow-left"></i> <?php echo $button_back; ?></button>
								</div>
								<div class="col-sm-6 text-right">
									<button type="button" id="button-shipping-address" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-arrow-right"></i> <?php echo $button_continue; ?></button>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-total">
							<div class="table-responsive">
								<table class="table table-bordered">
									<thead>
										<tr>
											<td class="text-left"><?php echo $column_product; ?></td>
											<td class="text-left"><?php echo $column_model; ?></td>
											<td class="text-right"><?php echo $column_quantity; ?></td>
											<td class="text-right"><?php echo $column_price; ?></td>
											<td class="text-right"><?php echo $column_total; ?></td>
										</tr>
									</thead>
									<tbody id="total">
										<tr>
											<td class="text-center" colspan="5"><?php echo $text_no_results; ?></td>
										</tr>
									</tbody>
								</table>
							</div>
							<fieldset>
								<legend><?php echo $text_order; ?></legend>
								<div class="form-group required">
									<label class="col-sm-2 control-label" for="input-shipping-method"><?php echo $entry_shipping_method; ?></label>
									<div class="col-sm-10">
										<div class="input-group">
											<select name="shipping_method" id="input-shipping-method" class="form-control">
												<option value=""><?php echo $text_select; ?></option>
												<option value="Delivery" <?php if($shipping_method=="Delivery"){?> selected="selected"<?php }?>>Delivery</option>
												<option value="Pick-up" <?php if($shipping_method=="Pick-up"){?> selected="selected"<?php }?>>Pick-up</option>
											</select>
											<span class="input-group-btn">
											<button type="button" id="button-shipping-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_apply; ?></button>
											</span></div>
									</div>
								</div>
								<div class="form-group required">
									<label class="col-sm-2 control-label" for="input-payment-method"><?php echo $entry_payment_method; ?></label>
									<div class="col-sm-10">
										<div class="input-group">
											<select name="payment_method" id="input-payment-method" class="form-control">
												<option value=""><?php echo $text_select; ?></option>
												<?php if ($payment_code) { ?>
												<option value="<?php echo $payment_code; ?>" selected="selected"><?php echo $payment_method; ?></option>
												<?php } ?>
											</select>
											<span class="input-group-btn">
											<button type="button" id="button-payment-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_apply; ?></button>
											</span></div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-coupon"><?php echo $entry_coupon; ?></label>
									<div class="col-sm-10">
										<div class="input-group">
											<input type="text" name="coupon" value="<?php echo $coupon; ?>" id="input-coupon" class="form-control" />
											<span class="input-group-btn">
											<button type="button" id="button-coupon" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_apply; ?></button>
											</span></div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-voucher"><?php echo $entry_voucher; ?></label>
									<div class="col-sm-10">
										<div class="input-group">
											<input type="text" name="voucher" value="<?php echo $voucher; ?>" id="input-voucher" data-loading-text="<?php echo $text_loading; ?>" class="form-control" />
											<span class="input-group-btn">
											<button type="button" id="button-voucher" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_apply; ?></button>
											</span></div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-reward"><?php echo $entry_reward; ?></label>
									<div class="col-sm-10">
										<div class="input-group">
											<input type="text" name="reward" value="<?php echo $reward; ?>" id="input-reward" data-loading-text="<?php echo $text_loading; ?>" class="form-control" />
											<span class="input-group-btn">
											<button type="button" id="button-reward" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_apply; ?></button>
											</span></div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
									<div class="col-sm-10">
										<select name="order_status_id" id="input-order-status" class="form-control">
											<?php foreach ($order_statuses as $order_status) { ?>
											<?php if ($order_status['order_status_id'] == $order_status_id) { ?>
											<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
											<?php } else { ?>
											<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
											<?php } ?>
											<?php } ?>
										</select>
										<input type="hidden" name="order_id" value="<?php echo $order_id; ?>" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-comment"><?php echo $entry_comment; ?></label>
									<div class="col-sm-10">
										<textarea name="comment" rows="5" id="input-comment" class="form-control"><?php echo $comment; ?></textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="input-affiliate"><?php echo $entry_affiliate; ?></label>
									<div class="col-sm-10">
										<input type="text" name="affiliate" value="<?php echo $affiliate; ?>" id="input-affiliate" class="form-control" />
										<input type="hidden" name="affiliate_id" value="<?php echo $affiliate_id; ?>" />
									</div>
								</div>
							</fieldset>
							<div class="row">
								<div class="col-sm-6 text-left">
									<button type="button" onclick="$('select[name=\'shipping_method\']').prop('disabled') ? $('a[href=\'#tab-payment\']').tab('show') : $('a[href=\'#tab-shipping\']').tab('show');" class="btn btn-default"><i class="fa fa-arrow-left"></i> <?php echo $button_back; ?></button>
								</div>
								<div class="col-sm-6 text-right">
									<button type="button" id="button-refresh" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-warning"><i class="fa fa-refresh"></i></button>
									<button type="button" id="button-save" class="btn btn-primary"><i class="fa fa-check-circle"></i> <?php echo $button_save; ?></button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript"><!--
// Disable the tabs
$('#order a[data-toggle=\'tab\']').on('click', function(e) {
	return false;
});
			
// Add all products to the cart using the api
$('#button-refresh').on('click', function() {
});

// Currency
$('select[name=\'currency\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/currency&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: 'currency=' + $('select[name=\'currency\'] option:selected').val(),
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'currency\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},	
		complete: function() {
			$('.fa-spin').remove();
		},		
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
			
			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			
				// Highlight any found errors
				$('select[name=\'currency\']').parent().parent().parent().addClass('has-error');			
			}
		},	
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'currency\']').trigger('change');

// Customer
$('input[name=\'customer\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',			
			success: function(json) {
				json.unshift({
					customer_id: '0',
					customer_group_id: '<?php echo $customer_group_id; ?>',						
					name: '<?php echo $text_none; ?>',
					customer_group: '',
					firstname: '',
					lastname: '',
					email: '',
					telephone: '',
					fax: '',
					custom_field: [],
					address: []			
				});				
				
				response($.map(json, function(item) {
					return {
						category: item['customer_group'],
						label: item['name'],
						value: item['customer_id'],
						customer_group_id: item['customer_group_id'],						
						firstname: item['firstname'],
						lastname: item['lastname'],
						email: item['email'],
						telephone: item['telephone'],
						fax: item['fax'],
						custom_field: item['custom_field'],
						address: item['address']
					}
				}));
			}
		});
	},
	'select': function(item) {
		// Reset all custom fields
		$('#tab-customer input[type=\'text\'], #tab-customer input[type=\'text\'], #tab-customer textarea').not('#tab-customer input[name=\'customer\'], #tab-customer input[name=\'customer_id\']').val('');
		$('#tab-customer select option').removeAttr('selected');
		$('#tab-customer input[type=\'checkbox\'], #tab-customer input[type=\'radio\']').removeAttr('checked');
		
		$('#tab-customer input[name=\'customer\']').val(item['label']);
		$('#tab-customer input[name=\'customer_id\']').val(item['value']);
		$('#tab-customer select[name=\'customer_group_id\']').val(item['customer_group_id']);
		$('#tab-customer input[name=\'firstname\']').val(item['firstname']);
		$('#tab-customer input[name=\'lastname\']').val(item['lastname']);
		$('#tab-customer input[name=\'email\']').val(item['email']);
		$('#tab-customer input[name=\'telephone\']').val(item['telephone']);
		$('#tab-customer input[name=\'fax\']').val(item['fax']);		
				
		for (i in item.custom_field) {
			$('#tab-customer select[name=\'custom_field[' + i + ']\']').val(item.custom_field[i]);
			$('#tab-customer textarea[name=\'custom_field[' + i + ']\']').val(item.custom_field[i]);
			$('#tab-customer input[name^=\'custom_field[' + i + ']\'][type=\'text\']').val(item.custom_field[i]);
			$('#tab-customer input[name^=\'custom_field[' + i + ']\'][type=\'hidden\']').val(item.custom_field[i]);
			$('#tab-customer input[name^=\'custom_field[' + i + ']\'][type=\'radio\'][value=\'' + item.custom_field[i] + '\']').prop('checked', true);	
			
			if (item.custom_field[i] instanceof Array) {
				for (j = 0; j < item.custom_field[i].length; j++) {
					$('#tab-customer input[name^=\'custom_field[' + i + ']\'][type=\'checkbox\'][value=\'' + item.custom_field[i][j] + '\']').prop('checked', true);
				}
			}
		}
	
		$('select[name=\'customer_group_id\']').trigger('change');
		
		html = '<option value="0"><?php echo $text_none; ?></option>'; 
			
		for (i in  item['address']) {
			html += '<option value="' + item['address'][i]['address_id'] + '">' + item['address'][i]['firstname'] + ' ' + item['address'][i]['lastname'] + ', ' + item['address'][i]['address_1'] + ', ' + item['address'][i]['city'] + ', ' + item['address'][i]['country'] + '</option>';
		}
		
		$('select[name=\'payment_address\']').html(html);
		$('select[name=\'shipping_address\']').html(html);
		
		$('select[name=\'payment_address\']').trigger('change');
		$('select[name=\'shipping_address\']').trigger('change');
	}
});
		
// Custom Fields
$('select[name=\'customer_group_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/customer/customfield&token=<?php echo $token; ?>&customer_group_id=' + this.value,
		dataType: 'json',	
		success: function(json) {
			$('.custom-field').hide();
			$('.custom-field').removeClass('required');
			
			for (i = 0; i < json.length; i++) {
				custom_field = json[i];
				
				$('.custom-field' + custom_field['custom_field_id']).show();
				
				if (custom_field['required']) {
					$('.custom-field' + custom_field['custom_field_id']).addClass('required');
				}
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'customer_group_id\']').trigger('change');

$('#button-customer').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&store_id=' + $('select[name=\'store_id\'] option:selected').val()+"&token=<?php echo $token; ?>&api=api/customer",
		type: 'post',
		data: $('#tab-customer input[type=\'text\'], #tab-customer input[type=\'hidden\'], #tab-customer input[type=\'radio\']:checked, #tab-customer input[type=\'checkbox\']:checked, #tab-customer select, #tab-customer textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-customer').button('loading');
		},
		complete: function() {
			 $('#button-customer').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}				
				
				for (i in json['error']) {
					var element = $('#input-' + i.replace('_', '-'));
					
					if (element.parent().hasClass('input-group')) {
											$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}				
				
				// Highlight any found errors
				$('.text-danger').parentsUntil('.form-group').parent().addClass('has-error');
			} else {
				$.ajax({
					url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/cart/add&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
					type: 'post',
					data: $('#cart input[name^=\'product\'][type=\'text\'], #cart input[name^=\'product\'][type=\'hidden\'], #cart input[name^=\'product\'][type=\'radio\']:checked, #cart input[name^=\'product\'][type=\'checkbox\']:checked, #cart select[name^=\'product\'], #cart textarea[name^=\'product\']'),
					dataType: 'json',
					beforeSend: function() {
						$('#button-product-add').button('loading');
					},
					complete: function() {
						$('#button-product-add').button('reset');
					},
					success: function(json) {
						$('.alert, .text-danger').remove();
						$('.form-group').removeClass('has-error');
					
						if (json['error'] && json['error']['warning']) {
							$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});		
					
				// $.ajax({
				// 	url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/voucher/add&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
				// 	type: 'post',
				// 	data: $('#cart input[name^=\'voucher\'][type=\'text\'], #cart input[name^=\'voucher\'][type=\'hidden\'], #cart input[name^=\'voucher\'][type=\'radio\']:checked, #cart input[name^=\'voucher\'][type=\'checkbox\']:checked, #cart select[name^=\'voucher\'], #cart textarea[name^=\'voucher\']'),
				// 	dataType: 'json',
				// 	beforeSend: function() {
				// 		$('#button-voucher-add').button('loading');
				// 	},
				// 	complete: function() {
				// 		$('#button-voucher-add').button('reset');
				// 	},
				// 	success: function(json) {
				// 		$('.alert, .text-danger').remove();
				// 		$('.form-group').removeClass('has-error');
					
				// 		if (json['error'] && json['error']['warning']) {
				// 			$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				// 		}
				// 	},
				// 	error: function(xhr, ajaxOptions, thrownError) {
				// 		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				// 	}
				// });	

				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
								
				$('a[href=\'#tab-cart\']').tab('show');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});
				
$('#tab-product input[name=\'product\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',			
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id'],
						model: item['model'],
						option: item['option'],
						price: item['price']						
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('#tab-product input[name=\'product\']').val(item['label']);
		$('#tab-product input[name=\'product_id\']').val(item['value']);
		
		if (item['option'] != '') {
			html  = '<fieldset>';
						html += '  <legend><?php echo $entry_option; ?></legend>';
				
			for (i = 0; i < item['option'].length; i++) {
				option = item['option'][i];
				
				if (option['type'] == 'select') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label" for="input-option' + option['product_option_id'] + '">' + option['name'] + '</label>';
					html += '  <div class="col-sm-10">';
					html += '    <select name="option[' + option['product_option_id'] + ']" id="input-option' + option['product_option_id'] + '" class="form-control">';
					html += '      <option value=""><?php echo $text_select; ?></option>';
				
					for (j = 0; j < option['product_option_value'].length; j++) {
						option_value = option['product_option_value'][j];
						
						html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];
						
						if (option_value['price']) {
							html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
						}
						
						html += '</option>';
					}
						
					html += '    </select>';
					html += '  </div>';
					html += '</div>';
				}
				
				if (option['type'] == 'radio') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label" for="input-option' + option['product_option_id'] + '">' + option['name'] + '</label>';
					html += '  <div class="col-sm-10">';
					html += '    <select name="option[' + option['product_option_id'] + ']" id="input-option' + option['product_option_id'] + '" class="form-control">';
					html += '      <option value=""><?php echo $text_select; ?></option>';
				
					for (j = 0; j < option['product_option_value'].length; j++) {
						option_value = option['product_option_value'][j];
						
						html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];
						
						if (option_value['price']) {
							html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
						}
						
						html += '</option>';
					}
						
					html += '    </select>';
					html += '  </div>';
					html += '</div>';
				}
					
				if (option['type'] == 'checkbox') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label">' + option['name'] + '</label>';
					html += '  <div class="col-sm-10">';
					html += '    <div id="input-option' + option['product_option_id'] + '">';
					
					for (j = 0; j < option['product_option_value'].length; j++) {
						option_value = option['product_option_value'][j];
						
						html += '<div class="checkbox">';
						
						html += '  <label><input type="checkbox" name="option[' + option['product_option_id'] + '][]" value="' + option_value['product_option_value_id'] + '" /> ' + option_value['name'];
						
						if (option_value['price']) {
							html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
						}
						
						html += '  </label>';
						html += '</div>';
					}
										
					html += '    </div>';
					html += '  </div>';
					html += '</div>';
				}
			
				if (option['type'] == 'image') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label" for="input-option' + option['product_option_id'] + '">' + option['name'] + '</label>';
					html += '  <div class="col-sm-10">';
					html += '    <select name="option[' + option['product_option_id'] + ']" id="input-option' + option['product_option_id'] + '" class="form-control">';
					html += '      <option value=""><?php echo $text_select; ?></option>';
				
					for (j = 0; j < option['product_option_value'].length; j++) {
						option_value = option['product_option_value'][j];
						
						html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];
						
						if (option_value['price']) {
							html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
						}
						
						html += '</option>';
					}
						
					html += '    </select>';					
					html += '  </div>';
					html += '</div>';
				}
						
				if (option['type'] == 'text') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label" for="input-option' + option['product_option_id'] + '">' + option['name'] + '</label>';
					html += '  <div class="col-sm-10"><input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['value'] + '" id="input-option' + option['product_option_id'] + '" class="form-control" /></div>';
					html += '</div>';					
				}
				
				if (option['type'] == 'textarea') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label" for="input-option' + option['product_option_id'] + '">' + option['name'] + '</label>';
					html += '  <div class="col-sm-10"><textarea name="option[' + option['product_option_id'] + ']" rows="5" id="input-option' + option['product_option_id'] + '" class="form-control">' + option['value'] + '</textarea></div>';
					html += '</div>';
				}
				
				if (option['type'] == 'file') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label">' + option['name'] + '</label>';
					html += '  <div class="col-sm-10">';
					html += '    <button type="button" id="button-upload' + option['product_option_id'] + '" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>';
					html += '    <input type="hidden" name="option[' + option['product_option_id'] + ']" value="' + option['value'] + '" id="input-option' + option['product_option_id'] + '" />';
					html += '  </div>';
					html += '</div>';
				}
				
				if (option['type'] == 'date') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label" for="input-option' + option['product_option_id'] + '">' + option['name'] + '</label>';
					html += '  <div class="col-sm-3"><div class="input-group date"><input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['value'] + '" placeholder="' + option['name'] + '" data-date-format="YYYY-MM-DD" id="input-option' + option['product_option_id'] + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
					html += '</div>';
				}
				
				if (option['type'] == 'datetime') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label" for="input-option' + option['product_option_id'] + '">' + option['name'] + '</label>';
					html += '  <div class="col-sm-3"><div class="input-group datetime"><input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['value'] + '" placeholder="' + option['name'] + '" data-date-format="YYYY-MM-DD HH:mm" id="input-option' + option['product_option_id'] + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
					html += '</div>';					
				}
				
				if (option['type'] == 'time') {
					html += '<div class="form-group' + (option['required'] ? ' required' : '') + '">';
					html += '  <label class="col-sm-2 control-label" for="input-option' + option['product_option_id'] + '">' + option['name'] + '</label>';
					html += '  <div class="col-sm-3"><div class="input-group time"><input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['value'] + '" placeholder="' + option['name'] + '" data-date-format="HH:mm" id="input-option' + option['product_option_id'] + '" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div></div>';
					html += '</div>';					
				}
			}
			
			html += '</fieldset>';
			
			$('#option').html(html);
			
			$('.date').datetimepicker({
				pickTime: false
			});
			
			$('.datetime').datetimepicker({
				pickDate: true,
				pickTime: true
			});
			
			$('.time').datetimepicker({
				pickDate: false
			});
		} else {
			$('#option').html('');
		}		
	}	
});

$('#button-product-add').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/cart/add&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: $('#tab-product input[name=\'product_id\'], #tab-product input[name=\'quantity\'], #tab-product input[name^=\'option\'][type=\'text\'], #tab-product input[name^=\'option\'][type=\'hidden\'], #tab-product input[name^=\'option\'][type=\'radio\']:checked, #tab-product input[name^=\'option\'][type=\'checkbox\']:checked, #tab-product select[name^=\'option\'], #tab-product textarea[name^=\'option\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-product-add').button('loading');
		},
		complete: function() {
			$('#button-product-add').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
		
			if (json['error']) {
				if (json['error']['warning']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
				
				if (json['error']['option']) {	
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));
						
						if (element.parent().hasClass('input-group')) {
							$(element).parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							$(element).after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}
				
				if (json['error']['store']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['store'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parentsUntil('.form-group').parent().addClass('has-error');				
			} else {
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});				
});

// Voucher
$('#button-voucher-add').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/voucher/add&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: $('#tab-voucher input[type=\'text\'], #tab-voucher input[type=\'hidden\'], #tab-voucher input[type=\'radio\']:checked, #tab-voucher input[type=\'checkbox\']:checked, #tab-voucher select, #tab-voucher textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-voucher-add').button('loading');
		},
		complete: function() {
			$('#button-voucher-add').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
		
			if (json['error']) {
				if (json['error']['warning']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				for (i in json['error']) {
					var element = $('#input-' + i.replace('_', '-'));
					
					if (element.parent().hasClass('input-group')) {
						$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}	

				// Highlight any found errors
				$('.text-danger').parentsUntil('.form-group').parent().addClass('has-error');					
			} else {
				$('input[name=\'from_name\']').attr('value', '');	
				$('input[name=\'from_email\']').attr('value', '');	
				$('input[name=\'to_name\']').attr('value', '');
				$('input[name=\'to_email\']').attr('value', '');	
				$('textarea[name=\'message\']').attr('value', '');	
				$('input[name=\'amount\']').attr('value', '<?php echo addslashes($voucher_min); ?>');
					
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});				
});

$('#tab-cart').delegate('.btn-danger', 'click', function() {
	var node = this;
	
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/cart/remove&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: 'key=' + encodeURIComponent(this.value),
		dataType: 'json',
		beforeSend: function() {
			$(node).button('loading');
		},
		complete: function() {
			$(node).button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
		
			// Check for errors
			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			} else {
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});				
});

$('#button-cart').on('click', function() {
	$('a[href=\'#tab-payment\']').tab('show');
});
				
// Payment Address
$('select[name=\'payment_address\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/customer/address&token=<?php echo $token; ?>&address_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'payment_address\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('#tab-payment .fa-spin').remove();
		},		
		success: function(json) {
			// Reset all fields
			$('#tab-payment input[type=\'text\'], #tab-payment input[type=\'text\'], #tab-payment textarea').val('');
			$('#tab-payment select option').not('#tab-payment select[name=\'payment_address\']').removeAttr('selected');
			$('#tab-payment input[type=\'checkbox\'], #tab-payment input[type=\'radio\']').removeAttr('checked');
					
			$('#tab-payment input[name=\'firstname\']').val(json['firstname']);
			$('#tab-payment input[name=\'lastname\']').val(json['lastname']);
			$('#tab-payment input[name=\'company\']').val(json['company']);
			$('#tab-payment input[name=\'address_1\']').val(json['address_1']);
			$('#tab-payment input[name=\'address_2\']').val(json['address_2']);
			$('#tab-payment input[name=\'city\']').val(json['city']);
			$('#tab-payment input[name=\'postcode\']').val(json['postcode']);
			$('#tab-payment select[name=\'country_id\']').val(json['country_id']);
			
			payment_zone_id = json['zone_id'];
			
			for (i in json['custom_field']) {
				$('#tab-payment select[name=\'custom_field[' + i + ']\']').val(json['custom_field'][i]);
				$('#tab-payment textarea[name=\'custom_field[' + i + ']\']').val(json['custom_field'][i]);
				$('#tab-payment input[name^=\'custom_field[' + i + ']\'][type=\'text\']').val(json['custom_field'][i]);
				$('#tab-payment input[name^=\'custom_field[' + i + ']\'][type=\'hidden\']').val(json['custom_field'][i]);
				$('#tab-payment input[name^=\'custom_field[' + i + ']\'][type=\'radio\'][value=\'' + json['custom_field'][i] + '\']').prop('checked', true);	
				$('#tab-payment input[name^=\'custom_field[' + i + ']\'][type=\'checkbox\'][value=\'' + json['custom_field'][i] + '\']').prop('checked', true);
				
				if (json['custom_field'][i] instanceof Array) {
					for (j = 0; j < json['custom_field'][i].length; j++) {
						$('#tab-payment input[name^=\'custom_field[' + i + ']\'][type=\'checkbox\'][value=\'' + json['custom_field'][i][j] + '\']').prop('checked', true);
					}
				}						
			}				
			
			$('#tab-payment select[name=\'country_id\']').trigger('change');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});

var payment_state_id = '<?php echo $payment_state_id; ?>';

$('#tab-payment select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/order/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#tab-payment select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('#tab-payment .fa-spin').remove();
		},			
		success: function(json) {

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['state'] && json['state'] != '') {
				for (i = 0; i < json['state'].length; i++) {
							html += '<option value="' + json['state'][i]['state_id'] + '"';
						
					if (json['state'][i]['state_id'] == payment_state_id) {
								html += ' selected="selected"';
						}
	
						html += '>' + json['state'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#tab-payment select[name=\'state_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#tab-payment select[name=\'country_id\']').trigger('change');


var payment_suburb_id = '<?php echo $payment_suburb_id; ?>';

$('#tab-payment select[name=\'state_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/order/state&token=<?php echo $token; ?>&state_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#tab-payment select[name=\'state_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('#tab-payment .fa-spin').remove();
		},			
		success: function(json) {

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['suburb'] && json['suburb'] != '') {
				for (i = 0; i < json['suburb'].length; i++) {

					html += '<option value="' + json['suburb'][i]['suburb_id'] + '"';	
					if (json['suburb'][i]['suburb_id'] == payment_suburb_id) {
						html += ' selected="selected"';
					}
	
					html += '>' + json['suburb'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			console.log(html);
			$('#tab-payment select[name=\'suburb_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#tab-payment select[name=\'state_id\']').trigger('change');

$('#button-payment-address').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/payment/address&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: $('#tab-payment input[type=\'text\'], #tab-payment input[type=\'hidden\'], #tab-payment input[type=\'radio\']:checked, #tab-payment input[type=\'checkbox\']:checked, #tab-payment select, #tab-payment textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-payment-address').button('loading');
		},
		complete: function() {
			$('#button-payment-address').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			// Check for errors
			if (json['error']) {
				if (json['error']['warning']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				for (i in json['error']) {
					var element = $('#input-payment-' + i.replace('_', '-'));
					
					if ($(element).parent().hasClass('input-group')) {
						$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}	
								
				// Highlight any found errors
				$('.text-danger').parentsUntil('.form-group').parent().addClass('has-error');				
			} else {
				// Payment Methods
				$.ajax({
					url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/payment/methods&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
					dataType: 'json',
					beforeSend: function() {
						$('#button-payment-address i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
						$('#button-payment-address').prop('disabled', true);
					},
					complete: function() {
						$('#button-payment-address i').replaceWith('<i class="fa fa-arrow-right"></i>');
						$('#button-payment-address').prop('disabled', false);
					},
					success: function(json) {
						if (json['error']) {
							$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
						} else {
							html = '<option value=""><?php echo $text_select; ?></option>';
							
							if (json['payment_methods']) {
								for (i in json['payment_methods']) {
									if (json['payment_methods'][i]['code'] == $('select[name=\'payment_method\'] option:selected').val()) {
										html += '<option value="' + json['payment_methods'][i]['code'] + '" selected="selected">' + json['payment_methods'][i]['title'] + '</option>';
									} else {
										html += '<option value="' + json['payment_methods'][i]['code'] + '">' + json['payment_methods'][i]['title'] + '</option>';
									}
								}
							}	
							console.log(html);
							$('select[name=\'payment_method\']').html(html);					
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});	
				
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
								
				// If shipping required got to shipping tab else total tabs
				if ($('select[name=\'shipping_method\']').prop('disabled')) {
					$('a[href=\'#tab-total\']').tab('show');		
				} else {
					$('a[href=\'#tab-shipping\']').tab('show');							
				}
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

// Shipping Address
$('select[name=\'shipping_address\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/customer/address&token=<?php echo $token; ?>&address_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'shipping_address\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('#tab-shipping .fa-spin').remove();
		},		
		success: function(json) {
			// Reset all fields
			$('#tab-shipping input[type=\'text\'], #tab-shipping input[type=\'text\'], #tab-shipping textarea').val('');
			$('#tab-shipping select option').not('#tab-shipping select[name=\'shipping_address\']').removeAttr('selected');
			$('#tab-shipping input[type=\'checkbox\'], #tab-shipping input[type=\'radio\']').removeAttr('checked');
					
			$('#tab-shipping input[name=\'firstname\']').val(json['firstname']);
			$('#tab-shipping input[name=\'lastname\']').val(json['lastname']);
			$('#tab-shipping input[name=\'company\']').val(json['company']);
			$('#tab-shipping input[name=\'address_1\']').val(json['address_1']);
			$('#tab-shipping input[name=\'address_2\']').val(json['address_2']);
			$('#tab-shipping input[name=\'city\']').val(json['city']);
			$('#tab-shipping input[name=\'postcode\']').val(json['postcode']);
			$('#tab-shipping select[name=\'country_id\']').val(json['country_id']);
			
			shipping_zone_id = json['zone_id'];
			
			for (i in json['custom_field']) {
				$('#tab-shipping select[name=\'custom_field[' + i + ']\']').val(json['custom_field'][i]);
				$('#tab-shipping textarea[name=\'custom_field[' + i + ']\']').val(json['custom_field'][i]);
				$('#tab-shipping input[name^=\'custom_field[' + i + ']\'][type=\'text\']').val(json['custom_field'][i]);
				$('#tab-shipping input[name^=\'custom_field[' + i + ']\'][type=\'hidden\']').val(json['custom_field'][i]);
				$('#tab-shipping input[name^=\'custom_field[' + i + ']\'][type=\'radio\'][value=\'' + json['custom_field'][i] + '\']').prop('checked', true);	
				$('#tab-shipping input[name^=\'custom_field[' + i + ']\'][type=\'checkbox\'][value=\'' + json['custom_field'][i] + '\']').prop('checked', true);
				
				if (json['custom_field'][i] instanceof Array) {
					for (j = 0; j < json['custom_field'][i].length; j++) {
						$('#tab-shipping input[name^=\'custom_field[' + i + ']\'][type=\'checkbox\'][value=\'' + json['custom_field'][i][j] + '\']').prop('checked', true);
					}
				}						
			}	
			
			$('#tab-shipping select[name=\'country_id\']').trigger('change');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});

var shipping_state_id = '<?php echo $shipping_state_id; ?>';

$('#tab-shipping select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/order/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#tab-shipping select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('#tab-shipping .fa-spin').remove();
		},			
		success: function(json) {
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['state'] && json['state'] != '') {
				for (i = 0; i < json['state'].length; i++) {
							html += '<option value="' + json['state'][i]['state_id'] + '"';
						
					if (json['state'][i]['state_id'] == shipping_state_id) {
								html += ' selected="selected"';
						}
	
						html += '>' + json['state'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#tab-shipping select[name=\'state_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#tab-shipping select[name=\'country_id\']').trigger('change');

var shipping_suburb_id = '<?php echo $shipping_suburb_id; ?>';

$('#tab-shipping select[name=\'state_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=sale/order/state&token=<?php echo $token; ?>&state_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#tab-shipping select[name=\'state_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('#tab-shipping .fa-spin').remove();
		},			
		success: function(json) {
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['suburb'] && json['suburb'] != '') {
				for (i = 0; i < json['suburb'].length; i++) {
							html += '<option value="' + json['suburb'][i]['suburb_id'] + '"';
						
					if (json['suburb'][i]['suburb_id'] == shipping_state_id) {
								html += ' selected="selected"';
						}
	
						html += '>' + json['suburb'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#tab-shipping select[name=\'suburb_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#tab-shipping select[name=\'state_id\']').trigger('change');

$('#button-shipping-address').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/shipping/address&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: $('#tab-shipping input[type=\'text\'], #tab-shipping input[type=\'hidden\'], #tab-shipping input[type=\'radio\']:checked, #tab-shipping input[type=\'checkbox\']:checked, #tab-shipping select, #tab-shipping textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-shipping-address').button('loading');
		},
		complete: function() {
			$('#button-shipping-address').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			// Check for errors
			if (json['error']) {
				if (json['error']['warning']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				for (i in json['error']) {
					var element = $('#input-shipping-' + i.replace('_', '-'));
					
					if ($(element).parent().hasClass('input-group')) {
						$(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
					} else {
						$(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
					}
				}
				
				// Highlight any found errors
				$('.text-danger').parentsUntil('.form-group').parent().addClass('has-error');					
			} else {
				// Shipping Methods
				// $.ajax({
				// 	url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/shipping/methods&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
				// 	dataType: 'json',
				// 	beforeSend: function() {
				// 		$('#button-shipping-address i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				// 		$('#button-shipping-address').prop('disabled', true);
				// 	},
				// 	complete: function() {
				// 		$('#button-shipping-address i').replaceWith('<i class="fa fa-arrow-right"></i>');
				// 		$('#button-shipping-address').prop('disabled', false);
				// 	},
				// 	success: function(json) {
				// 		if (json['error']) {
				// 			$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				// 		} else {
				// 			// Shipping Methods
				// 			html = '<option value=""><?php echo $text_select; ?></option>';
							
				// 			if (json['shipping_methods']) {
				// 				for (i in json['shipping_methods']) {
				// 					html += '<optgroup label="' + json['shipping_methods'][i]['title'] + '">';
								
				// 					if (!json['shipping_methods'][i]['error']) {
				// 						for (j in json['shipping_methods'][i]['quote']) {
				// 							if (json['shipping_methods'][i]['quote'][j]['code'] == $('select[name=\'shipping_method\'] option:selected').val()) {
				// 								html += '<option value="' + json['shipping_methods'][i]['quote'][j]['code'] + '" selected="selected">' + json['shipping_methods'][i]['quote'][j]['title'] + ' - ' + json['shipping_methods'][i]['quote'][j]['text'] + '</option>';
				// 							} else {
				// 								html += '<option value="' + json['shipping_methods'][i]['quote'][j]['code'] + '">' + json['shipping_methods'][i]['quote'][j]['title'] + ' - ' + json['shipping_methods'][i]['quote'][j]['text'] + '</option>';
				// 							}
				// 						}		
				// 					} else {
				// 						html += '<option value="" style="color: #F00;" disabled="disabled">' + json['shipping_method'][i]['error'] + '</option>';
				// 					}
									
				// 					html += '</optgroup>';
				// 				}
				// 			}
							
				// 			$('select[name=\'shipping_method\']').html(html);	
				// 		}
				// 	},
				// 	error: function(xhr, ajaxOptions, thrownError) {
				// 		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				// 	}
				// });	
				
				// // Refresh products, vouchers and totals
				// $('#button-refresh').trigger('click');
								
				$('a[href=\'#tab-total\']').tab('show');							
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});				
});

// Shipping Method
$('#button-shipping-method').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/shipping/method&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: 'shipping_method=' + $('select[name=\'shipping_method\'] option:selected').val(),
		dataType: 'json',
		beforeSend: function() {
			$('#button-shipping-method').button('loading');	
		},	
		complete: function() {
			$('#button-shipping-method').button('reset');
		},		
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
			
			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			
				// Highlight any found errors
				$('select[name=\'shipping_method\']').parent().parent().parent().addClass('has-error');			
			}
			
			if (json['success']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
			}
		},	
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

// Payment Method
$('#button-payment-method').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/payment/method&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: 'payment_method=' + $('select[name=\'payment_method\'] option:selected').val(),
		dataType: 'json',
		beforeSend: function() {
			$('#button-payment-method').button('loading');
		},	
		complete: function() {
			$('#button-payment-method').button('reset');
		},		
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
			
			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			
				// Highlight any found errors
				$('select[name=\'payment_method\']').parent().parent().parent().addClass('has-error');				
			}
			
			if (json['success']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});		
});

// Coupon
$('#button-coupon').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/coupon&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: $('input[name=\'coupon\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-coupon').button('loading');
		},	
		complete: function() {
			$('#button-coupon').button('reset');
		},		
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
			
			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			
				// Highlight any found errors
				$('input[name=\'coupon\']').parent().parent().parent().addClass('has-error');				
			}
			
			if (json['success']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});		
});

// Voucher
$('#button-voucher').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/voucher&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: $('input[name=\'voucher\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-voucher').button('loading');
		},	
		complete: function() {
			$('#button-voucher').button('reset');
		},		
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
			
			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				// Highlight any found errors
				$('input[name=\'voucher\']').parent().parent().parent().addClass('has-error');			
			}
			
			if (json['success']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});		
});

// Reward
$('#button-reward').on('click', function() {
	$.ajax({
		url: 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/reward&store_id=' + $('select[name=\'store_id\'] option:selected').val(),
		type: 'post',
		data: $('input[name=\'reward\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-reward').button('loading');
		},	
		complete: function() {
			$('#button-reward').button('reset');
		},		
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
			
			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				// Highlight any found errors
				$('input[name=\'reward\']').parent().parent().parent().addClass('has-error');
			}
			
			if (json['success']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				
				// Refresh products, vouchers and totals
				$('#button-refresh').trigger('click');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});		
});

// Affiliate
$('input[name=\'affiliate\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=marketing/affiliate/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',			
			success: function(json) {
				json.unshift({
					affiliate_id: 0,
					name: '<?php echo $text_none; ?>'
				});
								
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['affiliate_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'affiliate\']').val(item['label']);
		$('input[name=\'affiliate_id\']').val(item['value']);		
	}	
});

// Checkout
$('#button-save').on('click', function() {
	var order_id = $('input[name=\'order_id\']').val();
	
	if (order_id == 0) {
		var url = 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/order/add&store_id=' + $('select[name=\'store_id\'] option:selected').val();
	} else {
		var url = 'index.php?route=sale/order/api&token=<?php echo $token; ?>&api=api/order/edit&store_id=' + $('select[name=\'store_id\'] option:selected').val() + '&order_id=' + order_id;
	}
	
	$.ajax({
		url: url,
		type: 'post',
		data: $('#tab-total select[name=\'order_status_id\'], #tab-total select, #tab-total textarea[name=\'comment\'], #tab-total input[name=\'affiliate_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-save').button('loading');	
		},	
		complete: function() {
			$('#button-save').button('reset');
		},		
		success: function(json) {
			$('.alert, .text-danger').remove();
			
			if (json['error']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}
			
			if (json['success']) {
				$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '  <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}
			
			if (json['order_id']) {
				$('input[name=\'order_id\']').val(json['order_id']);
			}			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});		
});

$('#content').delegate('button[id^=\'button-upload\'], button[id^=\'button-custom-field\'], button[id^=\'button-payment-custom-field\'], button[id^=\'button-shipping-custom-field\']', 'click', function() {
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
				url: 'index.php?route=tool/upload/upload&token=<?php echo $token; ?>',
				type: 'post',		
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,		
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},		
				success: function(json) {
					$(node).parent().find('.text-danger').remove();
					
					if (json['error']) {
						$(node).parent().find('input[type=\'hidden\']').after('<div class="text-danger">' + json['error'] + '</div>');
					}
								
					if (json['success']) {
						alert(json['success']);
					}
					
					if (json['code']) {
						$(node).parent().find('input[type=\'hidden\']').attr('value', json['code']);
					}
				},			
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});

$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});	
//--></script> 
	<script type="text/javascript">
// Sort the custom fields
$('#tab-customer .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#tab-customer .form-group').length) {
		$('#tab-customer .form-group').eq($(this).attr('data-sort')).before(this);
	}

	if ($(this).attr('data-sort') > $('#tab-customer .form-group').length) {
		$('#tab-customer .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#tab-customer .form-group').length) {
		$('#tab-customer .form-group:first').before(this);
	}
});

// Sort the custom fields
$('#tab-payment .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#tab-payment .form-group').length) {
		$('#tab-payment .form-group').eq($(this).attr('data-sort')).before(this);
	}

	if ($(this).attr('data-sort') > $('#tab-payment .form-group').length) {
		$('#tab-payment .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#tab-payment .form-group').length) {
		$('#tab-payment .form-group:first').before(this);
	}
});

$('#tab-shipping .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#tab-shipping .form-group').length) {
		$('#tab-shipping .form-group').eq($(this).attr('data-sort')).before(this);
	}

	if ($(this).attr('data-sort') > $('#tab-shipping .form-group').length) {
		$('#tab-shipping .form-group:last').after(this);
	}

	if ($(this).attr('data-sort') < -$('#tab-shipping .form-group').length) {
		$('#tab-shipping .form-group:first').before(this);
	}
});
</script></div>
<?php echo $footer; ?>