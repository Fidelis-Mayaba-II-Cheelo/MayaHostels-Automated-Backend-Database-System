DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_SetStudentPasswordStatus` $$
CREATE PROCEDURE `sp_SetStudentPasswordStatus`(IN student_id INT,IN password_status ENUM("Active", "Expired", "Pending", "None"))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN 
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;
SET @local_student_id = student_id;
SET @local_password_status = password_status;

PREPARE stmt FROM 'UPDATE accounts SET password_status = ? WHERE maya_hostels_student_id = ?';
EXECUTE stmt USING @local_password_status, @local_student_id;
DEALLOCATE PREPARE stmt;

COMMIT;

END $$
DELIMITER ;