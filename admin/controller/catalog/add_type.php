<?php
class ControllerCatalogAddType extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/add_type');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/add_type');

		$this->getList();
	}

	public function add() {
		$this->load->language('catalog/add_type');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/add_type');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_add_type->addProductAddTypes($this->request->post);

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

			$this->response->redirect($this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('catalog/add_type');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/add_type');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->model_catalog_add_type->editProductTag($this->request->get['add_type_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/add_type');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/add_type');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {

			foreach ($this->request->post['selected'] as $add_type_id) {
				$this->model_catalog_add_type->deleteProductAddType($add_type_id);
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

			$this->response->redirect($this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
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
			'href' => $this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('catalog/add_type/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('catalog/add_type/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['add_types'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$add_type_total = $this->model_catalog_add_type->getTotalProductAddTypes();

		$results = $this->model_catalog_add_type->getProductAddTypes($filter_data);

		foreach ($results as $result) {
			$data['add_types'][] = array(
				'add_type_id'    => $result['add_type_id'],
				'name'   => $result['name'],
				'required'   =>($result['required'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'type'     => ($result['type'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'selection'     => ($result['checkbox'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'edit'       => $this->url->link('catalog/add_type/edit', 'token=' . $this->session->data['token'] . '&add_type_id=' . $result['add_type_id'] . $url, 'SSL')
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_type'] = $this->language->get('column_type');
		$data['column_required'] = $this->language->get('column_required');
		$data['column_action'] = $this->language->get('column_action');
		$data['column_selection'] = $this->language->get('column_selection');

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

		$data['sort_name'] = $this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$data['sort_type'] = $this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . '&sort=type' . $url, 'SSL');
		$data['sort_required'] = $this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . '&sort=required' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $add_type_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($add_type_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($add_type_total - $this->config->get('config_limit_admin'))) ? $add_type_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $add_type_total, ceil($add_type_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/add_type_list.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_form'] = !isset($this->request->get['add_type_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_type'] = $this->language->get('entry_type');
		$data['entry_required'] = $this->language->get('entry_required');
		$data['entry_checkbox'] = $this->language->get('entry_checkbox');

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

		if (isset($this->error['sort'])) {
			$data['error_sort'] = $this->error['sort'];
		} else {
			$data['error_sort'] = '';
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
			'href' => $this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['add_type_id'])) {
			$data['action'] = $this->url->link('catalog/add_type/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('catalog/add_type/edit', 'token=' . $this->session->data['token'] . '&add_type_id=' . $this->request->get['add_type_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('catalog/add_type', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['add_type_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$add_type_info = $this->model_catalog_add_type->getProductAddType($this->request->get['add_type_id'],'');
		}

		if (isset($this->request->post['username'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($add_type_info)) {
			$data['name'] = $add_type_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['required'])) {
			$data['required'] = $this->request->post['required'];
		} elseif (!empty($add_type_info)) {
			$data['required'] = $add_type_info['required'];
		} else {
			$data['required'] = 0;
		}
		
		if (isset($this->request->post['checkbox'])) {
			$data['checkbox'] = $this->request->post['checkbox'];
		} elseif (!empty($add_type_info)) {
			$data['checkbox'] = $add_type_info['checkbox'];
		} else {
			$data['checkbox'] = 0;
		}

		if (isset($this->request->post['type'])) {
			$data['type'] = $this->request->post['type'];
		} elseif (!empty($add_type_info)) {
			$data['type'] = $add_type_info['type'];
		} else {
			$data['type'] = 0;
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/add_type_form.tpl', $data));
	}

	protected function validateForm() {

		if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 50)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		$add_type_info = $this->model_catalog_add_type->getProductAddTypeByname($this->request->post['name']);

		if (!isset($this->request->get['add_type_id'])) {
			if ($add_type_info) {
				$this->error['warning'] = $this->language->get('error_exists');
			}
		} else {
			if ($add_type_info && ($this->request->get['add_type_id'] != $add_type_info['add_type_id'])) {
				$this->error['warning'] = $this->language->get('error_exists');
			}
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/add_type')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/add_type');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_catalog_add_type->getProductTags($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'add_type_id' => $result['add_type_id'],
					'name'            => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}