CREATE OR REPLACE PROCEDURE sp_set_student_password_status(
    IN p_student_id INT,
    IN p_password_status VARCHAR(20)  -- Using VARCHAR since ENUM isn't as common in PostgreSQL as in MySQL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Start transaction block
    BEGIN
        -- Update the admin's password status
        UPDATE accounts
        SET password_status = p_password_status
        WHERE maya_hostels_student_id = p_student_id;

        -- Commit transaction
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Rollback transaction if an error occurs
            ROLLBACK;
            RAISE;
    END;
END $$;
