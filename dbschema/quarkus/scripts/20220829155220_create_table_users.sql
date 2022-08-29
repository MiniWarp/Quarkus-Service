-- Migration SQL that makes the change goes here.
CREATE TABLE IF NOT EXISTS `users` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `nickname` varchar(32) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
    `gender` enum('male','female','unknown') COLLATE utf8mb4_bin NOT NULL DEFAULT 'unknown',
    `birthday` date NOT NULL,
    `phone` varchar(16) COLLATE utf8mb4_bin DEFAULT NULL,
    `email` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
    `disabled` tinyint(1) NOT NULL DEFAULT '0',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `email_UNIQUE` (`email`),
    UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- //@UNDO
-- SQL to undo the change goes here.
DROP TABLE `users`;
