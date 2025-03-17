DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_UpdateHostelCapacity` $$
CREATE PROCEDURE `sp_UpdateHostelCapacity`(mh_hostel_id INT , mh_new_hostel_capacity INT)
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SELECT 'An error occured while trying to update the hostel capacity.';
END;

START TRANSACTION;
UPDATE hostels SET hostel_capacity = mh_new_hostel_capacity WHERE maya_hostels_hostel_id = mh_hostel_id;
COMMIT;

END $$
DELIMITER ;