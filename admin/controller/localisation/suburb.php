<?php
class ControllerLocalisationSuburb extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('localisation/suburb');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/suburb');

		$this->getList();
	}

	public function add() {
		$this->load->language('localisation/suburb');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/suburb');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->model_localisation_suburb->addSuburb($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('localisation/suburb');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/suburb');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_suburb->editSuburb($this->request->get['suburb_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('localisation/suburb');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/suburb');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $suburb_id) {
				$this->model_localisation_suburb->deleteSuburb($suburb_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'c.name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('localisation/suburb/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('localisation/suburb/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['suburbs'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$suburb_total = $this->model_localisation_suburb->getTotalSuburb();

		$results = $this->model_localisation_suburb->getSuburbs($filter_data);

		foreach ($results as $result) {
			$data['suburbs'][] = array(
				'suburb_id' => $result['suburb_id'],
				'country' => $result['country'],
				'state' => $result['state'],
				'name'    => $result['name'] . (($result['suburb_id'] == $this->config->get('config_suburb_id')) ? $this->language->get('text_default') : null),
				'edit'    => $this->url->link('localisation/suburb/edit', 'token=' . $this->session->data['token'] . '&suburb_id=' . $result['suburb_id'] . $url, 'SSL')
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_country'] = $this->language->get('column_country');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_action'] = $this->language->get('column_action');
		$data['column_state'] = $this->language->get('column_state');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_country'] = $this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . '&sort=c.name' . $url, 'SSL');
		$data['sort_name'] = $this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . '&sort=su.name' . $url, 'SSL');
		$data['sort_state'] = $this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . '&sort=s.name' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $suburb_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($suburb_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($suburb_total - $this->config->get('config_limit_admin'))) ? $suburb_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $suburb_total, ceil($suburb_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/suburb_list.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['suburb_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_country'] = $this->language->get('entry_country');
		$data['entry_state'] = $this->language->get('entry_state');
		$data['entry_suburb'] = $this->language->get('entry_suburb');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_select'] = $this->language->get('text_select');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
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

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['suburb_id'])) {
			$data['action'] = $this->url->link('localisation/suburb/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('localisation/suburb/edit', 'token=' . $this->session->data['token'] . '&suburb_id=' . $this->request->get['suburb_id'] . $url, 'SSL');
		}
		$data['token'] = $this->session->data['token'];



		$data['cancel'] = $this->url->link('localisation/suburb', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['suburb_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$state_info = $this->model_localisation_suburb->getSuburb($this->request->get['suburb_id']);
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($state_info)) {
			$data['status'] = $state_info['status'];
		} else {
			$data['status'] = '1';
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($state_info)) {
			$data['name'] = $state_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['country_id'])) {
			$data['country_id'] = $this->request->post['country_id'];
		} elseif (!empty($state_info)) {
			$data['country_id'] = $state_info['country_id'];
		} else {
			$data['country_id'] = '';
		}

		if (isset($this->request->post['state_id'])) {
			$data['state_id'] = $this->request->post['country_id'];
		} elseif (!empty($state_info)) {
			$data['state_id'] = $state_info['state_id'];
		} else {
			$data['state_id'] = '';
		}

		$this->load->model('localisation/country');

		$data['countries'] = $this->model_localisation_country->getCountries();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/suburb_form.tpl', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'localisation/suburb')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if (empty($this->request->post['state_id'])) {
			$this->error['state'] = $this->language->get('error_state');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'localisation/suburb')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		return !$this->error;
	}
}