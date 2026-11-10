package com.evcharging.dao;

import com.evcharging.model.Booking;
import com.evcharging.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Types;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Create a new booking
    public boolean createBooking(Booking booking) throws SQLException {

        if (booking == null
                || booking.getBookingDate() == null
                || booking.getStartTime() == null
                || booking.getEndTime() == null) {
            throw new IllegalArgumentException(
                    "Booking details must not be null."
            );
        }

        if (booking.getUserId() <= 0
                || booking.getStationId() <= 0) {
            throw new IllegalArgumentException(
                    "Invalid user ID or station ID."
            );
        }

        LocalDate date = booking.getBookingDate();
        LocalTime start = booking.getStartTime();
        LocalTime end = booking.getEndTime();

        // Allow bookings today or on future dates
        if (date.isBefore(LocalDate.now())) {
            throw new IllegalArgumentException(
                    "You cannot book a date in the past."
            );
        }

        // For today's booking, the start time must still be in the future
        if (date.equals(LocalDate.now())
                && !start.isAfter(LocalTime.now())) {
            throw new IllegalArgumentException(
                    "Choose a start time later than the current time."
            );
        }
        if (!end.isAfter(start)) {
            throw new IllegalArgumentException(
                    "End time must be later than start time."
            );
        }

        String lockSql = """
                SELECT total_slots
                FROM charging_stations
                WHERE station_id = ? AND active = TRUE
                FOR UPDATE
                """;

        String countSql = """
                SELECT COUNT(*)
                FROM bookings
                WHERE station_id = ?
                  AND booking_date = ?
                  AND status = 'BOOKED'
                  AND start_time < ?
                  AND end_time > ?
                """;

        String insertSql = """
                INSERT INTO bookings
                    (user_id, station_id, booking_date,
                     start_time, end_time, status)
                VALUES (?, ?, ?, ?, ?, 'BOOKED')
                """;

        try (Connection connection = DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {
                int totalSlots;

                // Lock the station row while checking capacity
                try (PreparedStatement lockStatement =
                             connection.prepareStatement(lockSql)) {

                    lockStatement.setInt(1, booking.getStationId());

                    try (ResultSet resultSet =
                                 lockStatement.executeQuery()) {

                        if (!resultSet.next()) {
                            throw new IllegalArgumentException(
                                    "Charging station not found or inactive."
                            );
                        }

                        totalSlots = resultSet.getInt("total_slots");
                    }
                }

                // Count bookings that overlap the requested time
                int overlappingBookings;

                try (PreparedStatement countStatement =
                             connection.prepareStatement(countSql)) {

                    countStatement.setInt(1, booking.getStationId());
                    countStatement.setDate(2, Date.valueOf(date));
                    countStatement.setTime(3, Time.valueOf(end));
                    countStatement.setTime(4, Time.valueOf(start));

                    try (ResultSet resultSet =
                                 countStatement.executeQuery()) {

                        resultSet.next();
                        overlappingBookings = resultSet.getInt(1);
                    }
                }

                if (overlappingBookings >= totalSlots) {
                    connection.rollback();
                    return false;
                }

                // Insert the booking
                try (PreparedStatement insertStatement =
                             connection.prepareStatement(insertSql)) {

                    insertStatement.setInt(1, booking.getUserId());
                    insertStatement.setInt(2, booking.getStationId());
                    insertStatement.setDate(3, Date.valueOf(date));
                    insertStatement.setTime(4, Time.valueOf(start));
                    insertStatement.setTime(5, Time.valueOf(end));

                    boolean created =
                            insertStatement.executeUpdate() == 1;

                    if (created) {
                        connection.commit();
                    } else {
                        connection.rollback();
                    }

                    return created;
                }

            } catch (SQLException | RuntimeException e) {

                connection.rollback();
                throw e;

            } finally {
                connection.setAutoCommit(true);
            }
        }
    }

    // Retrieve all bookings for one user
    public List<Booking> getBookingsByUser(int userId)
            throws SQLException {

        List<Booking> bookings = new ArrayList<>();

        String sql = """
                SELECT booking_id, user_id, station_id, booking_date, start_time, end_time, status
                FROM bookings
                WHERE user_id = ?
                ORDER BY booking_date DESC, start_time DESC
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Booking booking = new Booking();

                    booking.setBookingId(
                            resultSet.getInt("booking_id")
                    );

                    booking.setUserId(
                            resultSet.getInt("user_id")
                    );

                    booking.setStationId(
                            resultSet.getInt("station_id")
                    );

                    booking.setBookingDate(
                            resultSet.getDate("booking_date")
                                    .toLocalDate()
                    );

                    booking.setStartTime(
                            resultSet.getTime("start_time")
                                    .toLocalTime()
                    );

                    booking.setEndTime(
                            resultSet.getTime("end_time")
                                    .toLocalTime()
                    );

                    booking.setStatus(
                            resultSet.getString("status")
                    );

                    bookings.add(booking);
                }
            }
        }

        return bookings;
    }

    // Cancel a booking belonging to a specific user
    public boolean cancelBooking(int bookingId, int userId)
            throws SQLException {

        String sql = """
                UPDATE bookings
                SET status = 'CANCELLED'
                WHERE booking_id = ?
                  AND user_id = ?
                  AND status = 'BOOKED'
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, bookingId);
            statement.setInt(2, userId);

            return statement.executeUpdate() == 1;
        }
    }

    // Check whether the station has a free slot at a given time
    public boolean isStationAvailable(
            int stationId,
            LocalDate date,
            LocalTime startTime,
            LocalTime endTime
    ) throws SQLException {

        if (date == null || startTime == null || endTime == null
                || stationId <= 0 || !endTime.isAfter(startTime)) {
            throw new IllegalArgumentException(
                    "Invalid station, date, or booking time."
            );
        }

        if (date.isBefore(LocalDate.now())) {
            return false;
        }

        String sql = """
                SELECT s.total_slots,
                       COUNT(b.booking_id) AS overlapping_bookings
                FROM charging_stations s
                LEFT JOIN bookings b
                  ON b.station_id = s.station_id
                 AND b.booking_date = ?
                 AND b.status = 'BOOKED'
                 AND b.start_time < ?
                 AND b.end_time > ?
                WHERE s.station_id = ?
                  AND s.active = TRUE
                GROUP BY s.station_id, s.total_slots
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setDate(1, Date.valueOf(date));
            statement.setTime(2, Time.valueOf(endTime));
            statement.setTime(3, Time.valueOf(startTime));
            statement.setInt(4, stationId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (!resultSet.next()) {
                    return false;
                }

                int totalSlots =
                        resultSet.getInt("total_slots");

                int overlappingBookings =
                        resultSet.getInt("overlapping_bookings");

                return overlappingBookings < totalSlots;
            }
        }
    }
}
