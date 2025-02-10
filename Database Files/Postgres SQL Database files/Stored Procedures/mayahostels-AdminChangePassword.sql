CREATE OR REPLACE PROCEDURE sp_admin_change_password(
    IN p_admin_id INT, 
    IN p_new_password VARCHAR(255), 
    IN p_new_hash_algorithm VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Start transaction block
    BEGIN
        -- Update the admin's password
        UPDATE accounts 
        SET account_password = p_new_password, 
            hash_algorithm = p_new_hash_algorithm
        WHERE maya_hostels_admin_id = p_admin_id;

        -- Call another stored procedure to update the password status
        CALL sp_set_admin_password_status(p_admin_id, 'Pending');

        -- Commit transaction
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Rollback transaction if an error occurs
            ROLLBACK;
            RAISE;
    END;
END $$;
