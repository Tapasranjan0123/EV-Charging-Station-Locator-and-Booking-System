package com.evcharging.util;

import java.sql.Connection;
import java.sql.SQLException;

public class TestConnection {

    public static void main(String[] args) {

        try (Connection connection =
                     DBConnection.getConnection()) {

            System.out.println(
                    "MySQL Connected Successfully!"
            );

        } catch (SQLException e) {

            System.out.println(
                    "Database Connection Failed!"
            );

            e.printStackTrace();
        }
    }
}

