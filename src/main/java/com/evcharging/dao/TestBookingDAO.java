package com.evcharging.dao;

import com.evcharging.model.Booking;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public class TestBookingDAO {

    public static void main(String[] args) {
        BookingDAO bookingDAO = new BookingDAO();

        // Use an existing user ID from your users table.
        int userId = 1;

        // Use an existing station ID from charging_stations.
        int stationId = 1;

        // Select a future date.
        LocalDate bookingDate = LocalDate.now().plusDays(2);

        LocalTime startTime = LocalTime.of(10, 0);
        LocalTime endTime = LocalTime.of(11, 0);

        try {

            // Step 1: Check station availability.
            boolean available = bookingDAO.isStationAvailable(
                    stationId,
                    bookingDate,
                    startTime,
                    endTime
            );

            System.out.println(
                    "Station available: " + available
            );

            if (!available) {
                System.out.println(
                        "No charging slot is available."
                );
                return;
            }

            // Step 2: Create the booking.
            Booking booking = new Booking();

            booking.setUserId(userId);
            booking.setStationId(stationId);
            booking.setBookingDate(bookingDate);
            booking.setStartTime(startTime);
            booking.setEndTime(endTime);
            booking.setStatus("BOOKED");

            boolean created = bookingDAO.createBooking(booking);

            if (created) {
                System.out.println("Booking created successfully!");
            } else {
                System.out.println(
                        "Booking failed: no slot is available."
                );
                return;
            }

            // Step 3: Retrieve the user's bookings.
            List<Booking> bookings =
                    bookingDAO.getBookingsByUser(userId);

            System.out.println("\n===== YOUR BOOKINGS =====");

            for (Booking item : bookings) {

                System.out.println(
                        "Booking ID: " + item.getBookingId()
                );

                System.out.println(
                        "Station ID: " + item.getStationId()
                );

                System.out.println(
                        "Date: " + item.getBookingDate()
                );

                System.out.println(
                        "Start Time: " + item.getStartTime()
                );

                System.out.println(
                        "End Time: " + item.getEndTime()
                );

                System.out.println(
                        "Status: " + item.getStatus()
                );

                System.out.println("-------------------------");
            }

            System.out.println(
                    "Total bookings: " + bookings.size()
            );

        } catch (SQLException e) {

            System.out.println(
                    "Database error while processing the booking."
            );

            e.printStackTrace();

        } catch (IllegalArgumentException e) {

            System.out.println(
                    "Invalid booking: " + e.getMessage()
            );
        }
    }
}
