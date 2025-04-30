CREATE OR REPLACE PROCEDURE sp_sendAdminNotification(
    mh_message VARCHAR(255), 
    mh_admin_id INT, 
    mh_student_id INT 
)
LANGUAGE plpgsql
AS $$
BEGIN
    
    INSERT INTO admin_notifications (notification_message, maya_hostels_admin_id, maya_hostels_student_id, notification_status) 
    VALUES (mh_message, mh_admin_id, mh_student_id, 1);
        
END $$;