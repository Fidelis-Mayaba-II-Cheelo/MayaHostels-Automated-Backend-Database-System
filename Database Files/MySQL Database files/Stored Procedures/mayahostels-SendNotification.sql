DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_sendNotification` $$
CREATE PROCEDURE `sp_sendNotification`(mh_message VARCHAR(255), mh_admin_id INT, mh_student_id INT, mh_single_student Boolean)
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE mh_current_student_id INT;
DECLARE student_id_cursor CURSOR FOR SELECT maya_hostels_student_id FROM students;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END ;

START TRANSACTION;
IF mh_student_id IS NULL AND mh_single_student IS FALSE THEN
OPEN student_id_cursor;

get_student_ids_loop: LOOP
FETCH student_id_cursor INTO mh_current_student_id;
IF done THEN
LEAVE get_student_ids_loop;
END IF;

INSERT INTO notifications (notification_message, maya_hostels_admin_id, maya_hostels_student_id) VALUES (mh_message, mh_admin_id, mh_current_student_id);
END LOOP;
CLOSE student_id_cursor;

ELSEIF mh_student_id IS NOT NULL AND mh_single_student IS TRUE THEN
INSERT INTO notifications (notification_message, maya_hostels_admin_id, maya_hostels_student_id) VALUES (mh_message, mh_admin_id, mh_student_id);
END IF ;

COMMIT;

END $$
DELIMITER ;