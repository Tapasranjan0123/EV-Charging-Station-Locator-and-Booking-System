package com.evcharging.dao;

import com.evcharging.model.User;
import com.evcharging.util.DBConnection;
import org.jetbrains.annotations.NotNull;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

public class UserDAO {

    private static final int ITERATIONS = 210_000;
    private static final int SALT_LENGTH = 16;
    private static final int KEY_LENGTH = 256;

    private static final SecureRandom RANDOM = new SecureRandom();

    // Register a new user with email and phone number
    public boolean registerUser(
            String name,
            String email,
            String phone,
            String password
    ) throws SQLException {

        if (name == null || name.isBlank()
                || email == null || email.isBlank()
                || phone == null || !phone.matches("[0-9]{10}")
                || password == null || password.length() < 8) {

            throw new IllegalArgumentException(
                    "Enter a name, valid email, 10-digit phone number, "
                            + "and password of at least 8 characters."
            );
        }

        String normalizedEmail = email.trim().toLowerCase();
        String normalizedPhone = phone.trim();

        if (emailExists(normalizedEmail)
                || phoneExists(normalizedPhone)) {
            return false;
        }

        String passwordHash = hashPassword(password);

        String sql = """
                INSERT INTO users (name, email, phone, password_hash, role)
                VALUES (?, ?, ?, ?, 'USER')
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {
            statement.setString(1, name.trim());
            statement.setString(2, normalizedEmail);
            statement.setString(3, normalizedPhone);
            statement.setString(4, passwordHash);

            return statement.executeUpdate() == 1;
        }
    }

    // Check whether an email already exists
    public boolean emailExists(@NotNull String email) throws SQLException {

        String sql = "SELECT 1 FROM users WHERE email = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {
            statement.setString(1, email.trim().toLowerCase());

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    // Check whether a phone number already exists
    public boolean phoneExists(String phone) throws SQLException {

        if (phone == null || phone.isBlank()) {
            return false;
        }

        String sql = "SELECT 1 FROM users WHERE phone = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {
            statement.setString(1, phone.trim());

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    // Find a user by email
    public User getUserByEmail(String email) throws SQLException {

        String sql = """
                SELECT user_id, name, email, phone, password_hash, role
                FROM users
                WHERE email = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {
            statement.setString(1, email.trim().toLowerCase());

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        }

        return null;
    }

    // Find a user by email OR phone number
    public User getUserByIdentifier(String identifier) throws SQLException {

        if (identifier == null || identifier.isBlank()) {
            return null;
        }

        String value = identifier.trim();

        String sql = """
                SELECT user_id, name, email, phone, password_hash, role
                FROM users
                WHERE email = ? OR phone = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {
            statement.setString(1, value.toLowerCase());
            statement.setString(2, value);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        }

        return null;
    }

    // Convert a database record into a User object
    private User mapUser(ResultSet resultSet) throws SQLException {

        User user = new User();

        user.setUserId(resultSet.getInt("user_id"));
        user.setName(resultSet.getString("name"));
        user.setEmail(resultSet.getString("email"));
        user.setPhone(resultSet.getString("phone"));
        user.setPasswordHash(resultSet.getString("password_hash"));
        user.setRole(resultSet.getString("role"));

        return user;
    }

    // Authenticate using an email address OR phone number
    public User loginUser(
            String identifier,
            String password
    ) throws SQLException {

        if (identifier == null || identifier.isBlank()
                || password == null) {
            return null;
        }

        User user = getUserByIdentifier(identifier);

        if (user == null) {
            return null;
        }

        return verifyPassword(password, user.getPasswordHash())
                ? user
                : null;
    }

    // Create a salted PBKDF2 password hash
    private String hashPassword(String password) {

        byte[] salt = new byte[SALT_LENGTH];
        RANDOM.nextBytes(salt);

        PBEKeySpec spec = new PBEKeySpec(
                password.toCharArray(),
                salt,
                ITERATIONS,
                KEY_LENGTH
        );

        try {
            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );

            byte[] hash = factory.generateSecret(spec).getEncoded();

            return "PBKDF2$" + ITERATIONS + "$"
                    + Base64.getEncoder().encodeToString(salt) + "$"
                    + Base64.getEncoder().encodeToString(hash);

        } catch (GeneralSecurityException e) {
            throw new IllegalStateException(
                    "Password hashing failed.", e
            );
        } finally {
            spec.clearPassword();
        }
    }

    // Verify the entered password
    private boolean verifyPassword(
            String password,
            String storedHash
    ) {

        if (storedHash == null) {
            return false;
        }

        String[] parts = storedHash.split("\\$");

        if (parts.length != 4 || !"PBKDF2".equals(parts[0])) {
            return false;
        }

        try {
            int iterations = Integer.parseInt(parts[1]);

            if (iterations < 1 || iterations > 1_000_000) {
                return false;
            }

            byte[] salt = Base64.getDecoder().decode(parts[2]);
            byte[] expectedHash = Base64.getDecoder().decode(parts[3]);

            PBEKeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    iterations,
                    expectedHash.length * 8
            );

            try {
                SecretKeyFactory factory =
                        SecretKeyFactory.getInstance(
                                "PBKDF2WithHmacSHA256"
                        );

                byte[] actualHash =
                        factory.generateSecret(spec).getEncoded();

                return MessageDigest.isEqual(
                        expectedHash, actualHash
                );

            } finally {
                spec.clearPassword();
            }

        } catch (GeneralSecurityException
                 | IllegalArgumentException e) {
            return false;
        }
    }
}
