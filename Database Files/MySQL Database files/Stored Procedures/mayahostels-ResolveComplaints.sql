DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_ResolveComplaint` $$
CREATE PROCEDURE sp_ResolveComplaint(IN complaint_id INT, IN admin_resolution_message VARCHAR(255), IN admin_id INT)
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

UPDATE complaints SET admin_complaint_resolution_message = admin_resolution_message,
maya_hostels_admin_id = admin_id, admin_resolution_date = current_timestamp(),
student_complaint_status = 0,
admin_complaint_resolution_status = 1
WHERE maya_hostels_complaints_id = complaint_id;

COMMIT;
END $$
DELIMITER ;