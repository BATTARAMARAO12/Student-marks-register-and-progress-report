<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Query Result</title>
    <% 
    String name = request.getParameter("teachername");
    String password = request.getParameter("password");
    String jdbcUrl = "jdbc:oracle:thin:@BRAMARAO:1521:XE";
    String dbUser = "system";
    String dbPassword = "root";
    
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        Statement statement = connection.createStatement();
        String query = "SELECT * FROM faculty WHERE name='" + name + "'";
        ResultSet resultSet = statement.executeQuery(query);
        
        while (resultSet.next()) {
            String dbPasswordFromDB = resultSet.getString("PASSWORD");
            
            if (password.equals(dbPasswordFromDB)) {%>
                <jsp:forward page="fpage.html" />
                
           <%  } else {
                out.println("pleasse enter valid credentilas ");%>
                <a href="facultylogin.html"> login</a><%
            }
        }
        
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
    %>
</head>
</html>
