-- Migration SQL that makes the change goes here.
CREATE TABLE IF NOT EXISTS `public_keys`(
    `kid` varchar(64) NOT NULL,
    `usage` varchar(32) NOT NULL,
    `jwk` text NOT NULL,
    `disabled` tinyint(4) unsigned NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`kid`),
    KEY `on_usage_and_disabled` (`usage`,`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `private_keys`(
    `kid` varchar(64) NOT NULL,
    `usage` varchar(32) NOT NULL,
    `jwk` text NOT NULL,
    `disabled` tinyint(4) unsigned NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`kid`),
    KEY `on_usage_and_disabled` (`usage`,`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- //@UNDO
-- SQL to undo the change goes here.
DROP TABLE `private_keys`;
DROP TABLE `public_keys`;
