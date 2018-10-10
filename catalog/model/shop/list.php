<?php
class ModelShopList extends Model {

	public function getTagNameByid($tag_ids) {

		$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "shop_tag WHERE status = 1 AND tag_id in (" . $tag_ids . ")");
		
		return $query->rows;
	}

	public function getAreaNameByCode($geocode) {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE code = '" . $geocode . "' AND status = '1' LIMIT 1");

		return $query->row;
	}

	public function getShopCoupon($shop_coupon_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shop_coupon WHERE date_start < NOW() AND date_end > NOW() AND status = 1 AND shop_coupon_id = '" . (int)$shop_coupon_id . "'");

		return $query->row;
	}

}