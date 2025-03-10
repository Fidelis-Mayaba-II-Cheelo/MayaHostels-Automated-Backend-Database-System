DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_MoveStudent` $$
CREATE PROCEDURE `sp_MoveStudent`(IN student_id INT, IN new_hostel_id INT, IN new_room_id INT, IN new_bedspace_id INT)
BEGIN

DECLARE mh_old_bedspace_id INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
ROLLBACK;
SELECT 'An error occurred whilst attempting to move student';
END ;

START TRANSACTION;

SELECT maya_hostels_bedspaces_id INTO mh_old_bedspace_id FROM students WHERE maya_hostels_student_id = student_id;

UPDATE students SET maya_hostels_hostel_id = new_hostel_id, maya_hostels_room_id = new_room_id, maya_hostels_bedspaces_id = new_bedspace_id 
WHERE maya_hostels_student_id = student_id;

UPDATE bedspaces SET is_occupied = 0 WHERE maya_hostels_bedspaces_id = mh_old_bedspace_id;

UPDATE bedspaces SET is_occupied = 1 WHERE maya_hostels_bedspaces_id = new_bedspace_id;

COMMIT;

END $$
DELIMITER ;