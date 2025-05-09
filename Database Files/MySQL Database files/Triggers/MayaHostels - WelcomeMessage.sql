DELIMITER $$
DROP TRIGGER IF EXISTS `tr_WelcomeNotificationAfterStudentRegistration` $$
CREATE TRIGGER `tr_WelcomeNotificationAfterStudentRegistration` AFTER INSERT ON students FOR EACH ROW
BEGIN
DECLARE admin_id INT;
DECLARE welcome_message VARCHAR(150);

SELECT maya_hostels_admin_id INTO admin_id FROM `admin` WHERE username = 'admin';

SET welcome_message = CONCAT("Welcome to Maya Hostels, ", NEW.student_name, "! We're thrilled to welcome you. We hope you have a wonderful stay.  For any assistance, please contact the hostel administration at 0963225635 or mayabacheelo@gmail.com.");

INSERT INTO notifications(notification_message, notification_status, maya_hostels_admin_id, maya_hostels_student_id) VALUES (welcome_message,1, admin_id, NEW.maya_hostels_student_id);

END $$
DELIMITER ;