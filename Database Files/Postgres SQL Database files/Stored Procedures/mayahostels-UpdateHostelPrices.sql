CREATE OR REPLACE PROCEDURE sp_UpdateHostelPrice(
    mh_hostel_id INT,
    mh_new_semester_price INT,
    mh_new_monthly_price INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Exception handling (rollback on error)
    BEGIN
        UPDATE hostels
        SET
            hostel_accommodation_price_per_semester = mh_new_semester_price,
            hostel_accomodation_price_per_month = mh_new_monthly_price
        WHERE
            maya_hostels_hostel_id = mh_hostel_id;

        COMMIT; -- Explicit commit
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        RAISE EXCEPTION 'An error occurred while attempting to update the hostel price: %', SQLERRM;
    END;
END;
$$;