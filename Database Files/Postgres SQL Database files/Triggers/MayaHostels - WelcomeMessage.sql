CREATE OR REPLACE FUNCTION welcome_notification_after_student_registration()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
DECLARE 
    admin_id INT;
    welcome_message TEXT;
BEGIN
    -- Get the admin ID for 'admin'
    SELECT maya_hostels_admin_id INTO admin_id 
    FROM admin 
    WHERE username = 'admin';

    -- Construct the welcome message with escaped single quotes
    welcome_message := 'Welcome to Maya Hostels, ' || NEW.student_name || 
                       '! We''re thrilled to welcome you. We hope you have a wonderful stay. ' || 
                       'For any assistance, please contact the hostel administration at 0963225635 or mayabacheelo@gmail.com.';

    -- Insert the notification
    INSERT INTO notifications(notification_message, maya_hostels_admin_id, maya_hostels_student_id) 
    VALUES (welcome_message, admin_id, NEW.maya_hostels_student_id);

    RETURN NEW;
END $$;

-- Drop existing trigger if it exists
DROP TRIGGER IF EXISTS tr_WelcomeNotificationAfterStudentRegistration ON students;

-- Create the trigger
CREATE TRIGGER tr_WelcomeNotificationAfterStudentRegistration
AFTER INSERT ON students
FOR EACH ROW 
EXECUTE FUNCTION welcome_notification_after_student_registration();
