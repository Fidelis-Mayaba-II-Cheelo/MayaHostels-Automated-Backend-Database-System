DELIMITER $$

CREATE TRIGGER tr_AfterComplaintStatusUpdate
AFTER UPDATE ON complaints
FOR EACH ROW
BEGIN
    DECLARE mh_student_message_1 VARCHAR(255);
    DECLARE mh_student_message_2 VARCHAR(255);
    DECLARE mh_admin_message_1 VARCHAR(255);
    DECLARE mh_admin_message_2 VARCHAR(255);

    SET mh_student_message_1 = 'Your complaint has been received. Please be patient while it is being resolved.';
    SET mh_admin_message_1 = 'Dear Admin, a complaint has been issued by a student, kindly check your complaints panel to view and resolve the complaint.';
    SET mh_student_message_2 = 'Your complaint has been resolved, kindly check your complaints panel to view the admin resolution message';
    SET mh_admin_message_2 = 'Your complaint resolution message has been sent successfully to the student recipient';

    IF NEW.student_complaint_status = 1 AND NEW.admin_complaint_resolution_status = 0 THEN
        CALL sp_sendNotification(mh_student_message_1, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id, TRUE);
        CALL sp_sendAdminNotification(mh_admin_message_1, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id);
    ELSEIF NEW.student_complaint_status = 0 AND NEW.admin_complaint_resolution_status = 1 THEN
        CALL sp_sendNotification(mh_student_message_2, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id, TRUE);
        CALL sp_sendAdminNotification(mh_admin_message_2, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id);
    END IF;
END$$

DELIMITER ;
