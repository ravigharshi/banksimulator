CREATE DATABASE IF NOT EXISTS abcbank;
USE abcbank;

--
-- Table structure for table 'role'
--
DROP TABLE IF EXISTS role;

CREATE TABLE role (
  role_id int(11) PRIMARY KEY,
  name varchar(255) DEFAULT NULL
) ENGINE=INNODB;

--
-- Table structure for table 'primary_account'
--
DROP TABLE IF EXISTS primary_account;

CREATE TABLE primary_account (
  id bigint(20) AUTO_INCREMENT PRIMARY KEY,
  account_balance decimal(19,2) DEFAULT NULL,
  account_number int(11) NOT NULL
) ENGINE=INNODB;

--
-- Table structure for table 'savings_account'
--
DROP TABLE IF EXISTS savings_account;

CREATE TABLE savings_account (
  id bigint(20) AUTO_INCREMENT PRIMARY KEY,
  account_balance decimal(19,2) DEFAULT NULL,
  account_number int(11) NOT NULL
) ENGINE=INNODB;

--
-- Table structure for table `user`
--
DROP TABLE IF EXISTS user;

CREATE TABLE user (
  user_id bigint(20) AUTO_INCREMENT PRIMARY KEY,
  email varchar(255) NOT NULL,
  enabled bit(1) NOT NULL,
  first_name varchar(255) DEFAULT NULL,
  last_name varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  phone varchar(255) DEFAULT NULL,
  username varchar(255) DEFAULT NULL,
  primary_account_id bigint(20) DEFAULT NULL,
  savings_account_id bigint(20) DEFAULT NULL,
  UNIQUE KEY uk_user (email),
  CONSTRAINT fk_primary_account FOREIGN KEY (primary_account_id) REFERENCES primary_account (id),
  CONSTRAINT fk_savings_account FOREIGN KEY (savings_account_id) REFERENCES savings_account (id)
) ENGINE=InnoDB;

--
-- Table structure for table 'appointment'
--
DROP TABLE IF EXISTS appointment;

CREATE TABLE appointment (
  id bigint(20) AUTO_INCREMENT PRIMARY KEY,
  confirmed bit(1) NOT NULL,
  date datetime DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  location varchar(255) DEFAULT NULL,
  user_id bigint(20) DEFAULT NULL,
  CONSTRAINT fk_appnt_user FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=INNODB;

--
-- Table structure for table 'primary_transaction'
--
DROP TABLE IF EXISTS primary_transaction;

CREATE TABLE primary_transaction (
  id bigint(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  amount double NOT NULL,
  available_balance decimal(19,2) DEFAULT NULL,
  date datetime DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  type varchar(255) DEFAULT NULL,
  primary_account_id bigint(20) DEFAULT NULL,
  CONSTRAINT fk_pt_primary_account FOREIGN KEY (primary_account_id) REFERENCES primary_account (id)
) ENGINE=INNODB;

--
-- Table structure for table 'recipient'
--
DROP TABLE IF EXISTS recipient;

CREATE TABLE recipient (
  id bigint(20) AUTO_INCREMENT PRIMARY KEY,
  account_number varchar(255) DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  phone varchar(255) DEFAULT NULL,
  user_id bigint(20) DEFAULT NULL,
  CONSTRAINT fk_recpt_user FOREIGN KEY (user_id) REFERENCES user (user_id)
) ENGINE=INNODB;

--
-- Table structure for table 'savings_transaction'
--
DROP TABLE IF EXISTS savings_transaction;

CREATE TABLE savings_transaction (
  id bigint(20) AUTO_INCREMENT PRIMARY KEY,
  amount double NOT NULL,
  available_balance decimal(19,2) DEFAULT NULL,
  date datetime DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  type varchar(255) DEFAULT NULL,
  savings_account_id bigint(20) DEFAULT NULL,
  CONSTRAINT fk_st_savings_account FOREIGN KEY (savings_account_id) REFERENCES savings_account (id)
) ENGINE=InnoDB;

--
-- Table structure for table 'user_role'
--
DROP TABLE IF EXISTS user_role;

CREATE TABLE user_role 
(
  user_role_id bigint(20) AUTO_INCREMENT PRIMARY KEY,
  role_id int(11) DEFAULT NULL,
  user_id bigint(20) DEFAULT NULL,
  CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES user (user_id),
  CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES role (role_id)
) ENGINE=InnoDB;

