<?php
class ControllerApiSendemail extends Controller {

	public function index() {

		if (isset($this->request->get['k']) && $this->request->get['k'] == ApiKey) {		
			if (isset($this->request->get['order_id'])) {
				$order_id = $this->request->get['order_id'];
			} else {
				$order_id = 0;
			}

			if (isset($this->request->get['order_status_id'])) {
				$order_status_id = $this->request->get['order_status_id'];
			} else {
				$order_status_id = 0;
			}

			if ($order_id) {		
				$order_info = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$order_id . "'");

				$data['order_info'] = $order_info->row;

				if (isset($data['order_info']['email']) && (int)$order_status_id == 4 ) {

					$subject = "Your order ".$data['order_info']['order_id']." has been cancelled.\n";

					$message = "Dear ".$data['order_info']['firstname'] .",\n\n";
					$message .= "We would like to confirm with you that your order ".$data['order_info']['order_id']." (Total Amount ".$this->currency->format($data['order_info']['total']).") has now been cancelled. If your order was paid by credit card or PayPal, we will send you another email shortly to confirm your money is refunded to your account.\n";
					$message .= "Regards\n";
					$message .= $data['order_info']['store_name']."\n";
					
					$this->load->language('mail/customer');

					$mail = new Mail();
					$mail->protocol = $this->config->get('config_mail_protocol');
					$mail->parameter = $this->config->get('config_mail_parameter');
					$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
					$mail->smtp_username = $this->config->get('config_mail_smtp_username');
					$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
					$mail->smtp_port = $this->config->get('config_mail_smtp_port');
					$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
						
					$mail->setTo($data['order_info']['email']);
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
					$mail->setSubject($subject);
					$mail->setText($message);
					$mail->send();


					//store_id
					$store_id = $data['order_info']['store_id'];
					$this->load->model('localisation/location');
					$location_info = $this->model_localisation_location->getLocation($store_id);

					//user_id
					if (!empty($location_info['user_id'])) {

						$user_info = $this->model_localisation_location->getUser($location_info['user_id']);			
						$url  = $data['order_info']['store_url']."admin/index.php?route=sale/order/edit&order_id=".$data['order_info']['order_id'];
						//send manager
						$subject = "The order ".$data['order_info']['order_id']." has been cancelled.\n";

						$message = "Dear ".$user_info['firstname'] .",\n\n";
						$message .= "The order ".$data['order_info']['order_id']." (Total Amount ".$this->currency->format($data['order_info']['total']).") has now been cancelled. Press on the following link to process the refund of this order : ".$url."\n";
						$message .= "Regards\n";
						$message .= $data['order_info']['store_name']."\n";

						$mail = new Mail();
						$mail->protocol = $this->config->get('config_mail_protocol');
						$mail->parameter = $this->config->get('config_mail_parameter');
						$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
						$mail->smtp_username = $this->config->get('config_mail_smtp_username');
						$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
						$mail->smtp_port = $this->config->get('config_mail_smtp_port');
						$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

						$mail->setTo($user_info['email']);
						$mail->setFrom($this->config->get('config_email'));
						$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
						$mail->setSubject($subject);
						$mail->setText($message);
						$mail->send();
					}


				}	

				if (isset($data['order_info']['email']) && (int)$order_status_id == 5 ) {

					$subject = "Your Order ".$data['order_info']['order_id']." has been refunded.\n";

					$message = "Dear ".$data['order_info']['firstname'] .",\n\n";
					$message .= "Your Order ".$data['order_info']['order_id']." (Total Amount ".$this->currency->format($data['order_info']['total']).") has been refunded.\n";
					$message .= "Regards\n";
					$message .= $data['order_info']['store_name']."\n";
					
					$this->load->language('mail/customer');

					$mail = new Mail();
					$mail->protocol = $this->config->get('config_mail_protocol');
					$mail->parameter = $this->config->get('config_mail_parameter');
					$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
					$mail->smtp_username = $this->config->get('config_mail_smtp_username');
					$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
					$mail->smtp_port = $this->config->get('config_mail_smtp_port');
					$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
						
					$mail->setTo($data['order_info']['email']);
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
					$mail->setSubject($subject);
					$mail->setText($message);
					$mail->send();

					//store_id
					$store_id = $data['order_info']['store_id'];
					$this->load->model('localisation/location');
					$location_info = $this->model_localisation_location->getLocation($store_id);
					//user_id
					if (!empty($location_info['user_id'])) {

						$user_info = $this->model_localisation_location->getUser($location_info['user_id']);			

						//send manager
						$subject = "The order ".$data['order_info']['order_id']." has been refunded successfully.\n";

						$message = "Dear ".$user_info['firstname'] .",\n\n";
						$message .= "The order ".$data['order_info']['order_id']." (Total Amount ".$this->currency->format($data['order_info']['total']).") has been refunded successfully.\n";
						$message .= "Regards\n";
						$message .= $data['order_info']['store_name']."\n";

						$mail = new Mail();
						$mail->protocol = $this->config->get('config_mail_protocol');
						$mail->parameter = $this->config->get('config_mail_parameter');
						$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
						$mail->smtp_username = $this->config->get('config_mail_smtp_username');
						$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
						$mail->smtp_port = $this->config->get('config_mail_smtp_port');
						$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

						$mail->setTo($user_info['email']);
						$mail->setFrom($this->config->get('config_email'));
						$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
						$mail->setSubject($subject);
						$mail->setText($message);
						$mail->send();
					}

				}
				$json = "send success!";
			} else {
				$json = "Order_id not found!";
			}
		} else {
			$json = 'Apikey validation error!';
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}