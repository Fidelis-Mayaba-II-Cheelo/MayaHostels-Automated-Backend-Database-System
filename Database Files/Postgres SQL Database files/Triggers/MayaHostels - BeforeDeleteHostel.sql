CREATE OR REPLACE FUNCTION tr_BeforeDeleteHostel()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
	mh_no_occupied_rooms INT;
BEGIN
SELECT SUM(COUNT(*)) INTO mh_no_occupied_rooms FROM students WHERE maya_hostels_hostel_id = OLD.maya_hostels_hostel_id;

IF mh_no_occupied_rooms > 0 THEN
	RAISE EXCEPTION 'Deletion of hostel with ID % cannot occur because it still has tenants', OLD.maya_hostels_hostel_id;
END IF;

RETURN NULL;
END $$;
CREATE OR REPLACE TRIGGER tr_BeforeDeleteHostel
BEFORE DELETE ON hostels
FOR EACH ROW
EXECUTE FUNCTION tr_BeforeDeleteHostel();