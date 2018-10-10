<?php
class ControllerLocalisationLocation extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('localisation/location');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/location');

		$this->getList();
	}

	public function add() {
		$this->load->language('localisation/location');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/location');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_location->addLocation($this->request->post);

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

			$this->response->redirect($this->url->link('localisation/location', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('localisation/location');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/location');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->model_localisation_location->editLocation($this->request->get['location_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('localisation/location', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('localisation/location');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/location');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $location_id) {
				$this->model_localisation_location->deleteLocation($location_id);
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

			$this->response->redirect($this->url->link('localisation/location', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'l.name';
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

		$data['breadcrumbs'] =   array();

		$data['breadcrumbs'][] =   array(
			'text' =>  $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] =   array(
			'text' =>  $this->language->get('heading_title'),
			'href' =>  $this->url->link('localisation/location', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('localisation/location/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('localisation/location/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['location'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$location_total = $this->model_localisation_location->getTotalLocations();

		$results = $this->model_localisation_location->getLocations($filter_data);

		foreach ($results as $result) {
			$data['location'][] =   array(
				'location_id' => $result['location_id'],
				'name'        => $result['name'],
				'address'     => $result['address'],
				'edit'        => $this->url->link('localisation/location/edit', 'token=' . $this->session->data['token'] . '&location_id=' . $result['location_id'] . $url, 'SSL')
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_address'] = $this->language->get('column_address');
		$data['column_action'] = $this->language->get('column_action');

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

		$data['sort_name'] = $this->url->link('localisation/location', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$data['sort_address'] = $this->url->link('localisation/location', 'token=' . $this->session->data['token'] . '&sort=address' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $location_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('localisation/location', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($location_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($location_total - $this->config->get('config_limit_admin'))) ? $location_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $location_total, ceil($location_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/location_list.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['location_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_geocode'] = $this->language->get('text_geocode');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_address'] = $this->language->get('entry_address');
		$data['entry_geocode'] = $this->language->get('entry_geocode');
		$data['entry_telephone'] = $this->language->get('entry_telephone');
		$data['entry_fax'] = $this->language->get('entry_fax');
		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_open'] = $this->language->get('entry_open');
		$data['entry_comment'] = $this->language->get('entry_comment');
		$data['entry_staff'] = $this->language->get('entry_staff');

		$data['help_geocode'] = $this->language->get('help_geocode');
		$data['help_open'] = $this->language->get('help_open');
		$data['help_comment'] = $this->language->get('help_comment');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		#@
		$data['button_image_add'] = $this->language->get('button_image_add');
		$data['button_remove'] = $this->language->get('button_remove');

		$data['tab_store'] = $this->language->get('tab_store');
		$data['tab_time'] = $this->language->get('tab_time');
		$data['tab_image'] = $this->language->get('tab_image');
		$data['tab_info'] = $this->language->get('tab_info');
		

		$data['entry_consume'] = $this->language->get('entry_consume');
		$data['entry_tag'] = $this->language->get('entry_tag');
		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_afternoon'] = $this->language->get('entry_afternoon');
		$data['entry_morning'] = $this->language->get('entry_morning');
		$data['entry_takeaway'] = $this->language->get('entry_takeaway');
		$data['entry_delivery'] = $this->language->get('entry_delivery');
		$data['entry_begin'] = $this->language->get('entry_begin');
		$data['entry_end'] = $this->language->get('entry_end');
		$data['entry_time'] = $this->language->get('entry_time');
		$data['entry_exclude'] = $this->language->get('entry_exclude');
		$data['entry_coupon'] = $this->language->get('entry_coupon');
		$data['entry_geo'] = $this->language->get('entry_geo');
		$data['entry_day'] = $this->language->get('entry_day');
		$data['entry_bgimage'] = $this->language->get('entry_bgimage');
		$data['entry_color'] = $this->language->get('entry_color');
		$data['entry_color1'] = $this->language->get('entry_color1');

		if (isset($this->error['image'])) {
			$data['error_image'] = $this->error['image'];
		} else {
			$data['error_image'] = '';
		}

		if (isset($this->error['bgimage'])) {
			$data['error_bgimage'] = $this->error['bgimage'];
		} else {
			$data['error_bgimage'] = '';
		}

		if (isset($this->error['tag'])) {
			$data['error_tag'] = $this->error['tag'];
		} else {
			$data['error_tag'] = '';
		}

		if (isset($this->error['geocode'])) {
			$data['error_geocode'] = $this->error['geocode'];
		} else {
			$data['error_geocode'] = '';
		}

		if (isset($this->error['consume'])) {
			$data['error_consume'] = $this->error['consume'];
		} else {
			$data['error_consume'] = '';
		}
		#@

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

		if (isset($this->error['geo'])) {
			$data['error_geo'] = $this->error['geo'];
		} else {
			$data['error_geo'] = '';
		}

		if (isset($this->error['address'])) {
			$data['error_address'] = $this->error['address'];
		} else {
			$data['error_address'] = '';
		}

		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		} else {
			$data['error_telephone'] = '';
		}

		if (isset($this->error['staff'])) {
			$data['error_staff'] = $this->error['staff'];
		} else {
			$data['error_staff'] = '';
		}

		if (isset($this->error['color'])) {
			$data['error_color'] = $this->error['color'];
		} else {
			$data['error_color'] = '';
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
			'href' => $this->url->link('localisation/location', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['location_id'])) {
			$data['action'] = $this->url->link('localisation/location/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('localisation/location/edit', 'token=' . $this->session->data['token'] .  '&location_id=' . $this->request->get['location_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('localisation/location', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['location_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$location_info = $this->model_localisation_location->getLocation($this->request->get['location_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('setting/store');

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($location_info)) {
			$data['name'] = $location_info['name'];
		} else {
			$data['name'] =   '';
		}

		if (isset($this->request->post['address'])) {
			$data['address'] = $this->request->post['address'];
		} elseif (!empty($location_info)) {
			$data['address'] = $location_info['address'];
		} else {
			$data['address'] = '';
		}

		if (isset($this->request->post['geocode'])) {
			$data['geocode'] = $this->request->post['geocode'];
		} elseif (!empty($location_info)) {
			$data['geocode'] = $location_info['geocode'];
		} else {
			$data['geocode'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($location_info)) {
			$data['telephone'] = $location_info['telephone'];
		} else {
			$data['telephone'] = '';
		}

		if (isset($this->request->post['fax'])) {
			$data['fax'] = $this->request->post['fax'];
		} elseif (!empty($location_info)) {
			$data['fax'] = $location_info['fax'];
		} else {
			$data['fax'] = '';
		}

		if (isset($this->request->post['image'])) {
			$data['image'] = $this->request->post['image'];
		} elseif (!empty($location_info)) {
			$data['image'] = $location_info['image'];
		} else {
			$data['image'] = '';
		}

		if (isset($this->request->post['bgimage'])) {
			$data['bgimage'] = $this->request->post['bgimage'];
		} elseif (!empty($location_info)) {
			$data['bgimage'] = $location_info['bgimage'];
		} else {
			$data['bgimage'] = '';
		}

		if (isset($this->request->post['color'])) {
			$data['color'] = $this->request->post['color'];
		} elseif (!empty($location_info)) {
			$data['color'] = $location_info['color'];
		} else {
			$data['color'] = '';
		}

		if (isset($this->request->post['color1'])) {
			$data['color1'] = $this->request->post['color1'];
		} elseif (!empty($location_info)) {
			$data['color1'] = $location_info['color1'];
		} else {
			$data['color1'] = '';
		}

		if (isset($this->request->post['user_id'])) {
			$data['user_id'] = $this->request->post['user_id'];
		} elseif (!empty($location_info)) {
			$data['user_id'] = $location_info['user_id'];
		} else {
			$data['user_id'] = '';
		}

		if (!empty($data['user_id'])) {
			$this->load->model('user/user');

			$user_info = $this->model_user_user->getUser($data['user_id']);
			$data['staff'] = $user_info['username'];

		} else {
			$data['staff'] = "";
		}


		$this->load->model('tool/image');

		if (isset($this->request->post['image']) && is_file(DIR_IMAGE . $this->request->post['image'])) {
			$data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
		} elseif (!empty($location_info) && is_file(DIR_IMAGE . $location_info['image'])) {
			$data['thumb'] = $this->model_tool_image->resize($location_info['image'], 100, 100);
		} else {
			$data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		if (isset($this->request->post['bgimage']) && is_file(DIR_IMAGE . $this->request->post['bgimage'])) {
			$data['bgthumb'] = $this->model_tool_image->resize($this->request->post['bgimage'], 490, 132);
		} elseif (!empty($location_info) && is_file(DIR_IMAGE . $location_info['bgimage'])) {
			$data['bgthumb'] = $this->model_tool_image->resize($location_info['bgimage'], 490, 132);
		} else {
			$data['bgthumb'] = $this->model_tool_image->resize('no_image.png', 490, 132);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 490, 132);

		if (isset($this->request->post['open'])) {
			$data['open'] = $this->request->post['open'];
		} elseif (!empty($location_info)) {
			$data['open'] = $location_info['open'];
		} else {
			$data['open'] = '';
		}

		if (isset($this->request->post['comment'])) {
			$data['comment'] = $this->request->post['comment'];
		} elseif (!empty($location_info)) {
			$data['comment'] = $location_info['comment'];
		} else {
			$data['comment'] = '';
		}

		#@
		//consume
		if (isset($this->request->post['consume'])) {
			$data['consume'] = $this->request->post['consume'];
		} elseif (!empty($location_info)) {
			$data['consume'] = $location_info['consume'];
		} else {
			$data['consume'] = 0;
		}

		// tags
		$this->load->model('catalog/tag');
		if (isset($this->request->post['tag_ids']) && is_array($this->request->post['tag_ids'])) {
			$tags = $this->request->post['tag_ids'];
		} elseif (!empty($location_info)) {
			$tags = explode(',', $location_info['tag_ids']);
		} else {
			$tags = array();
		}
		$data['tags'] = array();
		
		if(is_array($tags)){		
			foreach ($tags as $tag_id) {
				$tag_info = $this->model_catalog_tag->getTag($tag_id);

				if ($tag_info) {
					$data['tags'][] = array(
						'tag_id' => $tag_info['tag_id'],
						'name' => $tag_info['name'],
					);
				}
			}
		}		

		// geos
		$this->load->model('localisation/geo_zone');
		if(isset($this->request->post['geo_zone_id'])) {
			$geo_zone_info= $this->model_localisation_geo_zone->getGeoZone($this->request->post['geo_zone_id']);
			$data['geo'] = $geo_zone_info['name'];
			$data['geo_zone_id'] = $this->request->post['geo_zone_id'];
		} elseif (!empty($location_info)) {

			$data['geo_zone_id']=  $location_info['geo_zone_id'];
			$geo_zone_info= $this->model_localisation_geo_zone->getGeoZone($location_info['geo_zone_id']);
			if(!empty($geo_zone_info)) {
				$data['geo'] = $geo_zone_info['name'];
			}else{
				$data['geo'] = '';
			}
		} else {
			$data['geo_zone_id'] = 0;
			$data['geo'] = "";
		}

		// coupons
		$this->load->model('localisation/coupon');
		if (isset($this->request->post['coupon_ids']) && is_array($this->request->post['coupon_ids'])) {
			$coupons = $this->request->post['coupon_ids'];
		} elseif (!empty($location_info)) {
			$coupons = explode(',', $location_info['coupon_ids']);
		} else {
			$coupons = array();
		}
		$data['coupons'] = array();
		
		if(is_array($coupons)){		
			foreach ($coupons as $coupon_ids) {
				$coupon_info = $this->model_localisation_coupon->getCoupon($coupon_ids);

				if ($coupon_info) {
					$data['coupons'][] = array(
						'shop_coupon_id' => $coupon_info['shop_coupon_id'],
						'name' => $coupon_info['name'],
					);
				}
			}
		}
		// Images
		$this->load->model('tool/image');

		if (isset($this->request->post['shop_image'])) {
			$shop_images = $this->request->post['shop_image'];
		} elseif (isset($this->request->get['location_id'])) {
			$shop_images = $this->model_localisation_location->getShopImages($this->request->get['location_id']);
		} else {
			$shop_images = array();
		}

		$data['shop_images'] = array();

		foreach ($shop_images as $shop_image) {
			if (is_file(DIR_IMAGE . $shop_image['image'])) {
				$image = $shop_image['image'];
				$thumb = $shop_image['image'];
			} else {
				$image = '';
				$thumb = 'no_image.png';
			}

			$data['shop_images'][] = array(
				'image'      => $image,
				'thumb'      => $this->model_tool_image->resize($thumb, 100, 100),
				'sort_order' => $shop_image['sort_order']
			);
		}

		$data['times'] = array();
		$data['unavailables'] = array();
		$data['pretime']= array('delivery'=>0,'pickup'=>0);

		//shop_time
		if (isset($this->request->post['times'])) {
			$data['times'] = $this->request->post['times'];
			$data['unavailables'] = $this->request->post['unavailables'];
			$data['pretime'] = $this->request->post['pretime'];
			
		} elseif (isset($this->request->get['location_id'])) {
			$times = $this->model_localisation_location->getShopTimes($this->request->get['location_id']);


			if(!empty($times['times'])) {
				$data['times'] = unserialize($times['times']);
			}
			
			if(!empty($times['unavailable'])) {
				$data['unavailables'] = unserialize($times['unavailable']);
			}
			// echo "<pre>";
			// var_dump($data['unavailables']);die;

			if(!empty($times['pretime'])) {
				$data['pretime'] = unserialize($times['pretime']);
			}

		}

		//shop_info
		if (isset($this->request->post['info'])) {

			$data['infos'] = $this->request->post['infos'];

		} elseif (isset($this->request->get['location_id'])) {

			$data['infos'] = $this->model_localisation_location->getShopInfos($this->request->get['location_id']);

		} else {
			$data['infos'] = array();
		}		

		
		#@
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/location_form.tpl', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'localisation/location')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if ((utf8_strlen($this->request->post['address']) < 3) || (utf8_strlen($this->request->post['address']) > 128)) {
			$this->error['address'] = $this->language->get('error_address');
		}

		if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}

		#@
		if(!isset($this->request->post['image'])) {
			$this->error['image'] = $this->language->get('error_image');
		}

		if(empty($this->request->post['user_id'])) {
			$this->error['staff'] = $this->language->get('error_staff');
		}

		if(empty($this->request->post['geocode'])) {
			$this->error['geocode'] = $this->language->get('error_geocode');
		}

		if(!isset($this->request->post['tag_ids'])) {
			$this->error['tag'] = $this->language->get('error_tag');
		}

		if(!is_numeric($this->request->post['consume'])) {
			$this->error['consume'] = $this->language->get('error_consume');
		}
		#@

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'localisation/location')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	#@
	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/tag');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_catalog_tag->getTags($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'tag_id' => $result['tag_id'],
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

	#@
	public function autoShopComplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('localisation/location');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_localisation_location->getLocations($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'location_id' => $result['location_id'],
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

	public function autoUserComplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('user/user');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_user_user->getUsers($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'user_id' => $result['user_id'],
					'name'            => strip_tags(html_entity_decode($result['username'], ENT_QUOTES, 'UTF-8'))
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