<?php
class ModelShopReviews extends Model {

	public function isReview($location_id,$customer_id,$order_id) {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE product_id = '".(int)$location_id."' AND customer_id = '" . (int)$customer_id."' AND order_id = '" . (int)$order_id . "'");
		
		return $query->rows;
	}

	public function getTotalReviewsByLocationId($location_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review WHERE product_id= '".(int)$location_id."' AND status = 1");

		return $query->row['total'];
	}

	public function getInfoByLocationId($location_id) {

		$query = $this->db->query("SELECT round(AVG(rating),1) AS rating,round(AVG(rating1),1) AS rating1,round(AVG(rating2),1) AS rating2 FROM " . DB_PREFIX . "review WHERE product_id= '".(int)$location_id."' AND status = 1");

		
		$query->row['total_rating'] = round( ($query->row['rating'] + $query->row['rating1'] + $query->row['rating2'])/3,1);
		
		if(empty($query->row['rating'])) {
			$query->row['rating'] = 0;
		}		
		if(empty($query->row['rating1'])) {
			$query->row['rating1'] = 0;
		}		
		if(empty($query->row['rating2'])) {
			$query->row['rating2'] = 0;
		}
		$query->row['color'] = $this->getColor($query->row['total_rating']);

		return $query->row;
	}

	public function getReviewsByLocationId($location_id) {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE product_id= '".(int)$location_id."' AND status = 1");

		return $query->rows;
	}

	public function getTotalReviewsByCustomerId($customer_id) {

		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review WHERE customer_id= '".(int)$customer_id."' AND status = 1");
		
		return $query->row['total'];
	}

	public function getColor($total_rating) {

		if( 0<=$total_rating && $total_rating<1 ) {
			$color = "#FF5832";
		} elseif( 1<=$total_rating&& $total_rating<2){
			$color = "#FD6543";
		} elseif( 2<= $total_rating && $total_rating<3){
			$color = "#FF6D30";
		} elseif(3<=$total_rating && $total_rating<4) {
			$color = "#FF832E";
		} elseif(4<=$total_rating && $total_rating<5) {
			$color = "#FF9E2C";
		}elseif(5<=$total_rating && $total_rating<6) {
			$color = "#FFC329";
		}elseif(6<=$total_rating && $total_rating<7) {
			$color = "#FFE826";
		}elseif(7<=$total_rating && $total_rating<8) {
			$color = "#C8E724";
		}elseif(8<=$total_rating && $total_rating<9) {
			$color = "#77D323";
		}elseif(9<=$total_rating && $total_rating<=10) {
			$color = "#26BF22";
		}
		return $color;
	}

	public function getReviewsByOrderId($order_id) {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE order_id= '".(int)$order_id."' AND status = 1");

		return $query->row;
	}	

	public function getAvgRatingByOrderId($order_id) {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE order_id= '".(int)$order_id."' AND status = 1");

		if( $query->num_rows ) {
			$query->row['avgRating'] = round( ($query->row['rating']+$query->row['rating1']+$query->row['rating2'])/3,1);
		}
		return $query->row;
	}


	public function getReviews($start = 0, $limit = 20, $location_id) {
		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 1;
		}

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "review`  WHERE product_id = '" . (int)$location_id . "' AND status = 1 ORDER BY review_id DESC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}

	public function getReviewsByCustomerId($start = 0, $limit = 20, $customer_id) {
		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 1;
		}

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "review`  WHERE customer_id = '" . (int)$customer_id . "' ORDER BY review_id DESC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}
}