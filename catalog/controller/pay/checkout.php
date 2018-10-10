<?php
header("Cache-Control: no-cache");

class ControllerPayCheckout extends Controller
{
    private $error = array();

    public function index()
    {

        $data = array();
        $this->load->language('pay/checkout');

        $this->document->setTitle($this->language->get('heading_title'));

        $data['order']  = $this->url->link('account/order', '', 'SSL');
        $data['logout'] = $this->url->link('account/logout', '', 'SSL');
        $data['detail'] = $this->url->link('account/detail', '', 'SSL');

        $this->load->model('shop/info');
        $this->load->model('localisation/location');
        $this->load->model('localisation/suburb');

        //location_id
        if (!empty($this->request->post['location_id'])) {
            $location_id = $this->request->post['location_id'];

        } elseif (!empty($this->session->data['location_id'])) {
            $location_id = $this->session->data['location_id'];

        } else {
            $location_id = 0;
        }

        $data['order_id'] = '';

        //reorder 重复购买
        if (isset($this->request->get['reorder'])) {

            //clear cart
            $this->cart->clear();

            $order_id = $data['order_id'] = $this->request->get['reorder'];
            $this->load->model('account/order');

            $order_info = $this->model_account_order->getOrder($order_id);

            if (!empty($order_info)) {

                $location_id    = $order_info['store_id'];
                $data['change'] = $this->url->link('shop/info', 'location_id=' . $location_id);

                $products = $this->model_account_order->getOrderProducts($order_id);

                $this->load->model('catalog/product');

                foreach ($products as $product) {

                    $product_info = $this->model_catalog_product->getProduct($product['product_id']);

                    if ($product_info) {

                        $ext  = "";
                        $exts = $this->model_account_order->getOrderExts($product['order_product_id']);

                        if (!empty($exts)) {
                            foreach ($exts as $v) {
                                $ext[] = $v['product_ext_id'];
                            }
                        }
                        if ($ext) {
                            asort($ext);
                            $ext = implode(',', $ext);
                        }

                        $option  = array();
                        $options = $this->model_account_order->getOrderOptions($product['order_id'], $product['order_product_id']);
                        if (!empty($options)) {
                            $option[$options['product_option_id']] = $options['product_option_value_id'];
                        }
                        if (!empty($option)) {
                            $option = array_filter($option);
                        } else {
                            $option = array();
                        }

                        $this->cart->add($product['product_id'], $product['quantity'], $option, $location_id, $ext);
                    }
                }
            }
        }

        if (empty($location_id)) {
            $redirect = $this->url->link('common/home', '', 'SSL');
        }

        $location_info = $this->model_localisation_location->getLocation($location_id);

        $data['color'] = $location_info['color'];

        $data['isLogged'] = $this->customer->isLogged();

        if (!empty($location_id)) {

            // date_default_timezone_set('Etc/GMT-10');

            //post
            if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['pay'])) {

                if ($this->request->post['delivery_method'] == "Delivery") {

                    if (empty($this->request->post['shipping_address_1'])) {
                        $this->error['shipping_address_1'] = $this->language->get('error_shipping_address_1');
                    }

                    if (empty($this->request->post['shipping_address_2'])) {
                        $this->error['shipping_address_2'] = $this->language->get('error_shipping_address_2');
                    }
                }

                if (empty($this->request->post['shipping_firstname'])) {
                    $this->error['firstname'] = $this->language->get('error_firstname');
                }

                if (empty($this->request->post['shipping_lastname'])) {
                    $this->error['lastname'] = $this->language->get('error_lastname');
                }

                if ($this->request->post['shipping_orderWhen'] == "later") {
                    if (empty($this->request->post['shipping_orderDate']) || empty($this->request->post['shipping_orderTime'])) {
                        $this->error['orderWhen'] = $this->language->get('error_orderWhen');
                    }
                } else {
                    if (isset($this->session->data['shipping_address']['orderDate'])) {

                        $orderDate = date("Y-m-d", strtotime($this->session->data['shipping_address']['orderDate']));
                        $now_day   = date("Y-m-d", time());

                        //判断是否是当天
                        if (strtotime($orderDate) != strtotime($now_day)) {
                            $this->error['now_day'] = true;
                        }
                    }
                }

                if ((utf8_strlen($this->request->post['shipping_email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['shipping_email'])) {
                    $this->error['email'] = $this->language->get('error_email');
                }

                if ((utf8_strlen($this->request->post['shipping_telephone']) < 3) || (utf8_strlen($this->request->post['shipping_telephone']) > 32)) {
                    $this->error['telephone'] = $this->language->get('error_telephone');
                }

                if (!isset($this->request->post['first_warring']) && empty($this->error)) {

                    //判断是否符合第一次购买
                    $shipping_email     = $this->request->post['shipping_email'];
                    $shipping_address_1 = isset($this->request->post['shipping_address_1']) ? $this->request->post['shipping_address_1'] : "";
                    $shipping_address_2 = isset($this->request->post['shipping_address_2']) ? $this->request->post['shipping_address_2'] : "";

                    $this->load->model('pay/checkout');

                    $is_first = $this->model_pay_checkout->checkFirst($shipping_address_1, $shipping_address_2, $shipping_email, $location_id);

                    $is_login = $this->customer->isLogged();

                    $coupon_info = array();
                    if (isset($this->session->data['coupon'][$location_id])) {
                        $coupon_id   = $this->session->data['coupon'][$location_id];
                        $coupon_info = $this->model_shop_info->getCoupon($coupon_id);
                    }

                    if ($coupon_info['type'] == 1 && $is_first) {

                        $warring_info = 'The following discounts are not available: first time discount</br>Press checkout and the order will be placed without the discount.';

                        $this->session->data['first_warring'] = true;

                    } elseif ($coupon_info['type'] == 3 && !$is_login) {

                        $warring_info_available = "";

                        if ($is_first) {
                            $warring_info_available = '<br />the follwing discounts are still available: first time discount';
                        }

                        $warring_info = 'Please <a href="javascript:;" class="w23LoginBth">log in</a> to use loyalty discount. Press Checkout to ignore.<br />the following discounts are not available: loyalty discount(until you <a href="javascript:;" class="w23LoginBth">log in</a>)' . $warring_info_available;

                        $this->session->data['first_warring'] = true;
                    }

                } else {
                    unset($this->session->data['first_warring']);
                }

                $times_info = $this->model_shop_info->getShopTimes($location_id);
                //时间判断
                $oldtime  = strtotime($this->request->post['shipping_orderTime']); //预定
                $temptime = 5 * 60;

                if (!isset($this->session->data['isp']) || $this->session->data['isp'] == 1) {

                    $jg_time = $times_info['pretime']['delivery'] ? $times_info['pretime']['delivery'] : 0;
                } else {
                    $jg_time = $times_info['pretime']['pickup'] ? $times_info['pretime']['pickup'] : 0;
                }

                $nowtime = time(); //当前时间

                if ($oldtime - $nowtime < $jg_time * 60 - $temptime && $this->request->post['shipping_orderWhen'] != "now") {
                    $this->error['time_rest'] = true;
                }

                if (empty($this->error) && !isset($this->session->data['first_warring'])) {

                    //payment
                    $payment = array(
                        1 => array(
                            'title' => "Visa",
                            'code'  => "pp_pro",
                        ),
                        2 => array(
                            'title' => "Master Card",
                            'code'  => "pp_pro",
                        ),
                        3 => array(
                            'title' => "AMEX",
                            'code'  => "pp_pro",
                        ),
                        4 => array(
                            'title' => "Visa Checkout",
                            'code'  => "pp_pro",
                        ),
                        5 => array(
                            'title' => "Masterpass",
                            'code'  => "pp_pro",
                        ),
                        6 => array(
                            'title' => "PayPal",
                            'code'  => "pp_standard",
                        ),
                        7 => array(
                            'title' => "Cash",
                            'code'  => "cod",
                        ),
                    );

                    //payment
                    $this->session->data['payment_method']['title'] = $payment[$this->request->post['payment_method']]['title'];
                    $this->session->data['payment_method']['code']  = $payment[$this->request->post['payment_method']]['code'];

                    //shipping
                    $this->session->data['shipping_address']['firstname'] = $this->request->post['shipping_firstname'];
                    $this->session->data['shipping_address']['lastname']  = $this->request->post['shipping_lastname'];
                    $this->session->data['shipping_address']['address_1'] = isset($this->request->post['shipping_address_1']) ? $this->request->post['shipping_address_1'] : "";
                    $this->session->data['shipping_address']['address_2'] = isset($this->request->post['shipping_address_2']) ? $this->request->post['shipping_address_2'] : "";
                    $this->session->data['shipping_address']['email']     = $this->request->post['shipping_email'];
                    $this->session->data['shipping_address']['telephone'] = $this->request->post['shipping_telephone'];
                    $this->session->data['shipping_address']['suburb']    = isset($this->session->data['zone']) ? $this->session->data['zone'] : "";
                    $this->session->data['shipping_address']['suburb_id'] = isset($this->session->data['zone_id']) ? (int)$this->session->data['zone_id'] : 0;
                    $this->session->data['shipping_address']['method']    = $this->session->data['shipping_method'];

                    $this->session->data['shipping_address']['orderTime'] = $this->request->post['shipping_orderTime'];
                    $this->session->data['shipping_address']['orderDate'] = $this->request->post['shipping_orderDate'];

                    if ($this->request->post['shipping_orderWhen'] == "now") {
                        // date_default_timezone_set('PRC');
                        $data['times_array'] = array();
                        // $times_info = $this->model_shop_info->getShopTimes($location_id);

                        foreach ($times_info['times'] as $k => $v) {

                            if ($v['week'] == date("w")) {

                                if (!isset($this->session->data['isp']) || $this->session->data['isp'] == 1) {

                                    $jg_time = $times_info['pretime']['delivery'] ? $times_info['pretime']['delivery'] : 0;

                                    if ($v['md_begintime'] && $v['md_endtime']) {

                                        $begintime = $v['md_begintime'];
                                        $endtime   = $v['md_endtime'];
                                    }

                                    if ($v['nd_begintime'] && $v['nd_endtime']) {

                                        $begintime = $v['nd_begintime'];
                                        $endtime   = $v['nd_endtime'];
                                    }

                                } elseif ($this->session->data['isp'] == 2) {

                                    $jg_time = $times_info['pretime']['pickup'] ? $times_info['pretime']['pickup'] : 0;

                                    if ($v['mt_begintime'] && $v['mt_endtime']) {

                                        $begintime = $v['mt_begintime'];
                                        $endtime   = $v['mt_endtime'];
                                    }

                                    if ($v['nt_begintime'] && $v['nt_endtime']) {

                                        $begintime = $v['nt_begintime'];
                                        $endtime   = $v['nt_endtime'];
                                    }
                                }

                                if (strtotime($begintime) < time()) {
                                    $begintime = date('H:i', time());
                                }

                                // var_dump($begintime);die;

                                $begintime = strtotime(" +$jg_time minute", strtotime($begintime));
                                $begintime = date('H:i', $begintime);
                            }
                        }

                        $this->session->data['shipping_address']['orderTime'] = $begintime;
                        $this->session->data['shipping_address']['orderDate'] = date('D j M ', time());

                    }

                    // echo "<pre>";
                    // var_dump($_SESSION);die;

                    $this->session->data['shipping_address']['orderWhen'] = $this->request->post['shipping_orderWhen'];

                    //comment
                    $this->session->data['comment'] = $this->request->post['comment'];

                    $pay_url = $this->url->link('pay/confirm', '', 'SSL');
                    $this->response->redirect($pay_url);
                }
            }

            //

            if (isset($this->error['shipping_address_1'])) {
                $data['error_shipping_address_1'] = $this->error['shipping_address_1'];
            } else {
                $data['error_shipping_address_1'] = '';
            }

            if (isset($this->error['shipping_address_2'])) {
                $data['error_shipping_address_2'] = $this->error['shipping_address_2'];
            } else {
                $data['error_shipping_address_2'] = '';
            }

            if (isset($this->error['orderWhen'])) {
                $data['error_orderWhen'] = $this->error['orderWhen'];
            } else {
                $data['error_orderWhen'] = '';
            }

            if (isset($this->error['firstname'])) {
                $data['error_firstname'] = $this->error['firstname'];
            } else {
                $data['error_firstname'] = '';
            }

            if (isset($this->error['lastname'])) {
                $data['error_lastname'] = $this->error['lastname'];
            } else {
                $data['error_lastname'] = '';
            }

            if (isset($this->error['email'])) {
                $data['error_email'] = $this->error['email'];
            } else {
                $data['error_email'] = '';
            }

            if (isset($this->error['telephone'])) {

                $data['error_telephone'] = $this->error['telephone'];

            } else {
                $data['error_telephone'] = '';
            }

            if (isset($this->error['now_day'])) {

                $data['now_day'] = $this->error['now_day'];

            } else {
                $data['now_day'] = false;
            }

            if (!empty($this->request->post['first_warring'])) {

                $data['first_warring'] = $this->request->post['first_warring'];

            } elseif (isset($this->session->data['first_warring'])) {

                $data['first_warring'] = $this->session->data['first_warring'];

                unset($this->session->data['first_warring']);
            } else {
                $data['first_warring'] = "";
            }

            if (!empty($this->request->post['shipping_firstname'])) {

                $data['shipping_firstname'] = $this->request->post['shipping_firstname'];

            } elseif (isset($this->session->data['shipping_address']['firstname'])) {

                $data['shipping_firstname'] = $this->session->data['shipping_address']['firstname'];
            } else {
                $data['shipping_firstname'] = $this->customer->getFirstName();
            }

            if (!empty($this->request->post['shipping_lastname'])) {

                $data['shipping_lastname'] = $this->request->post['shipping_lastname'];

            } elseif (isset($this->session->data['shipping_address']['lastname'])) {

                $data['shipping_lastname'] = $this->session->data['shipping_address']['lastname'];
            } else {
                $data['shipping_lastname'] = $this->customer->getLastName();
            }

            $this->load->model('account/address');

            $address = $this->customer->getAddressId();

            if (!empty($address)) {
                $address_info = $this->model_account_address->getAddress($address);
            }

            if (!empty($this->request->post['shipping_address_1'])) {

                $data['shipping_address_1'] = $this->request->post['shipping_address_1'];

            } elseif (!empty($address_info['address_1'])) {

                $data['shipping_address_1'] = $address_info['address_1'];

            } elseif (isset($this->session->data['shipping_address']['address_1'])) {

                $data['shipping_address_1'] = $this->session->data['shipping_address']['address_1'];

            } else {

                $data['shipping_address_1'] = '';

            }

            if (!empty($this->request->post['shipping_address_2'])) {

                $data['shipping_address_2'] = $this->request->post['shipping_address_2'];

            } elseif (!empty($address_info['address_2'])) {

                $data['shipping_address_2'] = $address_info['address_2'];

            } elseif (isset($this->session->data['shipping_address']['address_2'])) {

                $data['shipping_address_2'] = $this->session->data['shipping_address']['address_2'];
            } else {
                $data['shipping_address_2'] = '';
            }

            if (!empty($this->request->post['payment_method'])) {

                $data['payment_method'] = $this->request->post['payment_method'];
            } else {
                $data['payment_method'] = 0;
            }

            if (!empty($this->request->post['comment'])) {

                $data['comment'] = $this->request->post['comment'];

            } elseif (isset($this->session->data['comment'])) {

                $data['comment'] = $this->session->data['comment'];
            } else {
                $data['comment'] = '';
            }

            if (!empty($this->request->post['shipping_orderWhen'])) {

                $data['shipping_orderWhen'] = $this->request->post['shipping_orderWhen'];

            } elseif (isset($this->session->data['shipping_address']['orderWhen'])) {

                $data['shipping_orderWhen'] = $this->session->data['shipping_address']['orderWhen'];

            } else {
                if ($this->session->data['time_open']) {

                    $data['shipping_orderWhen'] = 'now';
                } else {
                    $data['shipping_orderWhen'] = "later";
                }
            }

            if (!empty($this->request->post['shipping_orderDate'])) {

                $data['shipping_orderDate'] = $this->request->post['shipping_orderDate'];

            } elseif (isset($this->session->data['shipping_address']['orderDate'])) {

                $data['shipping_orderDate'] = $this->session->data['shipping_address']['orderDate'];

            } else {
                $data['shipping_orderDate'] = '';
            }

            if (!empty($this->request->post['shipping_orderTime'])) {

                $data['shipping_orderTime'] = $this->request->post['shipping_orderTime'];

            } elseif (isset($this->session->data['shipping_address']['orderTime'])) {

                $data['shipping_orderTime'] = $this->session->data['shipping_address']['orderTime'];

            } else {
                $data['shipping_orderTime'] = '';
            }

            if (isset($this->error['time_rest'])) {

                $data['shipping_orderTime'] = '';

            }

            if (!empty($this->request->post['shipping_email'])) {

                $data['shipping_email'] = $this->request->post['shipping_email'];

            } elseif (isset($this->session->data['shipping_address']['email'])) {

                $data['shipping_email'] = $this->session->data['shipping_address']['email'];
            } else {
                $data['shipping_email'] = $this->customer->getEmail();
            }

            if (!empty($this->request->post['shipping_telephone'])) {

                $data['shipping_telephone'] = $this->request->post['shipping_telephone'];

            } elseif (isset($this->session->data['shipping_address']['telephone'])) {

                $data['shipping_telephone'] = $this->session->data['shipping_address']['telephone'];

            } else {
                $data['shipping_telephone'] = $this->customer->getFax();
            }

            if (isset($warring_info)) {
                $data['warring_info'] = $warring_info;
            } else {
                $data['warring_info'] = "";
            }

            // date_default_timezone_set('PRC');

            $total            = 0;
            $productPrice     = 0;
            $deliveryPrice    = 0;
            $couponPrice      = 0;
            $tureProductPrice = 0;

            $times = array();

            $data['location_id'] = $this->session->data['location_id'] = $location_id;
            $location_info       = $this->model_localisation_location->getLocation($location_id);
            //Suburb
            if (isset($this->session->data['isp'])) {

                $data['delivery_method'] = "";
                $data['suburb_info']     = array();

                //suburb_info

                //price
                $deliveryPrice = 0;
                if ($this->session->data['isp'] == 1) {
                    $suburb_info                 = $this->model_localisation_suburb->getSuburb((int)$this->session->data['zone_id']);
                    $data['suburb_info']         = $suburb_info;
                    $this->session->data['zone'] = $suburb_info['name'];

                    $data['delivery_method'] = "Delivery";
                    $deliveryPrice           = $this->model_shop_info->getDeliveryFee($location_info['geo_zone_id'], $this->session->data['zone_id']);

                } elseif ($this->session->data['isp'] == 2) {

                    unset($this->session->data['zone_id']);
                    unset($this->session->data['zone']);
                    unset($this->session->data['geo_zone_id']);

                    $data['delivery_method'] = "Pick-up";
                }

                $data['isp']                            = $this->session->data['isp'] ? $this->session->data['isp'] : 1;
                $this->session->data['shipping_method'] = $data['delivery_method'];

                $begintime           = 0;
                $endtime             = 0;
                $jg_time             = 0;
                $data['days']        = array();
                $data['times_array'] = array();
                $d                   = isset($this->session->data['day_time']) ? $this->session->data['day_time'] : "";

                $times_info = $this->model_shop_info->getShopTimes($location_id);
                foreach ($times_info['times'] as $k => $v) {

                    $data['days'][] = (int)$v['week'];

                    if ($v['week'] == $d) {

                        if (!isset($this->session->data['isp']) || $this->session->data['isp'] == 1) {

                            $jg_time = $times_info['pretime']['delivery'] ? $times_info['pretime']['delivery'] : 0;

                            if ($v['md_begintime'] && $v['md_endtime']) {
                                $begintime = $v['md_begintime'];
                                $endtime   = $v['md_endtime'];
                            }

                            if ($v['nd_begintime'] && $v['nd_endtime']) {

                                $begintime = $v['nd_begintime'];
                                $endtime   = $v['nd_endtime'];
                            }

                        } elseif ($this->session->data['isp'] == 2) {

                            $jg_time = $times_info['pretime']['pickup'] ? $times_info['pretime']['pickup'] : 0;

                            if ($v['mt_begintime'] && $v['mt_endtime']) {

                                $begintime = $v['mt_begintime'];
                                $endtime   = $v['mt_endtime'];
                            }

                            if ($v['nt_begintime'] && $v['nt_endtime']) {

                                $begintime = $v['nt_begintime'];
                                $endtime   = $v['nt_endtime'];
                            }
                        }

                        $begintime = strtotime(" +$jg_time minute", strtotime($begintime));

                        //当前时间
                        if (strtotime($begintime) < time()) {
                            $begintime = date('H:i', time());
                        }

                        $begintime = strtotime(" +$jg_time minute", strtotime($begintime));
                        $shi       = date('H', $begintime);
                        $fen       = date('i', $begintime);

                        $fen = $fen + 15 - $fen % 15;

                        if ($fen >= 60) {
                            $fen = $fen - 60;
                            $shi = $shi + 1;
                        }

                        $begintime = $shi . ":" . $fen;

                        for ($i = strtotime($begintime); $i <= strtotime($endtime); $i = $i + 15 * 60) {
                            if ($i >= time()) {
                                $data['times_array'][] = date('H:i', $i);
                            }
                        }
                    }
                }
            }

            $data['unavailable'] = array();
            if (!empty($times_info['unavailable'])) {

                foreach ($times_info['unavailable'] as $un) {

                    $un['begintime'] = strtotime($un['begintime']);
                    $un['endtime']   = strtotime($un['endtime']);

                    $data['unavailable'][] = array($un['begintime'], $un['endtime']);

                }
            }

            //cart
            $data['cart'] = array();
            $data['cart'] = $this->cart->getProducts($location_id);

            if (!empty($data['cart'])) {
                foreach ($data['cart'] as $key => &$value) {
                    if ($value['is_discount']) {
                        $tureProductPrice += $value['total'];
                    }
                    $productPrice += $value['total'];
                    $value['total'] = $this->currency->format($value['total']);
                    $value['price'] = $this->currency->format($value['price'] * $value['quantity']);
                    if (!empty($value['option'])) {
                        $value['option'] = $value['option'][0];
                    }
                    $value['exts'] = array();
                    if (!empty($value['ext'])) {
                        foreach ($value['ext'] as $v) {
                            $type_info                                   = array();
                            $type_info                                   = $this->model_shop_info->getProductAddType($v['type']);
                            $value['exts'][$type_info['name']]['exts'][] = array(
                                'name'  => $v['name'],
                                'price' => $this->currency->format($v['price']),
                            );
                            $value['exts'][$type_info['name']]['type']     = $type_info['type'];
                            $value['exts'][$type_info['name']]['required'] = $type_info['required'];
                        }
                    }
                    unset($value['ext']);
                }
                unset($value);
            }

            //consume
            $data['consume_text'] = $consume = $location_info['consume'];

            $data['is_consume'] = 0;

            if ($consume) {
                if ($productPrice < $consume) {
                    $data['remaining']  = $this->currency->format($consume - $productPrice);
                    $data['is_consume'] = 1;

                }
            }

            //coupon
            $this->load->model('account/order');
            $is_login = $this->customer->getId();

            if ($is_login) {
                $times = $this->model_account_order->getTotalOrders();
            } else {
                $times = 0;
            }

            //totalprice
            if ($is_login) {
                $totalprice = $this->model_account_order->getTotalByCustomerId();
            } else {
                $totalprice = 0;
            }

            $coupon_id       = "";
            $coupon_info     = array();
            $tureCouponPrice = 0;

            if (isset($this->session->data['coupon'][$location_id])) {

                $coupon_id = $this->session->data['coupon'][$location_id];

                $coupon_info  = $this->model_shop_info->getCoupon($coupon_id);
                $data['type'] = $coupon_info['type'];

                $coupon_array = array(
                    'coupon_id'  => $coupon_id,
                    'times'      => $times,
                    'price'      => $tureProductPrice,
                    'totalPirce' => $totalprice,
                );
                $couponPrice_info = $this->model_shop_info->getCouponFee($coupon_array);

                //计算总价的优惠价
                if ($is_login && $couponPrice_info['is_use']) {

                    $tureCouponPrice = $couponPrice_info['price'];
                } else {
                    $tureCouponPrice = 0;
                }

                //discount_comment
                $discount_comment = "";

                if ($coupon_info['type'] == 2) {
                    if (isset($this->request->post['discount_comment'])) {

                        $discount_comment = $this->session->data['discount_comment'] = $this->request->post['discount_comment'];

                    } elseif (isset($this->session->data['discount_comment'])) {

                        $discount_comment = $this->session->data['discount_comment'];

                    } else {
                        //一种商品的情况
                        $coupon_product = $this->model_shop_info->getCouponProduct($coupon_info['coupon_product_ids']);

                        if ($coupon_product) {
                            $discount_comment = $coupon_product[0]['name'];
                        }

                        $this->session->data['discount_comment'] = $discount_comment;
                    }
                }

                $data['discount_comment'] = $discount_comment;

                //type=3

                if ($coupon_info['type'] == 3) {

                    $totalPrice   = 0;
                    $currentPrice = $tureProductPrice / $coupon_info['times'];

                    $m             = $times % ($coupon_info['times'] + 1);
                    $data['times'] = $coupon_info['times'] - $m;

                    $query = $this->db->query("SELECT total FROM `" . DB_PREFIX . "order` WHERE customer_id = '" . (int)$this->customer->getId() . "' AND order_status_id = 3 ORDER BY order_id DESC LIMIT 0," . (int)$m);

                    if ($query->num_rows) {
                        $query_total = 0;
                        foreach ($query->rows as $key => $value) {
                            $query_total += $value['total'];
                        }

                        $totalPrice = $query_total / $coupon_info['times'] + $currentPrice;
                    }

                    if ($m == $coupon_info['times']) {
                        $totalPrice = $query_total / $coupon_info['times'];
                    }

                    if ($totalPrice == 0) {

                        $totalPrice = $currentPrice;
                    }

                    $data['price']        = $this->currency->format($totalPrice);
                    $data['currentPrice'] = $this->currency->format($currentPrice);

                }

            }

            $data['coupon_id'] = $coupon_id;

            if ($coupon_info) {

                $data['coupon_name'] = $coupon_info['name'];
            } else {
                $data['coupon_name'] = "";
            }

            if ($productPrice < $consume) {
                $trueprice = $consume - $tureCouponPrice;

                if ($trueprice < 0) {
                    $trueprice = 0;
                }

                $total = $deliveryPrice + $trueprice;
            } else {
                $trueprice = $productPrice - $tureCouponPrice;

                if ($trueprice < 0) {
                    $trueprice = 0;
                }

                $total = $deliveryPrice + $trueprice;
            }

            $total   = $total > 0 ? $total : 0;
            $is_free = false;

            if (empty($deliveryPrice)) {
                $is_free = true;
            }

            $data['is_free'] = $is_free;

            $data['productPrice_text'] = $productPrice;

            $data['couponPrice']   = isset($couponPrice_info) ? $this->currency->format($couponPrice_info['price']) : 0;
            $data['productPrice']  = $this->currency->format($productPrice);
            $data['deliveryPrice'] = $this->currency->format($deliveryPrice);
            $data['consume']       = $this->currency->format($consume);
            $data['total']         = $this->currency->format($total);

            $data['info_finish'] = false;
            if ($data['shipping_firstname'] && $data['shipping_lastname'] && $data['shipping_email'] && $data['shipping_telephone'] && !$this->error) {

                $data['info_finish'] = true;
            }

            $data['ship_info'] = false;
            if ($data['shipping_address_1'] && $data['shipping_address_2'] && $data['shipping_orderDate'] && $data['shipping_orderTime'] && !$this->error) {

                $data['ship_info'] = true;
            }

            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/pay/checkout.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/pay/checkout.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/pay/checkout.tpl', $data));
            }
        } else {
            //home
            $this->response->redirect($redirect);
        }
    }

    public function mobile()
    {
        $json = array();

        $this->load->model('shop/info');
        $this->load->model('localisation/location');
        $this->load->model('localisation/suburb');

        //location_id
        if (!empty($this->request->post['location_id'])) {
            $location_id = $this->request->post['location_id'];

        } elseif (!empty($this->session->data['location_id'])) {
            $location_id = $this->session->data['location_id'];

        } else {
            $location_id = 0;
        }

        if (!empty($location_id)) {
            $json['status'] = true;
            $cartarr        = array();
            $cartarr        = $this->cart->getProducts($location_id);

            if($cartarr) {
                $json['url_message'] = '';
                $json['product']     = array();
                $i = 0;
                foreach ($cartarr as $k => $v) {
                    $i++;
                    if(count($cartarr) == $i) {
                        $json['url_message'] .= $v['upc'] . ',' . $v['quantity'] . ',0';
                    } else {
                        $json['url_message'] .= $v['upc'] . ',' . $v['quantity'] . ',0;';
                    }
                    $json['product'][] = array(
                        'product_id' => $v['product_id'],
                        'quantity' => $v['quantity'],
                        'name' => $v['name'],
                    );
                }
                // 存入session
                $_SESSION['mobile_message'] = $json;
            }
        } else {
            $json['status'] = false;
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));

    }

    public function qrCode()
    {
        $message = '';
        if (isset($this->request->get['message'])) {
            $message = $this->request->get['message'];
        }
        include DIR_SYSTEM . 'phpqrcode/qrlib.php';
        QRcode::png($message);die;
    }

}
