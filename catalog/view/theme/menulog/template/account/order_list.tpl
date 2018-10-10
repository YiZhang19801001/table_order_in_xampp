<?php echo $header;?>
<div class="content">
	<div class="myOrders minor contentBody">
		<div id="pastOrders">
			<div id="pastOrdersList" class="venueList">
				<?php foreach($orders as $key => $order){?>

				<div class="pastOrdersListRow pastOrdersListRowEven" style="position: relative">
					<div class="col0">
						<a href="<?php echo $order['store_url'];?>" data-restaurant-name="Doytao Thai Restaurant Croydon" class="venueListLink">
							<img src="<?php echo $order['store_pic'];?>" class="logo" alt="logo">
						</a>
					</div>
					<div class="col1">
						<h3 class="restName"><a href="<?php echo $order['store_url'];?>"  class="venueListLink"><?php echo $order['store_name'];?></a></h3>
						<span class="orderTime">Ordered on</span> <?php echo $order['date_added'];?>
						<p>
							<span class="orderItems">
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
						</p>
						<p class="orderPrice">Total: <?php echo $order['total'];?></p>
						<p style="color: red;    margin-top: 5px;" class="restName"><?php if($order['order_status']){echo $order['order_status'];}?></p>
						<div class="loyaltyProgress">
						</div>
					</div>
					<div class="col2">
						<span class="orderAgain">
						<a href="<?php echo $order['reorder'];?>" class="button" >Order Again</a>
					</span>
					<?php if(!$order['review_info']) {?>
						<span class="orderAgain orderReview"><a class="addReview venueListLink secondaryButton" href="<?php echo $order['review_url'];?>">Add Review</a></span>
					<?php }else{ ?>
						<span class="orderReview">
							<span>Your rating: <?php echo $order['review_info']['avg_rating']; ?>/10</span>
							<a onclick="show(<?php echo $key ?>)" class="readOrderReviewLink">Read your review</a>
						</span>
					<?php }?>
						<?php if($order['review_info']) {?>
						<div class="core-popoverBox core-popoverNoTitle core-popoverHelper pastOrderReviews core-popover core-popoverFocused listTag<?php echo $key ?>"
							 style="z-index: 10000; max-width: 255px; width: 255px; position: absolute; top: 5px; left: 557px; display: block; visibility: visible; opacity: 1;display: none">
							<div class="core-popoverArrow">
								<div class="core-outer"
									 style="width: 0px; height: 0px; border-width: 8px 0px 8px 12px; border-right-color: transparent; border-bottom-color: transparent;border-top-color: transparent; left: 295px; top: 41px;">
									<div class="core-inner"
										 style="width: 0px; height: 0px; border-width: 6px 0px 6px 10px; border-right-color: transparent; border-bottom-color: transparent; border-top-color: transparent; left: -12px; top: -6px;"></div>
								</div>
							</div>
							<a class="core-closeX" onclick="hide(<?php echo $key ?>)"></a>
							<div class="core-contentBox core-contentBoxNoTitle">
								<div class="pastOrderReviewBox">
									<div class="orderReviewComment">
										<p><strong>Overall-<?php echo $order['review_info']['avg_rating'];?> </strong>Food <?php echo $order['review_info']['rating'];?>, Value <?php echo $order['review_info']['rating1'];?>, Speed <?php echo $order['review_info']['rating2'];?></p>
										<p class="noSpaceBelow"> (<?php echo $order['review_info']['date_add'];?>)</p>
									</div>
									<div class="orderReviewStatus">
										<strong>Review status - </strong> active
									</div>
								</div>
							</div>
						</div>
						<?php }?>
					</div>
				</div>
				<div class="contentEnd">
			</div>
			<?php }?>
			<?php echo $pagination; ?>

<script>
    function show(index)
	{
	    $('.listTag'+ index).show();
	}
    function hide(index)
    {
        $('.listTag'+ index).hide();
    }
</script>

<?php echo $footer;?>



