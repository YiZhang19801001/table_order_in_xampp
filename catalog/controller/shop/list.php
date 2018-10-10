<?php
class ControllerShopList extends Controller
{
    private $error = array();

    public function index()
    {
        $this->load->language('shop/list');

        $this->document->setTitle($this->language->get('heading_title'));

        $data['shops'] = array();

        $this->load->model('localisation/location');
        $this->load->model('shop/list');
        $this->load->model('tool/image');

        foreach ((array) $this->config->get('config_location') as $location_id) {
            $location_info = $this->model_localisation_location->getLocation($location_id);

            if ($location_info) {
                if ($location_info['image']) {
                    $image = $this->model_tool_image->resize($location_info['image'], $this->config->get('config_image_location_width'), $this->config->get('config_image_location_height'));
                } else {
                    $image = false;
                }

                if ($location_info['tag_ids']) {
                    $tag_names = $this->model_shop_list->getTagNameByid($location_info['tag_ids']);

                    if ($tag_names) {
                        $tagname = "";
                        foreach ($tag_names as $k => $v) {
                            $tagname .= $v['name'] . "&nbsp;";
                        }
                    } else {
                        $tagname = false;
                    }
                } else {
                    $tagname = false;
                }

                if ($location_info['geocode']) {
                    $areainfo = $this->model_shop_list->getAreaNameByCode($location_info['geocode']);

                    if ($areainfo) {
                        $area_name = $areainfo['name'];
                    } else {
                        $area_name = false;
                    }

                } else {
                    $area_name = false;
                }
                if (!empty($location_info['consume'])) {
                    $consume = $location_info['consume'];
                } else {
                    $consume = 0;
                }
                $consume      = $this->currency->format($consume);
                $shop_coupons = array();
                if ($location_info['coupon_ids']) {
                    $coupon_ids = explode(',', $location_info['coupon_ids']);

                    foreach ($coupon_ids as $coupon_id) {
                        $shop_coupons[] = $this->model_shop_list->getShopCoupon($coupon_id);
                    }
                }

                $data['shops'][] = array(
                    'location_id'  => $location_info['location_id'],
                    'name'         => $location_info['name'],
                    'address'      => nl2br($location_info['address']),
                    'area_name'    => $area_name,
                    'telephone'    => $location_info['telephone'],
                    'fax'          => $location_info['fax'],
                    'image'        => $image,
                    'open'         => nl2br($location_info['open']),
                    'comment'      => $location_info['comment'],
                    'tag_names'    => $tagname,
                    'consume'      => $consume,
                    // 'text_consume' =>$text_consume,
                    'shop_coupons' => $shop_coupons,
                    'href'         => $this->url->link('shop/info', '&location_id=' . $location_info['location_id']),
                );
            }
        }

        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shop/list.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/shop/list.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/shop/list.tpl', $data));
        }
    }
}
