<?php
class ModelLocalisationState extends Model {

	public function addState($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "state SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', country_id = '" . (int)$data['country_id'] . "'");

		$this->cache->delete('state');
	}

	public function editState($state_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "state SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name'])  . "', country_id = '" . (int)$data['country_id'] . "' WHERE state_id = '" . (int)$state_id . "'");

		$this->cache->delete('state');
	}

	public function deleteState($state_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "state WHERE state_id = '" . (int)$state_id . "'");

		$this->cache->delete('state');
	}

	public function getTotalStates() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "state");

		return $query->row['total'];
	}

	public function getState($state_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "state WHERE state_id = '" . (int)$state_id . "'");

		return $query->row;
	}

	public function getStates($data = array()) {
		$sql = "SELECT *, s.name, c.name AS country FROM " . DB_PREFIX . "state s LEFT JOIN " . DB_PREFIX . "country c ON (s.country_id = c.country_id)";

		$sort_data = array(
			'c.name',
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

	public function getStatesByCountryId($country_id) {
		$state_data = $this->cache->get('state.' . (int)$country_id);
		
		if (!$state_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "state WHERE country_id = '" . (int)$country_id . "' AND status = '1' ORDER BY name");

			$state_data = $query->rows;

			$this->cache->set('state.' . (int)$country_id, $state_data);
		}

		return $state_data;
	}
}