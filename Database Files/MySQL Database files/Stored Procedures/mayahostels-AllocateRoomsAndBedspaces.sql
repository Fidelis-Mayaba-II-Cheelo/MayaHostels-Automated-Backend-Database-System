DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_AllocateRoomsAndBedspaces` $$
CREATE PROCEDURE `sp_AllocateRoomsAndBedspaces`(IN mh_student_id INT, IN mh_room_id INT, IN mh_bedspace_id INT, IN mh_hostel_id INT)
BEGIN
DECLARE mh_accommodation_status VARCHAR(12);

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
SET mh_accommodation_status = "Approved";
UPDATE bedspaces SET is_occupied = 1 WHERE maya_hostels_bedspaces_id = mh_bedspace_id;
UPDATE students SET maya_hostels_hostel_id = mh_hostel_id, 
maya_hostels_room_id = mh_room_id, maya_hostels_bedspaces_id = mh_bedspace_id, 
accommodation_status = mh_accommodation_status WHERE maya_hostels_student_id = mh_student_id;
COMMIT;

END $$
DELIMITER ;