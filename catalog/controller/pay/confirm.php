<?php
header("Cache-Control: no-cache");
class ControllerPayConfirm extends Controller {
	public function index() {

		if(isset($this->session->data['location_id'])) {

			$data['order'] = $this->url->link('account/order', '', 'SSL');
			$data['logout'] = $this->url->link('account/logout', '', 'SSL');
			$data['detail'] = $this->url->link('account/detail', '', 'SSL');

			$data['isLogged'] = $this->customer->isLogged();

			$location_id = $this->session->data['location_id'];
			$redirect = '';
			// Validate if payment method has been set.
			if (!isset($this->session->data['payment_method'])) {
				$redirect = $this->url->link('pay/checkout', '', 'SSL');
			}

			// Validate cart has products and has stock.
			if (!$this->cart->hasProducts($location_id)){
				$redirect = $this->url->link('common/home');
			}

			// Validate minimum quantity requirements.
			$products = $this->cart->getProducts($location_id);

			foreach ($products as $product) {
				$product_total = 0;

				foreach ($products as $product_2) {
					if ($product_2['product_id'] == $product['product_id']) {
						$product_total += $product_2['quantity'];
					}
				}

				if ($product['minimum'] > $product_total) {
					$redirect = $this->url->link('common/home');
					break;
				}
			}
			
			if (!$redirect) {
				$order_data = array();


				$order_data['totals'] = array();
				$total = 0;
				$taxes = $this->cart->getTaxes();

				$this->load->model('extension/extension');

				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}
				array_multisort($sort_order, SORT_ASC, $results);
				
				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('total/' . $result['code']);

						$this->{'model_total_' . $result['code']}->getTotal($order_data['totals'], $total, $taxes);
					}
				}

				$sort_order = array();

				foreach ($order_data['totals'] as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $order_data['totals']);


				$order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
				$order_data['store_id'] = $location_id;
				$order_data['store_name'] = $this->config->get('config_name');

				if ($order_data['store_id']) {
					$order_data['store_url'] = $this->config->get('config_url');
				} else {
					$order_data['store_url'] = HTTP_SERVER;
				}

				//shipping
				$order_data['shipping_firstname'] = $this->session->data['shipping_address']['firstname'] ? $this->session->data['shipping_address']['firstname'] : "";
				$order_data['shipping_lastname'] = $this->session->data['shipping_address']['lastname'] ? $this->session->data['shipping_address']['lastname'] : "";
				$order_data['shipping_address_1'] = $this->session->data['shipping_address']['address_1'] ? $this->session->data['shipping_address']['address_1'] : "";
				$order_data['shipping_address_2'] = $this->session->data['shipping_address']['address_2'] ? $this->session->data['shipping_address']['address_2'] : "";
				$order_data['shipping_email'] = $this->session->data['shipping_address']['email'] ? $this->session->data['shipping_address']['email'] : "";
				$order_data['shipping_telephone'] = $this->session->data['shipping_address']['telephone'] ? $this->session->data['shipping_address']['telephone'] : "";
				$order_data['shipping_suburb'] = $this->session->data['shipping_address']['suburb'] ? $this->session->data['shipping_address']['suburb'] : "";
				$order_data['shipping_suburb_id'] = $this->session->data['shipping_address']['suburb_id'] ? $this->session->data['shipping_address']['suburb_id'] : 0;
				$order_data['shipping_method'] = $this->session->data['shipping_address']['method'] ? $this->session->data['shipping_address']['method'] : "";
				$order_data['shipping_orderTime'] = $this->session->data['shipping_address']['orderTime'] ? $this->session->data['shipping_address']['orderTime'] : "";
				$order_data['shipping_orderDate'] = $this->session->data['shipping_address']['orderDate'] ? $this->session->data['shipping_address']['orderDate'] : "";
				$order_data['shipping_orderWhen'] = $this->session->data['shipping_address']['orderWhen'] ? $this->session->data['shipping_address']['orderWhen'] : "";

				$order_data['comment'] = $this->session->data['comment'] ? $this->session->data['comment'] : "";

				$suburb_info = $this->model_shop_info->getSuburbInfo($order_data['shipping_suburb_id']);

				if ($suburb_info) {
					//country
					$order_data['shipping_country_id'] = $suburb_info['country_id'];
					$country_info = $this->model_shop_info->getCountry($suburb_info['country_id']);
					$order_data['shipping_country'] = $country_info['name'];
					//state
					$order_data['shipping_state_id'] = $suburb_info['state_id'];
					$state_info = $this->model_shop_info->getState($suburb_info['state_id']);
					$order_data['shipping_state'] = $state_info['name'];

				} else {

					$order_data['shipping_country_id'] = 0;
					$order_data['shipping_country'] = "";
					$order_data['shipping_state_id'] = 0;
					$order_data['shipping_state'] = "";

				}

				//user
				if ($this->customer->isLogged()) {
					$this->load->model('account/customer');

					$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

					$order_data['customer_id'] = $this->customer->getId();
					$order_data['customer_group_id'] = $customer_info['customer_group_id'];
					$order_data['firstname'] = $customer_info['firstname'];
					$order_data['lastname'] = $customer_info['lastname'];
					$order_data['fax'] = $customer_info['fax'];

				} else {

					$order_data['customer_id'] = 0;
					$order_data['customer_group_id'] = $this->config->get('config_customer_group_id');
					$order_data['firstname'] = $order_data['shipping_firstname'];
					$order_data['lastname'] = $order_data['shipping_lastname'];
					$order_data['fax'] = "";
				}

				$order_data['email'] = $order_data['shipping_email'];
				$order_data['telephone'] = $order_data['shipping_telephone'];

				//payment
				$order_data['payment_firstname'] = $this->session->data['shipping_address']['firstname'];
				$order_data['payment_lastname'] = $this->session->data['shipping_address']['lastname'];
				$order_data['payment_address_1'] = $this->session->data['shipping_address']['address_1'];
				$order_data['payment_address_2'] = $this->session->data['shipping_address']['address_2'];

				$order_data['payment_state'] = $order_data['shipping_state'];
				$order_data['payment_state_id'] = $order_data['shipping_state_id'];
				$order_data['payment_country'] = $order_data['shipping_country'];
				$order_data['payment_country_id'] = $order_data['shipping_country_id'];
				$order_data['payment_suburb'] = $order_data['shipping_suburb'];
				$order_data['payment_suburb_id'] = $order_data['shipping_suburb_id'];


				if (isset($this->session->data['payment_method']['title'])) {
					$order_data['payment_method'] = $this->session->data['payment_method']['title'];
				} else {
					$order_data['payment_method'] = '';
				}

				if (isset($this->session->data['payment_method']['code'])) {
					$order_data['payment_code'] = $this->session->data['payment_method']['code'];
				} else {
					$order_data['payment_code'] = '';
				}

				//product
				$order_data['products'] = array();

				foreach ($this->cart->getProducts($location_id) as $product) {
					$option_data = array();

					foreach ($product['option'] as $option) {
						$option_data[] = array(
							'product_option_id'       => $option['product_option_id'],
							'product_option_value_id' => $option['product_option_value_id'],
							'option_id'               => $option['option_id'],
							'option_value_id'         => $option['option_value_id'],
							'name'                    => $option['name'],
							'value'                   => $option['value'],
							'type'                    => $option['type']
						);
					}

					$exts = array();

					if(!empty($product['ext'])) {

						foreach ($product['ext'] as $ext) {
							$exts[] = array(
								'product_ext_id' => $ext['product_ext_id'],
							);	
						}
					}

					$order_data['products'][] = array(
						'product_id' => $product['product_id'],
						'name'       => $product['name'],
						'model'      => $product['model'],
						'option'     => $option_data,
						'download'   => $product['download'],
						'quantity'   => $product['quantity'],
						'subtract'   => $product['subtract'],
						'price'      => $product['price'],
						'total'      => $product['total'],
						'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
						'reward'     => $product['reward'],
						'exts' => $exts
					);
				}

				//truetotal
				$order_data['total'] = $total;
				// Gift Voucher
				$order_data['vouchers'] = array();

				if (!empty($this->session->data['vouchers'])) {
					foreach ($this->session->data['vouchers'] as $voucher) {
						$order_data['vouchers'][] = array(
							'description'      => $voucher['description'],
							'code'             => substr(md5(mt_rand()), 0, 10),
							'to_name'          => $voucher['to_name'],
							'to_email'         => $voucher['to_email'],
							'from_name'        => $voucher['from_name'],
							'from_email'       => $voucher['from_email'],
							'voucher_theme_id' => $voucher['voucher_theme_id'],
							'message'          => $voucher['message'],
							'amount'           => $voucher['amount']
						);
					}
				}

				//coupon
				$order_data['coupon'] = array();

				if (!empty($this->session->data['coupon'][$location_id])) {
					$this->load->model('shop/info');

					$coupon_info = $this->model_shop_info->getCoupon($this->session->data['coupon'][$location_id]);

					$discount_total = 0;
					$sub_total = 0;
					$title = "";
					foreach ($this->cart->getProducts($location_id) as $product) {
						if($product['is_discount']){
							$sub_total += $product['total'];
						}
					}
					
					$this->load->model('account/order');
					$is_login = $this->customer->getId();

					if($is_login) {
						$times = $this->model_account_order->getTotalOrders();
					} else {
						$times = 0;
					}

					$coupon_array = array(
						'coupon_id' => $this->session->data['coupon'][$location_id],
						'times' => $times,
						'price' => $sub_total,
					);

					$couponFeeInfo = $this->model_shop_info->getCouponFee($coupon_array);

					if ($couponFeeInfo['is_use']) {
						$discount_total = $couponFeeInfo['price'];
					}

					$info = "";

					if ($couponFeeInfo['type'] == 2) {

						$info = $this->session->data['discount_comment'];
					}

					if ($couponFeeInfo['type'] == 3) {

						if ($couponFeeInfo['is_use']) {
							$info = 'loyalty credit '.$this->currency->format($couponFeeInfo['totalPrice']) .' total can be redeemed for this order';
						} else {
							$info = 'loyalty credit '.$this->currency->format($couponFeeInfo['currentPrice']). '  this order; '. $this->currency->format($couponFeeInfo['totalPrice']) .' total; '.$couponFeeInfo['n'].' orders to go';
						}
					}
 
					$order_data['coupon'] = array(
						'name' => $coupon_info['name'],
						'type' => $coupon_info['type'],
						'amount' => $discount_total,
						'info' => $info
					);

				}

				if (isset($this->request->cookie['tracking'])) {
					$order_data['tracking'] = $this->request->cookie['tracking'];

					$subtotal = $this->cart->getSubTotal($location_id);

					// Affiliate
					$this->load->model('affiliate/affiliate');

					$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);

					if ($affiliate_info) {
						$order_data['affiliate_id'] = $affiliate_info['affiliate_id'];
						$order_data['commission'] = ($subtotal / 100) * $affiliate_info['commission'];
					} else {
						$order_data['affiliate_id'] = 0;
						$order_data['commission'] = 0;
					}

					// Marketing
					$this->load->model('checkout/marketing');

					$marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);

					if ($marketing_info) {
						$order_data['marketing_id'] = $marketing_info['marketing_id'];
					} else {
						$order_data['marketing_id'] = 0;
					}
				} else {
					$order_data['affiliate_id'] = 0;
					$order_data['commission'] = 0;
					$order_data['marketing_id'] = 0;
					$order_data['tracking'] = '';
				}

				$order_data['language_id'] = $this->config->get('config_language_id');
				$order_data['currency_id'] = $this->currency->getId();
				$order_data['currency_code'] = $this->currency->getCode();
				$order_data['currency_value'] = $this->currency->getValue($this->currency->getCode());
				$order_data['ip'] = $this->request->server['REMOTE_ADDR'];

				if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
					$order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
				} elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
					$order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
				} else {
					$order_data['forwarded_ip'] = '';
				}

				if (isset($this->request->server['HTTP_USER_AGENT'])) {
					$order_data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
				} else {
					$order_data['user_agent'] = '';
				}

				if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
					$order_data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
				} else {
					$order_data['accept_language'] = '';
				}

				$this->load->model('checkout/order');
				
				$this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);
				
				//支付
				$data['payment'] = $this->load->controller('payment/' . $this->session->data['payment_method']['code']);


				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/pay/confirm.tpl')) {
					$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/pay/confirm.tpl', $data));
				} else {
					$this->response->setOutput($this->load->view('default/template/pay/confirm.tpl', $data));
				}
			} else {
				$this->response->redirect($redirect);
			}
		}
	}
}