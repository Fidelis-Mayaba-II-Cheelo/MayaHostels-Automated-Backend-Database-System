-- THIS IS A CRON JOB, USE pg_cron in PG_ADMIN

CREATE OR REPLACE FUNCTION fn_BirthdayMessage()
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
	mh_notification_message TEXT;
	mh_stud_record students%ROWTYPE;
	mh_stud_cursor CURSOR FOR SELECT maya_hostels_student_id, student_name, date_of_birth FROM students;
BEGIN
	OPEN mh_stud_cursor;
LOOP
	FETCH mh_stud_cursor INTO mh_stud_record;
EXIT WHEN NOT FOUND;

mh_notification_message := CONCAT('Happy Birthday ', mh_stud_record.student_name, '! '
	'Wishing you a day filled with joy, laughter, and all your favorite things!');

IF EXTRACT(MONTH FROM mh_stud_record.date_of_birth) = EXTRACT(MONTH FROM CURRENT_DATE) AND 
	EXTRACT(DAY FROM mh_stud_record.date_of_birth) = EXTRACT(DAY FROM CURRENT_DATE) THEN
	RAISE NOTICE 'Sending birthday message to %', mh_stud_record.student_name;
	INSERT INTO notifications(notification_message, notification_status, maya_hostels_admin_id, maya_hostels_student_id)
	VALUES (mh_notification_message, 1, 1, mh_stud_record.maya_hostels_student_id);
	END IF;


END LOOP;
CLOSE mh_stud_cursor;

RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
	RAISE EXCEPTION 'Error sending birthday messages: %', sqlerrm;
RETURN FALSE;
END$$;
