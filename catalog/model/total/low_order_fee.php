<?php
class ModelTotalLowOrderFee extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {

		$this->load->language('total/low_order_fee');

		$location_id = $this->session->data['location_id'];
		$sub_total = $this->cart->getSubTotal($location_id);

		$this->load->model('localisation/location');
		$location_info = $this->model_localisation_location->getLocation($location_id);

		$ext_price = 0;

		if ($sub_total < $location_info['consume']) {
			$ext_price = $location_info['consume'] - $sub_total;
		}

		if ($ext_price) {

			$total_data[] = array(
				'code'       => 'low_order_fee',
				'title'      => "Additional charges",
				'value'      => $ext_price,
				'sort_order' => $this->config->get('low_order_fee_sort_order')
			);
		}

		$total += $ext_price;
	}
}