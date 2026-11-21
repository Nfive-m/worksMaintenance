# worksMaintenance
A help desk and works maintenance respository for university of Ibadan 

University of Ibadan Works Maintenance Department Management System

1. Project Overview

The University of Ibadan Works Maintenance Department Management System is a web-based application designed to support the management and monitoring of maintenance activities within the university.

The system provides a centralized platform for handling maintenance requests, managing projects, monitoring technicians, generating reports, and tracking maintenance operations.

It aims to improve communication, accountability, record management, and the overall efficiency of maintenance operations.

2. Project Objectives

- Provide a centralized platform for managing maintenance requests.
- Improve the tracking and monitoring of maintenance activities.
- Support the management of maintenance projects.
- Enable administrators to manage users and technicians.
- Maintain organized records of maintenance operations.
- Generate reports for monitoring and decision-making.

3. Key Features

- User registration and authentication.
- Secure sign-in and sign-out.
- Role-based access control.
- Maintenance ticket management.
- Maintenance project management.
- Technician management.
- Maintenance reports.
- Notifications.
- Centralized data storage using Supabase.

4. User Roles

The system supports three main user roles:

Role| Description
ADMIN| Manages the system, users, technicians, projects, tickets, and reports.
TECHNICIAN| Handles assigned maintenance tasks and updates their progress.
USER| Can access the system according to the permissions assigned to ordinary users.

Newly registered users are assigned the "USER" role by default.

Only an administrator should promote users to higher roles.

5. Technologies Used

The project uses:

- HTML5 – Application structure.
- CSS3 – Styling and interface design.
- JavaScript – Application functionality and interactions.
- Supabase – Authentication, PostgreSQL database, and backend services.
- GitHub – Source code management and collaboration.

No PHP, Python, or frontend framework is required.

6. Project Structure

The main application files include:

worksMaintenance/
│
├── index.html
├── script.js
├── style.css
├── README.md
└── supabase-setup.sql

Additional files and folders may be added as development progresses.

7. Supabase Configuration

The application uses Supabase as its backend service.

Supabase provides:

- User authentication.
- PostgreSQL database storage.
- Database access policies.
- Role-based data access through Row Level Security (RLS).
- Realtime database capabilities.

Supabase Project

Project name: "worksMaintenance"

Supabase project reference:

ngirgfgudopxrlotpsky

The Supabase URL and publishable key should be configured in the application's JavaScript file.

Security note: Never expose the Supabase service-role key or secret keys in frontend JavaScript.

8. Authentication and Account Management

Users can register and sign in using their email addresses and passwords.

Registration

1. Open the application.
2. Navigate to the registration page.
3. Enter the required details.
4. Submit the registration form.
5. Sign in after successful registration and email confirmation, if required.

Administrator Account Setup

An administrator account must be created through the Supabase Authentication dashboard.

After creating the account, its role must be updated to "ADMIN" in the database.

Example SQL:

UPDATE public.profiles
SET
    full_name = 'Administrative',
    role = 'ADMIN',
    updated_at = now()
WHERE id = (
    SELECT id
    FROM auth.users
    WHERE lower(email) = lower('admin@example.com')
);

Replace the email address with the administrator's registered email address.

9. Database

The application uses PostgreSQL through Supabase.

The main database tables include:

- "profiles" – Stores user profile information and roles.
- "app_records" – Stores operational application records, including tickets, projects, reports, technicians, and notifications.

Row Level Security (RLS) is used to control access to database records based on user permissions.

10. Running the Application

The application is built with standard HTML, CSS, and JavaScript.

To run it locally:

1. Clone or download the repository.
2. Open the project folder.
3. Configure the Supabase connection.
4. Open "index.html" in a browser or use a local development server.
5. Register or sign in to access the application.

11. Installation and Setup

Clone the repository:

git clone https://github.com/Nfive-m/worksMaintenance.git

Navigate into the project folder:

cd worksMaintenance

Open the folder in your preferred code editor.

Configure the Supabase URL and publishable key in "script.js" before running the application.

12. Security Considerations

- User passwords are managed by Supabase Authentication.
- New users receive the default "USER" role.
- Administrative privileges must be assigned manually.
- Database access is controlled through Row Level Security.
- Service-role and secret keys must never be included in public frontend files.
- Users should not be allowed to assign themselves administrative privileges.

13. Project Status

This project is being developed as an academic software project.

Some features may still require implementation, integration, testing, and improvement.

The application is intended to demonstrate how a centralized maintenance management system can support the activities of the University of Ibadan Works Maintenance Department.

14. Contributors

Developed as part of an academic project.

Institution: University of Ibadan
Department: Computer Science

15. License

This project is developed for academic and educational purposes.
