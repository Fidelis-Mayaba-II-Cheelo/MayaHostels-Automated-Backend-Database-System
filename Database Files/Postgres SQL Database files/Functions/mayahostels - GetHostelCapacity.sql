-- Drop the function if it already exists
DROP FUNCTION IF EXISTS fn_GetHostelCapacity(INT);

-- Create the function
CREATE FUNCTION fn_GetHostelCapacity(mh_hostel_id INT)
RETURNS INT AS $$
DECLARE
    mh_hostel_capacity INT;
BEGIN
    -- Retrieve the hostel capacity for the given hostel ID
    SELECT hostel_capacity 
    INTO mh_hostel_capacity 
    FROM hostels 
    WHERE maya_hostels_hostel_id = mh_hostel_id;

    RETURN mh_hostel_capacity;
END;
$$ LANGUAGE plpgsql;
