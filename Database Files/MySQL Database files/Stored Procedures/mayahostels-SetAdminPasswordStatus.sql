DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_SetAdminPasswordStatus` $$
CREATE PROCEDURE `sp_SetAdminPasswordStatus`(IN admin_id INT,IN password_status ENUM("Active", "Expired", "Pending", "None"))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN 
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
SET @local_admin_id = admin_id;
SET @local_password_status = password_status;

PREPARE stmt FROM 'UPDATE accounts SET password_status = ? WHERE maya_hostels_admin_id = ?';
EXECUTE stmt USING @local_password_status, @local_admin_id;
DEALLOCATE PREPARE stmt;

COMMIT;

END $$
DELIMITER ;