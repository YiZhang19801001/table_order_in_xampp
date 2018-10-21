<?php
final class Action {
	private $file;
	private $class;
	private $method;
	private $args = array();

	public function __construct($route, $args = array()) {
		$path = '';

		// Break apart the route
		$parts = explode('/', str_replace('../', '', (string)$route));

		foreach ($parts as $part) {
			$path .= $part;

			if (is_dir(DIR_APPLICATION . 'controller/' . $path)) {
				$path .= '/';

				array_shift($parts);

				continue;
			}

			$file = DIR_APPLICATION . 'controller/' . str_replace(array('../', '..\\', '..'), '', $path) . '.php';

			if (is_file($file)) {
				$this->file = $file;

				$this->class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $path);

				array_shift($parts);

				break;
			}
		}

		if ($args) {
			$this->args = $args;
		}

		$method = array_shift($parts);

		if ($method) {
			$this->method = $method;
		} else {
			$this->method = 'index';
		}
	}

	public function execute($registry) {
		// Stop any magical methods being called
		if (substr($this->method, 0, 2) == '__') {
			return false;
		}

		if (is_file($this->file)) {
			include_once($this->file);

			$class = $this->class;

			$controller = new $class($registry); //??:: 为什么可以new class, class并不是一个类，只是一个参数。

			if (is_callable(array($controller, $this->method))) {
				//print_r($controller) is a huge object which can not really read.

				//echo call_user_func(array($controller, $this->method), $this->args) give bunch of pics before header bar in browser, and url is not just localhost, not jump to shop/info
				return call_user_func(array($controller, $this->method), $this->args);
				
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
}