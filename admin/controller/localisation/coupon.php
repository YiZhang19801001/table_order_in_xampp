<?php
class ControllerLocalisationCoupon extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('localisation/coupon');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/coupon');

		$this->getList();
	}

	public function add() {
		$this->load->language('localisation/coupon');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/coupon');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_coupon->addCoupon($this->request->post);

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

			$this->response->redirect($this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('localisation/coupon');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/coupon');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_coupon->editCoupon($this->request->get['shop_coupon_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('localisation/coupon');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/coupon');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $shop_coupon_id) {
				$this->model_localisation_coupon->deleteCoupon($shop_coupon_id);
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

			$this->response->redirect($this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . $url, 'SSL'));
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
			'href' => $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('localisation/coupon/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('localisation/coupon/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['coupons'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$coupon_total = $this->model_localisation_coupon->getTotalCoupons();

		$results = $this->model_localisation_coupon->getCoupons($filter_data);

		foreach ($results as $result) {
			$data['coupons'][] = array(
				'shop_coupon_id'  => $result['shop_coupon_id'],
				'name'       => $result['name'],
				'discount'   => $result['discount'],
				'sort_order'   => $result['sort_order'],
				'date_start' => date($this->language->get('date_format_short'), strtotime($result['date_start'])),
				'date_end'   => date($this->language->get('date_format_short'), strtotime($result['date_end'])),
				'status'     => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'edit'       => $this->url->link('localisation/coupon/edit', 'token=' . $this->session->data['token'] . '&shop_coupon_id=' . $result['shop_coupon_id'] . $url, 'SSL')
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['text_times'] = $this->language->get('text_times');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_discount'] = $this->language->get('column_discount');
		$data['column_date_start'] = $this->language->get('column_date_start');
		$data['column_date_end'] = $this->language->get('column_date_end');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_action'] = $this->language->get('column_action');
		$data['column_sort_order'] = $this->language->get('column_sort_order');

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

		$data['sort_name'] = $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$data['sort_discount'] = $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . '&sort=discount' . $url, 'SSL');
		$data['sort_date_start'] = $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . '&sort=date_start' . $url, 'SSL');
		$data['sort_date_end'] = $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . '&sort=date_end' . $url, 'SSL');
		$data['sort_status'] = $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . '&sort=status' . $url, 'SSL');
		$data['sort_sort_order'] = $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $coupon_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($coupon_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($coupon_total - $this->config->get('config_limit_admin'))) ? $coupon_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $coupon_total, ceil($coupon_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/coupon_list.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['shop_coupon_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_percent'] = $this->language->get('text_percent');
		$data['text_amount'] = $this->language->get('text_amount');
		$data['text_times'] = $this->language->get('text_times');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_discount'] = $this->language->get('entry_discount');
		$data['entry_type'] = $this->language->get('entry_type');
		$data['entry_total'] = $this->language->get('entry_total');
		$data['entry_product'] = $this->language->get('entry_product');
		$data['entry_date_start'] = $this->language->get('entry_date_start');
		$data['entry_date_end'] = $this->language->get('entry_date_end');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_times'] = $this->language->get('entry_times');
		$data['entry_info'] = $this->language->get('entry_info');
		$data['entry_order'] = $this->language->get('entry_order');
		$data['entry_max'] = $this->language->get('entry_max');

		$data['help_type'] = $this->language->get('help_type');
		$data['help_total'] = $this->language->get('help_total');
		$data['help_product'] = $this->language->get('help_product');
		$data['help_discount'] = $this->language->get('help_discount');
		$data['help_times'] = $this->language->get('help_times');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['token'] = $this->session->data['token'];

		if (isset($this->request->get['shop_coupon_id'])) {
			$data['shop_coupon_id'] = $this->request->get['shop_coupon_id'];
		} else {
			$data['shop_coupon_id'] = 0;
		}

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

		if (isset($this->error['type'])) {
			$data['error_type'] = $this->error['type'];
		} else {
			$data['error_type'] = '';
		}

		if (isset($this->error['times'])) {
			$data['error_times'] = $this->error['times'];
		} else {
			$data['error_times'] = '';
		}

		if (isset($this->error['discount'])) {
			$data['error_discount'] = $this->error['discount'];
		} else {
			$data['error_discount'] = '';
		}

		if (isset($this->error['total'])) {
			$data['error_total'] = $this->error['total'];
		} else {
			$data['error_total'] = '';
		}
		
		if (isset($this->error['coupon_product'])) {
			$data['error_coupon_product'] = $this->error['coupon_product'];
		} else {
			$data['error_coupon_product'] = '';
		}

		if (isset($this->error['date_start'])) {
			$data['error_date_start'] = $this->error['date_start'];
		} else {
			$data['error_date_start'] = '';
		}

		if (isset($this->error['date_end'])) {
			$data['error_date_end'] = $this->error['date_end'];
		} else {
			$data['error_date_end'] = '';
		}

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['shop_coupon_id'])) {
			$data['action'] = $this->url->link('localisation/coupon/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('localisation/coupon/edit', 'token=' . $this->session->data['token'] . '&shop_coupon_id=' . $this->request->get['shop_coupon_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('localisation/coupon', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['shop_coupon_id']) && (!$this->request->server['REQUEST_METHOD'] != 'POST')) {
			$coupon_info = $this->model_localisation_coupon->getCoupon($this->request->get['shop_coupon_id']);
		}
		

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($coupon_info)) {
			$data['name'] = $coupon_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['type'])) {
			$data['type'] = $this->request->post['type'];
		} elseif (!empty($coupon_info)) {
			$data['type'] = $coupon_info['type'];
		} else {
			$data['type'] = 'P';
		}

		if (isset($this->request->post['discount'])) {
			$data['discount'] = $this->request->post['discount'];
		} elseif (!empty($coupon_info)) {
			$data['discount'] = $coupon_info['discount'];
		} else {
			$data['discount'] = 0;
		}

		if (isset($this->request->post['times'])) {
			$data['times'] = $this->request->post['times'];
		} elseif (!empty($coupon_info)) {
			$data['times'] = $coupon_info['times'];
		} else {
			$data['times'] = 0;
		}

		if (isset($this->request->post['max_amount'])) {
			$data['max_amount'] = $this->request->post['max_amount'];
		} elseif (!empty($coupon_info)) {
			$data['max_amount'] = $coupon_info['max_amount'];
		} else {
			$data['max_amount'] = 0;
		}

		if (isset($this->request->post['total'])) {
			$data['total'] = $this->request->post['total'];
		} elseif (!empty($coupon_info)) {
			$data['total'] = $coupon_info['total'];
		} else {
			$data['total'] = 0;
		}

		if (isset($this->request->post['info'])) {
			$data['info'] = $this->request->post['info'];
		} elseif (!empty($coupon_info)) {
			$data['info'] = $coupon_info['info'];
		} else {
			$data['info'] = '';
		}

		if (isset($this->request->post['coupon_product'])) {
			$products = $this->request->post['coupon_product'];

		} elseif (isset($this->request->get['shop_coupon_id'])) {
			$products = $this->model_localisation_coupon->getCouponProducts($this->request->get['shop_coupon_id']);
			if($products){
				$products = explode(',', $products);
			}else{
				$products = array();
			}
		} else {
			$products = array();
		}

		$this->load->model('localisation/product');

		$data['coupon_product'] = array();

		foreach ($products as $product_id) {
			$product_info = $this->model_localisation_product->getProduct($product_id);

			if ($product_info) {
				$data['coupon_product'][] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name']
				);
			}
		}

		if (isset($this->request->post['date_start'])) {
			$data['date_start'] = $this->request->post['date_start'];
		} elseif (!empty($coupon_info)) {
			$data['date_start'] = ($coupon_info['date_start'] != '0000-00-00' ? $coupon_info['date_start'] : '');
		} else {
			$data['date_start'] = date('Y-m-d', time());
		}

		if (isset($this->request->post['date_end'])) {
			$data['date_end'] = $this->request->post['date_end'];
		} elseif (!empty($coupon_info)) {
			$data['date_end'] = ($coupon_info['date_end'] != '0000-00-00' ? $coupon_info['date_end'] : '');
		} else {
			$data['date_end'] = date('Y-m-d', strtotime('+1 month'));
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($coupon_info)) {
			$data['status'] = $coupon_info['status'];
		} else {
			$data['status'] = true;
		}

		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($coupon_info)) {
			$data['sort_order'] = $coupon_info['sort_order'];
		} else {
			$data['sort_order'] = 0;
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/coupon_form.tpl', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'localisation/coupon')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 128)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		$coupon_info = $this->model_localisation_coupon->getCouponByName($this->request->post['name']);

		if (!isset($this->request->get['shop_coupon_id'])) {
			if ($coupon_info) {
				$this->error['warning'] = $this->language->get('error_exists');
			}
		} else {
			if ($coupon_info && ($this->request->get['shop_coupon_id'] != $coupon_info['shop_coupon_id'])) {
				$this->error['warning'] = $this->language->get('error_exists');
			}
		}

		if(!empty($this->request->post['type'])) {
			//首次减免
			if((int)$this->request->post['type'] == 1) {
				//第一次订单全单9折
				if(!(float)$this->request->post['discount'] ) {
					$this->error['discount'] = $this->language->get('error_discount');
				}

			} elseif( (int)$this->request->post['type'] == 2 ) {

				//固定金额
				// 买满30送某个产品或折扣
				if(!(float)$this->request->post['total']) {
					$this->error['total'] = $this->language->get('error_total');
				}

			} elseif((int)$this->request->post['type'] == 3) {
				//购买次数
				//预定9次第10次免费（免费部分为前九次订单总额的百分之10-20，或前几次消费的均价)
				if(!(int)$this->request->post['times']) {
					$this->error['times'] = $this->language->get('error_times');
				}

				if(!(float)$this->request->post['discount'])  {
					$this->error['discount'] = $this->language->get('error_discount');
				}
			}
		} else {
			$this->error['type'] = $this->language->get('error_type');
		}


		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'localisation/coupon')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('localisation/coupon');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_localisation_coupon->getCoupons($filter_data,1);
			
			foreach ($results as $result) {
				$json[] = array(
					'shop_coupon_id' => $result['shop_coupon_id'],
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