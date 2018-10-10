<?php
class ModelCatalogAddType extends Model {
	public function addProductAddTypes($data) {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "product_add_type` SET name = '" . $this->db->escape($data['name']) . "', type = '" . (int)$data['type']. "', checkbox = '" . (int)$data['checkbox'] . "', required = '" . (int)$data['required'] . "'");
	}

	public function editProductTag($add_type_id, $data) {
		$this->db->query("UPDATE `" . DB_PREFIX . "product_add_type` SET name = '" . $this->db->escape($data['name']) . "', type = '" . (int)$data['type']  . "', checkbox = '" . (int)$data['checkbox'] . "' , required = '" . (int)$data['required'] . "' WHERE add_type_id = '" . (int)$add_type_id . "'");
	}

	public function deleteProductAddType($add_type_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "product_add_type` WHERE add_type_id = '" . (int)$add_type_id . "'");

		//删除商品type
		$this->db->query("DELETE FROM `" . DB_PREFIX . "product_ext` WHERE type = '" . (int)$add_type_id . "'");
	}

	public function getProductAddType($add_type_id) {

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_add_type` WHERE  add_type_id = '" . (int)$add_type_id . "'");
		return $query->row;
	}

	public function getProductAddTypeByname($name) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_add_type` WHERE  name = '" . $this->db->escape($name) . "'");

		return $query->row;
	}

	public function getProductAddTypes($data = array()) {
		
		$sql = "SELECT * FROM `" . DB_PREFIX . "product_add_type`";
		$sort_data = array(
			'name',
			'type',
			'required'
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

	public function getTotalProductAddTypes() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "product_add_type`");

		return $query->row['total'];
	}
}