CREATE DATABASE mess_management_system
    DEFAULT CHARACTER SET = 'utf8mb4';

USE mess_management_system;

-- Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    roll_no INT UNIQUE,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    max_semester_points INT DEFAULT 22500,
    role ENUM('Student', 'Staff') DEFAULT 'Student',
    hostel ENUM('A', 'B', 'C', 'D', 'E', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'PG', 'Q', 'FRF', 'FRG'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Meals Table
CREATE TABLE Meals (
    meal_id INT AUTO_INCREMENT PRIMARY KEY,
    meal_type ENUM('Breakfast', 'Lunch', 'Dinner') NOT NULL,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    menu TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (meal_type, day_of_week)
);

-- Meal Timings Table
CREATE TABLE Meal_Timings (
    meal_type VARCHAR(20) PRIMARY KEY,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

-- Attendance Table
CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    meal_id INT,
    scan_time TIMESTAMP NULL DEFAULT NULL,
    status ENUM('present', 'absent') DEFAULT 'absent',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (meal_id) REFERENCES Meals(meal_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tickets Table
CREATE TABLE Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    meal_id INT,
    status ENUM('Cancelled', 'Reserved', 'Pending') DEFAULT 'Pending',
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    penalty_points INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (meal_id) REFERENCES Meals(meal_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Penalties (
    penalty_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    meal_id INT,
    penalty_type ENUM('Cancelled', 'Attended', 'Missed') NOT NULL,
    points INT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (meal_id) REFERENCES Meals(meal_id)
);

-- Insert Sample Data into Users Table
INSERT INTO Users (full_name, roll_no, email, phone_number, password_hash, role, hostel) VALUES 
('hello', 123456, 'hello@hello', '1234567890', 'Hello', 'Student', 'C'),
('Bhavya', 12589, 'bhavya@thapar.edu', '9876543210', 'bhavya123', 'Student', 'Q'),
('Tanya', 221002, 'tanya@thapar.edu', '9876543211', 'tanya123', 'Student', 'N'),
('Yash', 221003, 'yash@thapar.edu', '9876543212', 'yash123', 'Student', 'L'),
('Meera', 221004, 'meera@thapar.edu', '9876543213', 'meera123', 'Student', 'FRG'),
('Aniket', 221007, 'aniket@thapar.edu', '9876543214', 'aniket123', 'Student', 'Q'),
('Nidhi', 221008, 'nidhi@thapar.edu', '9876543215', 'nidhi123', 'Student', 'H'),
('Saurav', 521001, 'saurav@thapar.edu', '9876543216', 'saurav123', 'Staff', 'G'),
('Priya', 921001, 'priya@thapar.edu', '9876543217', 'priya123', 'Staff', 'K');


-- Insert Sample Data into Meals Table
INSERT INTO Meals (meal_type, day_of_week, menu) VALUES
-- Breakfast
('Breakfast', 'Monday', 'Cornflakes, Aloo Pyaz Parantha, Cold Milk, Tea / Hot Milk, Brown Bread, Mix Jam, Butter, Curd, Boiled Egg & Omelette'),
('Breakfast', 'Tuesday', 'Vermicelli, Masala Poori With Black Chana, Cold Milk, Tea / Hot Milk, Brown Bread, Mix Jam, Butter, Curd, Whole Banana, Boiled Egg & Bhurji'),
('Breakfast', 'Wednesday', 'Masala Idli, Aloo Pyaaz Parantha, Cold Milk, Tea / Hot Milk, Brown Bread, Mix Jam, Butter, Curd, Boiled Egg & Bhurji'),
('Breakfast', 'Thursday', 'Sweet corn, Pyaz Parantha, Cold Milk, Tea / Hot Milk, Brown Bread, Mix Jam, Butter, Curd, Boiled Egg & Bhurji'),
('Breakfast', 'Friday', 'Cornflakes, Aloo Pyaz Parantha, Cold Milk, Tea / Hot Milk, Brown Bread, Mix Jam, Butter, Curd, Boiled Egg & Bhurji'),
('Breakfast', 'Saturday', 'Gobhi Parantha, Cold Milk, Tea / Hot Milk, Brown Bread, Mix Jam, Butter, Curd, Green Chutney, Boiled Egg & Omelette'),
('Breakfast', 'Sunday', 'Macroni, Mix veg Parantha, Cold Milk, Tea / Hot Milk, Brown Bread, Mix Jam, Butter, Curd, Boiled Egg & Omelette'),
-- Lunch
('Lunch', 'Monday', 'Rajmah Raseela, Lauki masala, Jeera Rice, Chapati, Jeera Raita, Green Salad, Jaljeera'),
('Lunch', 'Tuesday', 'Kadhi Pakoda, Aloo Capsicum, Plain Rice, Chapati, Green Salad, Roohafza'),
('Lunch', 'Wednesday', 'Kulche, Chole, Plain Rice, Green Chutney, Boondi Raita, Lacha Onion Salad, Aam Panna'),
('Lunch', 'Thursday', 'Chilli Paneer, Channa dal, Jeera Rice, Chapati, Cucumber Raita, Green Salad, Orange Tang'),
('Lunch', 'Friday', 'Black Chana Raseela, Nutri Keema, Steamed Rice, Chapati, OTC Raita, Green Salad, Masala Chaas'),
('Lunch', 'Saturday', 'Sambhar, Medu Vada, Soya Garlic Rice, Uttapam, Coconut Chutney, Fryums, Nimbu Pani'),
('Lunch', 'Sunday', 'Aloo Bhaji, Poori, Steamed Rice, Chapati, Mint Chutney, Laccha Onion, Sweet Lassi'),
-- Dinner
('Dinner', 'Monday', 'Aloo Baingan, Dal Dhaba, Steamed Rice, Chapati, Sirka Onion, Curd, Rashbhari'),
('Dinner', 'Tuesday', 'Kadhai Paneer, Dal Fry, Plain Rice, Tandoori Roti, Green Salad, Ice Cream, Egg Curry'),
('Dinner', 'Wednesday', 'Bhindi Do Pyaza, Dal Makhni, Onion Rice, Chapati, Three Beans Salad, Curd, Cold Rice Kheer'),
('Dinner', 'Thursday', 'Veg Handi, Dal Panchratan, Soya Garlic Rice, Chapati, Macroni Salad, Curd, Fruit Cake'),
('Dinner', 'Friday', 'Veg Kofta, Urad Chilka, Namkeen Rice, Chapati, Green Salad, Aloo Ghiya Raita, Fruit Custard'),
('Dinner', 'Saturday', 'Manchurian With Gravy, Moong Masoor Dal, Noodles, Chapati, Green Salad, Curd, Boondi Ladoo'),
('Dinner', 'Sunday', 'Mix Veg Mashroom, Dal Bukhara, Jeera Rice, Chapati, Green Salad, Curd, Gulab Jamun');

-- Insert Data into Tickets Table
INSERT INTO Tickets (user_id, meal_id, status, purchase_date) VALUES
(1, 1, 'Reserved', '2025-03-27 07:50:00'),
(2, 1, 'Cancelled', '2025-03-27 08:10:00'),
(3, 2, 'Reserved', '2025-03-27 12:30:00'),
(4, 2, 'Pending', '2025-03-27 12:45:00'),
(5, 3, 'Reserved', '2025-03-27 19:00:00'),
(6, 4, 'Cancelled', '2025-03-28 07:55:00'),
(7, 5, 'Reserved', '2025-03-28 12:15:00'),
(8, 6, 'Pending', '2025-03-28 12:40:00');

-- Insert Data into Attendance Table
INSERT INTO Attendance (user_id, meal_id, scan_time) VALUES
(1, 1, '2025-03-27 08:30:00'),
(2, 1, NULL),
(3, 2, '2025-03-27 13:00:00'),
(4, 2, NULL),
(5, 3, '2025-03-27 19:30:00'),
(6, 4, NULL),
(7, 5, '2025-03-28 08:15:00'),
(8, 6, NULL);

-- Insert Meal Timings Data
INSERT INTO Meal_Timings (meal_type, start_time, end_time) VALUES
('Breakfast', '07:00:00', '09:00:00'),
('Lunch', '12:00:00', '14:00:00'),
('Dinner', '19:00:00', '21:00:00');


