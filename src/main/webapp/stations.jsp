<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Charging Stations</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f4f8;
            margin: 0;
            color: #243447;
        }

        header {
            background: #087f5b;
            color: white;
            text-align: center;
            padding: 25px;
        }

        main {
            max-width: 1100px;
            margin: 35px auto;
            padding: 20px;
        }

        .station-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
        }

        .station-card {
            background: white;
            padding: 22px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .station-card h2 {
            color: #087f5b;
        }

        .price {
            font-size: 20px;
            font-weight: bold;
        }

        .back-button {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 18px;
            background: #087f5b;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .empty-message {
            background: white;
            padding: 20px;
            border-radius: 8px;
        }
    </style>
</head>

<body>

<header>
    <h1>EV Charging Stations</h1>
    <p>Find a charging station for your electric vehicle.</p>
</header>

<main>

    <c:choose>
        <c:when test="${empty stations}">
            <div class="empty-message">
                <h2>No charging stations found.</h2>
                <p>Please check your database or try again later.</p>
            </div>
        </c:when>

        <c:otherwise>
            <div class="station-list">

                <c:forEach var="station" items="${stations}">
                    <div class="station-card">

                        <h2>
                            <c:out value="${station.stationName}"/>
                        </h2>

                        <p>
                            <strong>City:</strong>
                            <c:out value="${station.city}"/>
                        </p>

                        <p>
                            <strong>Address:</strong>
                            <c:out value="${station.address}"/>
                        </p>

                        <p>
                            <strong>Charging Type:</strong>
                            <c:out value="${station.chargingType}"/>
                        </p>

                        <p class="price">
                            ₹ <c:out value="${station.pricePerUnit}"/>
                            per unit
                        </p>

                        <p>
                            <strong>Total Slots:</strong>
                            <c:out value="${station.totalSlots}"/>
                        </p>

                        <p>
                            <a href="${pageContext.request.contextPath}/booking.jsp?stationId=${station.stationId}"
                               style="display: inline-block;
              background: #087f5b;
              color: white;
              padding: 12px 18px;
              text-decoration: none;
              border-radius: 6px;">
                                Book Now
                            </a>
                        </p>

                    </div>
                </c:forEach>

            </div>
        </c:otherwise>
    </c:choose>

    <a class="back-button"
       href="${pageContext.request.contextPath}/">
        Back to Home
    </a>

</main>

</body>
</html>