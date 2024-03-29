<?php
class ControllerModulePavnewsletter extends Controller {
	protected function index($setting) {
		static $module = 0;
		$this->language->load('module/pavnewsletter');
		$this->load->model('account/customer');
		$this->load->model('pavnewsletter/subscribe');
		$general_setting = $this->config->get("pavnewsletter_config");
		$show_box = true;
		if($this->customer->isLogged()){
			$customer_email = $this->customer->getEmail();
			if($this->model_pavnewsletter_subscribe->checkExists($customer_email)){
				$show_box = false;
			}
			$this->data['customer_email'] = $customer_email;
		}
		if(!$show_box)
			return;
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/pavnewsletter.css')) {
			$this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/pavnewsletter.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavnewsletter.css');
		}
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
         	$this->data['base'] = $this->config->get('config_ssl');
	    } else {
	        $this->data['base'] = $this->config->get('config_url');
	    }
	    $this->data['action'] = $this->url->link('module/pavnewsletter/subscribe', '', 'SSL');
	    $this->data['prefix'] = isset($setting['prefix'])?$setting['prefix']:'';
		$this->data['position'] = isset($setting['position'])?$setting['position']:'';
		$this->data['module'] = $module++;
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavnewsletter.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavnewsletter.tpl';
		} else {
			$this->template = 'default/template/module/pavnewsletter.tpl';
		}

		$this->render();
	}
	public function subscribe(){
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate($this->request->post)) {
			$this->load->model('account/customer');
			$this->load->model('pavnewsletter/subscribe');
			$data = array();
			$data['store_id'] = $this->config->get('config_store_id');
			$data['customer_id'] = 0;
			$data['email'] = $this->request->post['email'];
			$data['store_id'] = 0;
			if($customer = $this->model_account_customer->getCustomerByEmail($this->request->post['email'])){
				$data['customer_id'] = $customer['customer_id'];
			}

			$this->model_pavnewsletter_subscribe->storeSubscribe( $data);

			$this->session->data['success'] = $this->language->get('text_success');
		}
		$this->redirect($this->url->link('common/home', '', 'SSL'));
		
	}
	protected function validate($data = array()){
		if(!empty($data)){
			if(isset($data['email']) && !empty($data['email']) && isset($data['action']))
				return true;
		}
		return false;
	}
}
