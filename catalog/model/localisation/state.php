<?php
class ModelLocalisationState extends Model {
	public function getStatesByCountryId($country_id) {
		$state_data = $this->cache->get('state.' . (int)$country_id);
		
		if (!$state_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "state WHERE country_id = '" . (int)$country_id . "' AND status = '1' ORDER BY name");

			$state_data = $query->rows;

			$this->cache->set('state.' . (int)$country_id, $state_data);
		}

		return $state_data;
	}

	public function getState($state_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "state WHERE state_id = '" . (int)$state_id . "'");

		return $query->row;
	}

	public function getStates() {
		$state_data = $this->cache->get('state.status');

		if (!$state_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "state WHERE status = '1' ORDER BY name ASC");

			$state_data = $query->rows;

			$this->cache->set('state.status', $state_data);
		}

		return $state_data;
	}
}