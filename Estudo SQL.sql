-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Item_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item_pedido` (
  `id_item_pedido` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_item_pedido`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `id_entrega` INT NOT NULL AUTO_INCREMENT,
  `id_pedido` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `status_entrega` ENUM('Preparando Envio', 'Em Transito', 'Entregue', 'Atrasado', 'Cancelada') NOT NULL,
  `codigo_rastreio` VARCHAR(100) NULL,
  `data_estimada_entrega` DATE NULL,
  `data_real_entrega` DATETIME NULL,
  PRIMARY KEY (`id_entrega`),
  UNIQUE INDEX `id_pedido_UNIQUE` (`id_pedido` ASC) VISIBLE,
  UNIQUE INDEX `codigo_rastreio_UNIQUE` (`codigo_rastreio` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `data_pedido` DATETIME NOT NULL,
  `status_pedido` VARCHAR(50) NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `Item_pedido_id_item_pedido` INT NOT NULL,
  `id_cliente_metodo_pagamento` INT NOT NULL,
  `Entrega_id_entrega` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_Pedido_Item_pedido1_idx` (`Item_pedido_id_item_pedido` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`Entrega_id_entrega` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Item_pedido1`
    FOREIGN KEY (`Item_pedido_id_item_pedido`)
    REFERENCES `mydb`.`Item_pedido` (`id_item_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entrega_id_entrega`)
    REFERENCES `mydb`.`Entrega` (`id_entrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente_PF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente_PF` (
  `id_cliente_PF` INT NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`id_cliente_PF`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente_PJ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente_PJ` (
  `id_cliente_pj` INT NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `razao_social` VARCHAR(255) NOT NULL,
  `nome_fantasia` VARCHAR(255) NULL,
  PRIMARY KEY (`id_cliente_pj`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `rua` VARCHAR(255) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `complemento` VARCHAR(100) NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `tipo_endereco` ENUM('Entrega', 'Cobranca', 'Principal', 'Outro') NOT NULL,
  `Entrega_id_entrega` INT NOT NULL,
  PRIMARY KEY (`id_endereco`),
  INDEX `fk_Endereco_Entrega1_idx` (`Entrega_id_entrega` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Entrega1`
    FOREIGN KEY (`Entrega_id_entrega`)
    REFERENCES `mydb`.`Entrega` (`id_entrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente_Metodo_Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente_Metodo_Pagamento` (
  `id_cliente_metodo_pagamento` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_metodo_pagamento` INT NOT NULL,
  `token_cartao` VARCHAR(255) NULL,
  `bandeira_cartao` VARCHAR(50) NULL,
  `validade_cartao` VARCHAR(7) NULL,
  `padrao` TINYINT NULL,
  `Pedido_id_pedido` INT NOT NULL,
  PRIMARY KEY (`id_cliente_metodo_pagamento`),
  INDEX `fk_Cliente_Metodo_Pagamento_Pedido1_idx` (`Pedido_id_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Metodo_Pagamento_Pedido1`
    FOREIGN KEY (`Pedido_id_pedido`)
    REFERENCES `mydb`.`Pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(20) NULL,
  `tipo_cliente` ENUM('PF', 'PJ') NOT NULL,
  `Pedido_id_pedido` INT NOT NULL,
  `Cliente_PF_id_cliente_PF` INT NOT NULL,
  `Cliente_PJ_id_cliente_pj` INT NOT NULL,
  `Endereco_id_endereco` INT NOT NULL,
  `Cliente_Metodo_Pagamento_id_cliente_metodo_pagamento` INT NOT NULL,
  PRIMARY KEY (`id_cliente`, `Cliente_PF_id_cliente_PF`, `Cliente_PJ_id_cliente_pj`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_Cliente_Pedido_idx` (`Pedido_id_pedido` ASC) VISIBLE,
  INDEX `fk_Cliente_Cliente_PF1_idx` (`Cliente_PF_id_cliente_PF` ASC) VISIBLE,
  INDEX `fk_Cliente_Cliente_PJ1_idx` (`Cliente_PJ_id_cliente_pj` ASC) VISIBLE,
  INDEX `fk_Cliente_Endereco1_idx` (`Endereco_id_endereco` ASC) VISIBLE,
  INDEX `fk_Cliente_Cliente_Metodo_Pagamento1_idx` (`Cliente_Metodo_Pagamento_id_cliente_metodo_pagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pedido`
    FOREIGN KEY (`Pedido_id_pedido`)
    REFERENCES `mydb`.`Pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Cliente_PF1`
    FOREIGN KEY (`Cliente_PF_id_cliente_PF`)
    REFERENCES `mydb`.`Cliente_PF` (`id_cliente_PF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Cliente_PJ1`
    FOREIGN KEY (`Cliente_PJ_id_cliente_pj`)
    REFERENCES `mydb`.`Cliente_PJ` (`id_cliente_pj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Endereco1`
    FOREIGN KEY (`Endereco_id_endereco`)
    REFERENCES `mydb`.`Endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Cliente_Metodo_Pagamento1`
    FOREIGN KEY (`Cliente_Metodo_Pagamento_id_cliente_metodo_pagamento`)
    REFERENCES `mydb`.`Cliente_Metodo_Pagamento` (`id_cliente_metodo_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `nome_produto` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `estoque` INT NOT NULL,
  `Item_pedido_id_item_pedido` INT NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `fk_Produto_Item_pedido1_idx` (`Item_pedido_id_item_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Item_pedido1`
    FOREIGN KEY (`Item_pedido_id_item_pedido`)
    REFERENCES `mydb`.`Item_pedido` (`id_item_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Metodo_Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Metodo_Pagamento` (
  `id_metodo_pagamento` INT NOT NULL AUTO_INCREMENT,
  `nome_metodo` VARCHAR(100) NOT NULL,
  `descricao_metodo` VARCHAR(255) NULL,
  `Cliente_Metodo_Pagamento_id_cliente_metodo_pagamento` INT NOT NULL,
  PRIMARY KEY (`id_metodo_pagamento`),
  UNIQUE INDEX `nome_metodo_UNIQUE` (`nome_metodo` ASC) VISIBLE,
  INDEX `fk_Metodo_Pagamento_Cliente_Metodo_Pagamento1_idx` (`Cliente_Metodo_Pagamento_id_cliente_metodo_pagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Metodo_Pagamento_Cliente_Metodo_Pagamento1`
    FOREIGN KEY (`Cliente_Metodo_Pagamento_id_cliente_metodo_pagamento`)
    REFERENCES `mydb`.`Cliente_Metodo_Pagamento` (`id_cliente_metodo_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
