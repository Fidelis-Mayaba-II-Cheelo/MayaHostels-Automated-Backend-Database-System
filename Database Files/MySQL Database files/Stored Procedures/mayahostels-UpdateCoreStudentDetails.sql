DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_UpdateCoreStudentDetails` $$
CREATE PROCEDURE `sp_UpdateCoreStudentDetails`(IN mh_student_id INT, IN mh_student_name VARCHAR(100), IN mh_student_number INT, IN mh_national_registration_number INT,
IN mh_program_of_study VARCHAR(255), IN mh_year_of_study tinyint, IN mh_date_of_birth date, IN mh_profile_picture VARCHAR(255), 
IN mh_gender ENUM("Male", "Female", "Other"), IN mh_student_phone_number VARCHAR(20), IN mh_student_phone_number_type ENUM("Work", "Personal", "Other"),
IN mh_student_guardian_phone_number VARCHAR(20), IN mh_student_guardian_phone_number_type ENUM("Work", "Personal", "Other"),
IN mh_student_email_address VARCHAR(255), IN mh_student_email_address_type ENUM("Work", "Personal", "Other"))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SELECT 'An error occured during update process of student core details.';
END;

START TRANSACTION;

IF NOT EXISTS(SELECT 1 FROM students WHERE maya_hostels_student_id = mh_student_id) THEN
SELECT 'Error: Student ID entered not found.';
ROLLBACK;
RESIGNAL;
END IF;

IF EXISTS(SELECT 1 FROM student_phone_numbers WHERE phone_number = mh_student_phone_number AND maya_hostels_student_id != mh_student_id) THEN
SELECT 'Error: Phone number already exists for another student.';
ROLLBACK;
RESIGNAL;
END IF;

IF EXISTS(SELECT 1 FROM student_guardian_phone_numbers WHERE guardian_phone_number = mh_student_guardian_phone_number AND maya_hostels_student_id != mh_student_id) THEN
SELECT 'Error: Guardian phone number already exists for another student.';
ROLLBACK;
RESIGNAL;
END IF;

IF EXISTS(SELECT 1 FROM student_email_addresses WHERE email_address = mh_student_email_address AND maya_hostels_student_id != mh_student_id) THEN
SELECT 'Error: Email address already exists for another student.';
ROLLBACK;
RESIGNAL;
END IF;

UPDATE students SET student_name = mh_student_name, student_number = mh_student_number, national_registration_number = mh_national_registration_number,
program_of_study = mh_program_of_study, year_of_study = mh_year_of_study, date_of_birth = mh_date_of_birth, profile_picture = mh_profile_picture,
gender = mh_gender WHERE maya_hostels_student_id = mh_student_id;

UPDATE student_phone_numbers SET phone_number = mh_student_phone_number WHERE phone_number_type = mh_student_phone_number_type AND maya_hostels_student_id = mh_student_id;

UPDATE student_guardian_phone_numbers SET guardian_phone_number = mh_student_guardian_phone_number WHERE guardian_phone_number_type = mh_student_guardian_phone_number_type AND maya_hostels_student_id = mh_student_id;

UPDATE student_email_addresses SET email_address = mh_student_email_address WHERE email_type = mh_student_email_address_type AND maya_hostels_student_id = mh_student_id;

COMMIT;

END $$
DELIMITER ;