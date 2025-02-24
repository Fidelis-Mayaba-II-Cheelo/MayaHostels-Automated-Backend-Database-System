CREATE OR REPLACE PROCEDURE sp_sendNotification(
    mh_message VARCHAR(255), 
    mh_admin_id INT, 
    mh_student_id INT, 
    mh_single_student BOOLEAN
)
LANGUAGE plpgsql
AS $$
DECLARE
    mh_current_student_id INT;
    student_id_cursor CURSOR FOR SELECT maya_hostels_student_id FROM students;
BEGIN
    IF mh_student_id IS NULL AND mh_single_student = FALSE THEN
        FOR mh_current_student_id IN student_id_cursor LOOP
            INSERT INTO notifications (notification_message, maya_hostels_admin_id, maya_hostels_student_id) 
            VALUES (mh_message, mh_admin_id, mh_current_student_id);
        END LOOP;
    ELSEIF mh_student_id IS NOT NULL AND mh_single_student = TRUE THEN
        INSERT INTO notifications (notification_message, maya_hostels_admin_id, maya_hostels_student_id) 
            VALUES (mh_message, mh_admin_id, mh_student_id);
    END IF;
END $$;