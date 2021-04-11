-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `admin_flg` TINYINT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `groups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` CHAR(8) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `map_user_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `map_user_group` (
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  INDEX `fk_map_user_group_users_idx` (`user_id` ASC),
  INDEX `fk_map_user_group_groups_idx` (`group_id` ASC),
  CONSTRAINT `fk_map_user_group_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`),
  CONSTRAINT `fk_map_user_group_groups`
    FOREIGN KEY (`group_id`)
    REFERENCES `groups` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `service` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `service_id` INT NOT NULL,
  `grant` VARCHAR(200) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_role_service_idx` (`service_id` ASC),
  CONSTRAINT `fk_role_service`
    FOREIGN KEY (`service_id`)
    REFERENCES `service` (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `map_group_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `map_group_role` (
  `group_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  INDEX `fk_map_group_role_groups_idx` (`group_id` ASC),
  INDEX `fk_map_group_role_role_idx` (`role_id` ASC),
  CONSTRAINT `fk_map_group_role_groups`
    FOREIGN KEY (`group_id`)
    REFERENCES `groups` (`id`),
  CONSTRAINT `fk_map_group_role_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `role` (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `resource_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resource_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resource` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(200) NOT NULL,
  `resource_type_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_resource_resource_type_idx` (`resource_type_id` ASC),
  CONSTRAINT `fk_resource_resource_type`
    FOREIGN KEY (`resource_type_id`)
    REFERENCES `resource_type` (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `map_group_resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `map_group_resource` (
  `group_id` INT NOT NULL,
  `resource_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE INDEX `unique_key` (`group_id` ASC, `resource_id` ASC),
  INDEX `fk_map_group_resource_group_idx` (`group_id` ASC),
  INDEX `fk_map_group_resource_resource_idx` (`resource_id` ASC),
  CONSTRAINT `fk_map_group_resource_group`
    FOREIGN KEY (`group_id`)
    REFERENCES `groups` (`id`),
  CONSTRAINT `fk_map_group_resource_resource`
    FOREIGN KEY (`resource_id`)
    REFERENCES `resource` (`id`))
ENGINE = InnoDB