CREATE OR REPLACE PROCEDURE sp_UpdateHostelCapacity(
    mh_hostel_id INT, 
    mh_new_hostel_capacity INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        UPDATE hostels 
        SET hostel_capacity = mh_new_hostel_capacity 
        WHERE maya_hostels_hostel_id = mh_hostel_id;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'An error occurred while trying to update the hostel capacity: %', SQLERRM;
    END;
END $$;