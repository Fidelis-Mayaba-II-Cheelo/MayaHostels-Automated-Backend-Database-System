CREATE OR REPLACE FUNCTION tr_SetFullyBooked()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
mh_hostel_capacity INT;
mh_filledBedspaces INT;
BEGIN
	SELECT hostel_capacity INTO mh_hostel_capacity FROM hostels WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;

SELECT COUNT(*) INTO mh_filledBedspaces FROM bedspaces b INNER JOIN rooms r ON b.maya_hostels_room_id = r.maya_hostels_room_id 
	WHERE b.is_occupied = 1 AND r.maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;

IF mh_filledBedspaces = mh_hostel_capacity THEN
	UPDATE hostels SET hostel_status = 1 WHERE maya_hostels_hostel_id = NEW.maya_hostels_hostel_id;
END IF;

RETURN NEW;
END $$;

CREATE OR REPLACE TRIGGER tr_SetFullyBooked
AFTER UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION tr_SetFullyBooked();