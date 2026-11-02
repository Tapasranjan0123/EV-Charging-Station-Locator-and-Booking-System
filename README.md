# ⚡ EV Charging Station Locator and Booking System

## 📌 Project Overview

The **EV Charging Station Locator and Booking System** is a web-based application developed to help electric vehicle (EV) users find nearby charging stations and book available charging slots conveniently.

The system provides an easy-to-use platform for managing charging stations, user accounts, and charging reservations. It aims to make EV charging more accessible, organised, and efficient.

## 🎯 Project Objectives

* Help EV users locate available charging stations.
* Allow users to book charging slots.
* Provide secure user registration and login.
* Manage charging station information.
* Maintain booking history.
* Allow users to cancel their bookings.

## 🚀 Key Features

### 1. User Management

* User Registration
* User Login and Logout
* User Authentication

### 2. Charging Station Management

* Add and manage charging stations.
* Display charging station details.
* Manage station availability.

### 3. EV Station Locator

* Display charging station locations.
* View station information and availability.

### 4. Booking Management

* Book charging slots.
* View booking history.
* Cancel existing bookings.

### 5. Database Management

* MySQL database connectivity.
* Store user information.
* Manage charging station records.
* Maintain booking records.

## 🛠️ Technologies Used

| Technology    | Purpose                 |
| ------------- | ----------------------- |
| Java          | Backend Development     |
| JSP           | Dynamic Web Pages       |
| Java Servlets | Server-side Processing  |
| JDBC          | Database Connectivity   |
| MySQL         | Database Management     |
| HTML          | Web Page Structure      |
| CSS           | Styling                 |
| JavaScript    | Frontend Interactivity  |
| Apache Tomcat | Web Server              |
| Maven         | Project Management      |
| IntelliJ IDEA | Development Environment |

## 📂 Project Structure

```text
EVChargingSystem/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/evcharging/
│       │       ├── controller/
│       │       ├── dao/
│       │       ├── model/
│       │       └── util/
│       │
│       └── webapp/
│           ├── WEB-INF/
│           ├── image/
│           ├── index.jsp
│           ├── login.jsp
│           ├── register.jsp
│           ├── booking.jsp
│           ├── dashboard.jsp
│           ├── stations.jsp
│           └── styles.css
│
├── pom.xml
├── .gitignore
└── README.md
```

## ⚙️ Installation and Setup

### Prerequisites

* Java JDK
* IntelliJ IDEA
* Apache Tomcat
* MySQL Server
* Maven

### Steps to Run the Project

1. Clone the repository.

2. Open the project in IntelliJ IDEA.

3. Configure the MySQL database.

4. Update database connection details in the DBConnection.java file.

5. Load the required database tables and data.

6. Configure Apache Tomcat.

7. Build the project using Maven.

8. Run the application on the Tomcat server.

9. Open the application in your browser.

## 👨‍💻 Development Team

This project is developed collaboratively by a team of four members.

| Member             | Responsibility                     |
| ------------------ | ---------------------------------- |
| Tapas Ranjan Sahoo | Backend Development and Database   |
| Roshon maharana    |Authentication and User Management  |
| Chandan Tarei      | Frontend Development               |
| Omm Narayan        | Booking Module and Logout          |

## 🔮 Future Enhancements

* Online payment integration.
* Real-time charging slot availability.
* Google Maps API integration.
* Mobile application integration.
* EV charging station recommendations.

## 📄 License

This project is developed for academic and educational purposes.
