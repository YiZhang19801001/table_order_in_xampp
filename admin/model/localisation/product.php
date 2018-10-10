<?php
class ModellocalisationProduct extends Model {
	public function addProduct($data) {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "shop_coupon_product` SET name = '" . $this->db->escape($data['name']) . "', `date_added` = NOW()");
	}

	public function editProduct($product_id, $data) {
		$this->db->query("UPDATE `" . DB_PREFIX . "shop_coupon_product` SET name = '" . $this->db->escape($data['name']) . "' WHERE product_id = '" . (int)$product_id . "'");
	}

	public function deleteProduct($product_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "shop_coupon_product` WHERE product_id = '" . (int)$product_id . "'");
	}

	public function getProduct($product_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "shop_coupon_product` WHERE  product_id = '" . (int)$product_id . "'");

		return $query->row;
	}

	public function getProductByname($name) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "shop_coupon_product` WHERE  name = '" . $this->db->escape($name) . "'");

		return $query->row;
	}

	public function getProducts($data = array()) {

		$sql = "SELECT * FROM `" . DB_PREFIX . "shop_coupon_product`  ";
		

		$sort_data = array(
			'name',
			'date_added'
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

	public function getTotalProducts() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "shop_coupon_product`");

		return $query->row['total'];
	}
}