<?php
class ControllerShopInfo extends Controller
{
    private $error = array();

    public function index()
    {
        $this->load->language('shop/info');

        $this->document->setTitle($this->language->get('heading_title'));

        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $data['logged'] = $this->customer->isLogged();
        $data['order']  = $this->url->link('account/order', '', 'SSL');
        // $data['first_name'] = $this->customer->getFirstName();
        $data['logout'] = $this->url->link('account/logout', '', 'SSL');
        $data['detail'] = $this->url->link('account/detail', '', 'SSL');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shop/info.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/shop/info.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/shop/info.tpl', $data));
        }
    }

    public function ajaxReturn()
    {

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['location_id'])) {

            $timezone = date_default_timezone_get(); //时区

            $result = array();

            $total            = 0;
            $productPrice     = 0;
            $deliveryPrice    = 0;
            $couponPrice      = 0;
            $tureProductPrice = 0;

            //shopInfo
            $this->load->model('localisation/location');

            $this->load->model('tool/image');

            $this->load->model('shop/info');

            $result['shopInfo']   = array();
            $result['schedule']   = array();
            $result['couponList'] = array();

            $location_id   = (int) $this->request->post['location_id'];
            $location_info = $this->model_localisation_location->getLocation($location_id);

            if (!empty($location_info)) {
                //logo
                $logo = "";
                if (is_file(DIR_IMAGE . $location_info['image'])) {

                    $logo = $this->model_tool_image->resize($location_info['image'], 140, 140);
                }
                //bgimage
                $bgimage = "";
                if (is_file(DIR_IMAGE . $location_info['bgimage'])) {

                    $bgimage = $this->model_tool_image->resize($location_info['bgimage'], 981, 265);
                }

                //tags
                $tag_ids = array();
                $tags    = array();

                if (!empty($location_info['tag_ids'])) {
                    $tag_ids = explode(',', $location_info['tag_ids']);
                }

                if (!empty($tag_ids)) {
                    foreach ($tag_ids as $tag_id) {
                        $tag_info = $this->model_shop_info->getTag($tag_id);
                        if (!empty($tag_info['name'])) {
                            $tags[] = $tag_info['name'];
                        }
                    }
                    if (!empty($tags)) {
                        $tags = implode(',', $tags);
                    }
                }

                //photos
                $photos      = array();
                $shop_images = $this->model_shop_info->getShopImages($location_id);

                if (!empty($shop_images)) {
                    foreach ($shop_images as $shop_image) {
                        if (is_file(DIR_IMAGE . $shop_image['image'])) {
                            $image = $shop_image['image'];
                        } else {
                            $image = 'no_image.png';
                        }
                        $photos[] = $this->model_tool_image->resize($image, 600, 400);
                    }
                }

                $this->load->model('shop/reviews');
                //star//totalReview

                $star_info = $this->model_shop_reviews->getInfoByLocationId($location_id);

                $totalReview = $this->model_shop_reviews->getTotalReviewsByLocationId($location_id);

                $shopInfo = $this->model_shop_info->getShopInfos($location_id);

                if ($shopInfo) {
                    foreach ($shopInfo as &$v) {
                        $v['info'] = stripslashes($v['info']);
                    }
                    unset($v);
                }

                //delivery
                $result['delivery'] = array();

                $this->session->data['geo_zone_id'] = (int) $location_info['geo_zone_id']; //区域群组
                //shipping_method
                if (!empty($this->request->post['isp'])) {
                    $this->session->data['isp'] = $this->request->post['isp'];
                }

                if (!empty($this->request->post['zone_id'])) {
                    $this->session->data['zone_id'] = $this->request->post['zone_id'];
                    //deliveryPrice
                    $deliveryPrice = $this->model_shop_info->getDeliveryFee($location_info['geo_zone_id'], $this->request->post['zone_id']);

                } elseif (!empty($this->session->data['zone_id'])) {
                    $deliveryPrice = $this->model_shop_info->getDeliveryFee($location_info['geo_zone_id'], $this->session->data['zone_id']);
                } else {
                    unset($this->session->data['zone_id']);
                    unset($this->session->data['geo_zone_id']);
                }

                if (!empty($this->request->post['shipping_orderDate'])) {
                    $this->session->data['shipping_address']['orderDate'] = $this->request->post['shipping_orderDate'];
                }

                if (!empty($this->request->post['shipping_orderTime'])) {
                    $this->session->data['shipping_address']['orderTime'] = $this->request->post['shipping_orderTime'];
                }

                if (!empty($location_info['geo_zone_id'])) {

                    $result['delivery'] = $this->model_shop_info->getDeliverys($location_info['geo_zone_id'], $location_id);
                }
                $times_info = $this->model_shop_info->getShopTimes($location_id);

                $day = array(
                    1 => 'Monday ',
                    2 => 'Tuesday',
                    3 => 'Wednesday',
                    4 => 'Thursday',
                    5 => 'Friday',
                    6 => 'Saturday',
                    0 => 'Sunday',
                );

                $is_open = 1;

                $d_open = 1;
                $t_open = 1;

                $times = array();

                $days = array();

                $d = date("w");

                $open_data = $day[$d];

                $open_time = "";

                $time_open = false;

                unset($this->session->data['time_open']);

                if (isset($this->request->post['day'])) {

                    $day_time                        = $this->request->post['day'];
                    $this->session->data['day_time'] = $day_time;

                } elseif (isset($this->session->data['day_time'])) {

                    $day_time = $this->session->data['day_time'];
                } else {
                    $day_time = $d;
                }

                if ($times_info) {

                    $w_open  = 0;
                    $jg_time = 0;
                    usort($times_info['times'], function ($a, $b) {
                        $al = (int) $a['week'];
                        $bl = (int) $b['week'];
                        if ($al == $bl) {
                            return 0;
                        }

                        return ($al > $bl) ? 1 : -1;
                    });
                    // date_default_timezone_set('Etc/GMT-10');
                    foreach ($times_info['times'] as $k => $v) {

                        $days[] = (int) $v['week'];

                        if ($v['week'] == $d) {

                            if (!isset($this->session->data['isp']) || $this->session->data['isp'] == 1) {

                                $open_time = "";

                                if ($v['md_begintime'] && $v['md_endtime']) {
                                    $open_time .= " " . $v['md_begintime'] . '-' . $v['md_endtime'];

                                    if (strtotime($v['md_begintime']) <= time() && strtotime($v['md_endtime']) >= time()) {
                                        $time_open = true;
                                    }
                                }

                                if ($v['nd_begintime'] && $v['nd_endtime']) {
                                    $open_time .= " " . $v['nd_begintime'] . '-' . $v['nd_endtime'];

                                    if (strtotime($v['nd_begintime']) <= time() && strtotime($v['nd_endtime']) >= time()) {
                                        $time_open = true;
                                    }
                                }

                            } elseif ($this->session->data['isp'] == 2) {

                                $open_time = "";
                                if ($v['mt_begintime'] && $v['mt_endtime']) {
                                    $open_time .= " " . $v['mt_begintime'] . '-' . $v['mt_endtime'];
                                }

                                if ($v['nt_begintime'] && $v['nt_endtime']) {

                                    $open_time .= " " . $v['nt_begintime'] . '-' . $v['nt_endtime'];

                                }
                            }
                            $w_open = 1;
                        }

                        //is_open
                        if (!empty($times_info['unavailable'])) {

                            foreach ($times_info['unavailable'] as $key => $value) {

                                if ($value['type'][1] == 1 || $value['type'][2] == 1) {

                                    if (time() > strtotime($value['begintime']) && time() < strtotime($value['endtime'])) {
                                        $d_open = 0;
                                    }
                                }
                                if ($value['type'][1] == 2 || $value['type'][2] == 2) {

                                    if (time() > strtotime($value['begintime']) && time() < strtotime($value['endtime'])) {
                                        $t_open = 0;
                                    }
                                }
                            }
                        }

                        //times
                        if ($day_time) {

                            if ($v['week'] == $day_time) {

                                $jg_time = 0;

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

                                        $times[] = date('H:i', $i);
                                    }
                                }
                            }
                        }
                    }

                    if (!$w_open) {
                        $is_open = 0;
                    }
                }

                //unavailable days
                if (!isset($this->session->data['isp']) || $this->session->data['isp'] == 1) {
                    if (!$t_open) {
                        $is_open = 0;
                    }
                } elseif ($this->session->data['isp'] == 2) {
                    if (!$d_open) {
                        $is_open = 0;
                    }
                }

                $this->session->data['time_open'] = $time_open;

                $result['shopInfo'] = array(
                    'location_id' => $location_id,
                    'logo'        => $logo,
                    'bgimage'     => $bgimage,
                    'name'        => $location_info['name'],
                    'address'     => $location_info['address'],
                    'tag'         => $tags,
                    "aboutUs"     => $location_info['comment'],
                    "photos"      => $photos,
                    "star"        => $star_info['total_rating'] / 2,
                    "totalReview" => $totalReview,
                    "open"        => $location_info['open'],
                    "isopen"      => empty($isopen),
                    "reviews"     => $this->url->link('shop/reviews'),
                    "bounds_text" => "",
                    "shopInfo"    => $shopInfo,
                    "opentime"    => $open_time,
                    "opendata"    => $open_data,
                    'is_open'     => $is_open,
                    'd_open'      => $d_open,
                    't_open'      => $t_open,
                    'w_open'      => $w_open,
                    'days'        => $days,
                    'times'       => $times,
                    "time_open"   => $time_open,
                    "timezone"    => $timezone,
                );

                $schedules   = array();
                $unavailable = array();

                //schedule

                $schedules   = $times_info['times'];
                $unavailable = $times_info['unavailable'];

                $week = array(
                    1 => 'Mon',
                    2 => 'Tues',
                    3 => 'Wed',
                    4 => 'Thur',
                    5 => 'Fri',
                    6 => 'Sat',
                    0 => 'Sun',
                );

                if (!empty($schedules)) {
                    //sort
                    usort($schedules, function ($a, $b) {
                        $al = (int) $a['week'];
                        $bl = (int) $b['week'];
                        if ($al == $bl) {
                            return 0;
                        }

                        return ($al > $bl) ? 1 : -1;
                    });

                    foreach ($schedules as $schedule) {

                        $w = $week[$schedule['week']];
                        if ($schedule['md_begintime'] && $schedule['md_endtime']) {
                            $result['schedule']['delivery'][$w][0] = $schedule['md_begintime'] . " to " . $schedule['md_endtime'];
                        } else {
                            $result['schedule']['delivery'][$w][0] = "";
                        }
                        if ($schedule['nd_begintime'] && $schedule['nd_endtime']) {
                            $result['schedule']['delivery'][$w][1] = $schedule['nd_begintime'] . " to " . $schedule['nd_endtime'];
                        } else {
                            $result['schedule']['delivery'][$w][1] = "";
                        }
                        if ($schedule['mt_begintime'] && $schedule['mt_endtime']) {
                            $result['schedule']['takeaway'][$w][0] = $schedule['mt_begintime'] . " to " . $schedule['mt_endtime'];
                        } else {
                            $result['schedule']['takeaway'][$w][0] = "";
                        }
                        if ($schedule['nt_begintime'] && $schedule['nt_endtime']) {
                            $result['schedule']['takeaway'][$w][1] = $schedule['nt_begintime'] . " to " . $schedule['nt_endtime'];
                        } else {
                            $result['schedule']['takeaway'][$w][1] = "";
                        }

                        if (empty($result['schedule']['takeaway'][$w][0]) && empty($result['schedule']['takeaway'][$w][1])) {
                            unset($result['schedule']['takeaway'][$w]);
                        }

                        if (empty($result['schedule']['delivery'][$w][0]) && empty($result['schedule']['delivery'][$w][1])) {
                            unset($result['schedule']['delivery'][$w]);
                        }

                    }
                }

                $result['shopInfo']['unavailable'] = array();
                if (!empty($unavailable)) {

                    $way = array(
                        1 => 'delivery',
                        2 => 'pickup',
                    );
                    $way_text = "";

                    foreach ($unavailable as $un) {

                        $un['begintime'] = strtotime($un['begintime']);
                        $un['endtime']   = strtotime($un['endtime']);

                        if ($un['type']) {

                            if ($un['type'][1] && !$un['type'][2]) {
                                $way_text = $way[$un['type'][1]];
                            }

                            if (!$un['type'][1] && $un['type'][2]) {
                                $way_text = $way[$un['type'][2]];
                            }

                            if ($un['type'][1] && $un['type'][2]) {
                                if ($un['type'][1] == $un['type'][2]) {
                                    $way_text = $way[$un['type'][1]];
                                } else {
                                    $way_text = "delivery and pickup";
                                }
                            }

                        }

                        $result['schedule']['unavailable'][] = date('D j M ', $un['begintime']) . " to " . date('D j M ', $un['endtime']) . date('Y', time()) . " (" . $way_text . " not available)";

                        $result['shopInfo']['unavailable'][] = array($un['begintime'], $un['endtime']);
                    }
                }

                //shopList
                $result['shopList'] = array();

                $category_info = $this->model_shop_info->getCatalog($location_id);

                $popularItems = array();
                if (!empty($category_info)) {
                    foreach ($category_info as $k => &$v) {
                        $v['foodItems'] = $this->model_shop_info->getProducts($v['category_id']);

                        $v['description']     = htmlspecialchars_decode($v['description']);
                        $result['shopList'][] = $v;

                        foreach ($v['foodItems'] as $key => $value) {
                            if ($value['special']['popular']) {

                                $popularItems[] = $value;
                            }
                        }
                    }
                }
                //popular
                $popular = array();
                if (!empty($popularItems)) {
                    $popular = array(
                        'category_id' => 0,
                        'name'        => "Popular Dishes",
                        'description' => "",
                        "foodItems"   => $popularItems,
                    );
                }
                if (!empty($result['shopList'])) {
                    $shopList = $result['shopList'];
                    foreach ($shopList as $key => $value) {

                        $result['shopList'][$key + 1] = $shopList[$key];
                    }

                    $result['shopList'][0] = $popular;
                }

                //cart
                $result['cart'] = array();
                if (!empty($this->request->post['product_id'])) {

                    $product_id = $this->request->post['product_id'];

                    $this->load->model('catalog/product');

                    $product_info = $this->model_catalog_product->getProduct($product_id);

                    if ($product_info) {
                        $ext = "";
                        if (!empty($this->request->post['product_ext_id'])) {
                            $ext = $this->request->post['product_ext_id'];
                        }

                        $is_ext = $this->model_shop_info->getProductExt($product_id);

                        if (isset($this->request->post['ext'])) {

                            if (isset($this->request->post['quantity'])) {
                                $quantity = intval($this->request->post['quantity']);
                            } else {
                                $quantity = 1;
                            }

                            $option = array();
                            if (!empty($this->request->post['product_option_id']) && !empty($this->request->post['product_option_value_id'])) {
                                $option[$this->request->post['product_option_id']] = $this->request->post['product_option_value_id'];
                            }

                            if (!empty($option)) {
                                $option = array_filter($option);
                            } else {
                                $option = array();
                            }

                            if ($ext) {
                                $ext = explode(',', $ext);
                                asort($ext);
                                $ext = implode(',', $ext);
                            }

                            $this->cart->add($this->request->post['product_id'], $quantity, $option, $location_id, $ext);
                        }
                    }
                }

                $result['cart'] = $this->cart->getProducts($location_id);

                //productprice
                if (!empty($result['cart'])) {
                    foreach ($result['cart'] as $key => &$value) {
                        if ($value['is_discount']) {
                            $tureProductPrice += $value['total'];
                        }
                        $productPrice += $value['total'];
                        $value['total'] = $this->currency->format($value['total']);
                        $value['price'] = $this->currency->format($value['price'] * $value['quantity']);

                        if (!empty($value['option'])) {
                            $value['option'] = $value['option'][0];
                        }
                        $value['product_ext_id'] = "";
                        if (!empty($value['ext'])) {
                            foreach ($value['ext'] as $v) {

                                $type_info                                   = array();
                                $type_info                                   = $this->model_shop_info->getProductAddType($v['type']);
                                $value['exts'][$type_info['name']]['exts'][] = array(
                                    'name'  => $v['name'],
                                    'price' => $this->currency->format($v['price'] * $value['quantity']),
                                );
                                $value['exts'][$type_info['name']]['type']     = $type_info['type'];
                                $value['exts'][$type_info['name']]['required'] = $type_info['required'];
                                $value['exts'][$type_info['name']]['checkbox'] = $type_info['checkbox'];

                                $value['product_ext_id'] .= $v['product_ext_id'] . ",";
                            }
                        }
                        unset($value['ext']);
                    }
                    unset($value);
                }

                //couponList
                $coupons = array();
                $coupons = explode(',', $location_info['coupon_ids']);

                $this->load->model('account/order');

                $is_login = $this->customer->getId();

                if ($is_login) {
                    $times = $this->model_account_order->getTotalOrders();
                } else {
                    $times = 0;
                }

                $result['couponList'] = array();

                // if($is_login) {

                $tureCouponPrice = 0;

                if (!empty($coupons)) {
                    foreach ($coupons as $k => $coupon_ids) {
                        $coupon_info = $this->model_shop_info->getCoupon($coupon_ids);

                        if ($coupon_info) {
                            $coupon_info['name_text'] = "";
                            $is_click                 = false;
                            $is_show                  = true;

                            $bounds = false;

                            if (!empty($this->request->post['coupon_id'])) {
                                $coupon_id = $this->request->post['coupon_id'];

                            } elseif (!empty($this->session->data['coupon'][$location_id])) {
                                $coupon_id = $this->session->data['coupon'][$location_id];

                            } else {
                                if ($k == 0) {
                                    $coupon_id = $coupon_info['shop_coupon_id'];
                                }

                            }
                            // $is_flag = 0;
                            if (((int) $coupon_info['type'] == 2)) {

                                $is_show = false;
                            }

                            if (((int) $coupon_info['type'] == 2) && ($tureProductPrice >= $coupon_info['total'])) {

                                $bounds_text = "";

                                $product_total = 0;

                                if ($coupon_info['coupon_product_ids']) {

                                    $coupon_product = $this->model_shop_info->getCouponProduct($coupon_info['coupon_product_ids']);

                                    foreach ($coupon_product as $k => $products) {

                                        $product_total += 1;

                                        if ($k == 0) {
                                            $bounds_text .= "or " . $products['name'];
                                        } else {
                                            $bounds_text .= ",or " . $products['name'];
                                        }
                                    }
                                }
                                $is_show = true;
                                if ($product_total > 1) {
                                    $bounds = true;
                                }

                                if ($coupon_info['max_amount'] > 0 && $tureProductPrice > $coupon_info['max_amount']) {
                                    $is_show = false;
                                }

                            }

                            if ($coupon_id == $coupon_info['shop_coupon_id']) {
                                $is_click = true;

                                $this->session->data['coupon'][$location_id] = $coupon_id;
                            }

                            $totalPrice   = 0;
                            $currentPrice = 0;
                            //couponPrice
                            if (($is_click && !empty($coupon_id))) {

                                $coupon_array = array(
                                    'coupon_id' => $coupon_id,
                                    'times'     => $times,
                                    'price'     => $tureProductPrice,
                                );

                                $couponPrice_info = $this->model_shop_info->getCouponFee($coupon_array);

                                //type != 3
                                if ($couponPrice_info['is_use']) {

                                    $tureCouponPrice = $couponPrice_info['price'];
                                } else {
                                    $tureCouponPrice = 0;
                                }

                                $couponPrice = $couponPrice_info['price'];
                            }

                            //type = 3

                            if ($coupon_info['type'] == 3) {

                                $totalPrice   = 0;
                                $currentPrice = $tureProductPrice / $coupon_info['times'];

                                $m     = $times % ($coupon_info['times'] + 1);
                                $n     = $coupon_info['times'] - $m;
                                $query = $this->db->query("SELECT total FROM `" . DB_PREFIX . "order` WHERE customer_id = '" . (int) $this->customer->getId() . "'  AND order_status_id = 3  ORDER BY order_id DESC LIMIT 0," . (int) $m);

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

                                if ($m == $coupon_info['times']) {

                                    $coupon_info['name_text'] = 'Your loyalty credit ' . $this->currency->format($totalPrice) . ' total can be redeemed for this order';
                                } else {

                                    $coupon_info['name_text'] = 'Your loyalty credit ' . $this->currency->format($currentPrice) . '  this order; ' . $this->currency->format($totalPrice) . ' total; ' . $n . ' orders to go';
                                }

                            }

                            if (((int) $coupon_info['type'] == 1 && $times >= 1)) {

                                $is_show = false;
                            }

                            $result['couponList'][] = array(
                                'id'          => $coupon_info['shop_coupon_id'],
                                'name'        => $coupon_info['name'],
                                'description' => $coupon_info['info'],
                                'type'        => $coupon_info['type'],
                                'price'       => $this->currency->format($tureCouponPrice),
                                'times'       => $coupon_info['times'],
                                'name_text'   => $coupon_info['name_text'],
                                'isShow'      => $is_show,
                                "is_click"    => $is_click,
                                "bounds"      => $bounds,
                                'sort_order'  => $coupon_info['sort_order'],
                            );
                        }
                    }
                }

                //
                if (!empty($result['couponList'])) {
                    $sort = array(
                        'direction' => 'SORT_ASC',
                        'field'     => 'sort_order',
                    );

                    $arrSort = array();

                    foreach ($result['couponList'] as $uniqid => $row) {

                        foreach ($row as $key => $value) {

                            $arrSort[$key][$uniqid] = $value;

                        }
                    }

                    if ($sort['direction']) {

                        array_multisort($arrSort[$sort['field']], constant($sort['direction']), $result['couponList']);
                    }
                }

                //price
                $result['price'] = array();

                $consume = $location_info['consume'];

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

                $total = $total > 0 ? $total : 0;

                $consume = $this->currency->format($location_info['consume']);
                $min     = $location_info['consume'];

                $remaining   = ($location_info['consume'] - $productPrice) > 0 ? ($location_info['consume'] - $productPrice) : 0;
                $remainPrice = $this->currency->format($remaining);

                $result['price'] = array(
                    "total"         => $this->currency->format($total),
                    "productPrice"  => $this->currency->format($productPrice),
                    "deliveryPrice" => $this->currency->format($deliveryPrice),
                    "couponPrice"   => $this->currency->format($couponPrice),
                    "remainPrice"   => $remainPrice,
                    "consume"       => $consume,
                    "remain"        => $productPrice,
                    "min"           => (int) $min,
                );

                //reviews
                $this->load->model('shop/reviews');
                $review_info = $this->model_shop_reviews->getReviewsByLocationId($location_id);

                $reviews = array();
                foreach ($review_info as $v) {
                    $date_added   = strtotime($v['date_added']);
                    $total_rating = round(($v['rating'] + $v['rating1'] + $v['rating2']) / 3, 1);
                    $reviews[]    = array(
                        'name'         => $v['author'],
                        'date_add'     => date('F,Y', $date_added),
                        'total_rating' => $total_rating,
                        'rating'       => floatval($v['rating']),
                        'rating1'      => floatval($v['rating1']),
                        'rating2'      => floatval($v['rating2']),
                        'text'         => $v['text'],
                    );
                }
                $result['reviews'] = $reviews;
            }

            if(isset($_SESSION['mobile_message']) && $_SESSION['mobile_message']['product']) {
                $result['mobile_message'] = $_SESSION['mobile_message'];
            }
            $result['isqrcode'] = IsQrcode;

            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($result));
        }

    }
}
