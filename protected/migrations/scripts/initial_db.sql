SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `platypus` DEFAULT CHARACTER SET utf8 ;
USE `platypus` ;

-- -----------------------------------------------------
-- Table `platypus`.`company`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`company` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  `short_name` VARCHAR(255) NULL ,
  `parent_company_id` INT UNSIGNED NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_company_parent_company` (`parent_company_id` ASC) ,
  CONSTRAINT `fk_company_parent_company`
    FOREIGN KEY (`parent_company_id` )
    REFERENCES `platypus`.`company` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`address_country`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`address_country` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `iso_code` CHAR(2) NOT NULL ,
  `label` VARCHAR(255) NOT NULL ,
  `dailing_code` VARCHAR(5) NULL COMMENT 'E.g. 27, 1, 61 etc' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'E.g. South Africa (ZA), Australia (AU) etc.';


-- -----------------------------------------------------
-- Table `platypus`.`address_province_state`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`address_province_state` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `abbreviation` VARCHAR(255) NULL ,
  `label` VARCHAR(255) NOT NULL ,
  `country_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_province_state_country` (`country_id` ASC) ,
  CONSTRAINT `fk_province_state_country`
    FOREIGN KEY (`country_id` )
    REFERENCES `platypus`.`address_country` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
COMMENT = 'E.g. Gauteng, Western Australia, Western Cape';


-- -----------------------------------------------------
-- Table `platypus`.`address_region`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`address_region` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(255) NOT NULL ,
  `province_state_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_region_province_state` (`province_state_id` ASC) ,
  CONSTRAINT `fk_region_province_state`
    FOREIGN KEY (`province_state_id` )
    REFERENCES `platypus`.`address_province_state` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
COMMENT = 'E.g. Northern Gauteng, Southern Gauteng, Northern Suburbs et' /* comment truncated */;


-- -----------------------------------------------------
-- Table `platypus`.`address_city`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`address_city` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(255) NOT NULL ,
  `region_id` INT UNSIGNED NULL ,
  `province_state_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_city_region` (`region_id` ASC) ,
  INDEX `fk_city_province_state` (`province_state_id` ASC) ,
  CONSTRAINT `fk_city_region`
    FOREIGN KEY (`region_id` )
    REFERENCES `platypus`.`address_region` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_city_province_state`
    FOREIGN KEY (`province_state_id` )
    REFERENCES `platypus`.`address_province_state` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
COMMENT = 'E.g. Tswane, Cape Town, Johannesburg, Perth, Durban';


-- -----------------------------------------------------
-- Table `platypus`.`address_suburb`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`address_suburb` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(255) NOT NULL ,
  `postal_code` VARCHAR(10) NULL ,
  `city_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_suburb_city` (`city_id` ASC) ,
  CONSTRAINT `fk_suburb_city`
    FOREIGN KEY (`city_id` )
    REFERENCES `platypus`.`address_city` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
COMMENT = 'E.g. Centurion CBD, Moreleta Park, Eldoraign';


-- -----------------------------------------------------
-- Table `platypus`.`address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `line_1` VARCHAR(255) NOT NULL ,
  `line_2` VARCHAR(255) NULL ,
  `line_3` VARCHAR(255) NULL ,
  `suburb_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_address_suburb` (`suburb_id` ASC) ,
  CONSTRAINT `fk_address_suburb`
    FOREIGN KEY (`suburb_id` )
    REFERENCES `platypus`.`address_suburb` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`contact_detail_type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`contact_detail_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(255) NOT NULL ,
  `description` TEXT NULL ,
  `display_order` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `validators` VARCHAR(255) NULL COMMENT 'The name of the validator or validator class to use when validating a value of this type. Comma separated list.' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'email address, mobile phone number, land line number, intern' /* comment truncated */;


-- -----------------------------------------------------
-- Table `platypus`.`contact_detail`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`contact_detail` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `type_id` INT UNSIGNED NOT NULL ,
  `value` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_contact_detail_type` (`type_id` ASC) ,
  CONSTRAINT `fk_contact_detail_type`
    FOREIGN KEY (`type_id` )
    REFERENCES `platypus`.`contact_detail_type` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`company_contact_detail`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`company_contact_detail` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `company_id` INT UNSIGNED NOT NULL ,
  `contact_detail_id` INT UNSIGNED NOT NULL ,
  `label` VARCHAR(255) NOT NULL ,
  `notes` TEXT NULL ,
  `date_superseded` DATETIME NULL DEFAULT '1970-01-01 00:00:00' COMMENT 'Date & Time that this contact detail was superseded by another contact detail. This will ensure that a history of contact details are maintained that will be searchable. Defaults to 1970-01-01 to indicates that date has not been superseded and is the current version of the contact detail.' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_company_contact_detail_company` (`company_id` ASC) ,
  INDEX `fk_company_contact_detail_contact_detail` (`contact_detail_id` ASC) ,
  CONSTRAINT `fk_company_contact_detail_company`
    FOREIGN KEY (`company_id` )
    REFERENCES `platypus`.`company` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_company_contact_detail_contact_detail`
    FOREIGN KEY (`contact_detail_id` )
    REFERENCES `platypus`.`contact_detail` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`company_address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`company_address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `company_id` INT UNSIGNED NOT NULL ,
  `address_id` INT UNSIGNED NOT NULL ,
  `label` VARCHAR(255) NOT NULL COMMENT 'E.g. Postal Address, home address, work address, site office, head office, delivery address etc.' ,
  `notes` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_company_address_company` (`company_id` ASC) ,
  INDEX `fk_company_address_address` (`address_id` ASC) ,
  CONSTRAINT `fk_company_address_company`
    FOREIGN KEY (`company_id` )
    REFERENCES `platypus`.`company` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_company_address_address`
    FOREIGN KEY (`address_id` )
    REFERENCES `platypus`.`address` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`person`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`person` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `full_name` VARCHAR(255) NULL ,
  `surname` VARCHAR(255) NULL ,
  `preferred_name` VARCHAR(255) NOT NULL ,
  `date_of_birth` DATE NULL ,
  `gender` INT UNSIGNED NULL COMMENT 'Possible values are:\nNot Specified\nMale\nFemale\n\nThese values are constants in the model class.' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'A person is someone whose information and identity has been ' /* comment truncated */;


-- -----------------------------------------------------
-- Table `platypus`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `person_id` INT UNSIGNED NOT NULL ,
  `username_contact_detail_id` INT UNSIGNED NOT NULL COMMENT 'A person\'s email address is used as his username. This is just a reference to the email address used as username.' ,
  `password` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_user_person` (`person_id` ASC) ,
  INDEX `fk_user_contact_detail` (`username_contact_detail_id` ASC) ,
  CONSTRAINT `fk_user_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `platypus`.`person` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_contact_detail`
    FOREIGN KEY (`username_contact_detail_id` )
    REFERENCES `platypus`.`contact_detail` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`person_address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`person_address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `person_id` INT UNSIGNED NOT NULL ,
  `address_id` INT UNSIGNED NOT NULL ,
  `label` VARCHAR(255) NOT NULL COMMENT 'E.g. Postal Address, home address, work address, site office, head office, delivery address etc.' ,
  `notes` TEXT NULL ,
  `date_superseded` DATETIME NULL DEFAULT '1970-01-01 00:00:00' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_candidate_address_candidate` (`person_id` ASC) ,
  INDEX `fk_candidate_address_address` (`address_id` ASC) ,
  CONSTRAINT `fk_person_address_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `platypus`.`person` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_person_address_address`
    FOREIGN KEY (`address_id` )
    REFERENCES `platypus`.`address` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`auth_assignment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`auth_assignment` (
  `itemname` VARCHAR(64) NOT NULL ,
  `userid` VARCHAR(65) NOT NULL ,
  `bizrule` TEXT NULL DEFAULT NULL ,
  `data` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`itemname`, `userid`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`auth_item`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`auth_item` (
  `name` VARCHAR(64) NOT NULL ,
  `type` INT NOT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  `bizrule` TEXT NULL DEFAULT NULL ,
  `data` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`auth_item_child`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`auth_item_child` (
  `parent` VARCHAR(64) NOT NULL ,
  `child` VARCHAR(64) NOT NULL ,
  PRIMARY KEY (`parent`, `child`) ,
  INDEX `fk_auth_item_parent` (`parent` ASC) ,
  INDEX `fk_auth_item_child` (`child` ASC) ,
  CONSTRAINT `fk_auth_item_parent`
    FOREIGN KEY (`parent` )
    REFERENCES `platypus`.`auth_item` (`name` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_auth_item_child`
    FOREIGN KEY (`child` )
    REFERENCES `platypus`.`auth_item` (`name` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`person_contact_detail`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`person_contact_detail` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `person_id` INT UNSIGNED NOT NULL ,
  `contact_detail_id` INT UNSIGNED NOT NULL ,
  `label` VARCHAR(255) NOT NULL ,
  `notes` TEXT NULL ,
  `date_superseded` DATETIME NULL DEFAULT '1970-01-01 00:00:00' COMMENT 'Date & Time that this contact detail was superseded by another contact detail. This will ensure that a history of contact details are maintained that will be searchable.' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_person_contact_detail_person` (`person_id` ASC) ,
  INDEX `fk_person_contact_detail_contact_detail` (`contact_detail_id` ASC) ,
  CONSTRAINT `fk_person_contact_detail_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `platypus`.`person` (`id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_person_contact_detail_contact_detail`
    FOREIGN KEY (`contact_detail_id` )
    REFERENCES `platypus`.`contact_detail` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `platypus`.`audit_trail`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `platypus`.`audit_trail` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `old_value` TEXT NULL ,
  `new_value` TEXT NULL ,
  `action` VARCHAR(255) NOT NULL ,
  `model` VARCHAR(255) NOT NULL ,
  `field` VARCHAR(255) NOT NULL ,
  `stamp` DATETIME NOT NULL ,
  `user_id` INT NOT NULL ,
  `model_id` INT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `platypus`.`contact_detail_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `platypus`;
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (1, 'Website', 'E.g. www.google.com, http://www.news.com.au', 1, 'url');
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (2, 'Email Address', 'E.g. person@company.com', 5, 'email');
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (3, 'Skype', 'A username for Skype, the Internet communication system. E.g. joe.bloggs, john_smith', 0, NULL);
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (4, 'Facebook', 'E.g. http://facebook.com/placemntpartner', 0, 'url');
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (5, 'Twitter', 'E.g. @LadyGaga', 0, 'twitter');
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (6, 'Telephone', 'E.g. +61 8 9874 1254, 08 9685 4587, 1300 123 123, 13 12 11', 2, 'telephone');
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (7, 'Mobile Phone', 'E.g. +61420852154, 0425786458', 4, 'mobile');
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (8, 'Fax Number', 'E.g. +61 8 9874 1254, 08 9685 4587', 1, 'telephone');
INSERT INTO `platypus`.`contact_detail_type` (`id`, `label`, `description`, `display_order`, `validators`) VALUES (9, 'LinkedIn', 'Linked in profile', 0, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `platypus`.`contact_detail`
-- -----------------------------------------------------
START TRANSACTION;
USE `platypus`;
INSERT INTO `platypus`.`contact_detail` (`id`, `type_id`, `value`) VALUES (1, 2, 'super@platypusplatform.com');

COMMIT;

-- -----------------------------------------------------
-- Data for table `platypus`.`person`
-- -----------------------------------------------------
START TRANSACTION;
USE `platypus`;
INSERT INTO `platypus`.`person` (`id`, `full_name`, `surname`, `preferred_name`, `date_of_birth`, `gender`) VALUES (1, 'Platypus', 'Super User', 'Platypus', NULL, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `platypus`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `platypus`;
INSERT INTO `platypus`.`user` (`id`, `person_id`, `username_contact_detail_id`, `password`) VALUES (1, 1, 1, 'd293c98482fd37cff714ee96610174d6');

COMMIT;
