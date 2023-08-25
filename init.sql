-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema swe
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema swe
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `swe` DEFAULT CHARACTER SET utf8 ;
USE `swe` ;

-- -----------------------------------------------------
-- Table `swe`.`company_name`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`company_name` ;

CREATE TABLE IF NOT EXISTS `swe`.`company_name` (
  `c_id` INT NOT NULL AUTO_INCREMENT,
  `c_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`c_id`),
  UNIQUE INDEX `c_name_UNIQUE` (`c_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`company_rank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`company_rank` ;

CREATE TABLE IF NOT EXISTS `swe`.`company_rank` (
  `c_id` INT NOT NULL,
  `c_rank` VARCHAR(45) NULL,
  PRIMARY KEY (`c_id`),
  CONSTRAINT
    FOREIGN KEY (`c_id`)
    REFERENCES `swe`.`company_name` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`company_employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`company_employee` ;

CREATE TABLE IF NOT EXISTS `swe`.`company_employee` (
  `c_id` INT NOT NULL,
  `num_employees` INT NULL,
  PRIMARY KEY (`c_id`),
  CONSTRAINT
    FOREIGN KEY (`c_id`)
    REFERENCES `swe`.`company_name` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`company_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`company_year` ;

CREATE TABLE IF NOT EXISTS `swe`.`company_year` (
  `c_id` INT NOT NULL,
  `f_yr` VARCHAR(45) NULL,
  PRIMARY KEY (`c_id`),
  CONSTRAINT
    FOREIGN KEY (`c_id`)
    REFERENCES `swe`.`company_name` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`sector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`sector` ;

CREATE TABLE IF NOT EXISTS `swe`.`sector` (
  `s_id` INT NOT NULL,
  `s_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`s_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`company_sector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`company_sector` ;

CREATE TABLE IF NOT EXISTS `swe`.`company_sector` (
  `c_id` INT NOT NULL,
  `s_id` INT NOT NULL,
  PRIMARY KEY (`c_id`),
  INDEX `s_id_idx` (`s_id` ASC) VISIBLE,
  CONSTRAINT
    FOREIGN KEY (`c_id`)
    REFERENCES `swe`.`company_name` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT
    FOREIGN KEY (`s_id`)
    REFERENCES `swe`.`sector` (`s_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`state` ;

CREATE TABLE IF NOT EXISTS `swe`.`state` (
  `state_id` INT NOT NULL,
  `state_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`city` ;

CREATE TABLE IF NOT EXISTS `swe`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  `state_id` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `state_id_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT
    FOREIGN KEY (`state_id`)
    REFERENCES `swe`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`company_city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`company_city` ;

CREATE TABLE IF NOT EXISTS `swe`.`company_city` (
  `c_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`c_id`),
  INDEX `city_id_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT
    FOREIGN KEY (`c_id`)
    REFERENCES `swe`.`company_name` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT
    FOREIGN KEY (`city_id`)
    REFERENCES `swe`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`company_finance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`company_finance` ;

CREATE TABLE IF NOT EXISTS `swe`.`company_finance` (
  `c_id` INT NOT NULL,
  `revenues` INT NULL,
  `r_change` DECIMAL(4,3) NULL,
  `profits` DECIMAL(10,1) NULL,
  `p_change` DECIMAL(4,3) NULL,
  `assets` INT NULL,
  `m_value` INT NULL,
  `m_cap` INT NULL,
  PRIMARY KEY (`c_id`),
  CONSTRAINT
    FOREIGN KEY (`c_id`)
    REFERENCES `swe`.`company_name` (`c_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`city_salary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`city_salary` ;

CREATE TABLE IF NOT EXISTS `swe`.`city_salary` (
  `city_id` INT NOT NULL,
  `mean_sd_salary_adj` DECIMAL(8,1) NULL,
  `mean_sd_salary_unadj` DECIMAL(8,1) NULL,
  `mean_salary_adj` DECIMAL(8,1) NULL,
  PRIMARY KEY (`city_id`),
  CONSTRAINT
    FOREIGN KEY (`city_id`)
    REFERENCES `swe`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`city_jobs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`city_jobs` ;

CREATE TABLE IF NOT EXISTS `swe`.`city_jobs` (
  `city_id` INT NOT NULL,
  `num_sd_jobs` INT NULL,
  PRIMARY KEY (`city_id`),
  CONSTRAINT
    FOREIGN KEY (`city_id`)
    REFERENCES `swe`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swe`.`city_econ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `swe`.`city_econ` ;

CREATE TABLE IF NOT EXISTS `swe`.`city_econ` (
  `city_id` INT NOT NULL,
  `med_home_p` DECIMAL(8,1) NULL,
  `col_avg` DECIMAL(8,1) NULL,
  `rent_avg` DECIMAL(8,1) NULL,
  `lpp_avg` DECIMAL(8,1) NULL,
  PRIMARY KEY (`city_id`),
  CONSTRAINT
    FOREIGN KEY (`city_id`)
    REFERENCES `swe`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
