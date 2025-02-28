CREATE OR REPLACE FUNCTION fn_get_unresolved_complaints() 
RETURNS TEXT 
LANGUAGE plpgsql 
AS $$
DECLARE
    mh_unresolved_complaints TEXT;
BEGIN
    -- Using STRING_AGG instead of GROUP_CONCAT in MySQL
    SELECT STRING_AGG(
        maya_hostels_complaints_id || ', ' || student_complaint_message || ', ' ||
        student_issue_date || ', ' || maya_hostels_student_id, ', ' 
        ORDER BY maya_hostels_complaints_id
    )
    INTO mh_unresolved_complaints
    FROM complaints 
    WHERE student_complaint_status = 1 AND admin_complaint_resolution_status = 0;

    RETURN mh_unresolved_complaints;
END;
$$;
