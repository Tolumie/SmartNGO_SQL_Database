-- Data Insertion

-- Admin Data
INSERT INTO Admin (Name, ContactInfo, Role, HireDate)
VALUES
('Alex Johnson', 'alex.johnson@email.com', 'SuperAdmin', '2023-05-10'),
('Jessica Brown', 'jessica.brown@email.com', 'Manager', '2024-01-15'),
('Chris Wilson', 'chris.wilson@email.com', 'Support', '2024-06-01'),
('Emily Adams', 'emily.adams@email.com', 'Manager', '2023-09-12'),
('Daniel Lee', 'daniel.lee@email.com', 'Support', '2025-01-05');

-- Staff Data
INSERT INTO Staff (Name, Role, ContactDetails) 
VALUES 
('John Doe', 'Manager', 'johndoe@example.com'),
('Jane Smith', 'Coordinator', 'janesmith@example.com'),
('Alice Brown', 'Supervisor', 'alicebrown@example.com'),
('Bob Green', 'Advisor', 'bobgreen@example.com'),
('Charlie White', 'Analyst', 'charliewhite@example.com'),
('David Black', 'Consultant', 'davidblack@example.com'),
('Emma Blue', 'Director', 'emmablue@example.com'),
('Fiona Yellow', 'Specialist', 'fionayellow@example.com'),
('George Red', 'Leader', 'georgered@example.com'),
('Hannah Purple', 'Assistant', 'hannahpurple@example.com'),
('Isaac Orange', 'Technician', 'isaacorange@example.com'),
('Jack Pink', 'Intern', 'jackpink@example.com');

-- Membership_Tiers Data
INSERT INTO Membership_Tiers (TierName, FreeProjectsAllowed, ExtraProjectFee)
VALUES
('Basic', 1, 50.00),
('Silver', 3, 30.00),
('Gold', 5, 0.00);

-- Members Data
INSERT INTO Members (Name, ContactInfo, MembershipLevel, Interests)
VALUES
('John Doe', 'john.doe@email.com', 'Gold', 'Wildlife Conservation'),
('Jane Smith', 'jane.smith@email.com', 'Silver', 'Beach Cleanup'),
('Lucas Martinez', 'lucas.martinez@email.com', 'Gold', 'Water Conservation'),
('Mia Green', 'mia.green@email.com', 'Basic', 'Urban Gardening'),
('Samuel Lee', 'samuel.lee@email.com', 'Silver', 'Energy Efficiency'),
('Emily Johnson', 'emily.johnson@email.com', 'Gold', 'Renewable Energy'),
('David Brown', 'david.brown@email.com', 'Gold', 'Waste Management'),
('Sophia Wilson', 'sophia.wilson@email.com', 'Silver', 'Forest Protection'),
('Oliver Taylor', 'oliver.taylor@email.com', 'Basic', 'Recycling Programs'),
('Ava Harris', 'ava.harris@email.com', 'Silver', 'Sustainable Agriculture'),
('Chloe Adams', 'chloe.adams@email.com', 'Gold', 'Wildlife Photography'),
('Liam Thompson', 'liam.thompson@email.com', 'Basic', 'Energy Auditing');

-- Projects Data
INSERT INTO Projects (ProjectCode, ProjectName, Description, Schedule, MaxParticipants, LeaderID)
VALUES
(1, 'Wildlife Protection Program', 'Protecting endangered species.', '2025-02-10', 20, 1),
(2, 'Clean Energy Campaign', 'Raising awareness about renewables.', '2025-11-20', 25, 2),
(3, 'Beach Cleanup Initiative', 'Coastal cleanup efforts.', '2025-06-15', 15, 3),
(4, 'Urban Greening Project', 'Bringing greenery to urban areas.', '2025-08-01', 30, 4),
(5, 'Recycling Awareness Program', 'Promoting recycling in communities.', '2025-07-12', 10, 5),
(6, 'Sustainable Agriculture Promotion', 'Educating about sustainable farming.', '2025-09-30', 20, 6),
(7, 'Water Conservation Initiative', 'Conserving water in arid regions.', '2025-05-20', 25, 7),
(8, 'Energy Efficiency Awareness', 'Reducing energy consumption in homes.', '2025-10-10', 18, 8),
(9, 'Forest Protection Program', 'Preserving forest ecosystems.', '2025-06-30', 22, 9),
(10, 'Waste Management Campaign', 'Proper waste disposal techniques.', '2025-12-01', 10, 10),
(11, 'Climate Change Workshops', 'Workshops for raising climate awareness.', '2025-03-15', 50, 11),
(12, 'Youth Leadership for Sustainability', 'Engaging youth leaders.', '2025-04-20', 40, 12);

-- Bookings Data
INSERT INTO Bookings (MemberID, ProjectCode, PaymentStatus)
VALUES
(1, 1, 'Paid'),
(2, 3, 'Paid'),
(3, 7, 'Unpaid'),
(4, 4, 'Unpaid'),
(5, 6, 'Paid'),
(6, 2, 'Paid'),
(7, 5, 'Paid'),
(8, 8, 'Unpaid'),
(9, 9, 'Paid'),
(10, 10, 'Unpaid'),
(11, 11, 'Paid'),
(12, 12, 'Paid');

-- Payments Data
INSERT INTO Payments (MemberID, ProjectCode, Amount, PaymentMethod)
VALUES
(1, 1, 100.00, 'CreditCard'),
(2, 3, 60.00, 'PayPal'),
(3, 7, 80.00, 'BankTransfer'),
(4, 4, 40.00, 'PayPal'),
(5, 6, 90.00, 'CreditCard'),
(6, 2, 100.00, 'BankTransfer'),
(7, 5, 50.00, 'CreditCard'),
(8, 8, 70.00, 'PayPal'),
(9, 9, 80.00, 'CreditCard'),
(10, 10, 60.00, 'BankTransfer'),
(11, 11, 100.00, 'CreditCard'),
(12, 12, 90.00, 'PayPal');
