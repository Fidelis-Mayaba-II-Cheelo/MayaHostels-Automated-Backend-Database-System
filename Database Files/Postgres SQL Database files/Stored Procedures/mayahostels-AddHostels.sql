CREATE OR REPLACE PROCEDURE sp_add_hostels(
    IN p_hostel_name VARCHAR(100),
    IN p_number_of_rooms INT,
    IN p_hostel_status SMALLINT,
    IN p_hostel_type VARCHAR(20),
    IN p_hostel_accommodation_price_per_month INT,
    IN p_maya_hostels_admin_id INT,
    IN p_semester INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_hostel_capacity INT;
    v_number_of_bedspaces_per_room INT;
    v_hostel_accommodation_price_per_semester INT;
BEGIN
    -- Start transaction
    BEGIN
        -- Determine hostel capacity and bedspaces per room based on hostel type
        CASE p_hostel_type
            WHEN 'Single' THEN 
                v_hostel_capacity := 1 * p_number_of_rooms;
                v_number_of_bedspaces_per_room := 1;
            WHEN 'Double' THEN 
                v_hostel_capacity := 2 * p_number_of_rooms;
                v_number_of_bedspaces_per_room := 2;
            WHEN 'Triple' THEN 
                v_hostel_capacity := 3 * p_number_of_rooms;
                v_number_of_bedspaces_per_room := 3;
            WHEN 'Quadruple' THEN 
                v_hostel_capacity := 4 * p_number_of_rooms;
                v_number_of_bedspaces_per_room := 4;
            ELSE 
                RAISE EXCEPTION 'Invalid hostel type';
        END CASE;

        -- Determine hostel accommodation price per semester
        v_hostel_accommodation_price_per_semester := 
            CASE p_semester
                WHEN 1 THEN 4 * p_hostel_accommodation_price_per_month
                WHEN 2 THEN 6 * p_hostel_accommodation_price_per_month
                ELSE 0
            END;

        -- Insert into the hostels table
        INSERT INTO hostels(
            hostel_name, number_of_rooms, hostel_status, hostel_type, hostel_capacity, 
            number_of_bedspaces_per_room, hostel_accommodation_price_per_semester, 
            hostel_accommodation_price_per_month, maya_hostels_admin_id
        ) VALUES (
            p_hostel_name, p_number_of_rooms, p_hostel_status, p_hostel_type, v_hostel_capacity, 
            v_number_of_bedspaces_per_room, v_hostel_accommodation_price_per_semester, 
            p_hostel_accommodation_price_per_month, p_maya_hostels_admin_id
        );

        -- Commit transaction
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Rollback transaction if an error occurs
            ROLLBACK;
            RAISE;
    END;
END $$;
