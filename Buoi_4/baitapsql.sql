-- DATABASE ------------------------------------
-- LỆNH TẠO DATABASE
CREATE DATABASE `homework_buoi_4`
-----------------------------------
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
-- Dữ liệu cho rate_res
INSERT INTO `rate_res` (`user_id`,`res_id`,`amount`, `date_rate`) VALUES 
					(1,1,5,NOW()),
					(2,1,4,NOW()),
					(1,3,5,NOW()),
					(3,2,5,NOW()),
					(3,1,2,NOW())
-----------------------------------
-- Bảng restaurant
CREATE TABLE `restaurant` (
    `res_id` INT PRIMARY KEY AUTO_INCREMENT,
    `res_name` VARCHAR(255),
    `Image` VARCHAR(255),
    `desc` VARCHAR(255)
);
-- Data cho restaurant
INSERT INTO `restaurant` (`res_name`) VALUES 
					("Yen Yakiniku"),
					("Golden Meat House"),
					("All Seasons Buffet - Da Nang"),
					("Brilliant Top Bar"),
					("Pink Salt Restaurant")
-----------------------------------
-- Bảng user
CREATE TABLE `user` (
    `user_id` INT PRIMARY KEY AUTO_INCREMENT,
    `full_name` VARCHAR(255),
    `email` VARCHAR(255),
    `password` VARCHAR(255)
);
-- Data cho user
INSERT INTO `user` (`full_name`) VALUES 
					("Lê Văn A"),
					("Nguyễn Phước B"),
					("Trần Phước C"),
					("Huỳnh Văn D"),
					("San Di"),
					("Lý Đình Hạo"),
					("Trần An Nhiên");
-----------------------------------
-- Bảng like_res
CREATE TABLE `like_res` (
    `user_id` INT,
    `res_id` INT,
    `date_like` DATETIME,
    FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
    FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
);

-- Data cho like_res
INSERT INTO `like_res` (`user_id`,`res_id`, `date_like`) VALUES 
					(1,1,NOW()),
					(2,1,NOW()),
					(1,3,NOW()),
					(3,2,NOW()),
					(3,1,NOW()),
					(4,2,NOW()),
    				(5,3,NOW()),
    				(2,4,NOW());
					

-----------------------------------

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
-- Data cho like_res
INSERT INTO `order` (`user_id`,`food_id`, `amount`) VALUES 
					(1,1,2),
					(2,1,3),
					(1,3,1),
					(3,2,4),
					(3,1,1),
					(4,2,3),
    				(5,3,2),
    				(1,1,3),
    				(2,4,1);
    				
-----------------------------------


-- Bảng food_type
CREATE TABLE `food_type` (
    `type_id` INT PRIMARY KEY AUTO_INCREMENT,
    `type_name` VARCHAR(255)
);
-----------------------------------

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

-- Data cho food
INSERT INTO `food` (`food_name`) VALUES 
					("Chả Ram Tôm Đất"),
					("Bánh Tráng Thịt Heo"),
					("Mì Quảng"),
					("Bún Bò Huế"),
					("Bún Chả Hà Nội")
-----------------------------------

-- Bảng sub_food
CREATE TABLE `sub_food` (
    `sub_id` INT PRIMARY KEY AUTO_INCREMENT,
    `sub_name` VARCHAR(255),
    `sub_price` FLOAT,
    `food_id` INT,
    FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
);

-- Data cho sub_food
INSERT INTO `sub_food` (`sub_name`) VALUES 
					("Bánh Tráng"),
					("Bún"),
					("Rau Sống")

-----------------------------------

-- Câu 1: Tìm 5 người đã like cho nhà hàng nhiều nhất
SELECT `user`.`user_id`,`like_res`.`user_id`, `full_name`, COUNT(`like_res`.`user_id`) AS "Số lượng"
FROM `like_res`
INNER JOIN `user` ON `user`.user_id = `like_res`.user_id
GROUP BY `like_res`.user_id
ORDER BY `Số lượng` DESC


-- Câu 2: Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT `restaurant`.`res_id`,`like_res`.`res_id`, `res_name`, COUNT(`like_res`.`res_id`) AS "Số lượng"
FROM `like_res`
INNER JOIN `restaurant` ON `restaurant`.res_id = `like_res`.res_id
GROUP BY `like_res`.res_id
ORDER BY `Số lượng` DESC
LIMIT 2

-- Câu 3: Tìm người đặt hàng nhiều nhất
SELECT `user`.`user_id`,`order`.`user_id`, `full_name`, COUNT(`order`.`user_id`) AS "Số lượng"
FROM `order`
INNER JOIN `user` ON `user`.user_id = `order`.user_id
GROUP BY `order`.user_id
ORDER BY `Số lượng` DESC
LIMIT 1

-- Câu 4: Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng) 
SELECT `user`.`user_id`,`full_name`
FROM `user`
LEFT JOIN `order` ON `user`.user_id = `order`.user_id
LEFT JOIN `like_res` ON `user`.user_id = `like_res`.user_id
LEFT JOIN `rate_res` ON `user`.user_id = `rate_res`.user_id
WHERE `order`.`user_id` IS NULL
  AND `like_res`.`user_id` IS NULL
  AND `rate_res`.`user_id` IS NULL;

