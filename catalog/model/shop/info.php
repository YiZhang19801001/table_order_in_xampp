<?php
class ModelShopInfo extends Model {

	public function getTagNameByid($tag_ids) {

		$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "shop_tag WHERE status = 1 AND tag_id in (" . $tag_ids . ")");
		
		return $query->rows;
	}

	public function getShopImages($location_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shop_image WHERE location_id = '" . (int)$location_id . "' ORDER BY sort_order DESC");

		return $query->rows;
	}

	public function getTag($tag_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "shop_tag` WHERE  `status`  = 1 AND tag_id = '" . (int)$tag_id . "'");
		
		return $query->row;
	}

	public function getShopTimes($location_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shop_time WHERE location_id = '" . (int)$location_id . "'");

		$result = array('times'=>'','unavailable'=>'','pretime'=>'');

		if($query->row['times']) {
			$result['times'] = unserialize( $query->row['times'] );
			$result['unavailable'] = unserialize( $query->row['unavailable'] );
			$result['pretime'] = unserialize( $query->row['pretime'] );
		}
		return $result;
	}

	public function getCoupon($shop_coupon_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "shop_coupon WHERE shop_coupon_id = '" . (int)$shop_coupon_id . "' AND status = 1 ORDER BY sort_order ASC");

		return $query->row;
	}

	public function getCatalog($location_id) {
		$query = $this->db->query("SELECT  c.category_id,cd.name,cd.description FROM " . DB_PREFIX . "category c LEFT JOIN ". DB_PREFIX ."category_description cd ON(c.category_id = cd.category_id) WHERE cd.language_id =  1 AND c.location_id = '" . (int)$location_id . "' ORDER BY c.sort_order ASC");

		return $query->rows;
	}

	public function getProducts($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2c.category_id = '" . (int)$category_id ."' AND p.status = 1 ORDER BY p.sort_order ASC");

		$this->load->model('tool/image');


		$result = array();
		$products = $query->rows;
		if(!empty($products)) {
			foreach ($products as  $value) {

				$price = array();
				//images
				$img = "";
				if(is_file(DIR_IMAGE . $value['image'])){

					$img = $this->model_tool_image->resize($value['image'], 400, 300);
				}

				$option = self::getProductOptions($value['product_id']);

				$ext_array = array();
				$ext = array();

				$ext_array = self::getProductExts($value['product_id']);

				if(!empty($ext_array)) {

					foreach ($ext_array as $v) {

						$type_info = array();
						$type_info  = self::getProductAddType($v['type']);

						$ext[$type_info['name']]['exts'][] = array(
							'product_ext_id' => $v['product_ext_id'],
							'name' => $v['name'],
							'price' => $this->currency->format($v['price'])
						);
						$ext[$type_info['name']]['required'] = $type_info['required'];
						$ext[$type_info['name']]['type'] = $type_info['type'];
						$ext[$type_info['name']]['checkbox'] = $type_info['checkbox'];
					}
				}

				if(empty($option)) {

					$price[] = array(
						"name" => "",
						"price" => $this->currency->format($value['price']),
						"option_id" => 0,
						"option_value_id" => 0,
						'ext'=>$ext
					);
				} else {
					foreach ($option as $v) {

						if($v['price_prefix'] == "+") {
							$total_price = $value['price'] + $v['price'];
						} elseif ($v['price_prefix'] == "-" ) {
							$total_price = $value['price'] - $v['price'];
						}

						$price[] = array(
							"name" => $v['name'],
							"price" => $this->currency->format($total_price),
							"option_id" => $v['product_option_id'],
							"option_value_id" => $v['product_option_value_id'],
							'ext' => $ext
						);
					}
				}

				$popular =$hot = $veg = $health =  false;
				if( !empty($value['product_tags']) ) {

					$product_tags = explode(',', $value['product_tags']);

					foreach ($product_tags as  $tag) {

						$tag_info = self::getProductTag((int)$tag);

						if($tag_info['name'] == "popular") {
							$popular = true;
						} 
						if($tag_info['name'] == "hot") {
							$hot = true;
						}
						if($tag_info['name'] == "veg") {
							$veg = true;
						} 
						if($tag_info['name'] == "health") {
							$health = true;
						}
					}
				}

				$result[] = array(
					"id"=> $value['product_id'],
					"subtitle"=>htmlspecialchars_decode($value['name']),
					'is_discount'=>$value['is_discount'],
					"img" => $img,
					"description" => htmlspecialchars_decode ($value['description']),
					"price" => $price,
					"special" =>array(
						"popular" => $popular,
						"hot" => $hot,
						"veg" => $veg,
						"health" => $health
					),
				);
			}
		}
		return $result;
	}

	public function getProductAttributes($product_id) {
		$product_attribute_data = array();

		$product_attribute_query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' GROUP BY attribute_id");

		foreach ($product_attribute_query->rows as $product_attribute) {
			$product_attribute_description_data = array();

			$product_attribute_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");

			foreach ($product_attribute_description_query->rows as $product_attribute_description) {
				$product_attribute_description_data[$product_attribute_description['language_id']] = array('text' => $product_attribute_description['text']);
			}

			$product_attribute_data[] = array(
				'attribute_id'                  => $product_attribute['attribute_id'],
				'product_attribute_description' => $product_attribute_description_data
			);
		}

		return $product_attribute_data;
	}

	public function getProductOptions($product_id) {
		$product_option_data = array();

		$sql = "SELECT * FROM " . DB_PREFIX ."product_option_value pv LEFT JOIN " . DB_PREFIX . "option_value_description od ON (od.option_value_id = pv.option_value_id) WHERE  pv.option_id = 1 AND od.language_id = '" . (int)$this->config->get('config_language_id') ."' AND pv.product_id = ". (int)$product_id;
		$query = $this->db->query($sql);

		$result = $query->rows;

		return $result;
	}

	public function getDeliverys($geo_zone_id,$location_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$geo_zone_id . "'");
		$deliverys = $query->rows; 
		$result = array();

		if(!empty($deliverys)) {
			$areaList = array();
			foreach ($deliverys as $v) {
				$suburb_info = self::getSuburbInfo($v['suburb_id']);
				$areaList[] = array(
					"id"=>$v['suburb_id'],
					"name"=>$suburb_info['name']
				); 
			}

			$zone_id = 0;
			$isp = 0;
			if(!empty($this->session->data['zone_id'])) {
				$zone_id = $this->session->data['zone_id'];
			}			

			if(!empty($this->session->data['isp'])) {
				$isp = $this->session->data['isp'];
			}else{
				$isp = 1;
			}

			if(!empty($this->session->data['shipping_address']['orderDate'])) {
				$shipping_orderDate = $this->session->data['shipping_address']['orderDate'];
			}else{
				$shipping_orderDate = "";
			}

			if(!empty($this->session->data['shipping_address']['orderTime'])) {
				$shipping_orderTime = $this->session->data['shipping_address']['orderTime'];
			}else{
				$shipping_orderTime = "";
			}

			$result = array(
				"id" => (int)$geo_zone_id,
				"isp"=> (int)$isp,
				"shipping_orderDate"=>$shipping_orderDate,
				"shipping_orderTime"=>$shipping_orderTime,
				"zone_id" => (int)$zone_id,
				"geo_zone_id" => (int)$geo_zone_id,
				'areaList'=> $areaList
			);
		}
		return $result;
	}

	public function getSuburbInfo($suburb_id) {
		$query = $this->db->query("SELECT  * FROM " . DB_PREFIX . "suburb WHERE suburb_id = '" . (int)$suburb_id . "'");
		return $query->row;
	}

	public function getCountry($country_id) {
		$query = $this->db->query("SELECT  * FROM " . DB_PREFIX . "country WHERE country_id = '" . (int)$country_id . "'");
		return $query->row;
	}

	public function getState($state_id) {
		$query = $this->db->query("SELECT  * FROM " . DB_PREFIX . "state WHERE state_id = '" . (int)$state_id . "'");
		return $query->row;
	}

	public function getProductTag($product_tag_id) {

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_tag` WHERE  product_tag_id = '" . (int)$product_tag_id . "'");
		return $query->row;
	}

	public function getDeliveryFee($geo_zone_id,$suburb_id){
		$query = $this->db->query("SELECT fee FROM `" . DB_PREFIX . "zone_to_geo_zone` WHERE  geo_zone_id = '" . (int)$geo_zone_id . "' AND suburb_id = '".(int)$suburb_id."'");

        		if (!empty($query->row['fee'])) {
			return $query->row['fee'];
		} else {
			return 0;
		}
	}

	public function getCouponFee($coupon_array) {


		$result = array('price'=>0,'is_use'=>false);

		if(!empty($coupon_array)) {
			if(!empty($coupon_array['coupon_id'])) {

				$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "shop_coupon WHERE shop_coupon_id = '" . (int)$coupon_array['coupon_id'] . "'");

				if( $query->num_rows ) {
					$coupon_info = $query->row;
					//type
					if ((int)$coupon_info['type'] == 1) {
						//首次减免
						$result['price'] = $coupon_array['price'] * ($coupon_info['discount']/100);
						if(($coupon_array['times']+1) == ($coupon_info['times']) && $this->customer->getId()) {

							$result['is_use'] = true;
						}
					} elseif ((int)$coupon_info['type'] == 2) {

					} elseif ((int)$coupon_info['type'] == 3) {

						//totalprice从第m+1条开始，取n条

						$result['totalPrice'] = 0;//累加总价
						$result['currentPrice'] = $coupon_array['price']/$coupon_info['times'];//现在单的价格

						
						$m = $coupon_array['times'] % ($coupon_info['times']+1);
						$result['n'] = $n = $coupon_info['times'] - $m;
						$query = $this->db->query("SELECT total FROM `" . DB_PREFIX . "order` WHERE customer_id = '" . (int)$this->customer->getId() . "'  AND order_status_id = 3    ORDER BY order_id DESC LIMIT 0,".(int)$m);
						
						if ($query->num_rows) {
							$query_total = 0;
							foreach ($query->rows as $key => $value) {
								$query_total += $value['total'];
							}

							$result['totalPrice']= $query_total/$coupon_info['times'] + $result['currentPrice']; 
						}

						if($m == $coupon_info['times']) {
							$result['totalPrice']= $query_total/$coupon_info['times'];
						}

						if ($result['totalPrice'] == 0) {

							$result['totalPrice'] = $result['currentPrice'];
						}

						if($m == $coupon_info['times'] ){

							$result['is_use'] = true;

							$result['price'] = $result['totalPrice'];
						}
						
					}
					$result['type'] = $coupon_info['type'] ;
				}
			}
		}
		return $result;
	}

	public function getProductExt($product_id,$product_option_value_id = 0) {
		$product_ext_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_ext WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_ext_data[] = array(
				'product_ext_id' => $result['product_ext_id'],
				'type'  => $result['type'],
				'name'   => $result['name'],
				'price' => $result['price'],
			);
		}

		return $product_ext_data;
	}

	public function getProductExts($product_id) {
		$product_ext_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_ext WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {


				$product_ext_data[] = array(
					'product_ext_id' => $result['product_ext_id'],
					'type'  => $result['type'],
					'name'   => $result['name'],
					'price' => $result['price'],
				);
			
		}

		return $product_ext_data;
	}

	public function getProductAddType($add_type_id) {

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_add_type` WHERE  add_type_id = '" . (int)$add_type_id . "'");
		return $query->row;
	}

	public function getShopInfos($location_id) {
		$query = $this->db->query("SELECT info FROM " . DB_PREFIX . "shop_info WHERE location_id = '" . (int)$location_id . "'");
		
		return $query->rows;
	}

	public function getCouponProduct($product_id) {
		$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "shop_coupon_product WHERE product_id in (" . $product_id . ")");
		
		return $query->rows;
	}
}