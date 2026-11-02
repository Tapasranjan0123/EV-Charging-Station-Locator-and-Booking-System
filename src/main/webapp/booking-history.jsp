<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.evcharging.model.Booking" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Booking History</title>


    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/styles.css">


</head>
<body>

<header>
    <h1>My Booking History</h1>
    <p>View your EV charging reservations.</p>
</header>

<main class="form-container">

    <%
        String success = request.getParameter("success");
        String cancelled = request.getParameter("cancelled");
        String error = request.getParameter("error");

        if ("1".equals(success)) {
    %>
    <p class="success">Your booking was created successfully!</p>
    <%
        }

        if ("1".equals(cancelled)) {
    %>
    <p class="success">Your booking has been cancelled successfully!</p>
    <%
        }

        if ("cancel".equals(error)) {
    %>
    <p class="error">Unable to cancel this booking.</p>
    <%
        }

        List<Booking> bookings =
                (List<Booking>) request.getAttribute("bookings");
    %>

    <% if (bookings == null) { %>

    <p>Please open this page through the booking history link.</p>

    <% } else if (bookings.isEmpty()) { %>

    <p>You have no bookings yet.</p>

    <% } else { %>

    <table>
        <thead>
        <tr>
            <th>Booking ID</th>
            <th>Station ID</th>
            <th>Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>

        <tbody>
        <% for (Booking booking : bookings) { %>
        <tr>
            <td><%= booking.getBookingId() %></td>
            <td><%= booking.getStationId() %></td>
            <td><%= booking.getBookingDate() %></td>
            <td><%= booking.getStartTime() %></td>
            <td><%= booking.getEndTime() %></td>
            <td><%= booking.getStatus() %></td>

            <td>
                <% if ("BOOKED".equals(booking.getStatus())) { %>

                <form action="${pageContext.request.contextPath}/cancel-booking"
                      method="post"
                      onsubmit="return confirm('Are you sure you want to cancel this booking?');">

                    <input type="hidden"
                           name="bookingId"
                           value="<%= booking.getBookingId() %>">

                    <button type="submit">Cancel Booking</button>
                </form>

                <% } else { %>

                Not Available

                <% } %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <% } %>

    <p>
        <a class="button"
           href="${pageContext.request.contextPath}/stations">
            Find Charging Stations
        </a>
    </p>

    <p>
        <a href="${pageContext.request.contextPath}/dashboard.jsp">
            Back to Dashboard
        </a>
    </p>

</main>

</body>
</html>
