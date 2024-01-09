<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Query Result</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: #fff;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <% 
    String rollnumber = request.getParameter("hallticket");
    
    String jdbcUrl = "jdbc:oracle:thin:@BRAMARAO:1521:XE";
    String dbUser = "system";
    String dbPassword = "root";
    
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        Statement statement = connection.createStatement();
        String query = "SELECT * FROM student_info WHERE rollnumber='" + rollnumber + "'";
        ResultSet resultSet = statement.executeQuery(query);
        
        if (resultSet.next()) {
    %>
    <div>
        <h2>Student details</h2>
        <table>
            <tr>
                <th>Name</th>
                <td><%= resultSet.getString("name") %></td>
            </tr>
            <tr>
                <th>Roll number</th>
                <td><%= resultSet.getString("rollnumber") %></td>
            </tr>
            <tr>
                <th>Branch</th>
                <td><%= resultSet.getString("branch") %></td>
            </tr>
            <tr>
                <th>Number</th>
                <td><%= resultSet.getString("contact_number") %></td>
            </tr>
            <tr>
                <th>E-mail</th>
                <td><%= resultSet.getString("email") %></td>
            </tr>
            <tr>
                <th>Academic start</th>
                <td><%= resultSet.getDate("start_date") %></td>
            </tr>
            <tr>
                <th>Academic end</th>
                <td><%= resultSet.getDate("end_date") %></td>
            </tr>
            <tr>
                <th>Adhar number</th>
                <td><%= resultSet.getString("adhar_number") %></td>
            </tr>
            <tr>
                <th>10<sup>th</sup> hall ticket number</th>
                <td><%= resultSet.getString("class_10_hall_ticket_number") %></td>
            </tr>
            <tr>
                <th>10th percentage</th>
                <td><%= resultSet.getFloat("class_10_percentage") %></td>
            </tr>
            <tr>
                <th>Inter percentage</th>
                <td><%= resultSet.getFloat("inter_percentage") %></td>
            </tr>
            <tr>
                <th>Father name</th>
                <td><%= resultSet.getString("father_name") %></td>
            </tr>
            <tr>
                <th>Father contact number</th>
                <td><%= resultSet.getString("father_contact_number") %></td>
            </tr>
        </table>
    </div>
    <%
        } else {
            out.println("<p>No student found with the provided hall ticket number.</p>");
        }
        
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
    %>
</body>
</html>
