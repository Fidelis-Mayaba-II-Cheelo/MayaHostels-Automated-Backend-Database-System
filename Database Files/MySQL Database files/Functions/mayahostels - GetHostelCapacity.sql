DELIMITER $$
DROP FUNCTION IF EXISTS `fn_GetHostelCapacity` $$
CREATE FUNCTION `fn_GetHostelCapacity`(mh_hostel_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE mh_hostel_capacity INT;
SELECT hostel_capacity INTO mh_hostel_capacity FROM hostels WHERE maya_hostels_hostel_id = mh_hostel_id;
RETURN mh_hostel_capacity;
END $$
DELIMITER ;