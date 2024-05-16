-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hellow_eventos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hellow_eventos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hellow_eventos` DEFAULT CHARACTER SET utf8 ;
USE `hellow_eventos` ;

-- -----------------------------------------------------
-- Table `hellow_eventos`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`tipo` (
  `id` TINYINT NOT NULL,
  `descricao` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`usuario` (
  `id` VARCHAR(50) NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `sobrenome` VARCHAR(20) NOT NULL,
  `login` VARCHAR(30) NOT NULL,
  `senha` VARCHAR(100) NOT NULL,
  `dt_nascimento` DATE NOT NULL,
  `dt_criacao` DATETIME NOT NULL DEFAULT current_timestamp,
  `dt_filiacao` DATE NOT NULL,
  `email` VARCHAR(80) NULL,
  `telefone` INT(11) NULL,
  `cpf` INT(11) NOT NULL,
  `tipo_id` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) ,
  INDEX `fk_usuario_tipo1_idx` (`tipo_id` ASC) ,
  CONSTRAINT `fk_usuario_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `hellow_eventos`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`endereco` (
  `id` SMALLINT NOT NULL,
  `logradouro` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `numero` SMALLINT NULL,
  `cep` INT(8) NOT NULL,
  `bairro` VARCHAR(20) NOT NULL,
  `cidade` VARCHAR(20) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `complemento` TEXT NULL,
  `tipo_id` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereco_tipo1_idx` (`tipo_id` ASC) ,
  CONSTRAINT `fk_endereco_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `hellow_eventos`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`evento` (
  `id` SMALLINT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `data` DATETIME NOT NULL,
  `descricao` TEXT NULL,
  `lotacao` SMALLINT NOT NULL,
  `endereco_id` SMALLINT NOT NULL,
  `tipo_id` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_evento_endereco1_idx` (`endereco_id` ASC) ,
  INDEX `fk_evento_tipo1_idx` (`tipo_id` ASC) ,
  CONSTRAINT `fk_evento_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `hellow_eventos`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `hellow_eventos`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`midia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`midia` (
  `id` SMALLINT NOT NULL,
  `formato` VARCHAR(4) NOT NULL,
  `duracao` SMALLINT NULL,
  `tamanho` SMALLINT NULL,
  `link` VARCHAR(80) NOT NULL,
  `evento_id` SMALLINT NOT NULL,
  `tipo_id` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `link_UNIQUE` (`link` ASC) ,
  INDEX `fk_midia_evento1_idx` (`evento_id` ASC) ,
  INDEX `fk_midia_tipo1_idx` (`tipo_id` ASC) ,
  CONSTRAINT `fk_midia_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `hellow_eventos`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_midia_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `hellow_eventos`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`fornecedor` (
  `id` SMALLINT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `cnpj` INT(14) NOT NULL,
  `ativo` BINARY NOT NULL DEFAULT 1,
  `endereco_id` SMALLINT NOT NULL,
  `tipo_id` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) ,
  INDEX `fk_fornecedor_endereco1_idx` (`endereco_id` ASC) ,
  INDEX `fk_fornecedor_tipo1_idx` (`tipo_id` ASC) ,
  CONSTRAINT `fk_fornecedor_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `hellow_eventos`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `hellow_eventos`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`ingresso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`ingresso` (
  `id` SMALLINT NOT NULL,
  `valor_base` DECIMAL(6,2) NOT NULL,
  `meia` BINARY NULL DEFAULT 0,
  `social` BINARY NULL DEFAULT 0,
  `valor_pago` DECIMAL(6,2) NOT NULL,
  `pago` BINARY NULL DEFAULT 0,
  `vip` BINARY NULL DEFAULT 0,
  `evento_id` SMALLINT NOT NULL,
  `tipo_id` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ingresso_evento1_idx` (`evento_id` ASC) ,
  INDEX `fk_ingresso_tipo1_idx` (`tipo_id` ASC) ,
  CONSTRAINT `fk_ingresso_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `hellow_eventos`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingresso_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `hellow_eventos`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`cliente` (
  `id` SMALLINT NOT NULL,
  `nome` VARCHAR(30) NOT NULL,
  `sobrenome` VARCHAR(30) NOT NULL,
  `cpf` INT(11) NOT NULL,
  `telefone` INT(11) NOT NULL,
  `email` VARCHAR(50) NULL,
  `endereco_id` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) ,
  INDEX `fk_cliente_endereco1_idx` (`endereco_id` ASC) ,
  CONSTRAINT `fk_cliente_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `hellow_eventos`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`fk_ingresso_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`fk_ingresso_cliente` (
  `ingresso_id` SMALLINT NOT NULL,
  `cliente_id` SMALLINT NOT NULL,
  PRIMARY KEY (`ingresso_id`, `cliente_id`),
  INDEX `fk_ingresso_has_cliente_cliente1_idx` (`cliente_id` ASC) ,
  INDEX `fk_ingresso_has_cliente_ingresso_idx` (`ingresso_id` ASC) ,
  CONSTRAINT `fk_ingresso_has_cliente_ingresso`
    FOREIGN KEY (`ingresso_id`)
    REFERENCES `hellow_eventos`.`ingresso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingresso_has_cliente_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `hellow_eventos`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hellow_eventos`.`fk_fornecedor_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hellow_eventos`.`fk_fornecedor_evento` (
  `fornecedor_id` SMALLINT NOT NULL,
  `evento_id` SMALLINT NOT NULL,
  PRIMARY KEY (`fornecedor_id`, `evento_id`),
  INDEX `fk_fornecedor_has_evento_evento1_idx` (`evento_id` ASC) ,
  INDEX `fk_fornecedor_has_evento_fornecedor1_idx` (`fornecedor_id` ASC) ,
  CONSTRAINT `fk_fornecedor_has_evento_fornecedor1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `hellow_eventos`.`fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_has_evento_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `hellow_eventos`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
