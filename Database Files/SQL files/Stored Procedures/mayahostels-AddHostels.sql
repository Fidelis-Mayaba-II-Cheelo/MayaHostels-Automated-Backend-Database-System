DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_AddHostels` $$
CREATE PROCEDURE `sp_AddHostels`(IN hostel_name VARCHAR(100), IN number_of_rooms INT, IN hostel_status tinyint, 
IN hostel_type VARCHAR(20), IN hostel_accommodation_price_per_month INT, IN maya_hostels_admin_id INT, IN semester INT)
BEGIN 
DECLARE hostel_capacity INT;
DECLARE number_of_bedspaces_per_room INT;
DECLARE hostel_accommodation_price_per_semester INT; 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
IF hostel_type = 'Single' THEN SET hostel_capacity = (1 * number_of_rooms); SET number_of_bedspaces_per_room = 1;
ELSEIF hostel_type = 'Double' THEN SET hostel_capacity = (2 * number_of_rooms); SET number_of_bedspaces_per_room = 2;
ELSEIF hostel_type = 'Triple' THEN SET hostel_capacity = (3 * number_of_rooms); SET number_of_bedspaces_per_room = 3;
ELSEIF hostel_type = 'Quadruple' THEN SET hostel_capacity = (4 * number_of_rooms); SET number_of_bedspaces_per_room = 4;
END IF;

SET hostel_accommodation_price_per_semester = 
CASE WHEN semester = 1 THEN (4 * hostel_accommodation_price_per_month)
WHEN semester = 2 THEN (6 * hostel_accommodation_price_per_month)
ELSE 0
END;

SET @local_hostel_name = hostel_name;
SET @local_number_of_rooms = number_of_rooms;
SET @local_hostel_status = hostel_status;
SET @local_hostel_type = hostel_type;
SET @local_hostel_accommodation_price_per_month = hostel_accommodation_price_per_month;
SET @local_maya_hostels_admin_id = maya_hostels_admin_id;
SET @local_semester = semester;

PREPARE stmt FROM 'INSERT INTO hostels(hostel_name, number_of_rooms, hostel_status, hostel_type, hostel_capacity, number_of_bedspaces_per_room, 
hostel_accommodation_price_per_semester, hostel_accommodation_price_per_month, maya_hostels_admin_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)';

EXECUTE stmt USING @local_hostel_name, @local_number_of_rooms, @local_hostel_status, @local_hostel_type, @hostel_capacity, 
@number_of_bedspaces_per_room, @hostel_accommodation_price_per_semester, @local_hostel_accommodation_price_per_month, @local_maya_hostels_admin_id;

DEALLOCATE PREPARE stmt;

COMMIT;
END $$
DELIMITER ;