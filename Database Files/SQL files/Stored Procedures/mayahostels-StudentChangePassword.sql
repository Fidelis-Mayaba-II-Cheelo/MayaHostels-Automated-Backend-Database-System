DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_StudentsChangePassword` $$
CREATE PROCEDURE `sp_StudentsChangePassword`(IN p_student_id INT, IN p_new_password VARCHAR(255), IN p_new_hash_algorithm VARCHAR(255))
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    UPDATE accounts 
    SET account_password = p_new_password, 
        hash_algorithm = p_new_hash_algorithm
    WHERE maya_hostels_student_id = p_student_id;

    CALL sp_SetStudentPasswordStatus(p_student_id, "Pending"); 

    COMMIT;

END $$