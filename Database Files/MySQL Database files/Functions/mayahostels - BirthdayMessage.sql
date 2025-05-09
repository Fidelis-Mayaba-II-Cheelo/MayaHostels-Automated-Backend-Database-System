-- THIS IS A CRON JOB
DELIMITER $$

CREATE PROCEDURE sp_BirthdayMessage()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE mh_notification_message TEXT;
    DECLARE v_student_id INT;
    DECLARE v_student_name VARCHAR(255);
    DECLARE v_date_of_birth DATE;

    DECLARE mh_stud_cursor CURSOR FOR 
        SELECT maya_hostels_student_id, student_name, date_of_birth FROM students;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN mh_stud_cursor;

    read_loop: LOOP
        FETCH mh_stud_cursor INTO v_student_id, v_student_name, v_date_of_birth;
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF MONTH(v_date_of_birth) = MONTH(CURDATE()) AND DAY(v_date_of_birth) = DAY(CURDATE()) THEN
            SET mh_notification_message = CONCAT('Happy Birthday ', v_student_name,
                '! Wishing you a day filled with joy, laughter, and all your favorite things!');
            
            
            SELECT CONCAT('Sending birthday message to ', v_student_name) AS Message;

            INSERT INTO notifications(notification_message, notification_status, maya_hostels_admin_id, maya_hostels_student_id)
            VALUES (mh_notification_message, 1, 1, v_student_id);
        END IF;
    END LOOP;

    CLOSE mh_stud_cursor;
END$$

DELIMITER ;
