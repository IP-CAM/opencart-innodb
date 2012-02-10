SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `customer_group`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `customer_group` (
  `customer_group_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`customer_group_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `store` (
  `store_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `url` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `ssl` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`store_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `customer` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `customer_group_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL DEFAULT '0' ,
  `firstname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `lastname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `email` VARCHAR(96) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `telephone` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `fax` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `password` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `cart` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `wishlist` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `newsletter` TINYINT(1) NOT NULL DEFAULT '0' ,
  `address_id` INT(11) NOT NULL DEFAULT '0' ,
  `ip` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '0' ,
  `status` TINYINT(1) NOT NULL ,
  `approved` TINYINT(1) NOT NULL ,
  `token` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`customer_id`) ,
  INDEX `fk_customer_customer_group` (`customer_group_id` ASC) ,
  INDEX `fk_customer_store` (`store_id` ASC) ,
  CONSTRAINT `fk_customer_customer_group1`
    FOREIGN KEY (`customer_group_id` )
    REFERENCES `customer_group` (`customer_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `country`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `country` (
  `country_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `iso_code_2` VARCHAR(2) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `iso_code_3` VARCHAR(3) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `address_format` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `postcode_required` TINYINT(1) NOT NULL ,
  `status` TINYINT(1) NOT NULL DEFAULT '1' ,
  PRIMARY KEY (`country_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `zone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `zone` (
  `zone_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `country_id` INT(11) NOT NULL ,
  `code` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `name` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `status` TINYINT(1) NOT NULL DEFAULT '1' ,
  PRIMARY KEY (`zone_id`) ,
  INDEX `fk_zone_country` (`country_id` ASC) ,
  CONSTRAINT `fk_zone_country`
    FOREIGN KEY (`country_id` )
    REFERENCES `country` (`country_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `address` (
  `address_id` INT(11) NOT NULL ,
  `customer_id` INT(11) NOT NULL ,
  `country_id` INT(11) NOT NULL DEFAULT '0' ,
  `zone_id` INT(11) NOT NULL DEFAULT '0' ,
  `firstname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `lastname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `company` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `address_1` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `address_2` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `city` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `postcode` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`address_id`) ,
  INDEX `fk_address_customer1` (`customer_id` ASC) ,
  INDEX `fk_address_country1` (`country_id` ASC) ,
  INDEX `fk_address_zone1` (`zone_id` ASC) ,
  CONSTRAINT `fk_address_customer1`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`customer_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_country1`
    FOREIGN KEY (`country_id` )
    REFERENCES `country` (`country_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_zone1`
    FOREIGN KEY (`zone_id` )
    REFERENCES `zone` (`zone_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `affiliate`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `affiliate` (
  `affiliate_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `firstname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `lastname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `email` VARCHAR(96) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `telephone` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `fax` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `password` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `company` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `website` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `address_1` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `address_2` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `city` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `postcode` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `country_id` INT(11) NOT NULL ,
  `zone_id` INT(11) NOT NULL ,
  `code` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `commission` DECIMAL(4,2) NOT NULL DEFAULT '0.00' ,
  `tax` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `payment` VARCHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `cheque` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `paypal` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `bank_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `bank_branch_number` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `bank_swift_code` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `bank_account_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `bank_account_number` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `ip` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `status` TINYINT(1) NOT NULL ,
  `approved` TINYINT(1) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`affiliate_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `language`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `language` (
  `language_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `code` VARCHAR(5) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `locale` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `image` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `directory` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `filename` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `sort_order` INT(3) NOT NULL DEFAULT '0' ,
  `status` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`language_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `order_status`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `order_status` (
  `order_status_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_order_status_language` (`language_id` ASC) ,
  PRIMARY KEY (`order_status_id`) ,
  CONSTRAINT `fk_order_status_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `currency`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `currency` (
  `currency_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `code` VARCHAR(3) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `symbol_left` VARCHAR(12) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `symbol_right` VARCHAR(12) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `decimal_place` CHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `value` FLOAT(15,8) NOT NULL ,
  `status` TINYINT(1) NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  PRIMARY KEY (`currency_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `order` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `store_id` INT(11) NOT NULL DEFAULT '0' ,
  `customer_id` INT(11) NOT NULL DEFAULT '0' ,
  `customer_group_id` INT(11) NOT NULL DEFAULT '0' ,
  `shipping_country_id` INT(11) NOT NULL ,
  `shipping_zone_id` INT(11) NOT NULL ,
  `payment_country_id` INT(11) NOT NULL ,
  `payment_zone_id` INT(11) NOT NULL ,
  `order_status_id` INT(11) NOT NULL DEFAULT '0' ,
  `affiliate_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `currency_id` INT(11) NOT NULL ,
  `invoice_no` INT(11) NOT NULL DEFAULT '0' ,
  `invoice_prefix` VARCHAR(26) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `store_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `store_url` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `firstname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `lastname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `email` VARCHAR(96) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `telephone` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `fax` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `shipping_firstname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `shipping_lastname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `shipping_company` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `shipping_address_1` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `shipping_address_2` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `shipping_city` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `shipping_postcode` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `shipping_country` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `shipping_zone` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `shipping_address_format` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `shipping_method` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `payment_firstname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `payment_lastname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `payment_company` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `payment_address_1` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `payment_address_2` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `payment_city` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `payment_postcode` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `payment_country` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `payment_zone` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `payment_address_format` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `payment_method` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `comment` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `total` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  `reward` INT(8) NOT NULL ,
  `commission` DECIMAL(15,4) NOT NULL ,
  `currency_code` VARCHAR(3) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `currency_value` DECIMAL(15,8) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  `ip` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  PRIMARY KEY (`order_id`) ,
  INDEX `fk_order_store` (`store_id` ASC) ,
  INDEX `fk_order_customer` (`customer_id` ASC) ,
  INDEX `fk_order_customer_group` (`customer_group_id` ASC) ,
  INDEX `fk_order_shipping_country` (`shipping_country_id` ASC) ,
  INDEX `fk_order_shipping_zone` (`shipping_zone_id` ASC) ,
  INDEX `fk_order_payment_country` (`payment_country_id` ASC) ,
  INDEX `fk_order_payment_zone` (`payment_zone_id` ASC) ,
  INDEX `fk_order_order_status` (`order_status_id` ASC) ,
  INDEX `fk_order_affiliate` (`affiliate_id` ASC) ,
  INDEX `fk_order_language` (`language_id` ASC) ,
  INDEX `fk_order_currency` (`currency_id` ASC) ,
  CONSTRAINT `fk_order_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_customer`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`customer_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_customer_group`
    FOREIGN KEY (`customer_group_id` )
    REFERENCES `customer_group` (`customer_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_shipping_country`
    FOREIGN KEY (`shipping_country_id` )
    REFERENCES `country` (`country_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_shipping_zone`
    FOREIGN KEY (`shipping_zone_id` )
    REFERENCES `zone` (`zone_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_payment_country`
    FOREIGN KEY (`payment_country_id` )
    REFERENCES `country` (`country_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_payment_zone`
    FOREIGN KEY (`payment_zone_id` )
    REFERENCES `zone` (`zone_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_order_status`
    FOREIGN KEY (`order_status_id` )
    REFERENCES `order_status` (`order_status_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_affiliate`
    FOREIGN KEY (`affiliate_id` )
    REFERENCES `affiliate` (`affiliate_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_currency`
    FOREIGN KEY (`currency_id` )
    REFERENCES `currency` (`currency_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `affiliate_transaction`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `affiliate_transaction` (
  `affiliate_transaction_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `affiliate_id` INT(11) NOT NULL ,
  `order_id` INT(11) NOT NULL ,
  `description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `amount` DECIMAL(15,4) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`affiliate_transaction_id`) ,
  INDEX `fk_affiliate_transaction_affiliate` (`affiliate_id` ASC) ,
  INDEX `fk_affiliate_transaction_order` (`order_id` ASC) ,
  CONSTRAINT `fk_affiliate_transaction_affiliate`
    FOREIGN KEY (`affiliate_id` )
    REFERENCES `affiliate` (`affiliate_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_affiliate_transaction_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `attribute_group`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `attribute_group` (
  `attribute_group_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `sort_order` INT(3) NOT NULL ,
  PRIMARY KEY (`attribute_group_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `attribute`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `attribute` (
  `attribute_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `attribute_group_id` INT(11) NOT NULL ,
  `sort_order` INT(3) NOT NULL ,
  PRIMARY KEY (`attribute_id`) ,
  INDEX `fk_attribute_attribute_group` (`attribute_group_id` ASC) ,
  CONSTRAINT `fk_attribute_attribute_group`
    FOREIGN KEY (`attribute_group_id` )
    REFERENCES `attribute_group` (`attribute_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `attribute_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `attribute_description` (
  `attribute_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_attribute_description_attribute` (`attribute_id` ASC) ,
  INDEX `fk_attribute_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_attribute_description_attribute`
    FOREIGN KEY (`attribute_id` )
    REFERENCES `attribute` (`attribute_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attribute_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `attribute_group_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `attribute_group_description` (
  `attribute_group_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_attribute_group_description_language` (`language_id` ASC) ,
  INDEX `fk_attribute_group_description_attribute_group` (`attribute_group_id` ASC) ,
  CONSTRAINT `fk_attribute_group_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attribute_group_description_attribute_group`
    FOREIGN KEY (`attribute_group_id` )
    REFERENCES `attribute_group` (`attribute_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `banner`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `banner` (
  `banner_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `status` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`banner_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `banner_image`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `banner_image` (
  `banner_image_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `banner_id` INT(11) NOT NULL ,
  `link` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `image` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`banner_image_id`) ,
  INDEX `fk_banner_image_banner` (`banner_id` ASC) ,
  CONSTRAINT `fk_banner_image_banner`
    FOREIGN KEY (`banner_id` )
    REFERENCES `banner` (`banner_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `banner_image_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `banner_image_description` (
  `banner_image_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `banner_id` INT(11) NOT NULL ,
  `title` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`banner_image_id`) ,
  INDEX `fk_banner_image_description_language` (`language_id` ASC) ,
  INDEX `fk_banner_image_description_banner` (`banner_id` ASC) ,
  CONSTRAINT `fk_banner_image_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_banner_image_description_banner`
    FOREIGN KEY (`banner_id` )
    REFERENCES `banner` (`banner_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `category` (
  `category_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `parent_id` INT(11) NULL ,
  `image` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `top` TINYINT(1) NOT NULL ,
  `column` INT(3) NOT NULL ,
  `sort_order` INT(3) NOT NULL DEFAULT '0' ,
  `status` TINYINT(1) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  PRIMARY KEY (`category_id`) ,
  INDEX `fk_category_category` (`parent_id` ASC) ,
  CONSTRAINT `fk_category_category`
    FOREIGN KEY (`parent_id` )
    REFERENCES `category` (`category_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `category_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `category_description` (
  `category_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `meta_description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `meta_keyword` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `name` (`name` ASC) ,
  INDEX `fk_category_description_category` (`category_id` ASC) ,
  INDEX `fk_category_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_category_description_category`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`category_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_category_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `layout`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `layout` (
  `layout_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`layout_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `category_to_layout`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `category_to_layout` (
  `category_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL ,
  `layout_id` INT(11) NOT NULL ,
  INDEX `fk_category_to_layout_category` (`category_id` ASC) ,
  INDEX `fk_category_to_layout_store` (`store_id` ASC) ,
  INDEX `fk_category_to_layout_layout` (`layout_id` ASC) ,
  CONSTRAINT `fk_category_to_layout_category`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`category_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_category_to_layout_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_category_to_layout_layout`
    FOREIGN KEY (`layout_id` )
    REFERENCES `layout` (`layout_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `category_to_store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `category_to_store` (
  `category_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL ,
  INDEX `fk_category_to_store_category` (`category_id` ASC) ,
  INDEX `fk_category_to_store_store` (`store_id` ASC) ,
  CONSTRAINT `fk_category_to_store_category`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`category_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_category_to_store_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `coupon`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `coupon` (
  `coupon_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `code` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `type` CHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `discount` DECIMAL(15,4) NOT NULL ,
  `logged` TINYINT(1) NOT NULL ,
  `shipping` TINYINT(1) NOT NULL ,
  `total` DECIMAL(15,4) NOT NULL ,
  `date_start` DATE NOT NULL ,
  `date_end` DATE NOT NULL ,
  `uses_total` INT(11) NOT NULL ,
  `uses_customer` VARCHAR(11) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `status` TINYINT(1) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`coupon_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `coupon_history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `coupon_history` (
  `coupon_history_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `coupon_id` INT(11) NOT NULL ,
  `order_id` INT(11) NOT NULL ,
  `customer_id` INT(11) NOT NULL ,
  `amount` DECIMAL(15,4) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`coupon_history_id`) ,
  INDEX `fk_coupon_history_coupon` (`coupon_id` ASC) ,
  INDEX `fk_coupon_history_order` (`order_id` ASC) ,
  INDEX `fk_coupon_history_customer` (`customer_id` ASC) ,
  CONSTRAINT `fk_coupon_history_coupon`
    FOREIGN KEY (`coupon_id` )
    REFERENCES `coupon` (`coupon_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_coupon_history_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_coupon_history_customer`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`customer_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `manufacturer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `manufacturer` (
  `manufacturer_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `image` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `sort_order` INT(3) NOT NULL ,
  PRIMARY KEY (`manufacturer_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `stock_status`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stock_status` (
  `stock_status_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`stock_status_id`) ,
  INDEX `fk_stock_status_language` (`language_id` ASC) ,
  CONSTRAINT `fk_stock_status_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `tax_class`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tax_class` (
  `tax_class_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `date_added` DATETIME NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  PRIMARY KEY (`tax_class_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `length_class`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `length_class` (
  `length_class_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `value` DECIMAL(15,8) NOT NULL ,
  PRIMARY KEY (`length_class_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `weight_class`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `weight_class` (
  `weight_class_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `value` DECIMAL(15,8) NOT NULL DEFAULT '0.00000000' ,
  PRIMARY KEY (`weight_class_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `manufacturer_id` INT(11) NOT NULL ,
  `stock_status_id` INT(11) NOT NULL ,
  `tax_class_id` INT(11) NOT NULL ,
  `weight_class_id` INT(11) NOT NULL DEFAULT '0' ,
  `length_class_id` INT(11) NOT NULL DEFAULT '0' ,
  `model` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `sku` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `upc` VARCHAR(12) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `location` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `quantity` INT(4) NOT NULL DEFAULT '0' ,
  `image` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `shipping` TINYINT(1) NOT NULL DEFAULT '1' ,
  `price` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  `points` INT(8) NOT NULL DEFAULT '0' ,
  `date_available` DATE NOT NULL ,
  `weight` DECIMAL(5,2) NOT NULL DEFAULT '0.00' ,
  `length` DECIMAL(5,2) NOT NULL DEFAULT '0.00' ,
  `width` DECIMAL(5,2) NOT NULL DEFAULT '0.00' ,
  `height` DECIMAL(5,2) NOT NULL DEFAULT '0.00' ,
  `subtract` TINYINT(1) NOT NULL DEFAULT '1' ,
  `minimum` INT(11) NOT NULL DEFAULT '1' ,
  `sort_order` INT(11) NOT NULL DEFAULT '0' ,
  `status` TINYINT(1) NOT NULL DEFAULT '0' ,
  `date_added` DATETIME NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  `viewed` INT(5) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`product_id`) ,
  INDEX `fk_product_manufacturer` (`manufacturer_id` ASC) ,
  INDEX `fk_product_stock_status` (`stock_status_id` ASC) ,
  INDEX `fk_product_tax_class` (`tax_class_id` ASC) ,
  INDEX `fk_product_length_class` (`length_class_id` ASC) ,
  INDEX `fk_product_weight_class` (`weight_class_id` ASC) ,
  CONSTRAINT `fk_product_manufacturer`
    FOREIGN KEY (`manufacturer_id` )
    REFERENCES `manufacturer` (`manufacturer_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_stock_status`
    FOREIGN KEY (`stock_status_id` )
    REFERENCES `stock_status` (`stock_status_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_tax_class`
    FOREIGN KEY (`tax_class_id` )
    REFERENCES `tax_class` (`tax_class_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_length_class`
    FOREIGN KEY (`length_class_id` )
    REFERENCES `length_class` (`length_class_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_weight_class`
    FOREIGN KEY (`weight_class_id` )
    REFERENCES `weight_class` (`weight_class_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `coupon_product`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `coupon_product` (
  `coupon_product_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `coupon_id` INT(11) NOT NULL ,
  `product_id` INT(11) NOT NULL ,
  PRIMARY KEY (`coupon_product_id`) ,
  INDEX `fk_coupon_product_coupon` (`coupon_id` ASC) ,
  INDEX `fk_coupon_product_product` (`product_id` ASC) ,
  CONSTRAINT `fk_coupon_product_coupon`
    FOREIGN KEY (`coupon_id` )
    REFERENCES `coupon` (`coupon_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_coupon_product_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `customer_ip`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `customer_ip` (
  `customer_ip_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `customer_id` INT(11) NOT NULL ,
  `ip` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`customer_ip_id`) ,
  INDEX `fk_customer_ip_customer` (`customer_id` ASC) ,
  CONSTRAINT `fk_customer_ip_customer`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`customer_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `customer_reward`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `customer_reward` (
  `customer_reward_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `customer_id` INT(11) NOT NULL DEFAULT '0' ,
  `order_id` INT(11) NOT NULL DEFAULT '0' ,
  `description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `points` INT(8) NOT NULL DEFAULT '0' ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`customer_reward_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `customer_transaction`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `customer_transaction` (
  `customer_transaction_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `customer_id` INT(11) NOT NULL ,
  `order_id` INT(11) NOT NULL ,
  `description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `amount` DECIMAL(15,4) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`customer_transaction_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `download`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `download` (
  `download_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `filename` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `mask` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `remaining` INT(11) NOT NULL DEFAULT '0' ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`download_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `download_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `download_description` (
  `download_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  INDEX `fk_download_description_download` (`download_id` ASC) ,
  INDEX `fk_download_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_download_description_download`
    FOREIGN KEY (`download_id` )
    REFERENCES `download` (`download_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_download_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `extension`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `extension` (
  `extension_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `type` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `code` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`extension_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `geo_zone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `geo_zone` (
  `geo_zone_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `date_modified` DATETIME NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`geo_zone_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `information`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `information` (
  `information_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `sort_order` INT(3) NOT NULL DEFAULT '0' ,
  `status` TINYINT(1) NOT NULL DEFAULT '1' ,
  PRIMARY KEY (`information_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `information_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `information_description` (
  `information_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `title` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_information_description_information` (`information_id` ASC) ,
  INDEX `fk_information_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_information_description_information`
    FOREIGN KEY (`information_id` )
    REFERENCES `information` (`information_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_information_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `information_to_layout`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `information_to_layout` (
  `information_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL ,
  `layout_id` INT(11) NOT NULL ,
  INDEX `fk_information_to_layout_information` (`information_id` ASC) ,
  INDEX `fk_information_to_layout_store` (`store_id` ASC) ,
  INDEX `fk_information_to_layout_layout` (`layout_id` ASC) ,
  CONSTRAINT `fk_information_to_layout_information`
    FOREIGN KEY (`information_id` )
    REFERENCES `information` (`information_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_information_to_layout_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_information_to_layout_layout`
    FOREIGN KEY (`layout_id` )
    REFERENCES `layout` (`layout_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `information_to_store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `information_to_store` (
  `information_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL ,
  INDEX `fk_information_to_store_information` (`information_id` ASC) ,
  INDEX `fk_information_to_store_store` (`store_id` ASC) ,
  CONSTRAINT `fk_information_to_store_information`
    FOREIGN KEY (`information_id` )
    REFERENCES `information` (`information_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_information_to_store_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `layout_route`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `layout_route` (
  `layout_route_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `layout_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL ,
  `route` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`layout_route_id`) ,
  INDEX `fk_layout_route_layout` (`layout_id` ASC) ,
  INDEX `fk_layout_route_store` (`store_id` ASC) ,
  CONSTRAINT `fk_layout_route_layout`
    FOREIGN KEY (`layout_id` )
    REFERENCES `layout` (`layout_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_layout_route_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `length_class_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `length_class_description` (
  `length_class_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `title` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `unit` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_length_class_description_length_class` (`length_class_id` ASC) ,
  INDEX `fk_length_class_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_length_class_description_length_class`
    FOREIGN KEY (`length_class_id` )
    REFERENCES `length_class` (`length_class_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_length_class_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `manufacturer_to_store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `manufacturer_to_store` (
  `manufacturer_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL ,
  INDEX `fk_manufacturer_to_store_manufacturer` (`manufacturer_id` ASC) ,
  INDEX `fk_manufacturer_to_store_store` (`store_id` ASC) ,
  CONSTRAINT `fk_manufacturer_to_store_manufacturer`
    FOREIGN KEY (`manufacturer_id` )
    REFERENCES `manufacturer` (`manufacturer_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_manufacturer_to_store_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `option`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `option` (
  `option_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `type` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `sort_order` INT(3) NOT NULL ,
  PRIMARY KEY (`option_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `option_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `option_description` (
  `option_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_option_description_option` (`option_id` ASC) ,
  INDEX `fk_option_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_option_description_option`
    FOREIGN KEY (`option_id` )
    REFERENCES `option` (`option_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_option_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `option_value`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `option_value` (
  `option_value_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `option_id` INT(11) NOT NULL ,
  `image` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `sort_order` INT(3) NOT NULL ,
  PRIMARY KEY (`option_value_id`) ,
  INDEX `fk_option_value_option` (`option_id` ASC) ,
  CONSTRAINT `fk_option_value_option`
    FOREIGN KEY (`option_id` )
    REFERENCES `option` (`option_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `option_value_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `option_value_description` (
  `option_value_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `option_id` INT(11) NOT NULL ,
  `name` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_option_value_description_language` (`language_id` ASC) ,
  INDEX `fk_option_value_description_option_value` (`option_value_id` ASC) ,
  INDEX `fk_option_value_description_option` (`option_id` ASC) ,
  CONSTRAINT `fk_option_value_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_option_value_description_option_value`
    FOREIGN KEY (`option_value_id` )
    REFERENCES `option_value` (`option_value_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_option_value_description_option`
    FOREIGN KEY (`option_id` )
    REFERENCES `option` (`option_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `order_product`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `order_product` (
  `order_product_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `order_id` INT(11) NOT NULL ,
  `product_id` INT(11) NOT NULL ,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `model` VARCHAR(24) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `quantity` INT(4) NOT NULL ,
  `price` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  `total` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  `tax` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  PRIMARY KEY (`order_product_id`) ,
  INDEX `fk_order_product_order` (`order_id` ASC) ,
  INDEX `fk_order_product_product` (`product_id` ASC) ,
  CONSTRAINT `fk_order_product_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_product_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `order_download`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `order_download` (
  `order_download_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `order_id` INT(11) NOT NULL ,
  `order_product_id` INT(11) NOT NULL ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `filename` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `mask` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `remaining` INT(3) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`order_download_id`) ,
  INDEX `fk_order_download_order` (`order_id` ASC) ,
  INDEX `fk_order_download_order_product` (`order_product_id` ASC) ,
  CONSTRAINT `fk_order_download_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_download_order_product`
    FOREIGN KEY (`order_product_id` )
    REFERENCES `order_product` (`order_product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `order_history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `order_history` (
  `order_history_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `order_id` INT(11) NOT NULL ,
  `order_status_id` INT(11) NOT NULL ,
  `notify` TINYINT(1) NOT NULL DEFAULT '0' ,
  `comment` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`order_history_id`) ,
  INDEX `fk_order_history_order` (`order_id` ASC) ,
  INDEX `fk_order_history_order_status` (`order_status_id` ASC) ,
  CONSTRAINT `fk_order_history_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_history_order_status`
    FOREIGN KEY (`order_status_id` )
    REFERENCES `order_status` (`order_status_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_option`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_option` (
  `product_option_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL ,
  `option_id` INT(11) NOT NULL ,
  `option_value` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `required` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`product_option_id`) ,
  INDEX `fk_product_option_product` (`product_id` ASC) ,
  INDEX `fk_product_option_option` (`option_id` ASC) ,
  CONSTRAINT `fk_product_option_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_option_option`
    FOREIGN KEY (`option_id` )
    REFERENCES `option` (`option_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_option_value`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_option_value` (
  `product_option_value_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_option_id` INT(11) NOT NULL ,
  `product_id` INT(11) NOT NULL ,
  `option_id` INT(11) NOT NULL ,
  `option_value_id` INT(11) NOT NULL ,
  `quantity` INT(3) NOT NULL ,
  `subtract` TINYINT(1) NOT NULL ,
  `price` DECIMAL(15,4) NOT NULL ,
  `price_prefix` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `points` INT(8) NOT NULL ,
  `points_prefix` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `weight` DECIMAL(15,8) NOT NULL ,
  `weight_prefix` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`product_option_value_id`) ,
  INDEX `fk_product_option_value_product_option` (`product_option_id` ASC) ,
  INDEX `fk_product_option_value_product` (`product_id` ASC) ,
  INDEX `fk_product_option_value_option` (`option_id` ASC) ,
  INDEX `fk_product_option_value_option_value` (`option_value_id` ASC) ,
  CONSTRAINT `fk_product_option_value_product_option`
    FOREIGN KEY (`product_option_id` )
    REFERENCES `product_option` (`product_option_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_option_value_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_option_value_option`
    FOREIGN KEY (`option_id` )
    REFERENCES `option` (`option_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_option_value_option_value`
    FOREIGN KEY (`option_value_id` )
    REFERENCES `option_value` (`option_value_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `order_option`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `order_option` (
  `order_option_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `order_id` INT(11) NOT NULL ,
  `order_product_id` INT(11) NOT NULL ,
  `product_option_id` INT(11) NOT NULL ,
  `product_option_value_id` INT(11) NOT NULL DEFAULT '0' ,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `value` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `type` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`order_option_id`) ,
  INDEX `fk_order_option_order` (`order_id` ASC) ,
  INDEX `fk_order_option_order_product` (`order_product_id` ASC) ,
  INDEX `fk_order_option_product_option_value` (`product_option_value_id` ASC) ,
  INDEX `fk_order_option_product_option` (`product_option_id` ASC) ,
  CONSTRAINT `fk_order_option_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_option_order_product`
    FOREIGN KEY (`order_product_id` )
    REFERENCES `order_product` (`order_product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_option_product_option_value`
    FOREIGN KEY (`product_option_value_id` )
    REFERENCES `product_option_value` (`product_option_value_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_option_product_option`
    FOREIGN KEY (`product_option_id` )
    REFERENCES `product_option` (`product_option_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `order_total`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `order_total` (
  `order_total_id` INT(10) NOT NULL AUTO_INCREMENT ,
  `order_id` INT(11) NOT NULL ,
  `code` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `title` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `text` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `value` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  `sort_order` INT(3) NOT NULL ,
  PRIMARY KEY (`order_total_id`) ,
  INDEX `fk_order_total_order` (`order_id` ASC) ,
  CONSTRAINT `fk_order_total_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_attribute`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_attribute` (
  `language_id` INT(11) NOT NULL ,
  `product_id` INT(11) NOT NULL ,
  `attribute_id` INT(11) NOT NULL ,
  `text` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_product_attribute_language` (`language_id` ASC) ,
  INDEX `fk_product_attribute_product` (`product_id` ASC) ,
  INDEX `fk_product_attribute_attribute` (`attribute_id` ASC) ,
  CONSTRAINT `fk_product_attribute_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_attribute_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_attribute_attribute`
    FOREIGN KEY (`attribute_id` )
    REFERENCES `attribute` (`attribute_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_description` (
  `product_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `meta_description` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `meta_keyword` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_product_description_product` (`product_id` ASC) ,
  INDEX `fk_product_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_product_description_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_discount`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_discount` (
  `product_discount_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL ,
  `customer_group_id` INT(11) NOT NULL ,
  `quantity` INT(4) NOT NULL DEFAULT '0' ,
  `priority` INT(5) NOT NULL DEFAULT '1' ,
  `price` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  `date_start` DATE NOT NULL ,
  `date_end` DATE NOT NULL ,
  PRIMARY KEY (`product_discount_id`) ,
  INDEX `fk_product_discount_product` (`product_id` ASC) ,
  INDEX `fk_product_discount_customer_group` (`customer_group_id` ASC) ,
  CONSTRAINT `fk_product_discount_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_discount_customer_group`
    FOREIGN KEY (`customer_group_id` )
    REFERENCES `customer_group` (`customer_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_image`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_image` (
  `product_image_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL ,
  `image` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `sort_order` INT(3) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`product_image_id`) ,
  INDEX `fk_product_image_product` (`product_id` ASC) ,
  CONSTRAINT `fk_product_image_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_related`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_related` (
  `product_id` INT(11) NOT NULL ,
  `related_id` INT(11) NOT NULL ,
  INDEX `fk_product_related_product` (`product_id` ASC) ,
  INDEX `fk_product_related_product2` (`related_id` ASC) ,
  CONSTRAINT `fk_product_related_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_related_product2`
    FOREIGN KEY (`related_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_reward`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_reward` (
  `product_reward_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL DEFAULT '0' ,
  `customer_group_id` INT(11) NOT NULL DEFAULT '0' ,
  `points` INT(8) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`product_reward_id`) ,
  INDEX `fk_product_reward_product` (`product_id` ASC) ,
  INDEX `fk_product_reward_customer_group` (`customer_group_id` ASC) ,
  CONSTRAINT `fk_product_reward_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_reward_customer_group`
    FOREIGN KEY (`customer_group_id` )
    REFERENCES `customer_group` (`customer_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_special`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_special` (
  `product_special_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL ,
  `customer_group_id` INT(11) NOT NULL ,
  `priority` INT(5) NOT NULL DEFAULT '1' ,
  `price` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  `date_start` DATE NOT NULL ,
  `date_end` DATE NOT NULL ,
  PRIMARY KEY (`product_special_id`) ,
  INDEX `fk_product_special_product` (`product_id` ASC) ,
  INDEX `fk_product_special_customer_group` (`customer_group_id` ASC) ,
  CONSTRAINT `fk_product_special_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_special_customer_group`
    FOREIGN KEY (`customer_group_id` )
    REFERENCES `customer_group` (`customer_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_tag`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_tag` (
  `product_tag_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `tag` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`product_tag_id`) ,
  INDEX `fk_product_tag_product` (`product_id` ASC) ,
  INDEX `fk_product_tag_language` (`language_id` ASC) ,
  CONSTRAINT `fk_product_tag_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_tag_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_to_category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_to_category` (
  `product_id` INT(11) NOT NULL ,
  `category_id` INT(11) NOT NULL ,
  INDEX `fk_product_to_category_product` (`product_id` ASC) ,
  INDEX `fk_product_to_category_category` (`category_id` ASC) ,
  CONSTRAINT `fk_product_to_category_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_to_category_category`
    FOREIGN KEY (`category_id` )
    REFERENCES `category` (`category_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_to_download`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_to_download` (
  `product_id` INT(11) NOT NULL ,
  `download_id` INT(11) NOT NULL ,
  INDEX `fk_product_to_download_product` (`product_id` ASC) ,
  INDEX `fk_product_to_download_download` (`download_id` ASC) ,
  CONSTRAINT `fk_product_to_download_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_to_download_download`
    FOREIGN KEY (`download_id` )
    REFERENCES `download` (`download_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_to_layout`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_to_layout` (
  `product_id` INT(11) NOT NULL ,
  `layout_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL ,
  INDEX `fk_product_to_layout_product` (`product_id` ASC) ,
  INDEX `fk_product_to_layout_layout` (`layout_id` ASC) ,
  INDEX `fk_product_to_layout_store` (`store_id` ASC) ,
  CONSTRAINT `fk_product_to_layout_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_to_layout_layout`
    FOREIGN KEY (`layout_id` )
    REFERENCES `layout` (`layout_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_to_layout_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `product_to_store`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `product_to_store` (
  `product_id` INT(11) NOT NULL ,
  `store_id` INT(11) NOT NULL DEFAULT '0' ,
  INDEX `fk_product_to_store_product` (`product_id` ASC) ,
  INDEX `fk_product_to_store_store` (`store_id` ASC) ,
  CONSTRAINT `fk_product_to_store_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_to_store_store`
    FOREIGN KEY (`store_id` )
    REFERENCES `store` (`store_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `return_status`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `return_status` (
  `return_status_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `language_id` INT(11) NOT NULL DEFAULT '0' ,
  `name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  INDEX `fk_return_status_language` (`language_id` ASC) ,
  PRIMARY KEY (`return_status_id`) ,
  CONSTRAINT `fk_return_status_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `return`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `return` (
  `return_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `order_id` INT(11) NOT NULL ,
  `customer_id` INT(11) NOT NULL ,
  `return_status_id` INT(11) NOT NULL ,
  `date_ordered` DATE NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  `firstname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `lastname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `email` VARCHAR(96) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `telephone` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `comment` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`return_id`) ,
  INDEX `fk_return_order` (`order_id` ASC) ,
  INDEX `fk_return_customer` (`customer_id` ASC) ,
  INDEX `fk_return_return_status` (`return_status_id` ASC) ,
  CONSTRAINT `fk_return_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_return_customer`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`customer_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_return_return_status`
    FOREIGN KEY (`return_status_id` )
    REFERENCES `return_status` (`return_status_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `return_action`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `return_action` (
  `return_action_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `language_id` INT(11) NOT NULL DEFAULT '0' ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  INDEX `fk_return_action_language` (`language_id` ASC) ,
  PRIMARY KEY (`return_action_id`) ,
  CONSTRAINT `fk_return_action_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `return_history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `return_history` (
  `return_history_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `return_id` INT(11) NOT NULL ,
  `return_status_id` INT(11) NOT NULL ,
  `notify` TINYINT(1) NOT NULL ,
  `comment` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`return_history_id`) ,
  INDEX `fk_return_history_return` (`return_id` ASC) ,
  INDEX `fk_return_history_return_status` (`return_status_id` ASC) ,
  CONSTRAINT `fk_return_history_return`
    FOREIGN KEY (`return_id` )
    REFERENCES `return` (`return_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_return_history_return_status`
    FOREIGN KEY (`return_status_id` )
    REFERENCES `return_status` (`return_status_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `return_reason`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `return_reason` (
  `return_reason_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `language_id` INT(11) NOT NULL DEFAULT '0' ,
  `name` VARCHAR(128) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  PRIMARY KEY (`return_reason_id`) ,
  INDEX `fk_return_reason_language` (`language_id` ASC) ,
  CONSTRAINT `fk_return_reason_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `return_product`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `return_product` (
  `return_product_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `return_id` INT(11) NOT NULL ,
  `product_id` INT(11) NOT NULL ,
  `return_reason_id` INT(11) NOT NULL ,
  `return_action_id` INT(11) NOT NULL ,
  `name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `model` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `quantity` INT(4) NOT NULL ,
  `opened` TINYINT(1) NOT NULL ,
  `comment` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`return_product_id`) ,
  INDEX `fk_return_product_product` (`product_id` ASC) ,
  INDEX `fk_return_product_return` (`return_id` ASC) ,
  INDEX `fk_return_product_return_reason` (`return_reason_id` ASC) ,
  INDEX `fk_return_product_return_action` (`return_action_id` ASC) ,
  CONSTRAINT `fk_return_product_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_return_product_return`
    FOREIGN KEY (`return_id` )
    REFERENCES `return` (`return_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_return_product_return_reason`
    FOREIGN KEY (`return_reason_id` )
    REFERENCES `return_reason` (`return_reason_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_return_product_return_action`
    FOREIGN KEY (`return_action_id` )
    REFERENCES `return_action` (`return_action_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `review` (
  `review_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `product_id` INT(11) NOT NULL ,
  `customer_id` INT(11) NOT NULL ,
  `author` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `text` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `rating` INT(1) NOT NULL ,
  `status` TINYINT(1) NOT NULL DEFAULT '0' ,
  `date_added` DATETIME NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  PRIMARY KEY (`review_id`) ,
  INDEX `fk_review_product` (`product_id` ASC) ,
  INDEX `fk_review_customer` (`customer_id` ASC) ,
  CONSTRAINT `fk_review_product`
    FOREIGN KEY (`product_id` )
    REFERENCES `product` (`product_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_review_customer`
    FOREIGN KEY (`customer_id` )
    REFERENCES `customer` (`customer_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `setting`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `setting` (
  `setting_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `store_id` INT(11) NOT NULL ,
  `group` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `key` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `value` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `serialized` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`setting_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `tax_rate`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tax_rate` (
  `tax_rate_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `geo_zone_id` INT(11) NOT NULL ,
  `name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `rate` DECIMAL(15,4) NOT NULL DEFAULT '0.0000' ,
  `type` CHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  PRIMARY KEY (`tax_rate_id`) ,
  INDEX `fk_tax_rate_geo_zone` (`geo_zone_id` ASC) ,
  CONSTRAINT `fk_tax_rate_geo_zone`
    FOREIGN KEY (`geo_zone_id` )
    REFERENCES `geo_zone` (`geo_zone_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `tax_rate_to_customer_group`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tax_rate_to_customer_group` (
  `tax_rate_id` INT(11) NOT NULL ,
  `customer_group_id` INT(11) NOT NULL ,
  INDEX `fk_tax_rate_to_customer_group_tax_rate` (`tax_rate_id` ASC) ,
  INDEX `fk_tax_rate_to_customer_group_customer_group` (`customer_group_id` ASC) ,
  CONSTRAINT `fk_tax_rate_to_customer_group_tax_rate`
    FOREIGN KEY (`tax_rate_id` )
    REFERENCES `tax_rate` (`tax_rate_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tax_rate_to_customer_group_customer_group`
    FOREIGN KEY (`customer_group_id` )
    REFERENCES `customer_group` (`customer_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `tax_rule`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tax_rule` (
  `tax_rule_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `tax_class_id` INT(11) NOT NULL ,
  `tax_rate_id` INT(11) NOT NULL ,
  `based` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `priority` INT(5) NOT NULL DEFAULT '1' ,
  PRIMARY KEY (`tax_rule_id`) ,
  INDEX `fk_tax_rule_tax_class` (`tax_class_id` ASC) ,
  INDEX `fk_tax_rule_tax_rate` (`tax_rate_id` ASC) ,
  CONSTRAINT `fk_tax_rule_tax_class`
    FOREIGN KEY (`tax_class_id` )
    REFERENCES `tax_class` (`tax_class_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tax_rule_tax_rate`
    FOREIGN KEY (`tax_rate_id` )
    REFERENCES `tax_rate` (`tax_rate_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `url_alias`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `url_alias` (
  `url_alias_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `query` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `keyword` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`url_alias_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `user_group`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `user_group` (
  `user_group_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `permission` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`user_group_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `user` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `user_group_id` INT(11) NOT NULL ,
  `username` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `password` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `firstname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `lastname` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `email` VARCHAR(96) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `code` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `ip` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT '' ,
  `status` TINYINT(1) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`user_id`) ,
  INDEX `fk_user_user_group` (`user_group_id` ASC) ,
  CONSTRAINT `fk_user_user_group`
    FOREIGN KEY (`user_group_id` )
    REFERENCES `user_group` (`user_group_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `voucher`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `voucher` (
  `voucher_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `order_id` INT(11) NOT NULL ,
  `code` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `from_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `from_email` VARCHAR(96) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `to_name` VARCHAR(64) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `to_email` VARCHAR(96) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `message` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `amount` DECIMAL(15,4) NOT NULL ,
  `voucher_theme_id` INT(11) NOT NULL ,
  `status` TINYINT(1) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`voucher_id`) ,
  INDEX `fk_voucher_order` (`order_id` ASC) ,
  CONSTRAINT `fk_voucher_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `voucher_history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `voucher_history` (
  `voucher_history_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `voucher_id` INT(11) NOT NULL ,
  `order_id` INT(11) NOT NULL ,
  `amount` DECIMAL(15,4) NOT NULL ,
  `date_added` DATETIME NOT NULL ,
  PRIMARY KEY (`voucher_history_id`) ,
  INDEX `fk_voucher_history_voucher` (`voucher_id` ASC) ,
  INDEX `fk_voucher_history_order` (`order_id` ASC) ,
  CONSTRAINT `fk_voucher_history_voucher`
    FOREIGN KEY (`voucher_id` )
    REFERENCES `voucher` (`voucher_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_voucher_history_order`
    FOREIGN KEY (`order_id` )
    REFERENCES `order` (`order_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `voucher_theme`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `voucher_theme` (
  `voucher_theme_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `image` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`voucher_theme_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `voucher_theme_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `voucher_theme_description` (
  `voucher_theme_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `name` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_voucher_theme_description_voucher_theme` (`voucher_theme_id` ASC) ,
  INDEX `fk_voucher_theme_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_voucher_theme_description_voucher_theme`
    FOREIGN KEY (`voucher_theme_id` )
    REFERENCES `voucher_theme` (`voucher_theme_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_voucher_theme_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `weight_class_description`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `weight_class_description` (
  `weight_class_id` INT(11) NOT NULL ,
  `language_id` INT(11) NOT NULL ,
  `title` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `unit` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_weight_class_description_weight_class` (`weight_class_id` ASC) ,
  INDEX `fk_weight_class_description_language` (`language_id` ASC) ,
  CONSTRAINT `fk_weight_class_description_weight_class`
    FOREIGN KEY (`weight_class_id` )
    REFERENCES `weight_class` (`weight_class_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_weight_class_description_language`
    FOREIGN KEY (`language_id` )
    REFERENCES `language` (`language_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `zone_to_geo_zone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `zone_to_geo_zone` (
  `zone_to_geo_zone_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `country_id` INT(11) NOT NULL ,
  `geo_zone_id` INT(11) NOT NULL ,
  `zone_id` INT(11) NULL ,
  `date_added` DATETIME NOT NULL ,
  `date_modified` DATETIME NOT NULL ,
  PRIMARY KEY (`zone_to_geo_zone_id`) ,
  INDEX `fk_zone_to_geo_zone_zone` (`zone_id` ASC) ,
  INDEX `fk_zone_to_geo_zone_country` (`country_id` ASC) ,
  INDEX `fk_zone_to_geo_zone_geo_zone` (`geo_zone_id` ASC) ,
  CONSTRAINT `fk_zone_to_geo_zone_zone`
    FOREIGN KEY (`zone_id` )
    REFERENCES `zone` (`zone_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_zone_to_geo_zone_country`
    FOREIGN KEY (`country_id` )
    REFERENCES `country` (`country_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_zone_to_geo_zone_geo_zone`
    FOREIGN KEY (`geo_zone_id` )
    REFERENCES `geo_zone` (`geo_zone_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
