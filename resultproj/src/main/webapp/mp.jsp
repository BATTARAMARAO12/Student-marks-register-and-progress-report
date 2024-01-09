<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Process Results</title>
</head>
<body>
    <%
        // Database connection parameters
        String jdbcUrl = "jdbc:oracle:thin:@BRAMARAO:1521:XE";
        String dbUser = "system";
        String dbPassword = "root";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Get form data from request parameters
            String rollNumber = request.getParameter("ROLL_NUMBER");
            String semester = request.getParameter("SEM");
            String name = request.getParameter("NAME");
            double subject1 = Double.parseDouble(request.getParameter("SUBJECT1"));
            double subject2 = Double.parseDouble(request.getParameter("SUBJECT2"));
            double subject3 = Double.parseDouble(request.getParameter("SUBJECT3"));
            double subject4 = Double.parseDouble(request.getParameter("SUBJECT4"));
            double subject5 = Double.parseDouble(request.getParameter("SUBJECT5"));
            double subject6 = Double.parseDouble(request.getParameter("SUBJECT6"));

            // Prepare the SQL INSERT statement
            String sql = "INSERT INTO RESULTS (ROLL_NUMBER, SEM, NAME, SUBJECT1, SUBJECT2, SUBJECT3, SUBJECT4, SUBJECT5, SUBJECT6) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, rollNumber);
            pstmt.setString(2, semester);
            pstmt.setString(3, name);
            pstmt.setDouble(4, subject1);
            pstmt.setDouble(5, subject2);
            pstmt.setDouble(6, subject3);
            pstmt.setDouble(7, subject4);
            pstmt.setDouble(8, subject5);
            pstmt.setDouble(9, subject6);

            // Execute the INSERT statement
            int rowsInserted = pstmt.executeUpdate();

            // Check if the data was successfully inserted
            if (rowsInserted > 0) {
                out.println("<h2>marks  inserted successfully.</h2>");
            } else {
                out.println("<h2>Error inserting data.</h2>");
            }
        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        } finally {
            // Close resources
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    %>
</body>
</html>
