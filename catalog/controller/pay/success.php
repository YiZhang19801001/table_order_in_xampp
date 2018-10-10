<?php
class ControllerPaySuccess extends Controller {
	public function index() {

		if(empty($this->session->data['order_id'])) {
			$redirect = $this->url->link('common/home', '', 'SSL');
		}
		if (isset($this->session->data['order_id'])) {

			$data['order'] = $this->url->link('account/order', '', 'SSL');
			$data['logout'] = $this->url->link('account/logout', '', 'SSL');
			$data['detail'] = $this->url->link('account/detail', '', 'SSL');

			$data['isLogged'] = $this->customer->isLogged();
			
			$this->load->model('account/order');

			$location_id = $this->session->data['location_id'];

			$data['order_id'] = $order_id = $this->session->data['order_id'];

			$order_info = $this->model_account_order->getOrder($order_id);

			$order_info['total'] = $this->currency->format($order_info['total']);

			$data['order_info'] = $order_info;

			$this->load->model('localisation/location');

			$this->load->model('tool/image');

			$data['location_info'] = $location_info = $this->model_localisation_location->getLocation($location_id);


			if(is_file(DIR_IMAGE . $location_info['image'])){

				$data['logo'] = $this->model_tool_image->resize($location_info['image'], 140, 140);
			}

			$this->load->model('shop/info');

			$data['times_info'] = $this->model_shop_info->getShopTimes($location_id);

			$this->cart->clear();

			// Add to activity log
			$this->load->model('account/activity');

			if ($this->customer->isLogged()) {
				$activity_data = array(
					'customer_id' => $this->customer->getId(),
					'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName(),
					'order_id'    => $this->session->data['order_id']
				);

				$this->model_account_activity->addActivity('order_account', $activity_data);
			} else {
				$activity_data = array(
					'name'     => $this->session->data['shipping_address']['firstname']. ' ' .$this->session->data['shipping_address']['lastname'],
					'order_id' => $this->session->data['order_id']
				);

				$this->model_account_activity->addActivity('order_guest', $activity_data);
			}

			//send email
			if (isset($order_info['email']) ) {

				$order_time = $order_info['shipping_orderDate'] ." ". $order_info['shipping_orderTime'];

				$subject = "Your Order ".$order_info['order_id']." has been placed.\n";

				$message = "Dear ".$order_info['firstname'] .",\n\n";
				$message .= "Congratulations! Your Order ".$order_info['order_id']." has been placed.\n";
				$message .= "Your order will be ready by the estimated time ". $order_time.".\n";
				$message .= "Regards\n";
				$message .= $order_info['store_name']."\n";

				$this->load->language('mail/customer');

				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
				$mail->smtp_username = $this->config->get('config_mail_smtp_username');
				$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
				$mail->smtp_port = $this->config->get('config_mail_smtp_port');
				$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

				$mail->setTo($order_info['email']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
				$mail->setSubject($subject);
				$mail->setText($message);
				$mail->send();
			}
			// echo "<pre>";
			// var_dump($_SESSION);die;
			// unset($this->session->data['shipping_method']);
			// unset($this->session->data['payment_method']);
			// unset($this->session->data['comment']);
			unset($this->session->data['order_id']);
			unset($this->session->data['coupon']);
			unset($this->session->data['location_id']);
			unset($this->session->data['shipping_orderTime']);
			unset($this->session->data['shipping_orderDate']);
			unset($this->session->data['shipping_address']['orderTime']);
			unset($this->session->data['shipping_address']['orderDate']);
			// unset($this->session->data['geo_zone_id']);
			// unset($this->session->data['isp']);
			// unset($this->session->data['zone_id']);

			$data['heading_title'] = $this->language->get('heading_title');

			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');



			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/success.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/common/success.tpl', $data));
			}
		} else {
			$this->response->redirect($redirect);
		}
	}
}