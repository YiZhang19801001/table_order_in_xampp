<?php
class ModelCatalogProductTag extends Model {
	public function addProductTag($data) {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "product_tag` SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "', sort = '" . (int)$data['sort'] . "', addtime = NOW()");
	}

	public function editProductTag($product_tag_id, $data) {
		$this->db->query("UPDATE `" . DB_PREFIX . "product_tag` SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "' , sort = '" . (int)$data['sort'] . "' WHERE product_tag_id = '" . (int)$product_tag_id . "'");
	}

	public function deleteProductTag($product_tag_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "product_tag` WHERE product_tag_id = '" . (int)$product_tag_id . "'");
	}

	public function getProductTag($product_tag_id) {

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_tag` WHERE  product_tag_id = '" . (int)$product_tag_id . "'");
		return $query->row;
	}

	public function getProductTagByname($name) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_tag` WHERE  name = '" . $this->db->escape($name) . "'");

		return $query->row;
	}

	public function getProductTags($data = array()) {
		
		$sql = "SELECT * FROM `" . DB_PREFIX . "product_tag`  ";
		$sort_data = array(
			'name',
			'sort',
			'status',
			'addtime'
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

	public function getTotalProductTags() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "product_tag`");

		return $query->row['total'];
	}

	public function getProductTagsByProductId($product_id) {
		$query = $this->db->query("SELECT product_tags FROM `" . DB_PREFIX . "product` WHERE  product_id = '" . (int)($product_id) . "'");
		return $query->row['product_tags'];
	}
}