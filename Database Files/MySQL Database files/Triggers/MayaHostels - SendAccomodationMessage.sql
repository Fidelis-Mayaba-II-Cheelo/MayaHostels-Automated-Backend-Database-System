DELIMITER $$

CREATE TRIGGER tr_sendAccommodationMessage
AFTER UPDATE ON bedspaces
FOR EACH ROW
BEGIN
	DECLARE mh_stud_id INT;
	DECLARE mh_approved_msg TEXT;
	DECLARE mh_pending_msg TEXT;
	DECLARE mh_none_msg TEXT;
	DECLARE mh_stud_name VARCHAR(100);
	DECLARE mh_acc_status VARCHAR(10);
	DECLARE mh_bedspace_no INT;
	DECLARE mh_room_no INT;
	DECLARE mh_hostel_name VARCHAR(100);
	DECLARE mh_hostel_type VARCHAR(10);
	DECLARE mh_acc_price_sem INT;
	DECLARE mh_acc_price_month INT;

	SELECT s.student_name, s.accommodation_status, s.maya_hostels_student_id,
		   b.bedspace_number, r.room_number, h.hostel_name, h.hostel_type,
		   h.hostel_accommodation_price_per_semester, h.hostel_accommodation_price_per_month
	INTO   mh_stud_name, mh_acc_status, mh_stud_id, mh_bedspace_no, mh_room_no, mh_hostel_name,
		   mh_hostel_type, mh_acc_price_sem, mh_acc_price_month
	FROM   students s
			INNER JOIN bedspaces b ON s.maya_hostels_bedspaces_id = b.maya_hostels_bedspaces_id
			INNER JOIN hostels h ON s.maya_hostels_hostel_id = h.maya_hostels_hostel_id
			INNER JOIN rooms r ON s.maya_hostels_room_id = r.maya_hostels_room_id
	WHERE  s.maya_hostels_bedspaces_id = NEW.maya_hostels_bedspaces_id;

	SET mh_approved_msg = CONCAT('Dear ', mh_stud_name, ', your accommodation request has been APPROVED!\n\nHostel: ', mh_hostel_name, ' (', mh_hostel_type, ')\nRoom Number: ', mh_room_no, '\nBedspace Number: ', mh_bedspace_no, '\nSemester Price: ', mh_acc_price_sem, '\nMonthly Price: ', mh_acc_price_month, '\n\nFurther instructions regarding check-in will follow. Congratulations!');
	SET mh_pending_msg  = CONCAT('Dear ', mh_stud_name, ', your accommodation request is currently PENDING review.\n\nWe will notify you of the status as soon as possible. Thank you for your patience.');
	SET mh_none_msg     = CONCAT('Dear ', mh_stud_name, ', there is currently no accommodation assigned to you.\n\nPlease contact the administration if you believe this is an error or if you wish to apply for accommodation.');

	INSERT INTO notifications (notification_status, maya_hostels_admin_id, maya_hostels_student_id, notification_message)
	VALUES (1, 1, mh_stud_id,
		   CASE mh_acc_status
			   WHEN 'None' THEN mh_none_msg
			   WHEN 'Pending' THEN mh_pending_msg
			   WHEN 'Approved' THEN mh_approved_msg
		   END);
END$$

DELIMITER ;
