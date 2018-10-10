<?php
class ModelTotalCoupon extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {

		$location_id = $this->session->data['location_id'];

		if (isset($this->session->data['coupon'][$location_id])) {

			$this->load->model('shop/info');

			$coupon_info = $this->model_shop_info->getCoupon($this->session->data['coupon'][$location_id]);


			if ($coupon_info) {

				$discount_total = 0;
				$sub_total = 0;
				foreach ($this->cart->getProducts($location_id) as $product) {
					if($product['is_discount']){
						$sub_total += $product['total'];
					}
				}
				
				$this->load->model('account/order');
				$is_login = $this->customer->getId();

				if($is_login) {
					$times = $this->model_account_order->getTotalOrders();
				} else {
					$times = 0;
				}

				$coupon_array = array(
					'coupon_id' => $this->session->data['coupon'][$location_id],
					'times' => $times,
					'price' => $sub_total,
				);

				$couponFeeInfo = $this->model_shop_info->getCouponFee($coupon_array);

				if ($couponFeeInfo['is_use']) {
					$discount_total = $couponFeeInfo['price'];
				}

				if ($couponFeeInfo['type'] == 2) {

					$title = "Discount Type : {$coupon_info['name']} , gift : {$this->session->data['discount_comment']}";

				} else {
					$title = "Discount Type : {$coupon_info['name']} " ;
				}

				// If discount greater than total
				if ($discount_total > $total) {
					$discount_total = $total;
				}

				if ( ( $couponFeeInfo['type'] == 1 || $couponFeeInfo['type']== 3) && $discount_total == 0) {

				} else {				
					$total_data[] = array(
						'code'       => 'coupon',
						'title'      => $title,
						'value'      => -$discount_total,
						'sort_order' => $this->config->get('coupon_sort_order')
					);
				}

				
				$total -= $discount_total;
			}
		}
	}

	public function confirm($order_info, $order_total) {
		$code = '';

		$start = strpos($order_total['title'], '(') + 1;
		$end = strrpos($order_total['title'], ')');

		if ($start && $end) {
			$code = substr($order_total['title'], $start, $end - $start);
		}

		$this->load->model('checkout/coupon');

		$coupon_info = $this->model_checkout_coupon->getCoupon($code);

		if ($coupon_info) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "coupon_history` SET coupon_id = '" . (int)$coupon_info['coupon_id'] . "', order_id = '" . (int)$order_info['order_id'] . "', customer_id = '" . (int)$order_info['customer_id'] . "', amount = '" . (float)$order_total['value'] . "', date_added = NOW()");
		}
	}

	public function unconfirm($order_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "coupon_history` WHERE order_id = '" . (int)$order_id . "'");
	}
}