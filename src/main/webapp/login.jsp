<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login - EV Charging System</title>

    <style>
        * {
            box-sizing: border-box;
        }

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
            max-width: 450px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-top: 15px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border: 1px solid #ccd5df;
            border-radius: 6px;
            font-size: 15px;
        }

        button {
            width: 100%;
            padding: 13px;
            margin-top: 25px;
            background: #087f5b;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .error {
            color: #c92a2a;
        }

        .links {
            margin-top: 22px;
            text-align: center;
            line-height: 2;
        }
    </style>
</head>

<body>

<header>
    <h1>EV Charging Station Locator</h1>
    <p>Welcome back!</p>
</header>

<div class="container">

    <h2>Login</h2>

    <% if ("1".equals(request.getParameter("registered"))) { %>
    <p style="color:green;">
        Registration successful! Please log in.
    </p>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
    <p class="error">
        <%= request.getAttribute("error") %>
    </p>
    <% } %>

    <form action="${pageContext.request.contextPath}/login"
          method="post">

        <label for="email">Email Address / Phone Number</label>

        <input type="text"
               id="email"
               name="email"
               placeholder="Enter your email or phone number"
               autocomplete="username"
               required>

        <label for="password">Password</label>

        <input type="password"
               id="password"
               name="password"
               autocomplete="current-password"
               required>

        <button type="submit">Login</button>

    </form>

    <div class="links">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register.jsp">
            Register
        </a>

        <br>

        <a href="${pageContext.request.contextPath}/index.jsp">
            Back to Home
        </a>
    </div>

</div>

</body>
</html>

