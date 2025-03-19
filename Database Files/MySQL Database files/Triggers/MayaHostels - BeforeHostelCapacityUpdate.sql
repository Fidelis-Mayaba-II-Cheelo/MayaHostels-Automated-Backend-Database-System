DELIMITER $$

DROP TRIGGER IF EXISTS `tr_BeforeHostelCapacityUpdate` $$

CREATE TRIGGER `tr_BeforeHostelCapacityUpdate` 
BEFORE UPDATE ON hostels 
FOR EACH ROW
BEGIN
    DECLARE mh_room_capacity INT;
    DECLARE counter INT DEFAULT 0;
    DECLARE room_id INT;
    DECLARE bedspace_counter INT;
    DECLARE mh_track_new_room_number INT;
    DECLARE max_room_number INT;
    DECLARE rooms_to_delete_count INT;

    -- Room capacity calculation
    IF OLD.hostel_type = 'Single' THEN 
        SET mh_room_capacity = 1;
    ELSEIF OLD.hostel_type = 'Double' THEN 
        SET mh_room_capacity = 2;
    ELSEIF OLD.hostel_type = 'Triple' THEN 
        SET mh_room_capacity = 3;
    ELSEIF OLD.hostel_type = 'Quadruple' THEN 
        SET mh_room_capacity = 4;
    END IF;

    -- Increase Capacity
    IF NEW.hostel_capacity > OLD.hostel_capacity THEN 
        -- Get the maximum existing room number
        SELECT IFNULL(MAX(room_number), 0) INTO max_room_number FROM rooms WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;
        SET mh_track_new_room_number = max_room_number + 1;

        -- Insert rooms
        WHILE counter < (NEW.hostel_capacity - OLD.hostel_capacity) DO
            INSERT INTO rooms (room_number, room_capacity, maya_hostels_hostel_id) 
            VALUES (mh_track_new_room_number, mh_room_capacity, NEW.maya_hostels_hostel_id);

            SET counter = counter + 1;
            SET mh_track_new_room_number = mh_track_new_room_number + 1;
        END WHILE;

        -- Insert bedspaces
        INSERT INTO bedspaces (is_occupied, bedspace_number, maya_hostels_room_id)
        SELECT 0, numbers.n, r.maya_hostels_room_id
        FROM rooms r, (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) AS numbers
        WHERE r.maya_hostels_hostel_id = NEW.maya_hostels_hostel_id
          AND r.room_number > max_room_number
          AND numbers.n <= mh_room_capacity;

    -- Decrease Capacity
    ELSEIF NEW.hostel_capacity < OLD.hostel_capacity THEN
        -- Check if any bedspaces in rooms to delete are occupied
        SELECT COUNT(*) INTO rooms_to_delete_count
        FROM rooms r
        JOIN bedspaces b ON r.maya_hostels_room_id = b.maya_hostels_room_id
        WHERE r.maya_hostels_hostel_id = NEW.maya_hostels_hostel_id
          AND r.room_number > NEW.hostel_capacity
          AND b.is_occupied = 1;

        IF rooms_to_delete_count > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot decrease capacity: Occupied bedspaces exist.';
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
END $$

DELIMITER ;