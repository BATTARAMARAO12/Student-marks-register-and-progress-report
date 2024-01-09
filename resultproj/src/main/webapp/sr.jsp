<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Student Information</title>
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
            String rollnumber = request.getParameter("rollnumber");
            String name = request.getParameter("name");
            String branch = request.getParameter("branch");
            String start_date = request.getParameter("start_date");
            String end_date = request.getParameter("end_date");
            String father_name = request.getParameter("father_name");
            String contact_number = request.getParameter("contact_number");
            String email = request.getParameter("email");
            String father_contact_number = request.getParameter("father_contact_number");
            String adhar_number = request.getParameter("adhar_number");
            String class_10_hall_ticket_number = request.getParameter("class_10_hall_ticket_number");
            double class_10_percentage = Double.parseDouble(request.getParameter("class_10_percentage"));
            double inter_percentage = Double.parseDouble(request.getParameter("inter_percentage"));

            // Prepare the SQL INSERT statement
            String sql = "INSERT INTO STUDENT_INFO (ROLLNUMBER, NAME, BRANCH, START_DATE, END_DATE, FATHER_NAME, CONTACT_NUMBER, EMAIL, FATHER_CONTACT_NUMBER, ADHAR_NUMBER, CLASS_10_HALL_TICKET_NUMBER, CLASS_10_PERCENTAGE, INTER_PERCENTAGE) VALUES (?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, rollnumber);
            pstmt.setString(2, name);
            pstmt.setString(3, branch);
            pstmt.setString(4, start_date);
            pstmt.setString(5, end_date);
            pstmt.setString(6, father_name);
            pstmt.setString(7, contact_number);
            pstmt.setString(8, email);
            pstmt.setString(9, father_contact_number);
            pstmt.setString(10, adhar_number);
            pstmt.setString(11, class_10_hall_ticket_number);
            pstmt.setDouble(12, class_10_percentage);
            pstmt.setDouble(13, inter_percentage);

            // Execute the INSERT statement
            int rowsInserted = pstmt.executeUpdate();

            // Check if the data was successfully inserted
            if (rowsInserted > 0) {
                out.println("<h2>Registered successfully.</h2>");
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
