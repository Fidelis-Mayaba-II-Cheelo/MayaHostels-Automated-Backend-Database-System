-- Drop the function if it already exists
DROP FUNCTION IF EXISTS fn_GetAvailableBedspaces(INT);

-- Create the function
CREATE FUNCTION fn_GetAvailableBedspaces(mh_hostel_id INT)
RETURNS INT AS $$
DECLARE
    number_of_available_bedspaces INT;
BEGIN 
    -- Count the available bedspaces in the given hostel
    SELECT COUNT(*) 
    INTO number_of_available_bedspaces 
    FROM bedspaces b
    INNER JOIN rooms r ON b.maya_hostels_room_id = r.maya_hostels_room_id
    INNER JOIN hostels h ON r.maya_hostels_hostel_id = h.maya_hostels_hostel_id
    WHERE h.maya_hostels_hostel_id = mh_hostel_id AND b.is_occupied = 0;

    RETURN number_of_available_bedspaces;
END;
$$ LANGUAGE plpgsql;
