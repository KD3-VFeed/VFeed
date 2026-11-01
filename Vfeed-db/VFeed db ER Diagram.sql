CREATE TABLE `users` (
  `user_id` int PRIMARY KEY AUTO_INCREMENT,
  `mobile_no` varchar(10) UNIQUE NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) UNIQUE NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(250),
  -- `city_id` int,
  `created_at` timestamp,
  `role` varchar(30) COMMENT 'Example: CUSTOMER, RESTAURANT, ADMIN'
);


CREATE TABLE `address` {
  `address_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  `restaurant_id` int NOT NULL,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
  `LOCATION_ID` int NOT NULL,
  FOREIGN KEY (LOCATION_ID) REFERENCES locations(location_id),
  FLAT_NO varchar(100) NOT NULL,
  CITY varchar(100) NOT NULL,
  STATE varchar(100) NOT NULL,
  COUNTRY varchar(100) NOT NULL,
  PINCODE varchar(10) NOT NULL 
  
  };




CREATE TABLE `locations` (
  `location_id` int PRIMARY KEY AUTO_INCREMENT,
  `longitude` decimal(10,7),
  `latitude` decimal(10,7)
);

CREATE TABLE `restaurants` (
  `restaurant_id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `phone` varchar(20),
  `status` varchar(30),
  `rating` decimal(2,1),
  `address` varchar(250)
);

CREATE TABLE `food_categories` (
  `food_category_id` int PRIMARY KEY AUTO_INCREMENT,
  `food_category_name` varchar(100) UNIQUE NOT NULL,
  `description` varchar(255),
);

CREATE TABLE `food_items` (
  `food_item_id` int PRIMARY KEY AUTO_INCREMENT,
  `restaurant_id` int NOT NULL,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
  `food_category_id` int,
  FOREIGN KEY (food_category_id) REFERENCES food_categories(food_category_id),
  `food_name` varchar(150) NOT NULL,
  `description` varchar(255),
  `price` decimal(10,2) NOT NULL,
  `availability` boolean NOT NULL DEFAULT true
);

CREATE TABLE `orders` (
  `order_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  `restaurant_id` int NOT NULL,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
  address_id int NOT NULL,
  FOREIGN KEY (address_id) REFERENCES address(address_id),
  `order_date` timestamp,
  `order_status` varchar(30) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `created_at` timestamp
);

CREATE TABLE `order_items` (
  `order_item_id` int PRIMARY KEY AUTO_INCREMENT,
  `order_id` int NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  `food_item_id` int NOT NULL,
  FOREIGN KEY (food_item_id) REFERENCES food_items(food_item_id),
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL COMMENT 'Unit price captured when the order is placed',
  `subtotal` decimal(10,2) NOT NULL
);

CREATE TABLE `order_status_history` (
  `history_id` int PRIMARY KEY AUTO_INCREMENT,
  `order_id` int NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  `status` varchar(30) NOT NULL,
  `changed_at` timestamp NOT NULL
);

CREATE TABLE `carts` (
  `cart_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int UNIQUE NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  `created_at` timestamp
);

CREATE TABLE `cart_items` (
  `cart_item_id` int PRIMARY KEY AUTO_INCREMENT,
  `cart_id` int NOT NULL,
  FOREIGN KEY (cart_id) REFERENCES carts(cart_id),
  `food_item_id` int NOT NULL,
  FOREIGN KEY (food_item_id) REFERENCES food_items(food_item_id),
  `quantity` int NOT NULL,
  `price` decimal(10,2) COMMENT 'Optional cart-time price snapshot; checkout must revalidate price'
);

-- ALTER TABLE `restaurants` ADD FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`);

-- ALTER TABLE `food_categories` ADD FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`);

-- ALTER TABLE `menu_items` ADD FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`);

-- ALTER TABLE `menu_items` ADD FOREIGN KEY (`food_category_id`) REFERENCES `food_categories` (`food_category_id`);

-- ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

-- ALTER TABLE `orders` ADD FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`);

-- ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

-- ALTER TABLE `order_items` ADD FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`menu_item_id`);

-- ALTER TABLE `order_status_history` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

-- ALTER TABLE `carts` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

-- ALTER TABLE `cart_items` ADD FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`);

-- ALTER TABLE `cart_items` ADD FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`menu_item_id`);
