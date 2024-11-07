
# User Access Management System

## Overview

The **User Access Management System** is a web-based application built with Java Servlets, JSP, and PostgreSQL. It allows users to register, log in, and request access to various software applications. The system has three roles:
- **Employee**: Requests access to software applications.
- **Manager**: Reviews and approves or rejects access requests.
- **Admin**: Manages software applications and has full system access.

This project is containerized using Docker and Docker Compose for easy deployment and scaling.

## Features

1. **User Registration**: New users sign up with the default role of "Employee".
2. **User Authentication**: Registered users can log in based on their roles.
3. **Software Management** (Admin only): Admins can add new software applications.
4. **Access Requests** (Employee only): Employees can request access to software.
5. **Request Approval** (Manager only): Managers can approve or reject access requests.

## Project Structure

- **Java Servlets**:
  - `SignUpServlet.java`: Handles user registration.
  - `LoginServlet.java`: Manages user authentication and redirection based on roles.
  - `SoftwareServlet.java`: Allows Admins to add new software applications.
  - `RequestServlet.java`: Handles access request submissions by Employees.
  - `ApprovalServlet.java`: Allows Managers to approve or reject requests.
- **JSP Pages**:
  - `signup.jsp`: User registration form.
  - `login.jsp`: User login form.
  - `createSoftware.jsp`: Form for Admins to add new software.
  - `requestAccess.jsp`: Form for Employees to request access.
  - `pendingRequests.jsp`: Page for Managers to view and act on pending requests.
  - `snackbar.jsp`: Displays feedback messages to users.
- **Database Tables**:
  - `users`: Stores user data with roles.
  - `software`: Stores software information.
  - `requests`: Logs access requests and statuses.
- **JavaScript**:
  - `script.js`: Contains validation and request-handling functions, including `submitApproval` and snackbar notifications.
- **CSS**:
  - `style.css`: Provides consistent styling across all pages.

## Setup and Installation

### Prerequisites

1. **Docker** - Ensure Docker is installed on your system.
2. **Docker Compose** - For orchestrating the application containers.

### Database Setup

The PostgreSQL database is hosted on a **Google Cloud Platform (GCP) instance**. Ensure that the instance is configured for external access, and note down the following details:
   - **GCP Instance IP**: Public IP address of the PostgreSQL instance.
   - **Database Name**: The name of your database, e.g., `user_access_management`.
   - **Database Credentials**: Username and password for database access.

### Configuration

1. Configure database credentials in the `config.properties` file:
   ```properties
   DB_URL=jdbc:postgresql://<GCP_INSTANCE_IP>:5432/user_access_management
   DB_USERNAME=your_db_username
   DB_PASSWORD=your_db_password
   DB_NAME=user_access_management
   ```

   Replace `<GCP_INSTANCE_IP>` with the IP address of your GCP PostgreSQL instance, and provide the correct `DB_USERNAME` and `DB_PASSWORD`.

2. Place `config.properties` in the `src/main/resources` directory.

### Docker Setup

1. **Dockerfile**: This project includes a Dockerfile to build the application image.
   ```dockerfile
   FROM tomcat:9.0-jdk11
   COPY target/UserAccessManagement.war /usr/local/tomcat/webapps/
   ```

2. **Docker Compose**: Create a `docker-compose.yml` file to run the application with Docker Compose.
   ```yaml
   version: '3.8'

   services:
     user-access-management:
       build: .
       container_name: user_access_management_app
       ports:
         - "8080:8080"
       environment:
         - DB_URL=jdbc:postgresql://<GCP_INSTANCE_IP>:5432/user_access_management
         - DB_USERNAME=your_db_username
         - DB_PASSWORD=your_db_password
       depends_on:
         - db

     db:
       image: postgres:13
       container_name: user_access_management_db
       environment:
         POSTGRES_USER: your_db_username
         POSTGRES_PASSWORD: your_db_password
         POSTGRES_DB: user_access_management
       ports:
         - "5432:5432"
       volumes:
         - db_data:/var/lib/postgresql/data

   volumes:
     db_data:
   ```

   - **Replace `<GCP_INSTANCE_IP>`** with the IP address of your GCP PostgreSQL instance.
   - **Replace `your_db_username` and `your_db_password`** with your actual database credentials.

3. **Build and Run**: Run the following commands to start the application.

   ```bash
   docker-compose build
   docker-compose up
   ```

4. **Access the application** in your browser at:
   ```
   http://localhost:8080/UserAccessManagement/
   ```

### Accessing the Application

Once the application is deployed and running, you can access the various functionalities:

1. **Sign Up**: Go to `/UserAccessManagement/jsp/signup.jsp` to register as an Employee.
2. **Login**: Go to `/UserAccessManagement/jsp/login.jsp` to log in.
3. **Roles & Access**:
   - **Employee**: Redirected to `requestAccess.jsp` to request software access.
   - **Manager**: Redirected to `pendingRequests.jsp` to approve/reject requests.
   - **Admin**: Redirected to `createSoftware.jsp` to add new software.

## Development Notes

### Snackbar Notifications
Feedback messages, such as success or error notifications, are displayed via the snackbar component included on each page. JavaScript functions handle these notifications.

### JavaScript Form Validations
JavaScript functions in `script.js` ensure form fields are filled appropriately. Functions like `validateSignUpForm`, `validateLoginForm`, `submitApproval`, and `validateSoftwareForm` handle front-end validation and feedback.

## Known Issues

1. **Snackbar Display Issues**: Snackbar feedback relies on URL query parameters (e.g., `?status=success`). Ensure that messages are passed correctly.
2. **ApprovalServlet**: If errors appear during request updates, verify that `requestId` and `action` parameters are set correctly in `pendingRequests.jsp`.

## Future Enhancements

1. **Role-Based Dashboard**: Enhance the user interface to provide a tailored dashboard for each role.
2. **Improved Security**: Hash passwords and implement secure session management.

