<?php
class ControllerCheckoutLogin extends Controller {
	public function index() {
		$this->load->language('checkout/checkout');

		$data['text_checkout_account'] = $this->language->get('text_checkout_account');
		$data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
		$data['text_new_customer'] = $this->language->get('text_new_customer');
		$data['text_returning_customer'] = $this->language->get('text_returning_customer');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_guest'] = $this->language->get('text_guest');
		$data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
		$data['text_register_account'] = $this->language->get('text_register_account');
		$data['text_forgotten'] = $this->language->get('text_forgotten');
		$data['text_loading'] = $this->language->get('text_loading');

		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_password'] = $this->language->get('entry_password');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_login'] = $this->language->get('button_login');

		$data['checkout_guest'] = ($this->config->get('config_checkout_guest') && !$this->config->get('config_customer_price') && !$this->cart->hasDownload());

		if (isset($this->session->data['account'])) {
			$data['account'] = $this->session->data['account'];
		} else {
			$data['account'] = 'register';
		}

		$data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/login.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/login.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/checkout/login.tpl', $data));
		}
	}

	public function save() {
		$this->load->language('checkout/checkout');

		$json = array();

		if ($this->customer->isLogged()) {
			//已登录
			$json['error'] = 1;
		}

		if (!$json) {
			$this->load->model('account/customer');
			
			// Check how many login attempts have been made.
			// $login_info = $this->model_account_customer->getLoginAttempts($this->request->post['email']);
				
			// if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
			// 	//登录失败次数
			// 	// $json['error']['warning'] = $this->language->get('error_attempts');
			// 	$json['error'] = 1;
			// }			

			// Check if customer has been approved.
			$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

			if ($customer_info && !$customer_info['approved']) {
				//未审核
				// $json['error']['warning'] = $this->language->get('error_approved');
				$json['error'] = 1;
			}
						
			if (!isset($json['error'])) {
				if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
					//用户帐号密码是否正确
					// $json['error']['warning'] = $this->language->get('error_login');
					$json['error'] = 1;
				
					$this->model_account_customer->addLoginAttempt($this->request->post['email']);
				} else {
					$this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
				}			
			}
		}

		if (!$json) {
			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->request->post['email'],
			);

			$this->model_account_activity->addActivity('login', $activity_data);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
