
DELETE FROM `users` WHERE `id` = 1;

INSERT INTO `users` (`id`, `name`, `nickname`, `address`)
VALUES (1, 'test', 'aaaa', 'example-address');


INSERT INTO `blog_posts` (`id`, `title`, `body`, `author_id`)
VALUES (1, 'test-title', 'aaaa-body', '1');
