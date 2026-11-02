<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EV Charge Odisha</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            color: #222;
            background: #fff;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 5%;
            border-bottom: 1px solid #eee;
            gap: 20px;
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            color: #222;
            text-decoration: none;
            white-space: nowrap;
        }

        .logo span {
            color: #159957;
        }

        .links {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 22px;
        }

        .links a {
            color: #555;
            text-decoration: none;
            font-size: 14px;
        }

        .links a:hover {
            color: #159957;
        }

        .links .login {
            padding: 10px 16px;
            border: 1px solid #159957;
            border-radius: 5px;
            color: #159957;
        }

        .links .register {
            padding: 11px 16px;
            border-radius: 5px;
            background: #159957;
            color: white;
        }

        .hero {
            max-width: 1450px;
            margin: auto;
            padding: 65px 25px;

            display: grid;
            grid-template-columns: 1fr 1fr;
            align-items: center;
            gap: 40px;
        }

        /* Right side image */
        .hero-image {
            width: 100%;
        }

        .hero-image img {
            width: 100%;
            height: auto;
            display: block;
            object-fit: contain;
            border-radius: 18px;
        }
        .location {
            color: #159957;
            font-size: 14px;
            font-weight: bold;
        }

        h1 {
            margin: 20px 0;
            font-family: Georgia, serif;
            font-size: clamp(36px, 5vw, 54px);
            line-height: 1.2;
        }

        h1 span {
            color: #159957;
        }

        .description {
            max-width: 650px;
            color: #666;
            font-size: 17px;
            line-height: 1.8;
        }

        .search {
            display: flex;
            max-width: 650px;
            gap: 10px;
            margin-top: 28px;
        }

        .search input {
            flex: 1;
            min-width: 0;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
        }

        .search button {
            padding: 14px 22px;
            border: none;
            border-radius: 6px;
            background: #159957;
            color: white;
            font-size: 15px;
            cursor: pointer;
        }

        .cities {
            max-width: 1100px;
            margin: auto;
            padding: 35px 25px 60px;
            border-top: 1px solid #eee;
        }

        .cities h2 {
            font-family: Georgia, serif;
            font-size: 28px;
        }

        .city-list {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .city-list a {
            padding: 13px 20px;
            border: 1px solid #ddd;
            border-radius: 6px;
            color: #333;
            text-decoration: none;
        }

        .city-list a:hover {
            color: #159957;
            border-color: #159957;
        }

        footer {
            padding: 22px;
            border-top: 1px solid #eee;
            color: #777;
            text-align: center;
            font-size: 13px;
        }

        @media (max-width: 800px) {
            nav {
                align-items: flex-start;
                flex-direction: column;
            }

            .links {
                gap: 15px;
            }

            .hero {
                grid-template-columns: 1fr;
                padding-top: 50px;
            }

            .hero-image img {
                height: 300px;
            }
        }

        @media (max-width: 480px) {
            .search {
                flex-direction: column;
            }

            .search button {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<%
    String context = request.getContextPath();
%>

<nav>
    <a class="logo" href="<%= context %>/index.jsp">
        ⚡ EV Charge <span>Odisha</span>
    </a>

    <div class="links">
        <a href="<%= context %>/map.jsp">Map</a>
        <a href="#cities">Cities</a>
        <a href="#odisha">Odisha</a>
        <a href="<%= context %>/stations">Stations</a>

        <a class="login"
           href="${pageContext.request.contextPath}/login.jsp">
            Login
        </a>


        <a class="register"
           href="<%= context %>/register.jsp">Register</a>
    </div>
</nav>

<main>
    <section class="hero" id="odisha">

        <!-- LEFT SIDE CONTENT -->
        <div class="hero-content">

            <div class="location">ODISHA, INDIA</div>

            <h1>
                EV charging stations<br>
                <span>across Odisha</span>
            </h1>

            <p class="description">
                Find electric vehicle charging stations in Bhubaneswar,
                Cuttack, Puri and other locations across Odisha.
                Explore charging options and access station booking.
            </p>

            <!-- SEARCH FORM -->
            <form class="search"
                  action="<%= context %>/stations"
                  method="get">

                <input type="text"
                       name="city"
                       placeholder="Search a city or charging station..."
                       aria-label="Search city or charging station">

                <button type="submit">Search</button>

            </form>

        </div>

        <!-- RIGHT SIDE IMAGE -->
        <div class="hero-image">

            <img src="<%= context %>/image/img.png"
                 alt="EV Charging Station">

        </div>

    </section>

    <section class="cities" id="cities">

        <h2>Explore Charging Stations by City</h2>

        <div class="city-list">
            <a href="<%= context %>/stations">Bhubaneswar →</a>
            <a href="<%= context %>/stations">Cuttack →</a>
            <a href="<%= context %>/stations">Puri →</a>
        </div>

    </section>
</main>

<footer>
    EV Charge Odisha · EV Charging Station Locator and Booking System
</footer>

</body>
</html>

