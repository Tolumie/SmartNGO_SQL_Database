-- 6. Sample Data Retrieval (SELECT) Queries
-- Basic queries to fetch data from single or joined tables.
-- ---

-- Retrieve all members with their membership level.
SELECT Name, MembershipLevel FROM Members;

-- Retrieve all projects with their leader's name.
SELECT ProjectName, Description, Schedule, MaxParticipants, Staff.Name AS Leader
FROM Projects
JOIN Staff ON Projects.LeaderID = Staff.StaffID;

-- Retrieve members who booked for a particular project (ProjectCode = 1).
SELECT Members.Name, Bookings.BookingDate, Bookings.PaymentStatus
FROM Bookings
JOIN Members ON Bookings.MemberID = Members.ID
WHERE Bookings.ProjectCode = 1;

-- Retrieve payment details for a specific project (ProjectCode = 2).
SELECT Members.Name, Payments.Amount, Payments.PaymentDate, Payments.PaymentMethod
FROM Payments
JOIN Members ON Payments.MemberID = Members.ID
WHERE Payments.ProjectCode = 2;

-- Get all members' participation feedback for a specific project (ProjectCode = 3).
SELECT Members.Name, Participation.Feedback
FROM Participation
JOIN Members ON Participation.MemberID = Members.ID
WHERE Participation.ProjectCode = 3;

-- Retrieve the membership tier details for each member.
SELECT Members.Name, Membership_Tiers.TierName, Membership_Tiers.FreeProjectsAllowed, Membership_Tiers.ExtraProjectFee
FROM Members
JOIN Membership_Tiers ON Members.MembershipLevel = Membership_Tiers.TierName;

-- Find the total number of bookings made for each project.
SELECT Projects.ProjectName, COUNT(Bookings.BookingID) AS TotalBookings
FROM Bookings
JOIN Projects ON Bookings.ProjectCode = Projects.ProjectCode
GROUP BY Projects.ProjectName;

-- Get members who have unpaid bookings.
SELECT Members.Name, Bookings.PaymentStatus
FROM Bookings
JOIN Members ON Bookings.MemberID = Members.ID
WHERE Bookings.PaymentStatus = 'Unpaid';

-- ---
-- 7. Advanced Data Retrieval (Joins, Subqueries)
-- More complex queries using JOINS and SUBQUERIES for deeper insights.
-- ---

-- Retrieve Members Who Have Booked 'Wildlife Protection Program' and Their Payment Status.
SELECT
    M.Name AS MemberName,
    B.BookingDate,
    B.PaymentStatus
FROM
    Members AS M
JOIN
    Bookings AS B ON M.ID = B.MemberID
JOIN
    Projects AS P ON B.ProjectCode = P.ProjectCode
WHERE
    P.ProjectName = 'Wildlife Protection Program';

-- List All Staff Members and Any Projects They Lead (using LEFT JOIN to include staff without projects).
SELECT
    S.Name AS StaffName,
    S.Role AS StaffRole,
    P.ProjectName
FROM
    Staff AS S
LEFT JOIN
    Projects AS P ON S.StaffID = P.LeaderID
ORDER BY
    S.Name;

-- Find Projects with More Than 20 Max Participants.
SELECT
    ProjectName,
    MaxParticipants,
    Description
FROM
    Projects
WHERE
    MaxParticipants > 20;

-- Get All Payments Made in the Last 6 Months (relative to current date).
SELECT
    M.Name AS MemberName,
    P.ProjectName,
    Py.Amount,
    Py.PaymentDate
FROM
    Payments AS Py
JOIN
    Members AS M ON Py.MemberID = M.ID
JOIN
    Projects AS P ON Py.ProjectCode = P.ProjectCode
WHERE
    Py.PaymentDate >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
ORDER BY
    Py.PaymentDate DESC;

-- Count the Number of Projects Each Staff Member Leads.
SELECT
    S.Name AS StaffName,
    S.Role,
    COUNT(P.ProjectCode) AS NumberOfProjectsLed
FROM
    Staff AS S
LEFT JOIN
    Projects AS P ON S.StaffID = P.LeaderID
GROUP BY
    S.StaffID, S.Name, S.Role
ORDER BY
    NumberOfProjectsLed DESC;

-- Subquery: Members Who Have Not Made Any Payments.
SELECT
    Name,
    ContactInfo
FROM
    Members
WHERE
    ID NOT IN (SELECT DISTINCT MemberID FROM Payments);

-- Subquery: Projects That Have No Bookings Yet.
SELECT
    ProjectName,
    Description
FROM
    Projects
WHERE
    ProjectCode NOT IN (SELECT DISTINCT ProjectCode FROM Bookings);

-- Subquery: Staff Members Who Lead Projects With 'Conservation' in Their Name.
SELECT
    Name,
    Role
FROM
    Staff
WHERE
    StaffID IN (
        SELECT LeaderID
        FROM Projects
        WHERE ProjectName LIKE '%Conservation%'
    );

-- ---
-- 8. Data Manipulation Language (DML) - CRUD Operations
-- Commands for creating (inserting), updating, and deleting data.
-- ---

-- INSERT: Insert a New Notification for a Member.
INSERT INTO Notifications (MemberID, Message)
VALUES (1, 'Your upcoming project, "Clean Energy Campaign", is scheduled for November 20, 2025.');

-- UPDATE: Update a Member's Contact Information.
UPDATE Members
SET ContactInfo = 'john.doe.new@email.com'
WHERE Name = 'John Doe';

-- UPDATE: Change the Role of a Staff Member (e.g., StaffID 2 is Jane Smith).
UPDATE Staff
SET Role = 'Senior Coordinator'
WHERE StaffID = 2;

-- UPDATE: Mark All Unpaid Bookings for a Specific Project (ProjectCode = 7) as Paid (manual update example).
UPDATE Bookings
SET PaymentStatus = 'Paid'
WHERE ProjectCode = 7 AND PaymentStatus = 'Unpaid';

-- DELETE: Delete a Specific Booking (BookingID = 4).
DELETE FROM Bookings
WHERE BookingID = 4;

-- DELETE: Delete All Login Attempts for a Specific Member (MemberID = 1).
DELETE FROM LoginAttempts
WHERE MemberID = 1;

-- ---
-- 9. Data Definition Language (DDL) - Alterations
-- Commands for modifying table structures after creation.
-- ---

-- ALTER TABLE: Add a new column 'PhoneNumber' to the Members table.
ALTER TABLE Members
ADD COLUMN PhoneNumber VARCHAR(20);

-- ALTER TABLE: Modify the data type of the 'Role' column in the Staff table.
ALTER TABLE Staff
MODIFY COLUMN Role VARCHAR(150);

-- ALTER TABLE: Remove the 'HireDate' column from the Admin table (use with caution).
-- ALTER TABLE Admin
-- DROP COLUMN HireDate;
