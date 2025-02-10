CREATE OR REPLACE PROCEDURE sp_resolve_complaint(
    IN p_complaint_id INT, 
    IN p_admin_resolution_message VARCHAR(255), 
    IN p_admin_id INT
)
LANGUAGE plpgsql 
AS $$
BEGIN
    -- Start a transaction
    BEGIN 
        UPDATE complaints 
        SET admin_complaint_resolution_message = p_admin_resolution_message,
            maya_hostels_admin_id = p_admin_id, 
            admin_resolution_date = CURRENT_TIMESTAMP,
            student_complaint_status = 0,
            admin_complaint_resolution_status = 1
        WHERE maya_hostels_complaints_id = p_complaint_id;

        -- Commit transaction
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE;
    END;
END $$;
