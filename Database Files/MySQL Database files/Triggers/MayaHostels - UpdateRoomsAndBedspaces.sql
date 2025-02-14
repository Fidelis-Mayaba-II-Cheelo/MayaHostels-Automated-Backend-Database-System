DELIMITER $$

DROP TRIGGER IF EXISTS `tr_UpdateRoomsAndBedspaces` $$
CREATE TRIGGER `tr_UpdateRoomsAndBedspaces`
AFTER INSERT ON hostels
FOR EACH ROW
BEGIN
    DECLARE mh_room_capacity INT;
    DECLARE counter INT DEFAULT 0;
    DECLARE done BOOL DEFAULT false;
    DECLARE room_id INT;
    DECLARE bedspace_counter INT;
    
    -- Cursor to get the newly inserted rooms for this hostel
    DECLARE cur CURSOR FOR 
    SELECT maya_hostels_room_id FROM rooms WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;
    
    -- Declare a handler to exit the loop when no more rooms are found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;

    -- Determine room capacity based on hostel type
    IF NEW.hostel_type = 'Single' THEN SET mh_room_capacity = 1;
    ELSEIF NEW.hostel_type = 'Double' THEN SET mh_room_capacity = 2;
    ELSEIF NEW.hostel_type = 'Triple' THEN SET mh_room_capacity = 3;
    ELSEIF NEW.hostel_type = 'Quadruple' THEN SET mh_room_capacity = 4;
    END IF;

    -- Insert rooms based on hostel capacity
    WHILE counter < NEW.hostel_capacity DO
        INSERT INTO rooms (room_number, room_capacity, maya_hostels_hostel_id) 
        VALUES (counter + 1, mh_room_capacity, NEW.maya_hostels_hostel_id);
        
        SET counter = counter + 1;
    END WHILE;

    -- Process inserted rooms and create corresponding bedspaces
    OPEN cur;

    rooms_loop: LOOP
        FETCH cur INTO room_id;

        IF done THEN
            LEAVE rooms_loop;
        END IF;

        SET bedspace_counter = 1;

        WHILE bedspace_counter <= mh_room_capacity DO
            INSERT INTO bedspaces (is_occupied, bedspace_number, maya_hostels_room_id)
            VALUES (0, bedspace_counter, room_id);

            SET bedspace_counter = bedspace_counter + 1;
        END WHILE;
    END LOOP;

    CLOSE cur;

END$$

DELIMITER ;