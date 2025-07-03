-- 3. Create Triggers for Automatic Updates or Actions

-- Trigger for updating the payment status of a booking when a payment is made
DELIMITER $$
CREATE TRIGGER UpdatePaymentStatus
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    UPDATE Bookings
    SET PaymentStatus = 'Paid'
    WHERE MemberID = NEW.MemberID AND ProjectCode = NEW.ProjectCode;
END$$
DELIMITER ;

-- Trigger for updating the number of participants when a new booking is made
DELIMITER $$
CREATE TRIGGER UpdateParticipantsCount
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
    DECLARE current_count INT;
    -- Count the number of bookings for the project
    SELECT COUNT(*) INTO current_count FROM Bookings WHERE ProjectCode = NEW.ProjectCode;
    -- Update the 'CurrentParticipants' in Projects table
    UPDATE Projects
    SET CurrentParticipants = current_count
    WHERE ProjectCode = NEW.ProjectCode;
END$$
DELIMITER ;

-- 4. Create Stored Procedures for Reusable Queries

-- Stored procedure to add a new project
DELIMITER $$
CREATE PROCEDURE AddNewProject(IN project_name VARCHAR(100), IN description TEXT, IN schedule DATE, IN max_participants INT, IN leader_id INT)
BEGIN
    INSERT INTO Projects (ProjectName, Description, Schedule, MaxParticipants, LeaderID)
    VALUES (project_name, description, schedule, max_participants, leader_id);
END$$
DELIMITER ;

-- Stored procedure to get all members' payment statuses for a specific project
DELIMITER $$
CREATE PROCEDURE GetProjectPayments(IN project_id INT)
BEGIN
    SELECT Members.Name, Payments.Amount, Payments.PaymentDate, Payments.PaymentMethod, Bookings.PaymentStatus
    FROM Payments
    JOIN Members ON Payments.MemberID = Members.ID
    JOIN Bookings ON Bookings.MemberID = Members.ID
    WHERE Payments.ProjectCode = project_id;
END$$
DELIMITER ;

-- Stored procedure to calculate the total earnings for a project based on payments
DELIMITER $$
CREATE PROCEDURE CalculateTotalEarnings(IN project_id INT)
BEGIN
    SELECT SUM(Amount) AS TotalEarnings
    FROM Payments
    WHERE ProjectCode = project_id;
END$$
DELIMITER ;


/*
Trigger for updating the payment status:

The Payments table references MemberID and ProjectCode. Ensure Bookings uses the same combination to identify bookings.
-- Trigger to handle cases where multiple bookings exist for the same member and project.
*/

DELIMITER $$
CREATE TRIGGER UpdatePaymentStatus
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    UPDATE Bookings
    SET PaymentStatus = 'Paid'
    WHERE MemberID = NEW.MemberID AND ProjectCode = NEW.ProjectCode AND PaymentStatus = 'Unpaid';
END$$
DELIMITER ;
Trigger for updating participants count:

Update CurrentParticipants in the Projects table by incrementing the value instead of recalculating, for better efficiency.
Modified Trigger:


DELIMITER $$
CREATE TRIGGER UpdateParticipantsCount
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
    UPDATE Projects
    SET CurrentParticipants = CurrentParticipants + 1
    WHERE ProjectCode = NEW.ProjectCode;
END$$
DELIMITER ;
Modifications for Stored Procedures
Adding a New Project:

Ensure LeaderID references an existing StaffID in the Staff table.
Modified Procedure:


DELIMITER $$
CREATE PROCEDURE AddNewProject(
    IN project_name VARCHAR(100), 
    IN description TEXT, 
    IN schedule DATE, 
    IN max_participants INT, 
    IN leader_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM Staff WHERE StaffID = leader_id) THEN
        INSERT INTO Projects (ProjectName, Description, Schedule, MaxParticipants, LeaderID)
        VALUES (project_name, description, schedule, max_participants, leader_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'LeaderID does not exist';
    END IF;
END$$
DELIMITER ;