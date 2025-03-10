CREATE OR REPLACE PROCEDURE sp_UpdateCoreStudentDetails(
    mh_student_id INT, 
    mh_student_name VARCHAR(100), 
    mh_student_number INT, 
    mh_national_registration_number INT,
    mh_program_of_study VARCHAR(255), 
    mh_year_of_study SMALLINT, -- PostgreSQL uses SMALLINT for TINYINT
    mh_date_of_birth DATE, 
    mh_profile_picture VARCHAR(255),
    mh_gender TEXT, -- PostgreSQL doesn't have ENUM directly, so i uses TEXT and added a constraint.
    mh_student_phone_number VARCHAR(20), 
    mh_student_phone_number_type TEXT, -- Same as gender
    mh_student_guardian_phone_number VARCHAR(20), 
    mh_student_guardian_phone_number_type TEXT, -- Same as gender
    mh_student_email_address VARCHAR(255), 
    mh_student_email_address_type TEXT -- Same as gender
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM students WHERE maya_hostels_student_id = mh_student_id) THEN
            RAISE EXCEPTION 'Error: Student ID entered not found.';
        END IF;

        IF EXISTS(SELECT 1 FROM student_phone_numbers WHERE phone_number = mh_student_phone_number AND maya_hostels_student_id != mh_student_id) THEN
            RAISE EXCEPTION 'Error: Phone number already exists for another student.';
        END IF;

        IF EXISTS(SELECT 1 FROM student_guardian_phone_numbers WHERE guardian_phone_number = mh_student_guardian_phone_number AND maya_hostels_student_id != mh_student_id) THEN
            RAISE EXCEPTION 'Error: Guardian phone number already exists for another student.';
        END IF;

        IF EXISTS(SELECT 1 FROM student_email_addresses WHERE email_address = mh_student_email_address AND maya_hostels_student_id != mh_student_id) THEN
            RAISE EXCEPTION 'Error: Email address already exists for another student.';
        END IF;

        UPDATE students 
        SET 
            student_name = mh_student_name, 
            student_number = mh_student_number, 
            national_registration_number = mh_national_registration_number,
            program_of_study = mh_program_of_study, 
            year_of_study = mh_year_of_study, 
            date_of_birth = mh_date_of_birth, 
            profile_picture = mh_profile_picture,
            gender = mh_gender 
        WHERE maya_hostels_student_id = mh_student_id;

        UPDATE student_phone_numbers 
        SET phone_number = mh_student_phone_number 
        WHERE phone_number_type = mh_student_phone_number_type 
          AND maya_hostels_student_id = mh_student_id;

        UPDATE student_guardian_phone_numbers 
        SET guardian_phone_number = mh_student_guardian_phone_number 
        WHERE guardian_phone_number_type = mh_student_guardian_phone_number_type 
          AND maya_hostels_student_id = mh_student_id;

        UPDATE student_email_addresses 
        SET email_address = mh_student_email_address 
        WHERE email_type = mh_student_email_address_type 
          AND maya_hostels_student_id = mh_student_id;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'An error occured during update process of student core details: %', SQLERRM;
    END;
END $$;

-- Added these constraints to make sure the correct type of values are entered for the gender, student phone number, student guardian phone number and student email address fields.
ALTER TABLE students ADD CONSTRAINT gender_check CHECK (gender IN ('Male', 'Female', 'Other'));
ALTER TABLE student_phone_numbers ADD CONSTRAINT student_phone_type_check CHECK (phone_number_type IN ('Work', 'Personal', 'Other'));
ALTER TABLE student_guardian_phone_numbers ADD CONSTRAINT student_guardian_phone_type_check CHECK (guardian_phone_number_type IN ('Work', 'Personal', 'Other'));
ALTER TABLE student_email_addresses ADD CONSTRAINT student_email_type_check CHECK (email_type IN ('Work', 'Personal', 'Other'));