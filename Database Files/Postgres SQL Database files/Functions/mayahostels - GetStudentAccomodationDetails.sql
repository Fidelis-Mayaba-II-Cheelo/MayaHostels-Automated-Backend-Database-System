CREATE OR REPLACE FUNCTION fn_GetStudentAccommodationDetails(mh_student_id INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE 
    accommodation_details TEXT;
BEGIN
    SELECT 
        'Student ID: ' || s.maya_hostels_student_id || ', ' ||
        'Student Name: ' || s.student_name || ', ' ||
        'Student Number: ' || s.student_number || ', ' ||
        'National Registration Number: ' || s.national_registration_number || ', ' ||
        'Program of Study: ' || s.program_of_study || ', ' ||
        'Year of Study: ' || s.year_of_study || ', ' ||
        'Date of Birth: ' || s.date_of_birth || ', ' ||
        'Profile Picture: ' || s.profile_picture || ', ' ||
        'Gender: ' || s.gender || ', ' ||
        'Accommodation Status: ' || s.accommodation_status || ', ' ||
        'Hostel Name: ' || h.hostel_name || ', ' ||
        'Hostel Type: ' || h.hostel_type || ', ' ||
        'Room Number: ' || r.room_number || ', ' ||
        'Bedspace Number: ' || b.bedspace_number || ', ' ||
        'Monthly Accommodation Payment: ' || h.hostel_accomodation_price_per_month || ', ' ||
        'Full Semester Accommodation Payment: ' || h.hostel_accommodation_price_per_semester
    INTO accommodation_details
    FROM students s 
    INNER JOIN hostels h ON s.maya_hostels_hostel_id = h.maya_hostels_hostel_id 
    INNER JOIN rooms r ON s.maya_hostels_room_id = r.maya_hostels_room_id 
    INNER JOIN bedspaces b ON s.maya_hostels_bedspaces_id = b.maya_hostels_bedspaces_id
    WHERE s.maya_hostels_student_id = mh_student_id;

    RETURN accommodation_details;
END $$;
