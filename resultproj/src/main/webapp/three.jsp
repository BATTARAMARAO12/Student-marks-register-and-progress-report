<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.Statement,java.sql.ResultSet,java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sample JSP Page with Oracle JDBC and SELECT Query</title>
</head>
<body>
    <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Load the Oracle JDBC driver (assuming it's in the classpath)
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Define your database connection details
            String url = "jdbc:oracle:thin:@BRAMARAO:1521:XE"; // Replace with your Oracle service name and host:port
            String username = "system";
            String password = "root";

            // Create a database connection
            con = DriverManager.getConnection(url, username, password);
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT * FROM t1"); // Use the correct table name and column names

            // Process the result set (e.g., display data)
            while (rs.next()) {
                String columnName1 = rs.getString("name");

                // Output the result
                out.println("Column 1: " + columnName1 + "<br>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Log the error and provide a user-friendly message
            e.printStackTrace();
            out.println("Error: Unable to retrieve data. Please try again later.");
        } finally {
            // Close resources in the reverse order they were opened
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
