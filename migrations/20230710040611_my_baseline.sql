-- Create "atlas_schema_revisions" table
CREATE TABLE `atlas_schema_revisions` (
    `version` varchar(255) NOT NULL,
    `description` varchar(255) NOT NULL,
    `type` bigint unsigned NOT NULL DEFAULT 2,
    `applied` bigint NOT NULL DEFAULT 0,
    `total` bigint NOT NULL DEFAULT 0,
    `executed_at` timestamp NOT NULL,
    `execution_time` bigint NOT NULL,
    `error` longtext NULL,
    `error_stmt` longtext NULL,
    `hash` varchar(255) NOT NULL,
    `partial_hashes` json NULL,
    `operator_version` varchar(255) NOT NULL,
    PRIMARY KEY (`version`)
) CHARSET utf8mb4 COLLATE utf8mb4_bin;
-- Create "users" table
CREATE TABLE `users` (
    `id` int NOT NULL,
    `name` varchar(100) NULL,
    PRIMARY KEY (`id`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Create "blog_posts" table
CREATE TABLE `blog_posts` (
    `id` int NOT NULL,
    `title` varchar(100) NULL,
    `body` text NULL,
    `author_id` int NULL,
    PRIMARY KEY (`id`),
    INDEX `author_fk` (`author_id`),
    CONSTRAINT `author_fk` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
