<?php

class ModelInstall extends Model {

    public function query($data)
    {
        $connection = mysql_connect($data['db_host'],
                                    $data['db_user'],
                                    $data['db_password']);

        mysql_select_db($data['db_name'], $connection);

        mysql_query("SET NAMES 'utf8'", $connection);
        mysql_query("SET CHARACTER SET utf8", $connection);
        mysql_query("SET @@session.sql_mode = 'MYSQL40'", $connection);

        // Transaction begin
        mysql_query("START TRANSACTION");

        $this->_fQuery('structure.sql');
        $this->_fQuery('configuration.sql');

        mysql_query("INSERT INTO `" . $data['db_prefix'] . "language`".
                    "SET name = 'English',".
                    "code = 'en',".
                    "locale = 'en_US.UTF-8,en_US,en-gb,english',".
                    "image = 'gb.png',".
                    "directory = 'english',".
                    "filename = 'english',".
                    "sort_order = '1',".
                    "status = '1'",
                    $connection);

        mysql_query("INSERT INTO `" . $data['db_prefix'] . "store`".
                    "SET name = 'Your Store',".
                    "url = '" . HTTP_OPENCART . "'",
                    $connection);

        mysql_query("INSERT INTO `" . $data['db_prefix'] . "user_group`".
                    "SET name = 'Top Administrator',".
                    'permission = \'a:2:{s:6:"access";a:116:{i:0;s:17:"catalog/attribute";i:1;s:23:"catalog/attribute_group";i:2;s:16:"catalog/category";i:3;s:16:"catalog/download";i:4;s:19:"catalog/information";i:5;s:20:"catalog/manufacturer";i:6;s:14:"catalog/option";i:7;s:15:"catalog/product";i:8;s:14:"catalog/review";i:9;s:18:"common/filemanager";i:10;s:13:"design/banner";i:11;s:13:"design/layout";i:12;s:14:"extension/feed";i:13;s:16:"extension/module";i:14;s:17:"extension/payment";i:15;s:18:"extension/shipping";i:16;s:15:"extension/total";i:17;s:16:"feed/google_base";i:18;s:19:"feed/google_sitemap";i:19;s:20:"localisation/country";i:20;s:21:"localisation/currency";i:21;s:21:"localisation/geo_zone";i:22;s:21:"localisation/language";i:23;s:25:"localisation/length_class";i:24;s:25:"localisation/order_status";i:25;s:26:"localisation/return_action";i:26;s:26:"localisation/return_reason";i:27;s:26:"localisation/return_status";i:28;s:25:"localisation/stock_status";i:29;s:22:"localisation/tax_class";i:30;s:21:"localisation/tax_rate";i:31;s:25:"localisation/weight_class";i:32;s:17:"localisation/zone";i:33;s:14:"module/account";i:34;s:16:"module/affiliate";i:35;s:13:"module/banner";i:36;s:17:"module/bestseller";i:37;s:15:"module/carousel";i:38;s:15:"module/category";i:39;s:15:"module/featured";i:40;s:18:"module/google_talk";i:41;s:18:"module/information";i:42;s:13:"module/latest";i:43;s:16:"module/slideshow";i:44;s:14:"module/special";i:45;s:12:"module/store";i:46;s:14:"module/welcome";i:47;s:16:"payment/alertpay";i:48;s:24:"payment/authorizenet_aim";i:49;s:21:"payment/bank_transfer";i:50;s:14:"payment/cheque";i:51;s:11:"payment/cod";i:52;s:21:"payment/free_checkout";i:53;s:14:"payment/liqpay";i:54;s:20:"payment/moneybookers";i:55;s:14:"payment/nochex";i:56;s:15:"payment/paymate";i:57;s:16:"payment/paypoint";i:58;s:26:"payment/perpetual_payments";i:59;s:14:"payment/pp_pro";i:60;s:17:"payment/pp_pro_uk";i:61;s:19:"payment/pp_standard";i:62;s:15:"payment/sagepay";i:63;s:22:"payment/sagepay_direct";i:64;s:18:"payment/sagepay_us";i:65;s:19:"payment/twocheckout";i:66;s:28:"payment/web_payment_software";i:67;s:16:"payment/worldpay";i:68;s:27:"report/affiliate_commission";i:69;s:22:"report/customer_credit";i:70;s:21:"report/customer_order";i:71;s:22:"report/customer_reward";i:72;s:24:"report/product_purchased";i:73;s:21:"report/product_viewed";i:74;s:18:"report/sale_coupon";i:75;s:17:"report/sale_order";i:76;s:18:"report/sale_return";i:77;s:20:"report/sale_shipping";i:78;s:15:"report/sale_tax";i:79;s:14:"sale/affiliate";i:80;s:12:"sale/contact";i:81;s:11:"sale/coupon";i:82;s:13:"sale/customer";i:83;s:19:"sale/customer_group";i:84;s:10:"sale/order";i:85;s:11:"sale/return";i:86;s:12:"sale/voucher";i:87;s:18:"sale/voucher_theme";i:88;s:15:"setting/setting";i:89;s:13:"setting/store";i:90;s:17:"shipping/citylink";i:91;s:13:"shipping/flat";i:92;s:13:"shipping/free";i:93;s:13:"shipping/item";i:94;s:23:"shipping/parcelforce_48";i:95;s:15:"shipping/pickup";i:96;s:19:"shipping/royal_mail";i:97;s:12:"shipping/ups";i:98;s:13:"shipping/usps";i:99;s:15:"shipping/weight";i:100;s:11:"tool/backup";i:101;s:14:"tool/error_log";i:102;s:12:"total/coupon";i:103;s:12:"total/credit";i:104;s:14:"total/handling";i:105;s:19:"total/low_order_fee";i:106;s:12:"total/reward";i:107;s:14:"total/shipping";i:108;s:15:"total/sub_total";i:109;s:9:"total/tax";i:110;s:11:"total/total";i:111;s:13:"total/voucher";i:112;s:9:"user/user";i:113;s:20:"user/user_permission";i:114;s:15:"shipping/pickup";i:115;s:17:"module/ocu_filter";}s:6:"modify";a:116:{i:0;s:17:"catalog/attribute";i:1;s:23:"catalog/attribute_group";i:2;s:16:"catalog/category";i:3;s:16:"catalog/download";i:4;s:19:"catalog/information";i:5;s:20:"catalog/manufacturer";i:6;s:14:"catalog/option";i:7;s:15:"catalog/product";i:8;s:14:"catalog/review";i:9;s:18:"common/filemanager";i:10;s:13:"design/banner";i:11;s:13:"design/layout";i:12;s:14:"extension/feed";i:13;s:16:"extension/module";i:14;s:17:"extension/payment";i:15;s:18:"extension/shipping";i:16;s:15:"extension/total";i:17;s:16:"feed/google_base";i:18;s:19:"feed/google_sitemap";i:19;s:20:"localisation/country";i:20;s:21:"localisation/currency";i:21;s:21:"localisation/geo_zone";i:22;s:21:"localisation/language";i:23;s:25:"localisation/length_class";i:24;s:25:"localisation/order_status";i:25;s:26:"localisation/return_action";i:26;s:26:"localisation/return_reason";i:27;s:26:"localisation/return_status";i:28;s:25:"localisation/stock_status";i:29;s:22:"localisation/tax_class";i:30;s:21:"localisation/tax_rate";i:31;s:25:"localisation/weight_class";i:32;s:17:"localisation/zone";i:33;s:14:"module/account";i:34;s:16:"module/affiliate";i:35;s:13:"module/banner";i:36;s:17:"module/bestseller";i:37;s:15:"module/carousel";i:38;s:15:"module/category";i:39;s:15:"module/featured";i:40;s:18:"module/google_talk";i:41;s:18:"module/information";i:42;s:13:"module/latest";i:43;s:16:"module/slideshow";i:44;s:14:"module/special";i:45;s:12:"module/store";i:46;s:14:"module/welcome";i:47;s:16:"payment/alertpay";i:48;s:24:"payment/authorizenet_aim";i:49;s:21:"payment/bank_transfer";i:50;s:14:"payment/cheque";i:51;s:11:"payment/cod";i:52;s:21:"payment/free_checkout";i:53;s:14:"payment/liqpay";i:54;s:20:"payment/moneybookers";i:55;s:14:"payment/nochex";i:56;s:15:"payment/paymate";i:57;s:16:"payment/paypoint";i:58;s:26:"payment/perpetual_payments";i:59;s:14:"payment/pp_pro";i:60;s:17:"payment/pp_pro_uk";i:61;s:19:"payment/pp_standard";i:62;s:15:"payment/sagepay";i:63;s:22:"payment/sagepay_direct";i:64;s:18:"payment/sagepay_us";i:65;s:19:"payment/twocheckout";i:66;s:28:"payment/web_payment_software";i:67;s:16:"payment/worldpay";i:68;s:27:"report/affiliate_commission";i:69;s:22:"report/customer_credit";i:70;s:21:"report/customer_order";i:71;s:22:"report/customer_reward";i:72;s:24:"report/product_purchased";i:73;s:21:"report/product_viewed";i:74;s:18:"report/sale_coupon";i:75;s:17:"report/sale_order";i:76;s:18:"report/sale_return";i:77;s:20:"report/sale_shipping";i:78;s:15:"report/sale_tax";i:79;s:14:"sale/affiliate";i:80;s:12:"sale/contact";i:81;s:11:"sale/coupon";i:82;s:13:"sale/customer";i:83;s:19:"sale/customer_group";i:84;s:10:"sale/order";i:85;s:11:"sale/return";i:86;s:12:"sale/voucher";i:87;s:18:"sale/voucher_theme";i:88;s:15:"setting/setting";i:89;s:13:"setting/store";i:90;s:17:"shipping/citylink";i:91;s:13:"shipping/flat";i:92;s:13:"shipping/free";i:93;s:13:"shipping/item";i:94;s:23:"shipping/parcelforce_48";i:95;s:15:"shipping/pickup";i:96;s:19:"shipping/royal_mail";i:97;s:12:"shipping/ups";i:98;s:13:"shipping/usps";i:99;s:15:"shipping/weight";i:100;s:11:"tool/backup";i:101;s:14:"tool/error_log";i:102;s:12:"total/coupon";i:103;s:12:"total/credit";i:104;s:14:"total/handling";i:105;s:19:"total/low_order_fee";i:106;s:12:"total/reward";i:107;s:14:"total/shipping";i:108;s:15:"total/sub_total";i:109;s:9:"total/tax";i:110;s:11:"total/total";i:111;s:13:"total/voucher";i:112;s:9:"user/user";i:113;s:20:"user/user_permission";i:114;s:15:"shipping/pickup";i:115;s:17:"module/ocu_filter";}}\'',
                    $connection);

        mysql_query("INSERT INTO `" . $data['db_prefix'] . "user`".
                    "SET user_group_id = '1',".
                    "username = '" . mysql_real_escape_string($data['username']) . "', ".
                    "password = '" . mysql_real_escape_string(md5($data['password'])) . "', ".
                    "email = '" . mysql_real_escape_string($data['email']) . "', ".
                    "status = '1', ".
                    "date_added = NOW()",
                    $connection);

        mysql_query("INSERT INTO `" . $data['db_prefix'] . "setting` ".
                    "SET `group` = 'config', ".
                    "`key` = 'config_email', ".
                    "value = '" . mysql_real_escape_string($data['email']) . "'",
                    $connection);

        mysql_query("INSERT INTO `" . $data['db_prefix'] . "setting` ".
                    "SET `group` = 'config', ".
                    "`key` = 'config_url', ".
                    "value = '" . mysql_real_escape_string(HTTP_OPENCART) . "'",
                    $connection);

        // Transaction complete
        mysql_query("COMMIT");


        mysql_close($connection);

        return true;
    }

    private function _fQuery($file)
    {
        $file = DIR_APPLICATION . 'sql' . DIRECTORY_SEPARATOR . $file;

        if ($sql = file($file)) {
            $query = '';

            foreach($sql as $line) {
                $tsl = trim($line);

                if (($sql != '') && (substr($tsl, 0, 2) != "--") && (substr($tsl, 0, 1) != '#')) {
                    $query .= $line;

                    if (preg_match('/;\s*$/', $line)) {
                        $query = str_replace("CREATE TABLE `", "CREATE TABLE `" . $data['db_prefix'], $query);
                        $query = str_replace("INSERT INTO `", "INSERT INTO `" . $data['db_prefix'], $query);

                        $result = mysql_query($query, $connection);

                        if (!$result) {
                            die(mysql_error());
                        }

                        $query = '';
                    }
                }
            }
        }
    }
}
