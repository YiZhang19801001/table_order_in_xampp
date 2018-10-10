<?php echo $header; ?>
<style>
	.cuisineNameList{
			text-overflow: ellipsis;
			overflow: hidden;
			white-space: nowrap;
			width: 70px;
		} 
		.restDetails{
			width: 230px;
		}
</style>
<div class="sitemapPage">
	<div id="takeawayPage" class="pageBody">
		<div class="content">
			<div class="minor contentBody">
				<div class="seoSection majorRegion">
					<div class="consumerFavourites">
						<div class="consumerFavouritesTitle">
							<p><strong>Consumer favourite delivery  restaurants in Adelaide</strong></p>
						</div>
						<table id="searchResultsTableResults">
							<tbody>
							<?php foreach ($shops as $shop) {  ?>
								<tr>
									<td>
										<div class="content">
											<div class="colLogo">
												<a href="<?php echo $shop['href'];?>" class="restaurantLink" ><img src="<?php echo $shop['image']; ?>"></a>
											</div>
											<div class="colName">
												<h2><a class="restaurantLink restaurantName"  href="<?php echo $shop['href'];?>" title="<?php echo $shop['name']; ?>"><?php echo $shop['name']; ?></a></h2>
												<div class="restDetails">
													<span class="venueCuisines">
													<span class="icon-food"></span>
													<div class="cuisineNameList" title="<?php echo $shop['tag_names']; ?>"><?php echo $shop['tag_names']; ?></div>
													</span>
													<span class="openingHours">
													<span class="icon-clock"></span>
													<div class="todaysSchedule" title="<?php echo $shop['open'];?>"><?php echo $shop['open'];?></div>
													<span class="contentEnd"></span>
													</span>
												</div>
												<div class="minOrder">
													Min order <?php echo $shop['consume']; ?>
												</div>
												<div class="contentEnd"></div>
												<div class="distance">
													<span class="icon-location"></span> <?php echo $shop['area_name']?>
												</div>
												<div data-venuelink="#"  class="promotionsWrapper">
													<div class="discountsWrapper">
														<?php foreach($shop['shop_coupons'] as $k => $shop_coupon) { if($k>1){?>
														<div class="discounts"> ... </div>
														<?php break;}else{?>
														<div class="discounts">
															<span class="uppercase"><?php echo $shop_coupon['name']; ?></span>
														</div>
														<?php }} ?>
													</div>
												</div>
												<!-- .promotionsWrapper -->
											</div>
											<div class="colRating">
												<div class="ratingLink">
													<a href="/viva-pizzeria#reviews" data-restaurant-id="75213" class="restaurantLink ratingStars">
														<span class="star greenStarFull">b</span><span class="star greenStarFull">b</span><span class="star greenStarFull">b</span><span class="star greenStarFull">b</span><span class="star greenStarHalf">b</span>
													</a>
													<a href="/viva-pizzeria#reviews" data-restaurant-id="75213" class="restaurantLink ratingCount">(137) <i class="fa fa-angle-right"></i></a>
												</div>
												<div class="ratingScore">
													<span class="icon-delivery"></span> 8.6
												</div>
											</div>
											<div class="btnOrder">
												<div class="btnSearchOrderVenue See Menu"><a href="<?php echo $shop['href'];?>" class="restaurantLink orderButton">See Menu <span class="icon-forward"></span></a></div>
											</div>
											<div class="contentEnd"></div>
										</div>
									</td>
								</tr>
								<?php } ?>
							</tbody>
						</table>
					</div>
					<div class="contentEnd"></div>
				</div>
				<a href="#" class="backLink">Back to Browse</a>
			</div>
		</div>
	</div>
</div>
<?php echo $footer; ?>