-- DATABASE ------------------------------------
-- LỆNH TẠO DATABASE
CREATE DATABASE `homework_buoi_4`

-- TẠO TABLE

-- Bảng rate_res
CREATE TABLE `rate_res` (
    `user_id` INT,
    `res_id` INT,
    `amount` INT,
    `date_rate` DATETIME,
    FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
    FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
);

-- Bảng restaurant
CREATE TABLE `restaurant` (
    `res_id` INT PRIMARY KEY AUTO_INCREMENT,
    `res_name` VARCHAR(255),
    `Image` VARCHAR(255),
    `desc` VARCHAR(255)
);

-- Bảng user
CREATE TABLE `user` (
    `user_id` INT PRIMARY KEY AUTO_INCREMENT,
    `full_name` VARCHAR(255),
    `email` VARCHAR(255),
    `password` VARCHAR(255)
);

-- Bảng like_res
CREATE TABLE `like_res` (
    `user_id` INT,
    `res_id` INT,
    `date_like` DATETIME,
    FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
    FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
);


-- Bảng order
CREATE TABLE `order` (
    `user_id` INT,
    `food_id` INT,
    `amount` INT,
    `code` VARCHAR(255),
    `arr_sub_id` VARCHAR(255),
    FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
    FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
);

-- Bảng food_type
CREATE TABLE `food_type` (
    `type_id` INT PRIMARY KEY AUTO_INCREMENT,
    `type_name` VARCHAR(255)
);


-- Bảng food
CREATE TABLE `food` (
    `food_id` INT PRIMARY KEY AUTO_INCREMENT,
    `food_name` VARCHAR(255),
    `image` VARCHAR(255),
    `price` FLOAT,
    `desc` VARCHAR(255),
    `type_id` INT,
    FOREIGN KEY (`type_id`) REFERENCES `food_type` (`type_id`)
);


-- Bảng sub_food
CREATE TABLE `sub_food` (
    `sub_id` INT PRIMARY KEY AUTO_INCREMENT,
    `sub_name` VARCHAR(255),
    `sub_price` FLOAT,
    `food_id` INT,
    FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
);



