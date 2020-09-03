
use presta;

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
-- Table `mydb`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  `preco` DECIMAL(5,2) NOT NULL,
  `tempo_min` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prestador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prestador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `dt_nascimento` DATETIME NOT NULL,
  `telefone` CHAR(15) NOT NULL,
  `cep` CHAR(8) NOT NULL,
  `endereco` VARCHAR(500) NOT NULL,
  `numero` VARCHAR(5) NOT NULL,
  `complemento` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`servico_has_prestador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servico_has_prestador` (
  `servico_id` INT NOT NULL,
  `prestador_id` INT NOT NULL,
  PRIMARY KEY (`servico_id`, `prestador_id`),
  INDEX `fk_servico_has_prestador_prestador1_idx` (`prestador_id` ASC) ,
  INDEX `fk_servico_has_prestador_servico_idx` (`servico_id` ASC) ,
  CONSTRAINT `fk_servico_has_prestador_servico`
    FOREIGN KEY (`servico_id`)
    REFERENCES `mydb`.`servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_has_prestador_prestador1`
    FOREIGN KEY (`prestador_id`)
    REFERENCES `mydb`.`prestador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`disponibilidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `disponibilidade` (
  `id` INT NOT NULL,
  `horario` DATETIME NOT NULL,
  `status` ENUM('disponivel', 'indisponivel') NOT NULL,
  `prestador_id` INT NOT NULL,
  PRIMARY KEY (`id`, `prestador_id`),
  INDEX `fk_disponibilidade_prestador1_idx` (`prestador_id` ASC) ,
  UNIQUE INDEX `horario_UNIQUE` (`horario` ASC) ,
  CONSTRAINT `fk_disponibilidade_prestador1`
    FOREIGN KEY (`prestador_id`)
    REFERENCES `mydb`.`prestador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`ranking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ranking` (`nome` INT, `preco` INT, `tempo_min` INT, `fnc_valor_hora(preco, tempo_min)` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`dados_idade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dados_idade` (`id` INT, `cpf` INT, `endereco` INT, `dt_nascimento` INT, `idade` INT);

-- -----------------------------------------------------
-- function fnc_valor_hora
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE FUNCTION fnc_valor_hora(p_preco DECIMAL(5,2), p_tempo INT)
 RETURNS DECIMAL(5,2)
BEGIN
        
	RETURN 60 * p_preco / p_tempo ;
    
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function fnc_idade
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE FUNCTION fnc_idade(p_data_nascimento DATE) 
RETURNS INT
BEGIN
	RETURN TIMESTAMPDIFF( YEAR, p_data_nascimento, CURDATE());
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `mydb`.`ranking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ranking`;
USE `mydb`;
CREATE  OR REPLACE VIEW `ranking` AS
SELECT
	s.nome,
    s.preco,
    s.tempo_min,
	fnc_valor_hora(preco, tempo_min)
    FROM servico s
    ORDER BY fnc_valor_hora DESC;

-- -----------------------------------------------------
-- View `mydb`.`dados_idade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`dados_idade`;
USE `mydb`;
CREATE  OR REPLACE VIEW `dados_idade` AS
SELECT
	p.id,
	p.cpf,
    p.endereco,
    p.dt_nascimento,
	fnc_idade(dt_nascimento) AS idade
    FROM prestador p;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
