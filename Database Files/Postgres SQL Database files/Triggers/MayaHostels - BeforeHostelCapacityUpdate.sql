CREATE OR REPLACE FUNCTION tr_BeforeHostelCapacityUpdate()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    mh_room_capacity INT;
    counter INT DEFAULT 0;
    room_id INT;
    bedspace_counter INT;
    mh_track_new_room_number INT;
    max_room_number INT;
    rooms_to_delete_count INT;
BEGIN
    -- Room capacity calculation
    IF OLD.hostel_type = 'Single' THEN 
        mh_room_capacity := 1;
    ELSIF OLD.hostel_type = 'Double' THEN 
        mh_room_capacity := 2;
    ELSIF OLD.hostel_type = 'Triple' THEN 
        mh_room_capacity := 3;
    ELSIF OLD.hostel_type = 'Quadruple' THEN 
        mh_room_capacity := 4;
    END IF;

    -- Increase Capacity
    IF NEW.hostel_capacity > OLD.hostel_capacity THEN 
        -- Get the maximum existing room number
        SELECT COALESCE(MAX(room_number), 0) INTO max_room_number FROM rooms WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;
        mh_track_new_room_number := max_room_number + 1;

        -- Insert rooms
        WHILE counter < (NEW.hostel_capacity - OLD.hostel_capacity) LOOP
            INSERT INTO rooms (room_number, room_capacity, maya_hostels_hostel_id) 
            VALUES (mh_track_new_room_number, mh_room_capacity, NEW.maya_hostels_hostel_id);

            counter := counter + 1;
            mh_track_new_room_number := mh_track_new_room_number + 1;
        END LOOP;

        -- Insert bedspaces
        INSERT INTO bedspaces (is_occupied, bedspace_number, maya_hostels_room_id)
        SELECT 0, numbers.n, r.maya_hostels_room_id
        FROM rooms r, (SELECT n FROM generate_series(1, 4) AS numbers(n))
        WHERE r.maya_hostels_hostel_id = NEW.maya_hostels_hostel_id
          AND r.room_number > max_room_number
          AND numbers.n <= mh_room_capacity;

    -- Decrease Capacity
    ELSIF NEW.hostel_capacity < OLD.hostel_capacity THEN
        -- Check if any bedspaces in rooms to delete are occupied
        SELECT COUNT(*) INTO rooms_to_delete_count
        FROM rooms r
        JOIN bedspaces b ON r.maya_hostels_room_id = b.maya_hostels_room_id
        WHERE r.maya_hostels_hostel_id = NEW.maya_hostels_hostel_id
          AND r.room_number > NEW.hostel_capacity
          AND b.is_occupied = 1;

        IF rooms_to_delete_count > 0 THEN
            RAISE EXCEPTION 'Cannot decrease capacity: Occupied bedspaces exist.';
        ELSE
            -- Delete bedspaces and rooms
            DELETE FROM bedspaces
            WHERE maya_hostels_room_id IN (
                SELECT maya_hostels_room_id
                FROM rooms
                WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id
                  AND room_number > NEW.hostel_capacity
            );

            DELETE FROM rooms
            WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id
              AND room_number > NEW.hostel_capacity;
        END IF;
    END IF;

    RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER tr_BeforeHostelCapacityUpdate
BEFORE UPDATE ON hostels
FOR EACH ROW
EXECUTE FUNCTION tr_BeforeHostelCapacityUpdate();