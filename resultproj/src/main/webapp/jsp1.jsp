<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Query Result</title>
   
   
</head>
<body>
<%
    // Initialize variables
    int s1 = 0, s2 = 0, s3 = 0, s4 = 0, s5 = 0, s6 = 0;
    float p = 0;
    String grade = "";

    // Get form data
    String name = request.getParameter("username");
    String ht = request.getParameter("hallticket");
    String sem = request.getParameter("exam");

    // Database connection details
    String jdbcUrl = "jdbc:oracle:thin:@BRAMARAO:1521:XE";
    String dbUser = "system";
    String dbPassword = "root";

    // Execute the query
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        Statement statement = connection.createStatement();
        String query = "SELECT * FROM results WHERE name='" + name + "' AND roll_number='" + ht + "' and sem='" + sem + "'";
        ResultSet resultSet = statement.executeQuery(query);

        // Display query result
        while (resultSet.next()) {
            s1 = resultSet.getInt("subject1");
            s2 = resultSet.getInt("subject2");
            s3 = resultSet.getInt("subject3");
            s4 = resultSet.getInt("subject4");
            s5 = resultSet.getInt("subject5");
            s6 = resultSet.getInt("subject6");
        }

        // Calculate average and grade
        p = (s1 + s2 + s3 + s4 + s5 + s6) / 6;

        if (p > 90) {
            grade = "O"; // Assuming "O" represents the top grade
        } else if (p >= 80) {
            grade = "A+";
        } else if (p >= 70) {
            grade = "A";
        } else if (p >= 60) {
            grade = "B+";
        } else if (p >= 50) {
            grade = "B";
        } else if (p >= 40) {
            grade = "C";
        } else {
            grade = "FAIL";
        }

        // Close resources
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
%>

<!-- Display the result -->
<table border="2"  align="center"  bgcolor="#43A6C6"  style="width:25%">
<th>results</th>
<tr><td>Name</td><td> <%= name %></td></tr><br>
<tr><td>Hall Ticket: </td><td><%= ht %></td></tr><br>
<tr><td>Semester: </td><td><%= sem %></td></tr><br>
<tr><td>Subject 1:</td><td> <%= s1 %></td></tr><br>
<tr><td>Subject 2:</td><td> <%= s2 %></td></tr><br>
<tr><td>Subject 3: </td><td><%= s3 %></td></tr><br>
<tr><td>Subject 4: </td><td><%= s4 %></td></tr><br>
<tr><td>Subject 5:</td><td> <%= s5 %></td></tr><br>
<tr><td>Subject 6:</td><td> <%= s6 %></td></tr><br>
<tr><td>Average:</td><td> <%= p %></td></tr><br>
<tr><td>Grade: </td><td><%= grade %></td></tr>
</table>
</body>
</html>
