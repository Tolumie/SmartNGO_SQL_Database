# Delite_FuturesDB

A complete SQL-based database project simulating a futures market platform for educational and analytical use. Designed with relational integrity, automation, and scalable querying in mind.


---

📘 Project Overview

Delite_FuturesDB was developed as a database solution for Delite Futures Initiative, a team-driven NGO that previously relied on manual, spreadsheet-based methods to track and manage key operational data — including member registration, project participation, bookings, and payments.

Due to increasing complexity, data loss risk, and inefficiencies in their manual process, the team proposed a centralized app to manage all dealings — and I was tasked with architecting the core database to power that app.

This SQL project provides:

A fully normalized relational database

Data structures for handling admin/staff/member roles

Tables for managing projects, payments, bookings, and feedback

Automated triggers and procedures to reduce repetitive logic

Built-in support for system logs like login attempts and notifications


The result is a robust, scalable backend database that ensures Delite can migrate from manual handling to a fully integrated system, with clean data pipelines and maintainable logic for future app development.

This project serves as the foundation for:

Web and mobile app integration

Advanced analytics and reporting

System integrity and future scalability



---

🗂️ Project Files

schema.sql: Database creation script

data.sql: Sample data insertion

triggers_procedures.sql: Triggers & stored procedures

queries.sql: Sample SQL queries

diagrams/: Contains:

Entity Relationship Diagram (ERD)

Use Case Diagram

Activity Diagram




---

🧱 Core Tables

Admin: Admin users

Staff: Project managers & leaders

Members: Registered participants

Membership_Tiers: Defines privileges per user tier

Projects: Sustainability-related project records

Bookings, Payments, Participation: Transactions & feedback tracking

LoginAttempts, Notifications: Logging & messaging



---

⚙️ Features

Triggers: Auto-update payment status and participant count

Stored Procedures: Simplify insertions and reporting

Indexes: Performance optimization across key relationships



---

🔁 Example Procedures

AddNewProject: Inserts a new project if staff exists

GetProjectPayments: Lists payments made per project

CalculateTotalEarnings: Sums all payments for a project



---

🧪 Example Queries

View unpaid members

Join members to project bookings

Analyze membership tier usage

Count bookings per project



---

🧩 Diagrams Explained

Entity Relationship Diagram (ERD): Illustrates the tables and their relationships — such as one-to-many between Members and Bookings, or Projects and Payments.

Use Case Diagram: Shows how different users (Admins, Staff, Members) interact with the system — e.g., booking a project, viewing payments.

Activity Diagram: Visualizes key workflows such as user registration, booking flow, or making a payment.



---

🧠 Skills Practiced

Normalization & relational design

SQL triggers, stored procedures

Conditional logic in SQL

Complex joins and aggregations

Optimizing SQL with indexing



---

📍 Roadmap (Next Steps)

Add Python scripts for ETL

Power BI dashboard integration

Flask-based project frontend

Docker containerization for full-stack deployment



---

🤝 Contributions

You're welcome to fork, suggest improvements, or adapt the schema for your own projects.


---

🛡 License

MIT

