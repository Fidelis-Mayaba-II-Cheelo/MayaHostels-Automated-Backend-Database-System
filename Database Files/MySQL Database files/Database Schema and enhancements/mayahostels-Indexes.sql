
-- INDEXING FOR BETTER PERFORMANCE
CREATE INDEX idx_student_id ON students(maya_hostels_student_id);
CREATE INDEX idx_admin_id ON admin(maya_hostels_admin_id);
CREATE INDEX idx_hostel_id ON hostels(maya_hostels_hostel_id);
CREATE INDEX idx_room_id ON rooms(maya_hostels_room_id);
CREATE INDEX idx_bedspace_id ON bedspaces(maya_hostels_bedspaces_id);
CREATE INDEX idx_notification_admin_id ON notifications(maya_hostels_admin_id);
CREATE INDEX idx_notification_student_id ON notifications(maya_hostels_student_id);

-- To speed up queries related to unresolved complaints
CREATE INDEX idx_complaints_status ON complaints(maya_hostels_admin_id, student_complaint_status);
-- For faster lookup of unread notifications
CREATE INDEX idx_notification_status ON notifications(notification_status);
-- For quick filtering based on active or pending accounts
CREATE INDEX idx_account_status ON accounts(account_type, password_status);
-- To speed up searches by program or by year of study
CREATE INDEX idx_program_year ON students(program_of_study, year_of_study);