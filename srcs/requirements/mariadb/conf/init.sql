CREATE DATABASE IF NOT EXISTS wordpress;
USE wordpress;

-- Création des tables nécessaires à WordPress
CREATE TABLE IF NOT EXISTS wp_posts (
  ID int(11) NOT NULL AUTO_INCREMENT,
  post_author bigint(20) unsigned NOT NULL DEFAULT '0',
  post_date datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  post_date_gmt datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  post_content longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  post_title text COLLATE utf8mb4_unicode_ci NOT NULL,
  post_status varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
  post_name varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (ID)
);
