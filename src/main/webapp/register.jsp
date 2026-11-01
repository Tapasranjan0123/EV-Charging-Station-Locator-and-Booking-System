<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - EV Charging System</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f0f4f8;
            color: #243447;
        }

        header {
            background: #087f5b;
            color: white;
            text-align: center;
            padding: 25px;
        }

        .container {
            max-width: 420px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            margin: 8px 0 18px;
            border: 1px solid #ccd5df;
            border-radius: 6px;
        }

        button {
            width: 100%;
            padding: 13px;
            background: #087f5b;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background: #066b4d;
        }

        .error {
            color: #c92a2a;
        }

        .success {
            color: #087f5b;
        }

        .link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>

<body>

<header>
    <h1>Create Your Account</h1>
    <p>EV Charging Station Locator and Booking System</p>
</header>

<div class="container">
    <h2>Register</h2>

    <% if (request.getAttribute("error") != null) { %>
    <p class="error">
        <%= request.getAttribute("error") %>
    </p>
    <% } %>

    <% if ("1".equals(request.getParameter("registered"))) { %>
    <p class="success">Registration successful! Please log in.</p>
    <% } %>

    <form action="${pageContext.request.contextPath}/register"
          method="post">

        <label for="name">Full Name</label>
        <input type="text" id="name" name="name"
               required maxlength="100">

        <label for="email">Email Address</label>
        <input type="email" id="email" name="email"
               required maxlength="150">

        <label for="phone">Phone Number</label>

        <input
                type="tel"
                id="phone"
                name="phone"
                placeholder="Enter your 10-digit phone number"
                pattern="[0-9]{10}"
                maxlength="10"
                required
        >

        <label for="password">Password</label>
        <input type="password" id="password" name="password"
               required minlength="8" autocomplete="new-password">

        <button type="submit">Create Account</button>
    </form>

    <div class="link">
        Already registered?
        <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
        <br><br>
        <a href="${pageContext.request.contextPath}/index.jsp">Back to Home</a>
    </div>
</div>

</body>
</html>
