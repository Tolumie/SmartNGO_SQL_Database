-- 1. Create Database and Use It
CREATE DATABASE DeliteFuturesDB;
USE DeliteFuturesDB;

-- 2. Create Tables in Order of Dependencies
/*The tables should be created starting from the most independent (no foreign keys) 
to the most dependent (with multiple foreign keys).
(a) Independent Tables
Admin: No foreign keys.
Staff: No foreign keys.
Membership_Tiers: No foreign keys.
*/
-- Admin Table
CREATE TABLE Admin (
    AdminID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(255) NOT NULL,
    Role ENUM('SuperAdmin', 'Manager', 'Support') NOT NULL,
    HireDate DATE DEFAULT (CURRENT_DATE)
);

-- Staff Table
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    ContactDetails VARCHAR(255) NOT NULL,
    HireDate DATE DEFAULT (CURRENT_DATE)
);


-- Membership_Tiers Table
CREATE TABLE Membership_Tiers (
    TierID INT AUTO_INCREMENT PRIMARY KEY,
    TierName ENUM('Basic', 'Silver', 'Gold') NOT NULL,
    FreeProjectsAllowed INT NOT NULL,
    ExtraProjectFee DECIMAL(10, 2) NOT NULL
);

/*(b) Tables Dependent on Independent Tables
Members: Indirectly references Membership_Tiers through MembershipLevel.
Projects: References Staff via LeaderID.
*/
-- Members Table
CREATE TABLE Members (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(255) NOT NULL,
    MembershipLevel ENUM('Basic', 'Silver', 'Gold') NOT NULL,
    Interests TEXT,
    RegistrationDate DATE DEFAULT (CURRENT_DATE)
);


-- Projects Table
CREATE TABLE Projects (
    ProjectCode INT AUTO_INCREMENT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    Description TEXT NOT NULL,
    Schedule DATE,
    MaxParticipants INT NOT NULL,
    LeaderID INT,
    CurrentParticipants INT DEFAULT 0,
    FOREIGN KEY (LeaderID) REFERENCES Staff(StaffID) ON DELETE SET NULL
);
/*
(c) Tables Dependent on Multiple Tables
Bookings: Depends on Members and Projects.
Payments: Depends on Members and Projects.
Participation: Depends on Members and Projects.*/

-- Bookings Table
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    ProjectCode INT,
    BookingDate DATE DEFAULT (CURRENT_DATE) ,
    PaymentStatus ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (MemberID) REFERENCES Members(ID) ON DELETE CASCADE,
    FOREIGN KEY (ProjectCode) REFERENCES Projects(ProjectCode) ON DELETE CASCADE
);


-- Payments Table
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    ProjectCode INT,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE DEFAULT (CURRENT_DATE),
    PaymentMethod ENUM('CreditCard', 'PayPal', 'BankTransfer') NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Members(ID),
    FOREIGN KEY (ProjectCode) REFERENCES Projects(ProjectCode)
);

-- Participation Table
CREATE TABLE Participation (
    ParticipationID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    ProjectCode INT,
    Feedback TEXT,
    ParticipationDate DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (MemberID) REFERENCES Members(ID),
    FOREIGN KEY (ProjectCode) REFERENCES Projects(ProjectCode)
);


/*(d) Logging and Notifications
LoginAttempts: Depends on Members.
Notifications: Depends on Members.*/


-- LoginAttempts Table
CREATE TABLE LoginAttempts (
    AttemptID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    AttemptTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    AttemptResult ENUM('Success', 'Failed') NOT NULL,
    FailureReason TEXT,
    FOREIGN KEY (MemberID) REFERENCES Members(ID)
);

-- Notifications Table
CREATE TABLE Notifications (
    NotificationID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    Message TEXT NOT NULL,
    SentTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MemberID) REFERENCES Members(ID)
);




/* 
   Indexing for Query Optimization 
*/

/* Indexes for Admin table */
CREATE INDEX idx_name ON Admin(Name);
CREATE INDEX idx_contactinfo ON Admin(ContactInfo);

/* Indexes for Staff table */
CREATE INDEX idx_role ON Staff(Role);
CREATE INDEX idx_name_staff ON Staff(Name);
CREATE INDEX idx_contactdetails ON Staff(ContactDetails);

/* Index for Membership_Tiers table */
CREATE INDEX idx_tiername ON Membership_Tiers(TierName);

/* Indexes for Members table */
CREATE INDEX idx_membershiplevel ON Members(MembershipLevel);
CREATE INDEX idx_registrationdate ON Members(RegistrationDate);

/* Index for Projects table */
CREATE INDEX idx_leaderid ON Projects(LeaderID);

/* Indexes for Bookings table */
CREATE INDEX idx_memberid ON Bookings(MemberID);
CREATE INDEX idx_projectcode ON Bookings(ProjectCode);

/* Indexes for Payments table */
CREATE INDEX idx_memberid_payments ON Payments(MemberID);
CREATE INDEX idx_projectcode_payments ON Payments(ProjectCode);

/* Indexes for Participation table */
CREATE INDEX idx_memberid_participation ON Participation(MemberID);
CREATE INDEX idx_projectcode_participation ON Participation(ProjectCode);

/* Indexes for LoginAttempts table */
CREATE INDEX idx_memberid_login ON LoginAttempts(MemberID);
CREATE INDEX idx_attempttime ON LoginAttempts(AttemptTime);

/* Indexes for Notifications table */
CREATE INDEX idx_memberid_notifications ON Notifications(MemberID);
CREATE INDEX idx_senttime_notifications ON Notifications(SentTime);