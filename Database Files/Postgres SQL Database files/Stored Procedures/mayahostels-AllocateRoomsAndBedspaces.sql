DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'sp_allocate_rooms_and_bedspaces') THEN
        DROP PROCEDURE sp_allocate_rooms_and_bedspaces;
    END IF;
END $$;

CREATE PROCEDURE sp_allocate_rooms_and_bedspaces(
    IN mh_student_id INT, 
    IN mh_room_id INT, 
    IN mh_bedspace_id INT, 
    IN mh_hostel_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE 
    mh_accommodation_status VARCHAR(12) := 'Approved';
BEGIN
    BEGIN
        -- Start transaction
        UPDATE bedspaces 
        SET is_occupied = 1 
        WHERE maya_hostels_bedspaces_id = mh_bedspace_id;

        UPDATE students 
        SET maya_hostels_hostel_id = mh_hostel_id, 
            maya_hostels_room_id = mh_room_id, 
            maya_hostels_bedspaces_id = mh_bedspace_id, 
            accommodation_status = mh_accommodation_status
        WHERE maya_hostels_student_id = mh_student_id;

        -- Commit transaction
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            -- Rollback on exception
            ROLLBACK;
            RAISE;
    END;
END $$;
