-- Drop existing trigger and function if they exist
DROP TRIGGER IF EXISTS tr_UpdateRoomsAndBedspaces ON hostels;
DROP FUNCTION IF EXISTS update_rooms_and_bedspaces();

-- Create the function for the trigger
CREATE FUNCTION update_rooms_and_bedspaces()
RETURNS TRIGGER AS $$
DECLARE
    mh_room_capacity INT;
    counter INT := 0;
    room_id INT;
    bedspace_counter INT;
    room_cursor REFCURSOR;
BEGIN
    -- Determine room capacity based on hostel type
    CASE NEW.hostel_type
        WHEN 'Single' THEN mh_room_capacity := 1;
        WHEN 'Double' THEN mh_room_capacity := 2;
        WHEN 'Triple' THEN mh_room_capacity := 3;
        WHEN 'Quadruple' THEN mh_room_capacity := 4;
        ELSE mh_room_capacity := 1; -- Default to 1 if hostel type is unknown
    END CASE;

    -- Insert rooms based on hostel capacity
    WHILE counter < NEW.hostel_capacity LOOP
        INSERT INTO rooms (room_number, room_capacity, maya_hostels_hostel_id) 
        VALUES (counter + 1, mh_room_capacity, NEW.maya_hostels_hostel_id)
        RETURNING maya_hostels_room_id INTO room_id;
        
        -- Insert bedspaces for the newly created room
        bedspace_counter := 1;
        WHILE bedspace_counter <= mh_room_capacity LOOP
            INSERT INTO bedspaces (is_occupied, bedspace_number, maya_hostels_room_id)
            VALUES (0, bedspace_counter, room_id);
            
            bedspace_counter := bedspace_counter + 1;
        END LOOP;

        counter := counter + 1;
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger to call the function after an insert
CREATE TRIGGER tr_UpdateRoomsAndBedspaces
AFTER INSERT ON hostels
FOR EACH ROW
EXECUTE FUNCTION update_rooms_and_bedspaces();
