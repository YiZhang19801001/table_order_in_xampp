<?php
class ControllerAccountLogin extends Controller {
	private $error = array();

	public function index() {
		if ($this->customer->isLogged()) {
			$this->response->redirect($this->url->link('common/home', '', 'SSL'));
		}
		$data['logged'] = $this->customer->isLogged();
		$data['home'] = $this->url->link('common/home', '', 'SSL');
		$data['title'] = $this->document->getTitle();

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$data['icon'] = $server . 'image/' . $this->config->get('config_icon');
		} else {
			$data['icon'] = '';
		}

		$this->document->setTitle($this->language->get('heading_title'));
		$data['footer'] = $this->load->controller('common/footer');
		 $data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/login.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/login.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/login.tpl', $data));
		}
	}
}