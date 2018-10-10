<?php
class ModelLocalisationSuburb extends Model {

	public function addSuburb($data) {

		$this->db->query("INSERT INTO " . DB_PREFIX . "suburb SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', state_id = '" . (int)$data['state_id'] . "', country_id = '" . (int)$data['country_id'] . "'");

		$this->cache->delete('suburb');
	}

	public function editSuburb($suburb_id, $data) {

		$this->db->query("UPDATE " . DB_PREFIX . "suburb SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', state_id = '" . (int)$data['state_id']  . "', country_id = '" . (int)$data['country_id'] . "' WHERE suburb_id = '" . (int)$suburb_id . "'");

		$this->cache->delete('suburb');
	}

	public function deleteSuburb($suburb_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "suburb WHERE suburb_id = '" . (int)$suburb_id . "'");

		$this->cache->delete('suburb');
	}

	public function getTotalSuburb() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "suburb");

		return $query->row['total'];
	}

	public function getSuburb($suburb_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "suburb WHERE suburb_id = '" . (int)$suburb_id . "'");

		return $query->row;
	}

	public function getSuburbs($data = array()) {
		$sql = "SELECT su.*, s.name as state, c.name AS country FROM " . DB_PREFIX . "suburb su LEFT JOIN " . DB_PREFIX . "state s ON (su.state_id = s.state_id)  LEFT JOIN " . DB_PREFIX . "country c ON (su.country_id = c.country_id)";

		$sort_data = array(
			'c.name',
			'su.name',
			's.name'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY c.name";
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

	public function getSuburbByStateId($state_id) {
		$suburb_data = $this->cache->get('suburb.' . (int)$state_id);
		
		if (!$suburb_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "suburb WHERE state_id = '" . (int)$state_id . "' AND status = '1' ORDER BY name");

			$suburb_data = $query->rows;

			$this->cache->set('suburb.' . (int)$state_id, $suburb_data);
		}

		return $suburb_data;
	}
}