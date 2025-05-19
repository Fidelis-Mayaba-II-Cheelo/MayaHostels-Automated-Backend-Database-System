DELIMITER $$

DROP TRIGGER IF EXISTS `tr_BeforeDeleteHostel`$$
CREATE TRIGGER `tr_BeforeDeleteHostel`
BEFORE DELETE ON hostels
FOR EACH ROW
BEGIN
    DECLARE mh_no_occupied_rooms INT;
    DECLARE MESSAGE_TEXT VARCHAR(100);
    SELECT COUNT(*) INTO mh_no_occupied_rooms
    FROM students
    WHERE maya_hostels_hostel_id = OLD.maya_hostels_hostel_id;

    IF mh_no_occupied_rooms > 0 THEN
        SIGNAL SQLSTATE '45000';
        SET MESSAGE_TEXT = CONCAT('Deletion of hostel with ID ', OLD.maya_hostels_hostel_id, ' cannot occur because it still has tenants.');
    END IF;
END$$

DELIMITER ;
