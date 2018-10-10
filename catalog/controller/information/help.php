<?php
class ControllerInformationHelp extends Controller {
	public function index() {
		$data = array();
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/help.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/information/help.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/information/help.tpl', $data));
		}
	}
}