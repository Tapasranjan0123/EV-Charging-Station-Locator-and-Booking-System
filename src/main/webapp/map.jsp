<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>EV Charging Map - Odisha</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Leaflet CSS -->
    <link rel="stylesheet"
          href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f8f6;
        }

        h2 {
            text-align: center;
            color: #159957;
            margin: 25px;
        }

        #map {
            height: 550px;
            width: 90%;
            margin: 20px auto;
            border-radius: 12px;
        }
    </style>
</head>

<body>

<h2>EV Charging Stations Map - Odisha</h2>

<div id="map"></div>

<!-- Leaflet JavaScript -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<script>

    // Map centered on Bhubaneswar
    var map = L.map('map').setView([20.2961, 85.8245], 8);

    // OpenStreetMap layer
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    // Bhubaneswar
    L.marker([20.2961, 85.8245])
        .addTo(map)
        .bindPopup("<b>Bhubaneswar EV Hub</b>");

    // Cuttack
    L.marker([20.4625, 85.8830])
        .addTo(map)
        .bindPopup("<b>Cuttack EV Point</b>");

    // Puri
    L.marker([19.8135, 85.8312])
        .addTo(map)
        .bindPopup("<b>Puri Green Charge</b>");

</script>

</body>
</html>