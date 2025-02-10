DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_AdminChangePassword` $$
CREATE PROCEDURE `sp_AdminChangePassword`(IN p_admin_id INT, IN p_new_password VARCHAR(255), IN p_new_hash_algorithm VARCHAR(255))
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
    WHERE maya_hostels_admin_id = p_admin_id;

    CALL sp_SetAdminPasswordStatus(p_admin_id, "Pending"); 

    COMMIT;

END $$