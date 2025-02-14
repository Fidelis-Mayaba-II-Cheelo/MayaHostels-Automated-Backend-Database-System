DELIMITER $$

DROP FUNCTION IF EXISTS `fn_GetAvailableBedspaces` $$

CREATE FUNCTION `fn_GetAvailableBedspaces`(mh_hostel_id INT)
RETURNS INT
DETERMINISTIC
BEGIN 
    DECLARE number_of_available_bedspaces INT;

    SELECT COUNT(*) 
    INTO number_of_available_bedspaces 
    FROM bedspaces b 
    INNER JOIN rooms r ON b.maya_hostels_room_id = r.maya_hostels_room_id 
    INNER JOIN hostels h ON r.maya_hostels_hostel_id = h.maya_hostels_hostel_id 
    WHERE h.maya_hostels_hostel_id = mh_hostel_id AND b.is_occupied = 0;

    RETURN number_of_available_bedspaces;

END $$

DELIMITER ;