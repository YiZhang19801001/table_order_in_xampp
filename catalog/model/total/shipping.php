<?php
class ModelTotalShipping extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		if (isset($this->session->data['isp'])) {

			$cost = 0;
			$isp = isset($this->session->data['isp']) ? $this->session->data['isp'] : "";
			$suburb_id = isset($this->session->data['zone_id']) ? (int)$this->session->data['zone_id'] : 0;
			$geo_zone_id = isset($this->session->data['geo_zone_id']) ? $this->session->data['geo_zone_id'] : 0;

			if ($isp == 1) {
				$shipping_method = "Delivery";

				$this->load->model('shop/info');
				$cost = $this->model_shop_info->getDeliveryFee($geo_zone_id,$suburb_id);

			} elseif ($isp == 2) {
				$shipping_method = "Pick-up";
			}

			$total_data[] = array(
				'code'       => 'shipping',
				'title'      => $shipping_method,
				'value'      => $cost,
				'sort_order' => $this->config->get('shipping_sort_order')
			);

			$total += $cost;
		}
	}
}