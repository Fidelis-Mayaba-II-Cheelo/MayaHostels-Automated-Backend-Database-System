CREATE OR REPLACE FUNCTION tr_AfterComplaintStatusUpdate()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    mh_student_message_1 VARCHAR(255);
    mh_student_message_2 VARCHAR(255);
    mh_admin_message_1 VARCHAR(255);
    mh_admin_message_2 VARCHAR(255);
BEGIN

    mh_student_message_1 := 'Your complaint has been received. Please be patient while it is being resolved.';
    mh_admin_message_1 := 'Dear Admin, a complaint has been issued by a student, kindly check your complaints panel to view and resolve the complaint.';
    mh_student_message_2 := 'Your complaint has been resolved, kindly check your complaints panel to view the admin resolution message';
    mh_admin_message_2 := 'Your complaint resolution message has been sent successfully to the student recipient';

    IF NEW.student_complaint_status = 1 AND NEW.admin_complaint_resolution_status = 0 THEN 
        PERFORM sp_sendNotification(mh_student_message_1, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id, TRUE); 
        PERFORM sp_sendAdminNotification(mh_admin_message_1, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id);

    ELSIF NEW.student_complaint_status = 0 AND NEW.admin_complaint_resolution_status = 1 THEN
        PERFORM sp_sendNotification(mh_student_message_2, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id, TRUE);
        PERFORM sp_sendAdminNotification(mh_admin_message_2, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id);
    END IF;

    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER tr_AfterComplaintStatusUpdate
AFTER UPDATE ON complaints
FOR EACH ROW
EXECUTE FUNCTION tr_AfterComplaintStatusUpdate();
