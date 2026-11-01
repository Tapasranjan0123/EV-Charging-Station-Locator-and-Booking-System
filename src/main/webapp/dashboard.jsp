<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.evcharging.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String context = request.getContextPath();
    String name = user.getName();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard - EV Charge Odisha</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f9f7;
            color: #243447;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 5%;
            background: white;
            border-bottom: 1px solid #e8ece8;
        }

        .logo {
            color: #222;
            font-size: 22px;
            font-weight: bold;
            text-decoration: none;
        }

        .logo span {
            color: #159957;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-links a {
            color: #444;
            text-decoration: none;
        }

        .logout {
            padding: 10px 16px;
            border-radius: 6px;
            background: #159957;
            color: white !important;
        }

        main {
            max-width: 1050px;
            margin: 45px auto;
            padding: 0 22px;
        }

        .welcome {
            padding: 35px;
            background: #eaf6ed;
            border-radius: 12px;
        }

        .welcome h1 {
            margin-top: 0;
            font-family: Georgia, serif;
            font-size: 36px;
        }

        .welcome p {
            color: #5d6a60;
            line-height: 1.7;
        }

        .section-title {
            margin-top: 38px;
            font-family: Georgia, serif;
            font-size: 27px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
            margin-top: 22px;
        }

        .card {
            padding: 25px;
            background: white;
            border: 1px solid #e5eae5;
            border-radius: 10px;
        }

        .icon {
            font-size: 30px;
        }

        .card h3 {
            margin-bottom: 10px;
        }

        .card p {
            color: #68736b;
            line-height: 1.6;
        }

        .button {
            display: inline-block;
            margin-top: 12px;
            padding: 11px 16px;
            background: #159957;
            color: white;
            border-radius: 6px;
            text-decoration: none;
        }

        footer {
            margin-top: 70px;
            padding: 25px;
            background: white;
            border-top: 1px solid #eee;
            text-align: center;
            color: #777;
        }

        @media (max-width: 700px) {
            nav {
                align-items: flex-start;
                flex-direction: column;
                gap: 15px;
            }

            .cards {
                grid-template-columns: 1fr;
            }

            .welcome h1 {
                font-size: 29px;
            }
        }
    </style>
</head>

<body>

<nav>
    <a class="logo" href="<%= context %>/index.jsp">
        ⚡ EV Charge <span>Odisha</span>
    </a>

    <div class="nav-links">
        <a href="<%= context %>/map.jsp">Map</a>
        <a href="<%= context %>/stations">Stations</a>
        <a href="<%= context %>/booking-history">My Bookings</a>
        <a class="logout" href="<%= context %>/logout">Logout</a>
    </div>
</nav>

<main>

    <section class="welcome">
        <h1>Welcome, <%= name %>!</h1>

        <p>
            Welcome to your EV Charge Odisha dashboard.
            Find charging stations and manage your charging reservations.
        </p>

        <a class="button" href="<%= context %>/stations">
            Explore Charging Stations →
        </a>
    </section>

    <h2 class="section-title">Your EV Dashboard</h2>

    <section class="cards">

        <article class="card">
            <div class="icon">📍</div>
            <h3>Charging Stations</h3>
            <p>Explore the charging stations currently listed in the system.</p>

            <a class="button" href="<%= context %>/stations">
                View Stations
            </a>
        </article>

        <article class="card">
            <div class="icon">📅</div>
            <h3>My Bookings</h3>
            <p>Review your charging reservations and their current status.</p>

            <a class="button" href="<%= context %>/booking-history">
                Booking History
            </a>
        </article>

        <article class="card">
            <div class="icon">⚡</div>
            <h3>Book Charging</h3>
            <p>Choose a listed station and request a charging time slot.</p>

            <a class="button" href="<%= context %>/stations">
                Book a Slot
            </a>
        </article>

    </section>

</main>

<footer>
    EV Charge Odisha · EV Charging Station Locator and Booking System
</footer>

</body>
</html>

