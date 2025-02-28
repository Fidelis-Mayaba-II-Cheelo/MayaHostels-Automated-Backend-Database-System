DELIMITER $$
DROP FUNCTION IF EXISTS `fn_GetUnresolvedComplaints` $$
CREATE FUNCTION `fn_GetUnresolvedComplaints`() 
RETURNS LONGTEXT
DETERMINISTIC
BEGIN
DECLARE mh_unresolved_complaints LONGTEXT;
-- Added CONCAT() inside the GROUP_CONCAT to add commas and spaces as separators between the fields. This will make the resulting string much easier to read.
SELECT GROUP_CONCAT(CONCAT(maya_hostels_complaints_id, ', ', student_complaint_message, ', ', student_issue_date, ', ', maya_hostels_student_id) ORDER BY maya_hostels_complaints_id) 
INTO mh_unresolved_complaints FROM complaints WHERE student_complaint_status = 1 AND admin_complaint_resolution_status = 0;
RETURN mh_unresolved_complaints;

END $$
DELIMITER ;