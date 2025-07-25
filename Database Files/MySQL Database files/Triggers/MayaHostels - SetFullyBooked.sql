DELIMITER $$

CREATE TRIGGER tr_SetFullyBooked
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
  DECLARE mh_hostel_capacity INT;
  DECLARE mh_filledBedspaces INT;

  SELECT hostel_capacity
  INTO mh_hostel_capacity
  FROM hostels
  WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;

  SELECT COUNT(*)
  INTO mh_filledBedspaces
  FROM bedspaces b
  INNER JOIN rooms r ON b.maya_hostels_room_id = r.maya_hostels_room_id
  WHERE b.is_occupied = 1
    AND r.maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;

  IF mh_filledBedspaces = mh_hostel_capacity THEN
    UPDATE hostels
    SET hostel_status = 1
    WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;
  END IF;

END$$

DELIMITER ;
