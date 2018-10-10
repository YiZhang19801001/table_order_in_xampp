<?php
class ModelTotalSubTotal extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {

		$this->load->language('total/sub_total');

		$location_id = $this->session->data['location_id'];

		$sub_total = $this->cart->getSubTotal($location_id);
		
		$total_data[] = array(
			'code'       => 'sub_total',
			'title'      => $this->language->get('text_sub_total'),
			'value'      => $sub_total,
			'sort_order' => $this->config->get('sub_total_sort_order')
		);

		$total += $sub_total;
	}
}