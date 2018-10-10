<?php

class ControllerShopTime extends Controller
{

    public function index()
    {

        $times = array();
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->request->post['day'] && $this->request->post['isp']) {

            $day         = $this->request->post['day'];
            $isp         = $this->request->post['isp'];
            $location_id = $this->request->post['location_id'];

            $this->load->model('shop/info');

            $times_info = $this->model_shop_info->getShopTimes($location_id);

            if ($times_info['pretime']) {

                $begintime = 0;
                $endtime   = 0;

                foreach ($times_info['times'] as $k => $v) {

                    if ($v['week'] == $day) {

                        $jg_time = 0;

                        if ($isp == 1) {

                            $jg_time = $times_info['pretime']['delivery'] ? $times_info['pretime']['delivery'] : 0;
                            if ($v['md_begintime'] && $v['md_endtime']) {
                                $begintime = $v['md_begintime'];
                                $endtime   = $v['md_endtime'];
                            }
                            if ($v['nd_begintime'] && $v['nd_endtime']) {
                                $begintime = $v['nd_begintime'];
                                $endtime   = $v['nd_endtime'];
                            }

                        } elseif ($isp == 2) {

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
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($times));
    }
}
