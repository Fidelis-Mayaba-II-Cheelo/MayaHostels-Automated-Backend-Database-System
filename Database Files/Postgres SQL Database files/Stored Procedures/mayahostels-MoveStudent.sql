CREATE OR REPLACE PROCEDURE sp_MoveStudent(
    student_id INT, 
    new_hostel_id INT, 
    new_room_id INT, 
    new_bedspace_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    mh_old_bedspace_id INT;
BEGIN
    BEGIN -- Explicit BEGIN/END block for exception handling
        SELECT maya_hostels_bedspaces_id INTO mh_old_bedspace_id FROM students WHERE maya_hostels_student_id = student_id;

        UPDATE students 
        SET 
            maya_hostels_hostel_id = new_hostel_id, 
            maya_hostels_room_id = new_room_id, 
            maya_hostels_bedspaces_id = new_bedspace_id
        WHERE maya_hostels_student_id = student_id;

        UPDATE bedspaces 
        SET is_occupied = 0 
        WHERE maya_hostels_bedspaces_id = mh_old_bedspace_id;

        UPDATE bedspaces 
        SET is_occupied = 1 
        WHERE maya_hostels_bedspaces_id = new_bedspace_id;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'An error occurred whilst attempting to move student';
    END;
END $$;