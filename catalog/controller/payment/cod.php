<?php
class ControllerPaymentCod extends Controller {
	public function index() {

		if ($this->session->data['payment_method']['code'] == 'cod') {
			$this->load->model('checkout/order');

			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('cod_order_status_id'));

			$redirect = $this->url->link('pay/success');

			$this->response->redirect($redirect);
		}
	}
}