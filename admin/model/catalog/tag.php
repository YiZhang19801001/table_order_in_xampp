<?php
class ModelCatalogTag extends Model {
	public function addTag($data) {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "shop_tag` SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "', sort = '" . (int)$data['sort'] . "', addtime = NOW()");
	}

	public function editTag($tag_id, $data) {
		$this->db->query("UPDATE `" . DB_PREFIX . "shop_tag` SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "' , sort = '" . (int)$data['sort'] . "' WHERE tag_id = '" . (int)$tag_id . "'");
	}

	public function deleteTag($tag_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "shop_tag` WHERE tag_id = '" . (int)$tag_id . "'");
	}

	public function getTag($tag_id,$flag = 1) {
		if($flag) {
			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "shop_tag` WHERE  `status`  = 1 AND tag_id = '" . (int)$tag_id . "'");
		} else {
			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "shop_tag` WHERE  tag_id = '" . (int)$tag_id . "'");
		}

		return $query->row;
	}

	public function getTagByname($name) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "shop_tag` WHERE  name = '" . $this->db->escape($name) . "'");

		return $query->row;
	}

	public function getTags($data = array(),$flag = 1) {
		if($flag){
			$sql = "SELECT * FROM `" . DB_PREFIX . "shop_tag` WHERE `status` = 1 ";
		}else{
			$sql = "SELECT * FROM `" . DB_PREFIX . "shop_tag`  ";
		}

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

	public function getTotalTags() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "shop_tag`");

		return $query->row['total'];
	}
}