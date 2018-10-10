<?php
class ModelLocalisationSuburb extends Model {
	public function getSuburbsByStateId($state_id) {
		$suburb_data = $this->cache->get('suburb.' . (int)$state_id);
		
		if (!$suburb_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "suburb WHERE state_id = '" . (int)$state_id . "' AND status = '1' ORDER BY name");

			$suburb_data = $query->rows;

			$this->cache->set('suburb.' . (int)$state_id, $suburb_data);
		}

		return $suburb_data;
	}

	public function getSuburbs() {
		$suburb_data = $this->cache->get('suburb.status');

		if (!$suburb_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "suburb WHERE status = '1' ORDER BY name ASC");

			$suburb_data = $query->rows;

			$this->cache->set('suburb.status', $suburb_data);
		}

		return $suburb_data;
	}

	
	public function getSuburb($suburb_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "suburb WHERE suburb_id = '" . (int)$suburb_id . "'");

		return $query->row;
	}
}