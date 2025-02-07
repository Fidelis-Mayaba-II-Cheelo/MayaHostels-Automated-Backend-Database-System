DELIMITER $$
DROP FUNCTION IF EXISTS `fn_IsBedspaceOccupied` $$
CREATE FUNCTION `fn_IsBedspaceOccupied`(mh_bedspace_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE bedspace_availability INT;
SELECT is_occupied INTO bedspace_availability FROM bedspaces WHERE maya_hostels_bedspaces_id = bedspace_id;
-- Handling cases of invalid mh_bedspace_id
IF bedspace_availability IS NULL THEN SET bedspace_availability = -1;
END IF;
RETURN bedspace_availability;
END $$
DELIMITER ;