/*================================================================================*/
/* DDL SCRIPT                                                                     */
/*================================================================================*/
/*  Title    : PhpPlaisio                                                         */
/*  FileName : db-page.ecm                                                        */
/*  Platform : MariaDB 10.x                                                       */
/*  Version  :                                                                    */
/*  Date     : Saturday, April 30, 2022                                           */
/*================================================================================*/
/*================================================================================*/
/* CREATE TABLES                                                                  */
/*================================================================================*/

CREATE TABLE `AUT_PAGE_TAB` (
  `ptb_id` TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `wrd_id` SMALLINT UNSIGNED NOT NULL,
  `ptb_label` VARCHAR(30) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`ptb_id`)
);

/*
COMMENT ON TABLE `AUT_PAGE_TAB`
@deprecated
*/

CREATE TABLE `ABC_AUTH_PAGE` (
  `pag_id` SMALLINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `pag_id_org` SMALLINT UNSIGNED,
  `ptb_id` TINYINT UNSIGNED,
  `wrd_id` SMALLINT UNSIGNED NOT NULL,
  `pag_alias` VARCHAR(32),
  `pag_class` VARCHAR(128) NOT NULL,
  `pag_label` VARCHAR(128) CHARACTER SET ascii COLLATE ascii_general_ci,
  `pag_weight` INT,
  CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (`pag_id`)
);

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE`.`pag_id`
The ID of the page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE`.`pag_id_org`
@deprecated
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE`.`ptb_id`
@deprecated
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE`.`wrd_id`
The title of the page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE`.`pag_alias`
The URL alias of the page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE`.`pag_class`
The PHP class that implementing the page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE`.`pag_label`
The label (i.e. PHP constant) of the page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE`.`pag_weight`
@deprecated
*/

CREATE TABLE `ABC_AUTH_PAGE_COMPANY` (
  `pag_id` SMALLINT UNSIGNED NOT NULL,
  `cmp_id` SMALLINT UNSIGNED NOT NULL,
  `pag_class` VARCHAR(128) NOT NULL,
  CONSTRAINT `PK_ABC_AUTH_PAGE_COMPANY` PRIMARY KEY (`pag_id`, `cmp_id`)
);

/*
COMMENT ON TABLE `ABC_AUTH_PAGE_COMPANY`
A company specific PHP class implementing a page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE_COMPANY`.`pag_id`
The page.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE_COMPANY`.`cmp_id`
The company.
*/

/*
COMMENT ON COLUMN `ABC_AUTH_PAGE_COMPANY`.`pag_class`
The PHP class implementing the page.
*/

/*================================================================================*/
/* CREATE INDEXES                                                                 */
/*================================================================================*/

CREATE INDEX `IX_AUT_PAGE_TAB1` ON `AUT_PAGE_TAB` (`wrd_id`);

CREATE INDEX `IX_ABC_AUTH_PAGE1` ON `ABC_AUTH_PAGE` (`ptb_id`);

CREATE INDEX `IX_ABC_AUTH_PAGE2` ON `ABC_AUTH_PAGE` (`pag_id_org`);

CREATE INDEX `wrd_id` ON `ABC_AUTH_PAGE` (`wrd_id`);

CREATE INDEX `IX_ABC_AUTH_PAGE_COMPANY2` ON `ABC_AUTH_PAGE_COMPANY` (`cmp_id`);

/*================================================================================*/
/* CREATE FOREIGN KEYS                                                            */
/*================================================================================*/

ALTER TABLE `AUT_PAGE_TAB`
  ADD CONSTRAINT `FK_AUT_PAGE_TAB_ABC_BABEL_WORD`
  FOREIGN KEY (`wrd_id`) REFERENCES `ABC_BABEL_WORD` (`wrd_id`);

ALTER TABLE `ABC_AUTH_PAGE`
  ADD CONSTRAINT `FK_ABC_AUTH_PAGE_ABC_BABEL_WORD`
  FOREIGN KEY (`wrd_id`) REFERENCES `ABC_BABEL_WORD` (`wrd_id`);

ALTER TABLE `ABC_AUTH_PAGE`
  ADD CONSTRAINT `FK_ABC_AUTH_PAGE_AUT_PAGE_TAB`
  FOREIGN KEY (`ptb_id`) REFERENCES `AUT_PAGE_TAB` (`ptb_id`);

ALTER TABLE `ABC_AUTH_PAGE`
  ADD CONSTRAINT `FK_ABC_AUTH_PAGE_ABC_AUTH_PAGE`
  FOREIGN KEY (`pag_id_org`) REFERENCES `ABC_AUTH_PAGE` (`pag_id`);

ALTER TABLE `ABC_AUTH_PAGE_COMPANY`
  ADD CONSTRAINT `FK_ABC_AUTH_PAGE_COMPANY_ABC_AUTH_COMPANY`
  FOREIGN KEY (`cmp_id`) REFERENCES `ABC_AUTH_COMPANY` (`cmp_id`);

ALTER TABLE `ABC_AUTH_PAGE_COMPANY`
  ADD CONSTRAINT `FK_ABC_AUTH_PAGE_COMPANY_ABC_AUTH_PAGE`
  FOREIGN KEY (`pag_id`) REFERENCES `ABC_AUTH_PAGE` (`pag_id`);
