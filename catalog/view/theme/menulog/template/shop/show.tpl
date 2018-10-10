<?php echo $header;?>
<div class="content">
	<div class="minor contentBody">
		<div class="userRatingsPage">
			<h1>Reviews by <?php echo $name;?></h1>
			<div class="userRatings">
				<ul class="ratingList">
					<?php foreach($reviews as $review){ ?>
					<li>
						<div class="restaurantInfo">
							<h2><a href="<?php echo $review['shop_url'];?>"><?php echo $review['shop_name'];?></a></h2> - <?php echo $review['address'];?></div>
						<div class="ratingContent">
							<p>
								<strong>Overall <?php echo $review['avg_rating'];?> - </strong> Food <?php echo $review['rating'];?>, Value <?php echo $review['rating1'];?>, Speed <?php echo $review['rating2'];?> </p>
							<p class="noSpaceBelow"><?php echo $review['text'];?>&nbsp; (<?php echo $name;?> - <?php echo $review['date_added']?>)</p>
						</div>
					</li>
					<?php }?>
				</ul>
			</div>
			<div class="userInfo">
				<img src="https://www.menulog.com.au/images/content/default_user_photo.gif" style="width: 200px; height: 126px;">
			</div>
			<div class="contentEnd"></div>
			<?php echo $pagination;?>
		</div>
<?php echo $footer;?>
