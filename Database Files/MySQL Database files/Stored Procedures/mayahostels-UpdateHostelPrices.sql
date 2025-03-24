DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_UpdateHostelPrice` $$
CREATE PROCEDURE `sp_UpdateHostelPrice`(IN mh_hostel_id INT, IN mh_new_semester_price INT, IN mh_new_monthly_price INT)
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SELECT 'An error occured whilst attempting to update the hostel price';
END;

START TRANSACTION;
UPDATE hostels SET hostel_accommodation_price_per_semester = mh_new_semester_price, 
hostel_accomodation_price_per_month = mh_new_monthly_price WHERE maya_hostels_hostel_id = mh_hostel_id;
COMMIT;

END $$
DELIMITER ;