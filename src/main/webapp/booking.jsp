<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book EV Charging</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/styles.css">

    <style>
        .booking-container {
            max-width: 550px;
            margin: 35px auto;
            padding: 25px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .booking-container h2 {
            text-align: center;
            color: #176b50;
        }

        .booking-container button {
            width: 100%;
            margin-top: 15px;
        }
    </style>


</head>

<body>

<header>
    <h1>EV Charging Booking</h1>
    <p>Reserve your charging time.</p>
</header>

<main class="booking-container">


    <h2>Book a Charging Slot</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div style="background:#ffe8e8;color:#b42318;padding:12px;
                margin:15px 0;border-radius:6px;">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <% if ("1".equals(request.getParameter("success"))) { %>
    <div style="background:#e6f7ed;color:#087f5b;padding:12px;
                margin:15px 0;border-radius:6px;">
        Booking submitted successfully!
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/book"
          method="post">

        <label for="stationId">Station ID</label>

        <input type="number"
               id="stationId"
               name="stationId"
               value="<%= request.getParameter("stationId") == null
                   ? "" : request.getParameter("stationId") %>"
               min="1"
               required>

        <label for="bookingDate">Booking Date</label>

        <input type="date"
               id="bookingDate"
               name="bookingDate"
               min="<%= java.time.LocalDate.now() %>"
               required>

        <label for="startTime">Start Time</label>
        <input type="time"
               id="startTime"
               name="startTime"
               step="60"
               required>

        <label for="endTime">End Time</label>
        <input type="time"
               id="endTime"
               name="endTime"
               step="60"
               required>

        <button type="submit">Confirm Booking</button>

    </form>

    <p>
        <a href="${pageContext.request.contextPath}/stations">
            Back to Charging Stations
        </a>
    </p>

    <p>
        <a href="${pageContext.request.contextPath}/booking-history">
            My Bookings
        </a>
    </p>


</main>

</body>
</html>
