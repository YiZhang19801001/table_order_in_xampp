<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-location" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-location" class="form-horizontal">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-store" data-toggle="tab" ><?php echo $tab_store; ?></a></li>
						<li ><a href="#tab-time" data-toggle="tab" ><?php echo $tab_time; ?></a></li>
						<li ><a href="#tab-image" data-toggle="tab" ><?php echo $tab_image; ?></a></li>
						<li ><a href="#tab-info" data-toggle="tab" ><?php echo $tab_info; ?></a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-store">
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
								<div class="col-sm-10">
									<input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
									<?php if ($error_name) { ?>
									<div class="text-danger"><?php echo $error_name; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-address"><?php echo $entry_address; ?></label>
								<div class="col-sm-10">
									<textarea type="text" name="address" placeholder="<?php echo $entry_address; ?>" rows="5" id="input-address" class="form-control"><?php echo $address; ?></textarea>
									<?php if ($error_address) { ?>
									<div class="text-danger"><?php echo $error_address; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-geocode"><span data-toggle="tooltip" data-container="#content" title="<?php echo $help_geocode; ?>"><?php echo $entry_geocode; ?></span></label>
								<div class="col-sm-10">
									<input type="text" name="geocode" value="<?php echo $geocode; ?>" placeholder="<?php echo $entry_geocode; ?>" id="input-geocode" class="form-control" />
									<?php if ($error_geocode) { ?>
									<div class="text-danger"><?php echo $error_geocode; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
								<div class="col-sm-10">
									<input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
									<?php if ($error_telephone) { ?>
									<div class="text-danger"><?php echo $error_telephone; ?></div>
									<?php  } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-fax"><?php echo $entry_fax; ?></label>
								<div class="col-sm-10">
									<input type="text" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="form-control" />
								</div>
							</div>
						   	<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-staff"><?php echo $entry_staff; ?></label>
								<div class="col-sm-10">
									<input type="text" name="staff" value="<?php echo $staff; ?>" placeholder="<?php echo $entry_staff; ?>" id="input-staff" class="form-control" />
									<input type="hidden" name="user_id" value="<?php echo $user_id; ?>" />
									<?php if ($error_staff) { ?>
									<div class="text-danger"><?php echo $error_staff; ?></div>
									<?php } ?>     
								</div>
						    </div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
								<div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
									<input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
									<?php if ($error_image) { ?>
									<div class="text-danger"><?php echo $error_image; ?></div>
									<?php  } ?>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-bgimage"><?php echo $entry_bgimage; ?></label>
								<div class="col-sm-10"><a href="" id="thumb-bgimage" data-toggle="image" class="img-thumbnail"><img src="<?php echo $bgthumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
									<input type="hidden" name="bgimage" value="<?php echo $bgimage; ?>" id="input-bgimage" />
									<?php if ($error_bgimage) { ?>
									<div class="text-danger"><?php echo $error_bgimage; ?></div>
									<?php  } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-color"><?php echo $entry_color; ?></label>
								<div class="col-sm-10"><input type="text" name="color" value="<?php echo $color; ?>" id="input-color" class="form-control"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-color1"><?php echo $entry_color1; ?></label>
								<div class="col-sm-10"><input type="text" name="color1" value="<?php echo $color1; ?>" id="input-color1" class="form-control"/>
								</div>
							</div>
							 <div class="form-group required">
								<label class="col-sm-2 control-label" for="input-tag"><?php echo $entry_tag; ?></label>
								<div class="col-sm-10">
									<input type="text" name="tag_ids" value="" placeholder="<?php echo $entry_tag; ?>" id="input-tag" class="form-control" />
									<div id="tag" class="well well-sm" style="height: 150px; overflow: auto;">
										<?php foreach ($tags as $tag) { ?>
										<div id="tag<?php echo $tag['tag_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $tag['name']; ?>
											<input type="hidden" name="tag_ids[]" value="<?php echo $tag['tag_id']; ?>" />
										</div>
										<?php } ?>
									</div>
									<?php if ($error_tag) { ?>
									<div class="text-danger"><?php echo $error_tag; ?></div>
									<?php }?>
								</div>
							</div>
							 <div class="form-group">
								<label class="col-sm-2 control-label" for="input-coupon"><?php echo $entry_coupon; ?></label>
								<div class="col-sm-10">
									<input type="text" name="coupon_ids" value="" placeholder="<?php echo $entry_coupon; ?>" id="input-coupon" class="form-control" />
									<div id="coupon" class="well well-sm" style="height: 150px; overflow: auto;">
										<?php foreach ($coupons as $coupon) { ?>
										<div id="coupon<?php echo $coupon['shop_coupon_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $coupon['name']; ?>
											<input type="hidden" name="coupon_ids[]" value="<?php echo $coupon['shop_coupon_id']; ?>" />
										</div>
										<?php } ?>
									</div>
								</div>
							</div>
						   	<div class="form-group">
								<label class="col-sm-2 control-label" for="input-geo"><?php echo $entry_geo; ?></label>
								<div class="col-sm-10">
									<input type="text" name="geo" value="<?php echo $geo; ?>" placeholder="<?php echo $entry_geo; ?>" id="input-geo" class="form-control" />
									<input type="hidden" name="geo_zone_id" value="<?php echo $geo_zone_id; ?>" />
									<?php if ($error_geo) { ?>
									<div class="text-danger"><?php echo $error_geo; ?></div>
									<?php } ?>     
								</div>
						    </div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-consume"><?php echo $entry_consume; ?></label>
								<div class="col-sm-10">
									<input type="text" name="consume" value="<?php echo $consume; ?>" placeholder="<?php echo $entry_consume; ?>" id="input-consume" class="form-control" />
									<?php if ($error_consume) { ?>
									<div class="text-danger"><?php echo $error_consume; ?></div>
									<?php  } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-open"><span data-toggle="tooltip" data-container="#content" title="<?php echo $help_open; ?>"><?php echo $entry_open; ?></span></label>
								<div class="col-sm-10">
									<textarea name="open" rows="5" placeholder="<?php echo $entry_open; ?>" id="input-open" class="form-control"><?php echo $open; ?></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-comment"><span data-toggle="tooltip" data-container="#content" title="<?php echo $help_comment; ?>"><?php echo $entry_comment; ?></span></label>
								<div class="col-sm-10">
									<textarea name="comment" rows="5" placeholder="<?php echo $entry_comment; ?>" id="input-comment" class="form-control"><?php echo $comment; ?></textarea>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-time">
							<div class="table-responsive">
								<table id="times" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<td class="text-left"><?php echo $entry_day;?></td>
											<td class="text-left" colspan="4"><?php echo $entry_delivery; ?></td>
											<td class="text-left" colspan="4"><?php echo $entry_takeaway; ?></td> 
											<td></td>
										</tr>
									</thead>
									<tbody>
										<?php $times_row = 0; ?>
										<?php foreach($times as $time) {?>
										<tr id="times-row<?php echo $times_row; ?>">
											<td class="text-left" style="width:10%">
												<select name="times[<?php echo $times_row; ?>][week]" class="form-control">
													<option value="1" <?php if($time['week'] == 1){?>selected="selected"<?php }?>>Mon</option>
													<option value="2"  <?php if($time['week'] == 2){?>selected="selected"<?php }?>>Tues</option>
													<option value="3"  <?php if($time['week'] == 3){?>selected="selected"<?php }?>>Wed</option>
													<option value="4"   <?php if($time['week'] == 4){?>selected="selected"<?php }?>>Thurs</option>
													<option value="5"  <?php if($time['week'] == 5){?>selected="selected"<?php }?>>Fri</option>
													<option value="6"  <?php if($time['week'] == 6){?>selected="selected"<?php }?>>Sat</option>
													<option value="0"   <?php if($time['week'] == 0){?>selected="selected"<?php }?>>Sun</option>
												</select>
											</td>
											<td class="text-left">
												<div class="input-group date">
													<input type="text" name="times[<?php echo $times_row; ?>][md_begintime]" placeholder="<?php echo $entry_begin; ?>" data-date-format="HH:mm" class="form-control" value="<?php echo $time['md_begintime']?>">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>
											<td class="text-left">
												<div class="input-group date">
													<input type="text" name="times[<?php echo $times_row; ?>][md_endtime]" placeholder="<?php echo $entry_end; ?>" data-date-format="HH:mm" class="form-control" value="<?php echo $time['md_endtime']?>">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>
											<td class="text-left">
												<div class="input-group date">
													<input type="text" name="times[<?php echo $times_row; ?>][nd_begintime]" value="<?php echo $time['nd_begintime']?>" placeholder="<?php echo $entry_begin; ?>" data-date-format="HH:mm" class="form-control" >
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>
											<td class="text-left">
												<div class="input-group date">
													<input type="text" name="times[<?php echo $times_row; ?>][nd_endtime]" value="<?php echo $time['nd_endtime']?>" placeholder="<?php echo $entry_end; ?>" data-date-format="HH:mm" class="form-control">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>
											<td class="text-left">
												<div class="input-group date">
													<input type="text" name="times[<?php echo $times_row; ?>][mt_begintime]" value="<?php echo $time['mt_begintime']?>" placeholder="<?php echo $entry_begin; ?>" data-date-format="HH:mm" class="form-control">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>
											<td class="text-left">
												<div class="input-group date">
													<input type="text" name="times[<?php echo $times_row; ?>][mt_endtime]" value="<?php echo $time['mt_endtime']?>" placeholder="<?php echo $entry_end; ?>" data-date-format="HH:mm" class="form-control">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>
											<td class="text-left">
												<div class="input-group date">
													<input type="text" name="times[<?php echo $times_row; ?>][nt_begintime]" placeholder="<?php echo $entry_begin; ?>" data-date-format="HH:mm" value="<?php echo $time['nt_begintime']?>" class="form-control">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>
											<td class="text-left">
												<div class="input-group date">
													<input type="text" name="times[<?php echo $times_row; ?>][nt_endtime]"  value="<?php echo $time['nt_endtime']?>" placeholder="<?php echo $entry_end; ?>" data-date-format="HH:mm" class="form-control">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>

											<td class="text-left">
												<button type="button" onclick="$('#times-row<?php echo $times_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i>
												</button>
											</td>
										</tr>
										<?php $times_row++; ?>
										<?php }?>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="9"></td>
											<td class="text-left"><button type="button" onclick="addTimes();" data-toggle="tooltip" title="<?php echo $button_times_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
										</tr>
									</tfoot>
								</table>
							</div>							
							<div class="table-responsive">
								<table id="unavailable" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<td></td>
											<td></td>
											<td class="text-center" colspan="2">unavailable dates</td>
											<td></td>
										</tr>
									</thead>
									<tbody>
										<?php $unavailable_row = 0; ?>
										<?php if(!empty($unavailables)) { foreach($unavailables as $unavailable) {?>
										<tr id="unavailable-row<?php echo $unavailable_row; ?>">
											<td class="text-left">
												<select name="unavailables[<?php echo $unavailable_row;?>][type][1]" class="form-control">
													<option value="0"><?php echo $text_select;?></option>
													<option value="1" <?php if(isset($unavailable['type'][1]) && $unavailable['type'][1] == 1){?>selected="selected"<?php }?>>Delivery</option>
													<option value="2" <?php if(isset($unavailable['type'][1]) && $unavailable['type'][1] == 2){?>selected="selected"<?php }?>>Pick-up</option>
												</select>
											</td>
											<td class="text-left">
												<select name="unavailables[<?php echo $unavailable_row;?>][type][2]" class="form-control">
													<option value="0"><?php echo $text_select;?></option>
													<option value="1" <?php if(isset($unavailable['type'][2]) && $unavailable['type'][2] == 1){?>selected="selected"<?php }?>>Delivery</option>
													<option value="2" <?php if(isset($unavailable['type'][2]) &&$unavailable['type'][2] == 2){?>selected="selected"<?php }?>>Pick-up</option>
												</select>
											</td>
											<td class="text-left">
												<div class="input-group datetime">
													<input type="text" placeholder="<?php echo $entry_begin; ?>" data-date-format="YYYY-MM-DD HH:mm" class="form-control"  name="unavailables[<?php echo $unavailable_row;?>][begintime]" value="<?php echo $unavailable['begintime']?>">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>											
											<td class="text-left">
												<div class="input-group datetime">
													<input type="text" placeholder="<?php echo $entry_end; ?>" data-date-format="YYYY-MM-DD HH:mm" class="form-control" name="unavailables[<?php echo $unavailable_row;?>][endtime]" value="<?php echo $unavailable['endtime']?>">
													<span class="input-group-btn">
														<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
													</span>
												</div>
											</td>

											<td class="text-left">
												<button type="button" onclick="$('#unavailable-row<?php echo $unavailable_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i>
												</button>
											</td>
										</tr>
										<?php $unavailable_row++; ?>
										<?php } }?>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="4"></td>
											<td class="text-left"><button type="button" onclick="addUnavailable();" data-toggle="tooltip" title="<?php echo $button_times_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
										</tr>
									</tfoot>
								</table>
							</div>	
							<div class="table-responsive">
								<table id="pretime" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<td>Delivery</td>
											<td>Pick-up</td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="text-left">
												<input type="text" class="form-control" name="pretime[delivery]" value="<?php echo $pretime['delivery'];?>">
											</td>	
											<td class="text-left">
												<input type="text" class="form-control" name="pretime[pickup]" value="<?php echo $pretime['pickup'];?>">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="tab-pane" id="tab-image">
							<div class="table-responsive">
								<table id="images" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<td class="text-left"><?php echo $entry_image; ?></td>
											<td class="text-right"><?php echo $entry_sort_order; ?></td>
											<td></td>
										</tr>
									</thead>
									<tbody>
										<?php $image_row = 0; ?>
										<?php foreach ($shop_images as $shop_image) { ?>
										<tr id="image-row<?php echo $image_row; ?>">
											<td class="text-left"><a href="" id="thumb-image<?php echo $image_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $shop_image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="shop_image[<?php echo $image_row; ?>][image]" value="<?php echo $shop_image['image']; ?>" id="input-image<?php echo $image_row; ?>" /></td>

											<td class="text-right"><input type="text" name="shop_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $shop_image['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>

											<td class="text-left"><button type="button" onclick="$('#image-row<?php echo $image_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
										</tr>
										<?php $image_row++; ?>
										<?php } ?>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="9"></td>
											<td class="text-left"><button type="button" onclick="addImage();" data-toggle="tooltip" title="<?php echo $button_image_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>						
						<div class="tab-pane" id="tab-info">
							<div class="table-responsive">
								<table id="infos" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<td class="text-left"><?php echo $tab_info; ?></td>
											<td></td>
										</tr>
									</thead>
									<tbody>
										<?php $info_row = 0; ?>
										<?php foreach ($infos as $info) { ?>
										<tr id="info-row<?php echo $info_row; ?>">
											<td class="text-left"><textarea name="infos[<?php echo $info_row;?>]" rows="5" placeholder="" id="input-comment" class="form-control"><?php echo $info['info'];?></textarea></td>
											<td class="text-left"><button type="button" onclick="$('#info-row<?php echo $info_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
										</tr>
										<?php $info_row++; ?>
										<?php } ?>
									</tbody>
									<tfoot>
										<tr>
											<td></td>
											<td class="text-left"><button type="button" onclick="addInfo();" data-toggle="tooltip" title="<?php echo $button_image_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	// tag
	$('input[name=\'tag_ids\']').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=localisation/location/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
				dataType: 'json',     
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['tag_id']
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('input[name=\'tag_ids\']').val('');
			
			$('#tag' + item['value']).remove();
			
			$('#tag').append('<div id="tag' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="tag_ids[]" value="' + item['value'] + '" /></div>');  
		}
	});

	$('#tag').delegate('.fa-minus-circle', 'click', function() {
		$(this).parent().remove();
	});	
	// coupon
	$('input[name=\'coupon_ids\']').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=localisation/coupon/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
				dataType: 'json',     
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['shop_coupon_id']
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('input[name=\'coupon_ids\']').val('');
			
			$('#coupon' + item['value']).remove();
			
			$('#coupon').append('<div id="coupon' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="coupon_ids[]" value="' + item['value'] + '" /></div>');  
		}
	});

	$('#coupon').delegate('.fa-minus-circle', 'click', function() {
		$(this).parent().remove();
	});

	$('input[name=\'geo\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=localisation/geo_zone/autoComplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					geo_zone_id: 0,
					name: '<?php echo $text_none; ?>'
				});

				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['geo_zone_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'geo\']').val(item['label']);
		$('input[name=\'geo_zone_id\']').val(item['value']);
	}
});
	$('input[name=\'staff\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=localisation/location/autoUserComplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				json.unshift({
					user_id: 0,
					name: '<?php echo $text_none; ?>'
				});

				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['user_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'staff\']').val(item['label']);
		$('input[name=\'user_id\']').val(item['value']);
	}
});
</script>
  <script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
	html  = '<tr id="image-row' + image_row + '">';
	html += '  <td class="text-left"><a href="" id="thumb-image' + image_row + '"data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /><input type="hidden" name="shop_image[' + image_row + '][image]" value="" id="input-image' + image_row + '" /></td>';
	html += '  <td class="text-right"><input type="text" name="shop_image[' + image_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + image_row  + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';
	
	$('#images tbody').append(html);
	
	image_row++;
}
//--></script>  
 <script type="text/javascript"><!--
var info_row = <?php echo $info_row; ?>;

function addInfo() {
	html  = '<tr id="info-row' + info_row + '">';
	html +='<td class="text-left"><textarea name="infos['+info_row+']" rows="5" placeholder="" id="input-comment" class="form-control"></textarea></td>';

	html += '  <td class="text-left"><button type="button" onclick="$(\'#info-row' + info_row  + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';

	html += '</tr>';
	
	$('#infos tbody').append(html);
	
	info_row++;
}
//--></script> 
<script type="text/javascript"><!--
var times_row = <?php echo $times_row; ?>;

function addTimes() {
	html = '<tr id="times-row'+ times_row+'">';
		html += '<td class="text-left"><select name="times['+times_row+'][week]" class="form-control">';
		html +='<option value="1" selected="selected">Mon</option><option value="2">Tues</option><option value="3">Wed</option><option value="4" >Thurs</option><option value="5">Fri</option><option value="6">Sat</option><option value="7" >Sun</option>';
		html +='</select>';
		html += '</td>';
		html += '<td class="text-left">';
		html += '<div class="input-group date">';
		html += '<input type="text" name="times['+times_row+'][md_begintime]" placeholder="<?php echo $entry_begin; ?>" data-date-format="HH:mm" class="form-control" value="">';
		html += '<span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td>';
		html += '<td class="text-left"><div class="input-group date">';
		html += '<input type="text" name="times['+times_row+'][md_endtime]" placeholder="<?php echo $entry_end; ?>" data-date-format="HH:mm" class="form-control" value=""><span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left"><div class="input-group date">';
		html += '<input type="text" name="times['+times_row+'][nd_begintime]" value="" placeholder="<?php echo $entry_begin; ?>" data-date-format="HH:mm" class="form-control" ><span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left"><div class="input-group date">';
		html += '<input type="text" name="times['+times_row+'][nd_endtime]" value="" placeholder="<?php echo $entry_end; ?>" data-date-format="HH:mm" class="form-control"><span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left"><div class="input-group date">';
		html += '<input type="text" name="times['+times_row+'][mt_begintime]" value="" placeholder="<?php echo $entry_begin; ?>" data-date-format="HH:mm" class="form-control"><span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left"><div class="input-group date">';
		html += '<input type="text" name="times['+times_row+'][mt_endtime]" value="" placeholder="<?php echo $entry_end; ?>" data-date-format="HH:mm" class="form-control"><span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left"><div class="input-group date">';
		html +='<input type="text" name="times['+times_row+'][nt_begintime]" placeholder="<?php echo $entry_begin; ?>" data-date-format="HH:mm" value="" class="form-control"><span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left"><div class="input-group date">';
		html += '<input type="text" name="times['+times_row+'][nt_endtime]"  value="" placeholder="<?php echo $entry_end; ?>" data-date-format="HH:mm" class="form-control"><span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left">';

		html += '<button type="button" onclick="$(\'#times-row'+times_row+'\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td></tr>';
	$('#times tbody').append(html);

	$('.date').datetimepicker({
		pickDate: false
	});	
	$('.datetime').datetimepicker({
		pickTime:false
	});
		
	times_row++;
}
//--></script> 

<script type="text/javascript"><!--
var unavailable_row = <?php echo $unavailable_row; ?>;

function addUnavailable() {

	html = '<tr id="unavailable-row'+unavailable_row+'">';

	

	html +='<td class="text-left">';
			
	html += '<select name="unavailables['+unavailable_row+'][type][1]" class="form-control">';
	html += '<option value="0"><?php echo $text_select;?></option>';
	html += '<option value="1">Delivery</option>';
	html +='<option value="2">Pick-up</option></select></td><td class="text-left">';
	html +='<select name="unavailables['+unavailable_row+'][type][2]" class="form-control">';
	html +='<option value="0"><?php echo $text_select;?></option>';
	html += '<option value="1">Delivery</option>';
	html +='<option value="2">Pick-up</option></select></td>';

	html+='<td class="text-left">';

	html+= '<div class="input-group datetime">';

	html+='<input type="text" placeholder="<?php echo $entry_begin; ?>" data-date-format="YYYY-MM-DD HH:mm" class="form-control"  name="unavailables['+unavailable_row+'][begintime]">';

	html+='<span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left"><div class="input-group datetime">';

	html+='<input type="text" placeholder="<?php echo $entry_end; ?>" data-date-format="YYYY-MM-DD HH:mm" class="form-control"  name="unavailables['+unavailable_row+'][endtime]">';

	html+='<span class="input-group-btn"><button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button></span></div></td><td class="text-left">';

	html += '<button type="button" onclick="$(\'#unavailable-row'+unavailable_row+'\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td></tr>';



	$('#unavailable tbody').append(html);

	$('.date').datetimepicker({
		pickDate: false
	});	
	$('.datetime').datetimepicker({
		pickTime:true,
		pickDate:true
	});
		
	unavailable_row++;
}
//--></script> 

<script>
	$('.date').datetimepicker({
		pickDate: false
	});	
	$('.datetime').datetimepicker({
		pickTime:true,
		pickDate:true
	});
</script>
<?php echo $footer; ?>