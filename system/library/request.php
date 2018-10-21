<?php
class Request {
	public $get = array();
	public $post = array();
	public $cookie = array();
	public $files = array();
	public $server = array();

	public function __construct() {
		$this->get = $this->clean($_GET); //Array ( [route] => shop/info [location_id] => 4 )
		$this->post = $this->clean($_POST);//Array ( )
		$this->request = $this->clean($_REQUEST);//Array ( [route] => shop/info [location_id] => 4 )
		$this->cookie = $this->clean($_COOKIE);//Array ( [language] => en [currency] => AUD [PHPSESSID] => 3jso9ofjg4nvget3p1rj1sdrc1 [__atuvc] => 1|42 )
		$this->files = $this->clean($_FILES);//Array ( )
		$this->server = $this->clean($_SERVER);
		
	}

	public function clean($data) {
		if (is_array($data)) {
			foreach ($data as $key => $value) {
				unset($data[$key]);

				$data[$this->clean($key)] = $this->clean($value);
			}
		} else {
			$data = htmlspecialchars($data, ENT_COMPAT, 'UTF-8');
		}

		
		return $data;
	}
}