CREATE SCHEMA mayahostels;

SET search_path TO mayahostels;

CREATE TABLE admin (
    maya_hostels_admin_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

CREATE TABLE admin_email_addresses (
    maya_hostels_admin_id INT NOT NULL,
    email_address VARCHAR(100) NOT NULL UNIQUE,
    email_type VARCHAR(10) CHECK (email_type IN ('Work', 'Personal', 'Other')),
    PRIMARY KEY (maya_hostels_admin_id, email_address),
    FOREIGN KEY (maya_hostels_admin_id) REFERENCES admin (maya_hostels_admin_id) ON DELETE CASCADE
);

CREATE TABLE hostels (
    maya_hostels_hostel_id SERIAL PRIMARY KEY,
    hostel_name VARCHAR(100) NOT NULL UNIQUE,
    number_of_rooms INT NOT NULL,
    hostel_status SMALLINT DEFAULT 0,
    hostel_type VARCHAR(10) CHECK (hostel_type IN ('Single', 'Double', 'Triple', 'Quadruple')),
    hostel_capacity INT NOT NULL,
    number_of_bedspaces_per_room INT NOT NULL,
    hostel_accommodation_price_per_semester INT NOT NULL,
    hostel_accomodation_price_per_month INT NOT NULL,
    maya_hostels_admin_id INT NOT NULL,
    FOREIGN KEY (maya_hostels_admin_id) REFERENCES admin (maya_hostels_admin_id) ON DELETE CASCADE
);

CREATE TABLE hostel_images (
    maya_hostels_hostel_images_id SERIAL PRIMARY KEY,
    hostel_image VARCHAR(255) NOT NULL,
    maya_hostels_hostel_id INT NOT NULL,
    FOREIGN KEY (maya_hostels_hostel_id) REFERENCES hostels (maya_hostels_hostel_id) ON DELETE CASCADE
);

CREATE TABLE rooms (
    maya_hostels_room_id SERIAL PRIMARY KEY,
    room_number INT NOT NULL,
    room_capacity INT NOT NULL,
    maya_hostels_hostel_id INT NOT NULL,
    FOREIGN KEY (maya_hostels_hostel_id) REFERENCES hostels (maya_hostels_hostel_id) ON DELETE CASCADE
);

CREATE TABLE bedspaces (
    maya_hostels_bedspaces_id SERIAL PRIMARY KEY,
    is_occupied SMALLINT DEFAULT 0,
    bedspace_number INT NOT NULL,
    maya_hostels_room_id INT NOT NULL,
    FOREIGN KEY (maya_hostels_room_id) REFERENCES rooms (maya_hostels_room_id) ON DELETE CASCADE
);

CREATE TABLE students (
    maya_hostels_student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_number INT NOT NULL UNIQUE,
    national_registration_number INT NOT NULL UNIQUE,
    program_of_study VARCHAR(255) NOT NULL,
    year_of_study SMALLINT NOT NULL CHECK (year_of_study BETWEEN 1 AND 6),
    date_of_birth DATE NOT NULL,
    profile_picture VARCHAR(255) NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    accommodation_status VARCHAR(10) CHECK (accommodation_status IN ('None', 'Pending', 'Approved')),
    maya_hostels_hostel_id INT,
    maya_hostels_room_id INT,
    maya_hostels_bedspaces_id INT,
    FOREIGN KEY (maya_hostels_hostel_id) REFERENCES hostels (maya_hostels_hostel_id) ON DELETE CASCADE,
    FOREIGN KEY (maya_hostels_room_id) REFERENCES rooms (maya_hostels_room_id) ON DELETE CASCADE,
    FOREIGN KEY (maya_hostels_bedspaces_id) REFERENCES bedspaces (maya_hostels_bedspaces_id) ON DELETE CASCADE
);

CREATE TABLE student_phone_numbers (
    maya_hostels_student_id INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    phone_number_type VARCHAR(10) CHECK (phone_number_type IN ('Work', 'Personal', 'Other')),
    PRIMARY KEY (maya_hostels_student_id, phone_number),
    FOREIGN KEY (maya_hostels_student_id) REFERENCES students (maya_hostels_student_id) ON DELETE CASCADE
);

CREATE TABLE student_guardian_phone_numbers (
    maya_hostels_student_id INT NOT NULL,
    guardian_phone_number VARCHAR(20) NOT NULL,
    guardian_phone_number_type VARCHAR(10) CHECK (guardian_phone_number_type IN ('Work', 'Personal', 'Other')),
    PRIMARY KEY (maya_hostels_student_id, guardian_phone_number),
    FOREIGN KEY (maya_hostels_student_id) REFERENCES students (maya_hostels_student_id) ON DELETE CASCADE
);

CREATE TABLE student_email_addresses (
    maya_hostels_student_id INT NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    email_type VARCHAR(10) CHECK (email_type IN ('Work', 'Personal', 'Other')),
    PRIMARY KEY (maya_hostels_student_id, email_address),
    FOREIGN KEY (maya_hostels_student_id) REFERENCES students (maya_hostels_student_id) ON DELETE CASCADE
);

CREATE TABLE accounts (
    maya_hostels_accounts_id SERIAL PRIMARY KEY,
    account_type VARCHAR(10) CHECK (account_type IN ('Student', 'Admin')),
    account_password VARCHAR(255) NOT NULL,
    password_status VARCHAR(10) CHECK (password_status IN ('Active', 'Expired', 'Pending', 'None')),
    hash_algorithm VARCHAR(255) NOT NULL,
    maya_hostels_admin_id INT,
    maya_hostels_student_id INT,
    CONSTRAINT unique_account UNIQUE (maya_hostels_admin_id, maya_hostels_student_id),
    FOREIGN KEY (maya_hostels_admin_id) REFERENCES admin (maya_hostels_admin_id) ON DELETE CASCADE,
    FOREIGN KEY (maya_hostels_student_id) REFERENCES students (maya_hostels_student_id) ON DELETE CASCADE
);

CREATE TABLE notifications (
    maya_hostels_notifications_id SERIAL PRIMARY KEY,
    notification_message VARCHAR(255) NOT NULL,
    notification_status SMALLINT DEFAULT 0,
    date_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_broadcast BOOLEAN DEFAULT false,
    broadcast_id UUID,
    maya_hostels_admin_id INT NOT NULL,
    maya_hostels_student_id INT NOT NULL,
    FOREIGN KEY (maya_hostels_admin_id) REFERENCES admin (maya_hostels_admin_id) ON DELETE CASCADE,
    FOREIGN KEY (maya_hostels_student_id) REFERENCES students (maya_hostels_student_id) ON DELETE CASCADE
);

CREATE TABLE admin_notifications (
    maya_hostels_admin_notifications_id SERIAL PRIMARY KEY,
    notification_message VARCHAR(255) NOT NULL,
    notification_status SMALLINT DEFAULT 0,
    date_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    maya_hostels_admin_id INT NOT NULL,
    maya_hostels_student_id INT NOT NULL,
    FOREIGN KEY (maya_hostels_admin_id) REFERENCES admin (maya_hostels_admin_id) ON DELETE CASCADE,
    FOREIGN KEY (maya_hostels_student_id) REFERENCES students (maya_hostels_student_id) ON DELETE CASCADE
);

CREATE TABLE ratings (
    maya_hostels_ratings_id SERIAL PRIMARY KEY,
    student_rating_message VARCHAR(255) NOT NULL,
    student_scale_rating SMALLINT DEFAULT 0 CHECK (student_scale_rating BETWEEN 1 AND 10),
    student_improvement_suggestions VARCHAR(255) NOT NULL,
    rating_status SMALLINT DEFAULT 0,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    maya_hostels_admin_id INT,
    maya_hostels_student_id INT NOT NULL,
    FOREIGN KEY (maya_hostels_admin_id) REFERENCES admin (maya_hostels_admin_id) ON DELETE CASCADE,
    FOREIGN KEY (maya_hostels_student_id) REFERENCES students (maya_hostels_student_id) ON DELETE CASCADE
);

CREATE TABLE complaints (
    maya_hostels_complaints_id SERIAL PRIMARY KEY,
    student_complaint_message VARCHAR(255) NOT NULL,
    admin_complaint_resolution_message VARCHAR(255),
    student_issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_resolution_date TIMESTAMP DEFAULT NULL,
    student_complaint_status SMALLINT DEFAULT 0,
    admin_complaint_resolution_status SMALLINT DEFAULT 0,
    maya_hostels_admin_id INT,
    maya_hostels_student_id INT NOT NULL,
    FOREIGN KEY (maya_hostels_admin_id) REFERENCES admin (maya_hostels_admin_id) ON DELETE CASCADE,
    FOREIGN KEY (maya_hostels_student_id) REFERENCES students (maya_hostels_student_id) ON DELETE CASCADE
);
