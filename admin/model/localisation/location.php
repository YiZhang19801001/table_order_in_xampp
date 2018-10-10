<?php
class ModelLocalisationLocation extends Model {
	public function addLocation($data) {
		#@
		//tag_ids
		if(is_array($data['tag_ids'])){
			$tag_ids = implode(',',$data['tag_ids']);
		}
		//coupon_ids
		if(is_array($data['coupon_ids'])){
			$coupon_ids = implode(',',$data['coupon_ids']);
		}
		//shop_image
		$this->db->query("DELETE FROM " . DB_PREFIX . "shop_image WHERE location_id = '" . (int)$location_id . "'");

		if (isset($data['shop_image'])) {
			foreach ($data['shop_image'] as $shop_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "shop_image SET location_id = '" . (int)$location_id . "', image = '" . $this->db->escape($shop_image['image']) . "', sort_order = '" . (int)$shop_image['sort_order'] . "'");
			}
		}

		//shop_info
		$this->db->query("DELETE FROM " . DB_PREFIX . "shop_info WHERE location_id = '" . (int)$location_id . "'");

		if (isset($data['infos'])) {
			foreach ($data['infos'] as $info) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "shop_info SET location_id = '" . (int)$location_id . "', info = '" . $this->db->escape($info) . "'");
			}
		}

		//shop_times
		$this->db->query("DELETE FROM " . DB_PREFIX . "shop_times WHERE location_id = '" . (int)$location_id ."'");
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "shop_time SET location_id = '" . (int)$location_id . "', times = '" . $this->db->escape(serialize($data['times'])) . "', unavailable = '" . $this->db->escape(serialize($data['unavailables'])) . "', pretime ='". $this->db->escape(serialize($data['pretime']))."'");


		#@
		#


		$this->db->query("INSERT INTO " . DB_PREFIX . "location SET name = '" . $this->db->escape($data['name']) . "', address = '" . $this->db->escape($data['address']) . "', geocode = '" . $this->db->escape($data['geocode']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', image = '" . $this->db->escape($data['image']). "', bgimage = '" . $this->db->escape($data['bgimage']) . "', open = '" . $this->db->escape($data['open']) . "', comment = '" . $this->db->escape($data['comment']) .   "', tag_ids = '" . $this->db->escape($tag_ids).  "', coupon_ids = '" . $this->db->escape($coupon_ids) .  "', geo_zone_id = '" . $this->db->escape($data['geo_zone_id']) .   "', consume = '" . $this->db->escape($data['consume']) .   "', user_id = '" . (int)$data['user_id'] . "'");
	}

	public function editLocation($location_id, $data) {
		#@
		//tag_ids
		if(is_array($data['tag_ids'])){
			$tag_ids = implode(',',$data['tag_ids']);
		}
		//coupon_ids
		if(is_array($data['coupon_ids'])){
			$coupon_ids = implode(',',$data['coupon_ids']);
		}
		//shop_times
		$this->db->query("DELETE FROM " . DB_PREFIX . "shop_time WHERE location_id = '" . (int)$location_id ."'");


		// if(isset($data['times'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "shop_time SET location_id = '" . (int)$location_id . "', times = '" . $this->db->escape(serialize($data['times'])) . "', unavailable = '" . $this->db->escape(serialize($data['unavailables'])) . "' , pretime ='".$this->db->escape(serialize($data['pretime']))."'");
		// }

		//shop_image
		$this->db->query("DELETE FROM " . DB_PREFIX . "shop_image WHERE location_id = '" . (int)$location_id . "'");

		if (isset($data['shop_image'])) {
			foreach ($data['shop_image'] as $shop_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "shop_image SET location_id = '" . (int)$location_id . "', image = '" . $this->db->escape($shop_image['image']) . "', sort_order = '" . (int)$shop_image['sort_order'] . "'");
			}
		}
		#@
		#
		//shop_info
		$this->db->query("DELETE FROM " . DB_PREFIX . "shop_info WHERE location_id = '" . (int)$location_id . "'");

		if (isset($data['infos'])) {
			foreach ($data['infos'] as $info) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "shop_info SET location_id = '" . (int)$location_id . "', info = '" . $this->db->escape($info) . "'");
			}
		}

		$this->db->query("UPDATE " . DB_PREFIX . "location SET name = '" . $this->db->escape($data['name']) . "', address = '" . $this->db->escape($data['address']) . "', geocode = '" . $this->db->escape($data['geocode']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', image = '" . $this->db->escape($data['image']) . "', bgimage = '" . $this->db->escape($data['bgimage']). "', color = '" . $this->db->escape($data['color']) . "', color1 = '" . $this->db->escape($data['color1']) . "', open = '" . $this->db->escape($data['open']) . "', comment = '" . $this->db->escape($data['comment']) .  "', tag_ids = '" . $this->db->escape($tag_ids).  "', coupon_ids = '" . $this->db->escape($coupon_ids) . "', geo_zone_id = '" . $this->db->escape($data['geo_zone_id']) .   "', consume = '" . $this->db->escape($data['consume']).   "', user_id = '" . (int)$data['user_id']. "' WHERE location_id = '" . (int)$location_id . "'");
	}

	public function deleteLocation($location_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "location WHERE location_id = " . (int)$location_id);
	}

	public function getLocation($location_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "location WHERE location_id = '" . (int)$location_id . "'");

		return $query->row;
	}

	public function getLocations($data = array()) {
		$sql = "SELECT location_id, name, address FROM " . DB_PREFIX . "location";

		$sort_data = array(
			'name',
			'address',
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

	public function getTotalLocations() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "location");

		return $query->row['total'];
	}

	public function getShopImages($location_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shop_image WHERE location_id = '" . (int)$location_id . "' ORDER BY sort_order DESC");

		return $query->rows;
	}

	public function getShopTimes($location_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shop_time WHERE location_id = '" . (int)$location_id . "'");
		
		return $query->row;
	}
	public function getShopInfos($location_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shop_info WHERE location_id = '" . (int)$location_id . "'");
		
		return $query->rows;
	}
}
