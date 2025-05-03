DELIMITER $$

CREATE TRIGGER tr_AfterRatingAdded
AFTER INSERT ON ratings
FOR EACH ROW
BEGIN
    DECLARE mh_hostel_id INT;
    DECLARE mh_rating_count INT;
    DECLARE mh_hostel_name VARCHAR(100);
    DECLARE mh_avg_rating DECIMAL(4,2);

    
    SELECT maya_hostels_hostel_id INTO mh_hostel_id 
    FROM students
    WHERE maya_hostels_student_id = NEW.maya_hostels_student_id;

    
    SELECT COUNT(*) INTO mh_rating_count 
    FROM ratings r 
    INNER JOIN students s ON r.maya_hostels_student_id = s.maya_hostels_student_id 
    WHERE s.maya_hostels_hostel_id = mh_hostel_id;

    
    IF mh_rating_count % 10 = 0 THEN
        

        SELECT ROUND(AVG(r.student_scale_rating), 2) INTO mh_avg_rating
        FROM ratings r
        INNER JOIN students s ON r.maya_hostels_student_id = s.maya_hostels_student_id 
        WHERE s.maya_hostels_hostel_id = mh_hostel_id;

        SELECT hostel_name INTO mh_hostel_name
        FROM hostels
        WHERE maya_hostels_hostel_id = mh_hostel_id;


        INSERT INTO admin_notifications (notification_message, notification_status, maya_hostels_admin_id, maya_hostels_student_id)
        VALUES (CONCAT('The average rating of ', mh_hostel_name, ' hostel is: ', mh_avg_rating), 1, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id);
    END IF;
END $$

DELIMITER ;
