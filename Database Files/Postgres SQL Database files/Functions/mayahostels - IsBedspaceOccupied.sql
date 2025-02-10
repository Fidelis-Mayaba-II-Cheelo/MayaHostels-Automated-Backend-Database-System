CREATE OR REPLACE FUNCTION fn_IsBedspaceOccupied(mh_bedspace_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE 
    bedspace_availability INT;
BEGIN
    -- Retrieve is_occupied value from the bedspaces table
    SELECT is_occupied INTO bedspace_availability 
    FROM bedspaces 
    WHERE maya_hostels_bedspaces_id = mh_bedspace_id;

    -- Handling cases of invalid mh_bedspace_id
    IF bedspace_availability IS NULL THEN 
        bedspace_availability := -1;
    END IF;

    RETURN bedspace_availability;
END $$;
