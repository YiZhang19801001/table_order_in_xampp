<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
	<div class="container-fluid">
	  <div class="pull-right">
		<button type="submit" form="form-coupon" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-coupon" class="form-horizontal">
		  <div class="tab-content">
			<div class="tab-pane active" id="tab-general">
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
				<label class="col-sm-2 control-label" for="input-type"><?php echo $entry_type; ?></label>
				<div class="col-sm-10">
				  <select name="type" id="input-type" class="form-control">
					<?php if ($type == '1') { ?>
					<option value="1" selected="selected"><?php echo $text_percent; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_percent; ?></option>
					<?php } ?>
					<?php if ($type == '2') { ?>
					<option value="2" selected="selected"><?php echo $text_amount; ?></option>
					<?php } else { ?>
					<option value="2"><?php echo $text_amount; ?></option>
					<?php } ?>
					<?php if ($type == '3') { ?>
					<option value="3" selected="selected"><?php echo $text_times; ?></option>
					<?php } else { ?>
					<option value="3"><?php echo $text_times; ?></option>
					<?php } ?>
				  </select>
				  <?php if ($error_type) { ?>
				  <div class="text-danger"><?php echo $error_type; ?></div>
				  <?php } ?>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-discount"><span data-toggle="tooltip" title="<?php echo $help_discount; ?>"><?php echo $entry_discount; ?></span></label>
				<div class="col-sm-10">
				  <input type="text" name="discount" value="<?php echo $discount; ?>" placeholder="<?php echo $entry_discount; ?>" id="input-discount" class="form-control" />
				  <?php if ($error_discount) { ?>
				  <div class="text-danger"><?php echo $error_discount; ?></div>
				  <?php } ?>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-times"><span data-toggle="tooltip" title="<?php echo $help_times; ?>"><?php echo $entry_times; ?></span></label>
				<div class="col-sm-10">
				  <input type="text" name="times" value="<?php echo $times; ?>" placeholder="<?php echo $entry_times; ?>" id="input-times" class="form-control" />
				  <?php if ($error_times) { ?>
				  <div class="text-danger"><?php echo $error_times; ?></div>
				  <?php } ?>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-total"><span data-toggle="tooltip" title="<?php echo $help_total; ?>"><?php echo $entry_total; ?></span></label>
				<div class="col-sm-10">
				  <input type="text" name="total" value="<?php echo $total; ?>" placeholder="<?php echo $entry_total; ?>" id="input-total" class="form-control" />
				  <?php if ($error_total) { ?>
				  <div class="text-danger"><?php echo $error_total; ?></div>
				  <?php } ?>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-max"><?php echo $entry_max; ?></label>
				<div class="col-sm-10">
				  <input type="text" name="max_amount" value="<?php echo $max_amount; ?>" placeholder="<?php echo $entry_max; ?>" id="input-max" class="form-control" />
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-product"><span data-toggle="tooltip" title="<?php echo $help_product; ?>"><?php echo $entry_product; ?></span></label>
				<div class="col-sm-10">
				  <input type="text" name="product" value="" placeholder="<?php echo $entry_product; ?>" id="input-product" class="form-control" />
				  <div id="coupon-product" class="well well-sm" style="height: 150px; overflow: auto;">
					<?php foreach ($coupon_product as $coupon_product) { ?>
					<div id="coupon-product<?php echo $coupon_product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $coupon_product['name']; ?>
					  <input type="hidden" name="coupon_product[]" value="<?php echo $coupon_product['product_id']; ?>" />
					</div>
					<?php } ?>
				  </div>
				 <?php if ($error_coupon_product) { ?>
				  <div class="text-danger"><?php echo $error_coupon_product; ?></div>
				  <?php } ?>
				</div>
			  </div>
			  <div class="form-group">
					<label class="col-sm-2 control-label" for="input-info"><?php echo $entry_info;?></label>
					<div class="col-sm-10">
					  <textarea name="info" rows="5" placeholder="<?php echo $entry_info;?>" id="input-info" class="form-control"><?php echo $info; ?></textarea>
					</div>
				</div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-date-start"><?php echo $entry_date_start; ?></label>
				<div class="col-sm-3">
				  <div class="input-group date">
					<input type="text" name="date_start" value="<?php echo $date_start; ?>" placeholder="<?php echo $entry_date_start; ?>" data-date-format="YYYY-MM-DD" id="input-date-start" class="form-control" />
					<span class="input-group-btn">
					<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
					</span></div>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-date-end"><?php echo $entry_date_end; ?></label>
				<div class="col-sm-3">
				  <div class="input-group date">
					<input type="text" name="date_end" value="<?php echo $date_end; ?>" placeholder="<?php echo $entry_date_end; ?>" data-date-format="YYYY-MM-DD" id="input-date-end" class="form-control" />
					<span class="input-group-btn">
					<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
					</span></div>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
				<div class="col-sm-10">
				  <select name="status" id="input-status" class="form-control">
					<?php if ($status) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-sort_order"><?php echo $entry_order; ?></label>
				<div class="col-sm-10">
				  <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_order; ?>" id="input-sort_order" class="form-control" />
				</div>
			  </div>
			</div>
		  </div>
		</form>
	  </div>
	</div>
  </div>
  <script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=localisation/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',			
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'product\']').val('');
		
		$('#coupon-product' + item['value']).remove();
		
		$('#coupon-product').append('<div id="coupon-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="coupon_product[]" value="' + item['value'] + '" /></div>');	
	}
});

$('#coupon-product').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
</script>
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script></div>
<?php echo $footer; ?>