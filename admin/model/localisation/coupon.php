<?php
class ModelLocalisationCoupon extends Model {
	public function addCoupon($data) {

		if($data['coupon_product']) {
			$coupon_product = implode(',', $data['coupon_product']);
		} else {
			$coupon_product = "";
		}

		$this->db->query("INSERT INTO " . DB_PREFIX . "shop_coupon SET name = '" . $this->db->escape($data['name']) . "', discount = '" . (float)$data['discount'] . "', type = '" . $this->db->escape($data['type']) . "', total = '" . (float)$data['total']. "', max_amount = '" . (float)$data['max_amount'] . "', times = '" . (int)$data['times'] ."', coupon_product_ids = '" . $coupon_product . "', date_start = '" . $this->db->escape($data['date_start']) . "', date_end = '" . $this->db->escape($data['date_end']) .  "', status = '" . (int)$data['status'] .  "', sort_order = '" . (int)$data['sort_order'] ."', info = '" . $this->db->escape($data['info']) . "', date_added = NOW()");

		return $coupon_id;
	}

	public function editCoupon($shop_coupon_id, $data) {

		if($data['coupon_product']) {
			$coupon_product = implode(',', $data['coupon_product']);
		} else {
			$coupon_product = "";
		}
		$this->db->query("UPDATE " . DB_PREFIX . "shop_coupon SET name = '" . $this->db->escape($data['name']) .  "', discount = '" . (float)$data['discount'] . "', type = '" . $this->db->escape($data['type']) . "', total = '" . (float)$data['total'] . "', max_amount = '" . (float)$data['max_amount'] . "', times = '" . (int)$data['times'] . "', coupon_product_ids = '" . $coupon_product . "', date_start = '" . $this->db->escape($data['date_start']) . "', date_end = '" . $this->db->escape($data['date_end']) ."', status = '" . (int)$data['status'] ."', sort_order = '" . (int)$data['sort_order'] ."', info = '" . $this->db->escape($data['info'])  . "' WHERE shop_coupon_id = '" . (int)$shop_coupon_id . "'");

	}

	public function deleteCoupon($shop_coupon_id) {

		$this->db->query("DELETE FROM " . DB_PREFIX . "shop_coupon WHERE shop_coupon_id = '" . (int)$shop_coupon_id . "'");
	}

	public function getCoupon($shop_coupon_id,$flag=0) {
		if($flag = 0){

			$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "shop_coupon WHERE shop_coupon_id = '" . (int)$shop_coupon_id . "' AND status = 1");
		}else{
			$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "shop_coupon WHERE shop_coupon_id = '" . (int)$shop_coupon_id . "'");
		}

		return $query->row;
	}

	public function getCoupons($data = array(),$flag = 0) {
		$sql = "SELECT * FROM " . DB_PREFIX . "shop_coupon ";

		if($flag){
			$sql = "SELECT * FROM " . DB_PREFIX . "shop_coupon WHERE status = 1";
		}

		$sort_data = array(
			'name',
			'discount',
			'date_start',
			'date_end',
			'sort_order',
			'status'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getCouponProducts($shop_coupon_id) {
		$coupon_product_data = array();

		$query = $this->db->query("SELECT `coupon_product_ids` FROM " . DB_PREFIX . "shop_coupon WHERE shop_coupon_id = '" . (int)$shop_coupon_id . "'");

		$result = $query->row;
		$coupon_product_data = $result['coupon_product_ids'];
		

		return $coupon_product_data;
	}

	public function getTotalCoupons() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "shop_coupon");

		return $query->row['total'];
	}

	public function getCouponByName($name) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "shop_coupon` WHERE  name = '" . $this->db->escape($name) . "'");

		return $query->row;
	}
}