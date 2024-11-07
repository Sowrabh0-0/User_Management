package com.example.useraccessmanagement.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class DatabaseUtils {
    private static final String URL;
    private static final String USERNAME;
    private static final String PASSWORD;
    private static final String DATABASE_NAME;

    static {
        try {
            Class.forName("org.postgresql.Driver");
            Properties props = new Properties();
            try (InputStream input = DatabaseUtils.class.getClassLoader().getResourceAsStream("config.properties")) {
                if (input == null) {
                    throw new RuntimeException("Unable to find config.properties");
                }
                props.load(input);
    
                DATABASE_NAME = props.getProperty("DB_NAME");
                URL = props.getProperty("DB_URL") + DATABASE_NAME;
                USERNAME = props.getProperty("DB_USERNAME");
                PASSWORD = props.getProperty("DB_PASSWORD");
            } catch (IOException e) {
                throw new RuntimeException("Failed to load database configuration", e);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("PostgreSQL JDBC Driver not found.", e);
        }
    }
    

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    public static void initializeDatabase() {
        try (Connection conn = DriverManager.getConnection(URL.replace(DATABASE_NAME, ""), USERNAME, PASSWORD);
            Statement stmt = conn.createStatement()) {
    
            String checkDbExistsQuery = "SELECT 1 FROM pg_database WHERE datname = '" + DATABASE_NAME + "'";
            ResultSet rs = stmt.executeQuery(checkDbExistsQuery);
    
            if (!rs.next()) {  
                String createDatabaseQuery = "CREATE DATABASE " + DATABASE_NAME;
                stmt.executeUpdate(createDatabaseQuery);
                System.out.println("Database " + DATABASE_NAME + " created successfully.");
            } else {
                System.out.println("Database " + DATABASE_NAME + " already exists.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error while checking or creating the database", e);
        }
    
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            String createUsersTable = "CREATE TABLE IF NOT EXISTS users (" +
                    "id SERIAL PRIMARY KEY, " +
                    "username VARCHAR(50) UNIQUE NOT NULL, " +
                    "password VARCHAR(50) NOT NULL, " +
                    "role VARCHAR(20) CHECK (role IN ('Employee', 'Manager', 'Admin')) NOT NULL" +
                    ");";
    
            String createSoftwareTable = "CREATE TABLE IF NOT EXISTS software (" +
                    "id SERIAL PRIMARY KEY, " +
                    "name VARCHAR(100) NOT NULL, " +
                    "description TEXT, " +
                    "access_levels VARCHAR(50) NOT NULL" +
                    ");";
    
            String createRequestsTable = "CREATE TABLE IF NOT EXISTS requests (" +
                    "id SERIAL PRIMARY KEY, " +
                    "user_id INT REFERENCES users(id), " +
                    "software_id INT REFERENCES software(id), " +
                    "access_type VARCHAR(20) CHECK (access_type IN ('Read', 'Write', 'Admin')) NOT NULL, " +
                    "reason TEXT, " +
                    "status VARCHAR(20) CHECK (status IN ('Pending', 'Approved', 'Rejected')) NOT NULL" +
                    ");";
    
            stmt.executeUpdate(createUsersTable);
            stmt.executeUpdate(createSoftwareTable);
            stmt.executeUpdate(createRequestsTable);
    
            System.out.println("Database tables created or already exist.");
    
            String insertDemoUsers = "INSERT INTO users (username, password, role) VALUES " +
                    "('admin', 'admin123', 'Admin'), " +
                    "('manager', 'manager123', 'Manager'), " +
                    "('employee', 'employee123', 'Employee') " +
                    "ON CONFLICT (username) DO NOTHING;";
    
            stmt.executeUpdate(insertDemoUsers);
            System.out.println("Demo users initialized: admin, manager, employee.");
    
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error initializing the database", e);
        }
    }
}
    