<?php
class ControllerAccountDetail extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->language('account/detail');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/customer');

		$this->load->model('account/address');

		$this->load->model('tool/upload');

		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['logout'] = $this->url->link('account/logout', '', 'SSL');
		$data['detail'] = $this->url->link('account/detail', '', 'SSL');

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_account_customer->editCustomer($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'email'        => $this->customer->getEmail()
			);

			$this->model_account_activity->addActivity('detail', $activity_data);

			$this->response->redirect($this->url->link('account/detail', '', 'SSL'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => "HOME",
			'href'      => $this->url->link('common/home')
		);

		//用户信息
		$data['action'] = $this->url->link('account/detail', '', 'SSL');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['exists'])) {
			$data['error_exists'] = $this->error['exists'];
		} else {
			$data['error_exists'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['password'])) {
			$data['error_password'] = $this->error['password'];
		} else {
			$data['error_password'] = '';
		}

		if (isset($this->error['newPassword'])) {
			$data['error_newPassword'] = $this->error['newPassword'];
		} else {
			$data['error_newPassword'] = '';
		}

		if (isset($this->error['newPassword1'])) {
			$data['error_newPassword1'] = $this->error['newPassword1'];
		} else {
			$data['error_newPassword1'] = '';
		}

		if (isset($this->error['newPassword2'])) {
			$data['error_newPassword2'] = $this->error['newPassword2'];
		} else {
			$data['error_newPassword2'] = '';
		}

		if (isset($this->error['newPassword3'])) {
			$data['error_newPassword3'] = $this->error['newPassword3'];
		} else {
			$data['error_newPassword3'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

			$address_info = $this->model_account_address->getAddress($this->customer->getAddressId());
		}

		if (isset($this->request->post['firstName'])) {
			$data['firstname'] = $this->request->post['firstname'];
		} elseif (!empty($customer_info)) {
			$data['firstname'] = $customer_info['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		} elseif (!empty($customer_info)) {
			$data['lastname'] = $customer_info['lastname'];
		} else {
			$data['lastname'] = '';
		}

		if (isset($this->request->post['alias'])) {
			$data['alias'] = $this->request->post['alias'];
		} elseif (!empty($customer_info)) {
			$data['alias'] = $customer_info['alias'];
		} else {
			$data['alias'] = '';
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} elseif (!empty($customer_info)) {
			$data['email'] = $customer_info['email'];
		} else {
			$data['email'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($customer_info)) {
			$data['telephone'] = $customer_info['telephone'];
		} else {
			$data['telephone'] = '';
		}

		if (isset($this->request->post['fax'])) {
			$data['fax'] = $this->request->post['fax'];
		} elseif (!empty($customer_info)) {
			$data['fax'] = $customer_info['fax'];
		} else {
			$data['fax'] = '';
		}


		if (isset($this->request->post['newsletter'])) {
			$data['newsletter'] = $this->request->post['newsletter'];

		} elseif (!empty($customer_info)) {
			$data['newsletter'] = $customer_info['newsletter'];
		} else {
			$data['newsletter'] = 0;
		}

		if (isset($this->request->post['password'])) {
			$data['password'] = $this->request->post['password'];
		}  else {
			$data['password'] = '';
		}
		
		if (isset($this->request->post['newPassword'])) {
			$data['newPassword'] = $this->request->post['newPassword'];
		}  else {
			$data['newPassword'] = '';
		}

		if (isset($this->request->post['passwordCheck'])) {
			$data['passwordCheck'] = $this->request->post['passwordCheck'];
		}  else {
			$data['passwordCheck'] = '';
		}

		//userPhoto
		#@todo
		if (isset($this->request->post['userPhoto'])) {
			$data['upload_id'] = $this->request->post['upload_id'];
			$img_info = $this->model_tool_upload->getUploadByUploadId($this->request->post['upload_id']);
			$data['file_name'] = $img_info['name'];

		} elseif (!empty($customer_info) && !empty($customer_info['upload_id'])) {
			$data['upload_id'] = $customer_info['upload_id'];
			$img_info = $this->model_tool_upload->getUploadByUploadId($customer_info['upload_id']);
			$data['file_name'] = $img_info['name'];

		} else {
			$data['upload_id'] = '';
			$data['file_name'] = "";

		}

		//address
		$this->load->model('localisation/country');

		$data['countries'] = $this->model_localisation_country->getCountries();

		$this->load->model('localisation/state');

		$data['states'] = $this->model_localisation_state->getStates();

		$this->load->model('localisation/suburb');

		$data['suburbs'] = $this->model_localisation_suburb->getSuburbs();

		$data['countries'] = $this->model_localisation_country->getCountries();

		if (isset($this->request->post['country_id'])) {
			$data['country_id'] = $this->request->post['country_id'];
		} elseif (!empty($address_info) && !empty($address_info['country_id'])) {
			$data['country_id'] =$address_info['country_id'];
		} else {
			$data['country_id'] = 0;
		}

		if (isset($this->request->post['state_id'])) {
			$data['state_id'] = $this->request->post['state_id'];
		} elseif (!empty($address_info) && !empty($address_info['country_id'])) {
			$data['states'] = $this->model_localisation_state->getStatesByCountryId($address_info['country_id']);
			$data['state_id'] = $address_info['state_id'];
		} else {
			$data['state_id'] = 0;
		}

		if (isset($this->request->post['suburb_id'])) {
			$data['suburb_id'] = $this->request->post['suburb_id'];
		} elseif (!empty($address_info) && !empty($address_info['state_id'])) {
			$data['suburbs'] = $this->model_localisation_suburb->getSuburbsByStateId($address_info['state_id']);
			$data['suburb_id'] = $address_info['suburb_id'];
		} else {
			$data['suburb_id'] = 0;
		}

		if (isset($this->request->post['address_1'])) {
			$data['address_1'] = $this->request->post['address_1'];
		} elseif (!empty($address_info)) {
			$data['address_1'] = $address_info['address_1'];
		} else {
			$data['address_1'] = "";
		}
		
		if (isset($this->request->post['address_2'])) {
			$data['address_2'] = $this->request->post['address_2'];
		} elseif (!empty($address_info)) {
			$data['address_2'] = $address_info['address_2'];
		} else {
			$data['address_2'] = "";
		}

		if (isset($this->request->post['address_3'])) {
			$data['address_3'] = $this->request->post['address_3'];
		} elseif (!empty($address_info)) {
			$data['address_3'] = $address_info['address_3'];
		} else {
			$data['address_3'] = "";
		}




		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/detail.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/detail.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/detail.tpl', $data));
		}
	}

	protected function validate() {

		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if (($this->customer->getEmail() != $this->request->post['email']) && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['exists'] = $this->language->get('error_exists');
		}

		if (($this->customer->getEmail() != $this->request->post['email']) && !$this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {

			if($this->request->post['password']) {
				if(!$this->customer->checkPwd($this->customer->getId(),$this->request->post['password'])) {
					$this->error['password'] = $this->language->get('error_password');
				}
			} else {
				$this->error['password'] = $this->language->get('error_password2');
			}
		}

		//change password
		if($this->request->post['newPassword'] || $this->request->post['passwordCheck']) {


			if(utf8_strlen($this->request->post['newPassword']) < 4) {
				$this->error['newPassword1'] =$this->language->get('error_newPassword1');
			}

			if(($this->request->post['newPassword'] != $this->request->post['passwordCheck'])) {
				$this->error['newPassword3'] = $this->language->get('error_newPassword2');
			}

			if(empty($this->request->post['password'])) {
				$this->error['newPassword2'] = $this->language->get('error_password1');
			} else {
				if(!$this->customer->checkPwd($this->customer->getId(),$this->request->post['password'])) {
					$this->error['password'] = $this->language->get('error_password');
				}
			}

		}



		

		return !$this->error;
	}
}