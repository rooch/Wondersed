<?php
define('EXTENSION_NAME', "Custom Product Tab (CPT)");
define('EXTENSION_VERSION', "1.2.2");
define('EXTENSION_TYPE', "vQmod");
define('EXTENSION_COMPATIBILITY', "OpenCart 1.5.4.x, 1.5.5.x and 1.5.6.x");
define('EXTENSION_URL', "http://www.opencart.com/index.php?route=extension/extension/info&extension_id=1536");
define('EXTENSION_SUPPORT', "support@opencart.ee");
define('EXTENSION_SUPPORT_FORUM', "http://forum.opencart.com/viewtopic.php?f=123&t=28958");

class ControllerModuleCustomProductTab extends Controller {
    private $error = array();
    private $defaults = array(
        'cpt_installed'                     => 1,
        'custom_product_tab_status'         => 0,
        'cpt_always_show'                   => 0,
        'cpt_use_default_language_value'    => 1,
        'cpt_remove_sql_changes'            => 0
    );

    public function index() {
        $this->data = array_merge($this->data, $this->language->load('module/custom_product_tab'));

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
            $checkbox_settings = array(
                'cpt_always_show',
                'cpt_use_default_language_value',
                'cpt_remove_sql_changes'
            );

            # Loop through all settings for the post/config values
            foreach ($checkbox_settings as $checkbox_setting) {
                if (!isset($this->request->post[$checkbox_setting])) {
                    $this->request->post[$checkbox_setting] = 0;
                }
            }

            $this->model_setting_setting->editSetting('custom_product_tab', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->checkDatabaseStructure();

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (!class_exists('VQMod')) {
            $this->data['error_warning'] = $this->language->get('error_vqmod');
        }

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/custom_product_tab', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/custom_product_tab', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['ext_name'] = EXTENSION_NAME;
        $this->data['ext_version'] = EXTENSION_VERSION;
        $this->data['ext_type'] = EXTENSION_TYPE;
        $this->data['ext_compatibility'] = EXTENSION_COMPATIBILITY;
        $this->data['ext_url'] = EXTENSION_URL;
        $this->data['ext_support'] = EXTENSION_SUPPORT;
        $this->data['ext_support_forum'] = EXTENSION_SUPPORT_FORUM;
        $this->data['ext_subject'] = sprintf($this->language->get('text_ext_subject'), EXTENSION_NAME);

        $this->load->model('localisation/language');
        $this->data['language_count'] = (int)$this->model_localisation_language->getTotalLanguages();

        # Loop through all settings for the post/config values
        foreach (array_keys($this->defaults) as $setting) {
            if (isset($this->request->post[$setting])) {
                $this->data[$setting] = $this->request->post[$setting];
            } else {
                $this->data[$setting] = $this->config->get($setting);
                if ($this->data[$setting] === null) {
                    $this->data['error_warning'] = $this->language->get('error_unsaved_settings');
                    if (isset($this->defaults[$setting])) {
                        $this->data[$setting] = $this->defaults[$setting];
                    }
                }
            }
        }

        $this->template = 'module/custom_product_tab.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    public function install() {
        $column_exists = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "product_description LIKE 'specs'");
        if (!$column_exists->num_rows) {
            $this->db->query("ALTER TABLE " . DB_PREFIX . "product_description ADD specs TEXT COLLATE utf8_bin NOT NULL");
        }

        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('custom_product_tab', $this->defaults);
    }

    public function uninstall() {
        if ($this->config->get("cpt_remove_sql_changes")) {
            $column_exists = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "product_description LIKE 'specs'");
            if ($column_exists->num_rows) {
                $this->db->query("ALTER TABLE " . DB_PREFIX . "product_description DROP COLUMN specs");
            }
        }
        $this->load->model('setting/setting');
        $this->model_setting_setting->deleteSetting('custom_product_tab');
    }

    private function checkDatabaseStructure() {
        $column_exists = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "product_description LIKE 'specs'");
        if (!$column_exists->num_rows) {
            $this->error['warning'] = sprintf($this->language->get('error_missing_column'), DB_PREFIX . 'product_description', 'specs');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/custom_product_tab')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return $this->checkDatabaseStructure();
        } else {
            return false;
        }
    }
}
?>
