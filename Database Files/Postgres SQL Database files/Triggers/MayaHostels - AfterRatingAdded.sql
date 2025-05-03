CREATE OR REPLACE FUNCTION tr_AfterRatingAdded()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
	DECLARE
	mh_hostel_id INT;
	mh_rating_count INT;
	mh_hostel_name VARCHAR(100);
	mh_avg_rating NUMERIC(4,2);
BEGIN

	SELECT maya_hostels_hostel_id INTO mh_hostel_id FROM students
	WHERE maya_hostels_student_id = NEW.maya_hostels_student_id;

	SELECT COUNT(*) INTO mh_rating_count FROM ratings r 
	INNER JOIN students s ON r.maya_hostels_student_id = s.maya_hostels_student_id 
	WHERE s.maya_hostels_hostel_id = mh_hostel_id;

IF mh_rating_count % 10 = 0 THEN 
	
	SELECT ROUND(AVG(r.student_scale_rating),2) INTO mh_avg_rating FROM ratings r
	INNER JOIN students s ON r.maya_hostels_student_id = s.maya_hostels_student_id 
	WHERE s.maya_hostels_hostel_id = mh_hostel_id;

    SELECT hostel_name INTO mh_hostel_name FROM hostels WHERE maya_hostels_hostel_id = mh_hostel_id;

    RAISE NOTICE 'The average rating of % hostel is %', mh_hostel_name, mh_avg_rating;

    INSERT INTO admin_notifications (notification_message, notification_status, maya_hostels_admin_id, maya_hostels_student_id)
    VALUES (CONCAT('The average rating of ', mh_hostel_name, ' hostel is: ', mh_avg_rating), 1, NEW.maya_hostels_admin_id, NEW.maya_hostels_student_id);
    

END IF;

RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER tr_AfterRatingAdded
AFTER INSERT ON ratings
FOR EACH ROW
EXECUTE FUNCTION tr_AfterRatingAdded();
