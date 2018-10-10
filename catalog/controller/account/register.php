<?php
class ControllerAccountRegister extends Controller {
	private $error = array();

	public function index() {
		if ($this->customer->isLogged()) {
			$this->response->redirect($this->url->link('shop/info', 'location_id=4', 'SSL'));
		}

		$this->load->language('account/register');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/customer');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$customer_id = $this->model_account_customer->addCustomer($this->request->post);
			
			// Clear any previous login attempts for unregistered accounts.
			$this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
			
			$this->customer->login($this->request->post['email'], $this->request->post['password']);

			unset($this->session->data['guest']);

			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $customer_id,
				'email'        => $this->request->post['email']
			);

			$this->model_account_activity->addActivity('register', $activity_data);

			$this->response->redirect($this->url->link('common/home'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => 'Home',
			'href' => $this->url->link('common/home')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');


		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['state'])) {
			$data['error_state'] = $this->error['state'];
		} else {
			$data['error_state'] = '';
		}

		if (isset($this->error['suburb'])) {
			$data['error_suburb'] = $this->error['suburb'];
		} else {
			$data['error_suburb'] = '';
		}

		if (isset($this->error['password'])) {
			$data['error_password'] = $this->error['password'];
		} else {
			$data['error_password'] = '';
		}

		if (isset($this->error['confirm'])) {
			$data['error_confirm'] = $this->error['confirm'];
		} else {
			$data['error_confirm'] = '';
		}

		$data['action'] = $this->url->link('account/register', '', 'SSL');

		$data['customer_groups'] = array();

		if (is_array($this->config->get('config_customer_group_display'))) {
			$this->load->model('account/customer_group');

			$customer_groups = $this->model_account_customer_group->getCustomerGroups();

			foreach ($customer_groups as $customer_group) {
				if (in_array($customer_group['customer_group_id'], $this->config->get('config_customer_group_display'))) {
					$data['customer_groups'][] = $customer_group;
				}
			}
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} else {
			$data['email'] = '';
		}

		$this->load->model('localisation/country');

		$data['countries'] = $this->model_localisation_country->getCountries();

		$this->load->model('localisation/state');

		$data['states'] = $this->model_localisation_state->getStates();

		$this->load->model('localisation/suburb');

		$data['suburbs'] = $this->model_localisation_suburb->getSuburbs();

		if (isset($this->request->post['password'])) {
			$data['password'] = $this->request->post['password'];
		} else {
			$data['password'] = '';
		}

		if (isset($this->request->post['confirm'])) {
			$data['confirm'] = $this->request->post['confirm'];
		} else {
			$data['confirm'] = '';
		}

		if (isset($this->request->post['country_id'])) {
			$data['country_id'] = $this->request->post['country_id'];
		} else {
			$data['country_id'] = 0;
		}

		if (isset($this->request->post['state_id'])) {
			$data['state_id'] = $this->request->post['state_id'];
		} elseif(isset($this->request->post['country_id'])) {
			$data['states'] = $this->model_localisation_state->getStatesByCountryId($this->request->post['country_id']);
			$data['state_id'] = 0;
		} else {
			$data['state_id'] = 0;
		}

		if (isset($this->request->post['suburb_id'])) {
			$data['suburb_id'] = $this->request->post['suburb_id'];
		} elseif(isset($this->request->post['state_id'])) {
			$data['suburbs'] = $this->model_localisation_suburb->getSuburbsByStateId($this->request->post['state_id']);
			$data['suburb_id'] = 0;
		} else {
			$data['suburb_id'] = 0;
		}

		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/register.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/register.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/register.tpl', $data));
		}
	}

	public function validate() {

		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_exists');
		}

		// if ($this->request->post['country_id'] == '') {
		// 	$this->error['country'] = $this->language->get('error_country');
		// }

		// if (!isset($this->request->post['state_id']) || $this->request->post['state_id'] == '') {
		// 	$this->error['state'] = $this->language->get('error_state');
		// }

		// if (!isset($this->request->post['suburb_id']) || $this->request->post['suburb_id'] == '') {
		// 	$this->error['suburb'] = $this->language->get('error_suburb');
		// }

		if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
			$this->error['password'] = $this->language->get('error_password');
		}

		if ($this->request->post['confirm'] != $this->request->post['password']) {
			$this->error['confirm'] = $this->language->get('error_confirm');
		}

		return !$this->error;
	}

	public function customfield() {
		$json = array();

		$this->load->model('account/custom_field');

		// Customer Group
		if (isset($this->request->get['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->get['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $this->request->get['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

		foreach ($custom_fields as $custom_field) {
			$json[] = array(
				'custom_field_id' => $custom_field['custom_field_id'],
				'required'        => $custom_field['required']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}