<?php
class ModelPayCheckout extends Model {
	/**
	 * 检查是否第一次购买
	 * @param  string $shipping_address_1 [地址1]
	 * @param  string $shipping_address_2 [地址2]
	 * @param  string $shipping_email              [用户填写email]
	 * @param  string $location_id    [店铺ID]
	 * @return  bool                     [description]
	 */
	public function checkFirst($shipping_address_1="", $shipping_address_2="", $shipping_email="", $location_id) {

		$is_first = 0;

		if (!empty($shipping_email)) {

			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order WHERE shipping_email = '".$shipping_email."' AND store_id = '" . (int)$location_id . "'");
			$is_first =  $query->num_rows;

		}

		if(!$is_first && !empty($shipping_address_1) && !empty($shipping_address_2)) {

			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order WHERE shipping_address_1 = '".$shipping_address_1."' AND shipping_address_2 = '".$shipping_address_2."' AND store_id = '" . (int)$location_id . "'");
			$is_first = $query->num_rows;
		}

		return $is_first;
	}
}