package com.evcharging.dao;

import com.evcharging.model.User;

import java.sql.SQLException;

public class TestUserDAO {

    public static void main(String[] args) {

        UserDAO userDAO = new UserDAO();

        String name = "Test User";
        String email = "testuser@example.com";
        String phone = "9876543210";
        String password = "TestPass123!";

        try {

            if (!userDAO.emailExists(email)
                    && !userDAO.phoneExists(phone)) {

                boolean registered = userDAO.registerUser(
                        name,
                        email,
                        phone,
                        password
                );

                if (registered) {
                    System.out.println("Registration Successful!");
                } else {
                    System.out.println("Registration Failed!");
                }

            } else {
                System.out.println(
                        "Email or phone already exists. Testing login."
                );
            }

            // Test login using email
            User emailUser = userDAO.loginUser(email, password);

            if (emailUser != null) {
                System.out.println("\nEmail Login Successful!");
                System.out.println("User ID: " + emailUser.getUserId());
                System.out.println("Name: " + emailUser.getName());
                System.out.println("Email: " + emailUser.getEmail());
                System.out.println("Phone: " + emailUser.getPhone());
                System.out.println("Role: " + emailUser.getRole());
            } else {
                System.out.println("\nEmail Login Failed!");
            }

            // Test login using phone number
            User phoneUser = userDAO.loginUser(phone, password);

            if (phoneUser != null) {
                System.out.println("\nPhone Login Successful!");
                System.out.println("User ID: " + phoneUser.getUserId());
                System.out.println("Name: " + phoneUser.getName());
                System.out.println("Email: " + phoneUser.getEmail());
                System.out.println("Phone: " + phoneUser.getPhone());
                System.out.println("Role: " + phoneUser.getRole());
            } else {
                System.out.println("\nPhone Login Failed!");
            }

        } catch (SQLException e) {

            System.out.println("Database operation failed.");
            e.printStackTrace();

        } catch (IllegalArgumentException e) {

            System.out.println(e.getMessage());
        }
    }
}
