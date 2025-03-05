CREATE DATABASE united_helpers;
USE united_helpers;

-- Volunteer Table
CREATE TABLE volunteer (
    volunteer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20)
);

-- Task Table
CREATE TABLE task (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    task_code VARCHAR(10) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    task_type_id INT,
    task_status_id INT,
    FOREIGN KEY (task_type_id) REFERENCES task_type(task_type_id),
    FOREIGN KEY (task_status_id) REFERENCES task_status(task_status_id)
);

-- Task Type Table
CREATE TABLE task_type (
    task_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

-- Task Status Table
CREATE TABLE task_status (
    task_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Packing List Table
CREATE TABLE packing_list (
    packing_list_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL
);

-- Package Type Table
CREATE TABLE package_type (
    package_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

-- Package Table
CREATE TABLE package (
    package_id INT AUTO_INCREMENT PRIMARY KEY,
    task_id INT,
    creation_date DATE NOT NULL,
    weight DECIMAL(5,2),
    FOREIGN KEY (task_id) REFERENCES task(task_id)
);

-- Package Contents Table
CREATE TABLE package_contents (
    package_id INT,
    item_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (package_id, item_id),
    FOREIGN KEY (package_id) REFERENCES package(package_id),
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

-- Item Table
CREATE TABLE item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    value DECIMAL(10,2),
    quantity_on_hand INT NOT NULL
);

-- Volunteer Task Assignment Table
CREATE TABLE volunteer_task (
    volunteer_id INT,
    task_id INT,
    start_time DATETIME,
    end_time DATETIME,
    PRIMARY KEY (volunteer_id, task_id),
    FOREIGN KEY (volunteer_id) REFERENCES volunteer(volunteer_id),
    FOREIGN KEY (task_id) REFERENCES task(task_id)
);

INSERT INTO volunteer (name, address, phone) VALUES
('Alice Johnson', '123 Elm St, NY', '555-1234'),
('Bob Smith', '456 Maple Ave, CA', '555-5678');

INSERT INTO task_type (type_name) VALUES
('recurring'), ('packing');

INSERT INTO task_status (status_name) VALUES
('ongoing'), ('open'), ('completed');

INSERT INTO task (task_code, description, task_type_id, task_status_id) VALUES
('101', 'Answer the telephone', 1, 1),
('102', 'Prepare 5000 packages', 2, 2);

INSERT INTO packing_list (name, description) VALUES
('Medical Pack', 'Contains first aid supplies'),
('Food Pack', 'Contains non-perishable food items');

INSERT INTO package_type (type_name) VALUES
('basic medical'), ('child-care'), ('food');

INSERT INTO package (task_id, creation_date, weight) VALUES
(2, '2025-03-01', 5.3),
(2, '2025-03-02', 4.8);