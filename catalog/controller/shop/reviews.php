<?php
class ControllerShopReviews extends Controller
{
    private $error = array();

    public function index()
    {

        $data = array();

        $this->load->language('shop/reviews');
        $this->load->model('shop/reviews');

        $this->document->setTitle($this->language->get('heading_title'));

        $customer_id = $this->customer->isLogged();
        $location_id = 0;
        $order_id    = 0;

        if (isset($this->request->get['location_id'])) {

            $location_id = $this->request->get['location_id'];

            if (isset($this->request->get['order_id'])) {

                $order_id = $this->request->get['order_id'];
            }

            if ($this->customer->getAlias()) {

                $data['name'] = $this->customer->getAlias();
            } else {

                $data['name'] = $this->customer->getFirstName();
            }

            $data['location_id'] = $location_id;
            $data['customer_id'] = $customer_id;

            //is_review
            if (!empty($order_id)) {

                $data['is_review'] = $this->model_shop_reviews->isReview($location_id, $customer_id, $order_id);
            } else {
                $data['is_review'] = 1;
            }

            $url = '';

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['page'])) {
                $page = $this->request->get['page'];
            } else {
                $page = 1;
            }

            $data['total_reviews'] = $this->model_shop_reviews->getTotalReviewsByLocationId($location_id);
            $data['info']          = $this->model_shop_reviews->getInfoByLocationId($location_id);

            $review_total = $this->model_shop_reviews->getTotalReviewsByLocationId($location_id);
            $review_info  = $this->model_shop_reviews->getReviews(($page - 1) * 10, 10, $location_id);

            //reviews
            $reviews = array();

            foreach ($review_info as $v) {

                $total_rating = round(($v['rating'] + $v['rating1'] + $v['rating2']) / 3, 1);

                $reviews[] = array(
                    'name'          => $v['author'],
                    'total_reviews' => $this->model_shop_reviews->getTotalReviewsByCustomerId($v['customer_id']),
                    'date_add'      => $v['date_added'],
                    'total_rating'  => $total_rating,
                    'rating'        => floatval($v['rating']),
                    'rating1'       => floatval($v['rating1']),
                    'rating2'       => floatval($v['rating2']),
                    'text'          => $v['text'],
                    'review_url'    => $this->url->link('shop/reviews/show', 'customer_id=' . $v['customer_id']),
                    'color'         => $this->model_shop_reviews->getColor($total_rating),
                );
            }

            $data['reviews'] = $reviews;

            $pagination             = new Pagination();
            $pagination->total      = $review_total;
            $pagination->text_first = '&lt;';
            $pagination->text_last  = '&gt;';
            $pagination->text_next  = 'NEXT';
            $pagination->text_prev  = 'PREV';
            $pagination->page       = $page;
            $pagination->limit      = 10;
            $pagination->url        = $this->url->link('shop/reviews', 'location_id=' . $location_id . '&order_id=' . $order_id . '&page={page}', 'SSL');

            $data['pagination'] = $pagination->render();

            $data['order_id'] = $order_id;

            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shop/reviews.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/shop/reviews.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/shop/reviews.tpl', $data));
            }
        }
    }

    public function write()
    {
        $this->load->language('shop/reviews');

        $json = array();

        $customer_id = $this->customer->isLogged();

        if (!$customer_id) {

            $json['error'] = $this->language->get('error_name');
        }

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {

            if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 10) {
                $json['error'] = $this->language->get('error_rating');
            }

            if (empty($this->request->post['rating1']) || $this->request->post['rating1'] < 0 || $this->request->post['rating1'] > 10) {
                $json['error'] = $this->language->get('error_rating');
            }

            if (empty($this->request->post['rating2']) || $this->request->post['rating2'] < 0 || $this->request->post['rating2'] > 10) {
                $json['error'] = $this->language->get('error_rating');
            }

            if ($this->config->get('config_google_captcha_status') && empty($json['error'])) {
                if (isset($this->request->post['g-recaptcha-response'])) {
                    $recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('config_google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

                    $recaptcha = json_decode($recaptcha, true);

                    if (!$recaptcha['success']) {
                        $json['error'] = $this->language->get('error_captcha');
                    }
                } else {
                    $json['error'] = $this->language->get('error_captcha');
                }
            }

            if (!isset($json['error'])) {
                $this->load->model('catalog/review');

                $this->model_catalog_review->addReview($this->request->post['location_id'], $this->request->post);

                $json['success'] = $this->language->get('text_success');
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function show()
    {
        $data = array();

        if (isset($this->request->get['customer_id'])) {

            $this->load->model('shop/reviews');

            $url = '';

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['page'])) {
                $page = $this->request->get['page'];
            } else {
                $page = 1;
            }

            $customer_id = $this->request->get['customer_id'];

            $review_total = $this->model_shop_reviews->getTotalReviewsByCustomerId($customer_id);
            $review_info  = $this->model_shop_reviews->getReviewsByCustomerId(($page - 1) * 10, 10, $customer_id);

            if (!empty($review_info)) {

                $this->load->model('localisation/location');
                $reviews = array();

                foreach ($review_info as $review) {

                    $shop_info = $this->model_localisation_location->getLocation($review['product_id']);

                    $reviews[] = array(
                        'shop_name'  => $shop_info['name'],
                        'shop_url'   => $this->url->link('shop/info', 'location_id=' . $review['product_id']),
                        'address'    => $shop_info['address'],
                        'avg_rating' => round(($review['rating'] + $review['rating1'] + $review['rating2']) / 3, 1),
                        'rating'     => $review['rating'],
                        'rating1'    => $review['rating1'],
                        'rating2'    => $review['rating2'],
                        'text'       => $review['text'],
                        'date_added' => $review['date_added'],
                    );
                }

                $data['name']    = $review['author'];
                $data['reviews'] = $reviews;

                $pagination             = new Pagination();
                $pagination->total      = $review_total;
                $pagination->text_first = '&lt;';
                $pagination->text_last  = '&gt;';
                $pagination->text_next  = 'NEXT';
                $pagination->text_prev  = 'PREV';
                $pagination->page       = $page;
                $pagination->limit      = 10;
                $pagination->url        = $this->url->link('shop/reviews/show', 'customer_id=' . $customer_id . '&page={page}', 'SSL');

                $data['pagination'] = $pagination->render();

                $data['footer'] = $this->load->controller('common/footer');
                $data['header'] = $this->load->controller('common/header');

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shop/show.tpl')) {
                    $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/shop/show.tpl', $data));
                } else {
                    $this->response->setOutput($this->load->view('default/template/shop/show.tpl', $data));
                }
            }
        }
    }
}
