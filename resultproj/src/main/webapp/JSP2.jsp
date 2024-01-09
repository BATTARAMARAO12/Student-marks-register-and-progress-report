<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Query Result</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        h2 {
            text-align: center;
            color: #333;
        }
    </style>
</head>
<body>
<%
    // Initialize variables
    int count = 0;
    int s1 = 0, s2 = 0, s3 = 0, s4 = 0, s5 = 0, s6 = 0;
    float p = 0,tp=0;
    String grade = "";
    String sem = "";
    String tg = " ";

    // Get form data (hard-coded for demonstration)
    String name = request.getParameter("username");
    String ht = request.getParameter("hallticket");
    
    // Database connection details
    String jdbcUrl = "jdbc:oracle:thin:@BRAMARAO:1521:XE";
    String dbUser = "system";
    String dbPassword = "root";

    // Execute the query
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        Statement statement = connection.createStatement();
        String query = "SELECT * FROM results natural join student_info WHERE name='" + name + "' AND roll_number='" + ht + "'ORDER BY SEM";
        ResultSet resultSet = statement.executeQuery(query);

        // Display query result
        out.println("<h2>Student Information</h2>");
        out.println("<table>");
        out.println("<tr><th>Name</th><th>Branch</th><th>Rollnumber</th></tr>");
        
        while (resultSet.next()) {
            if (count == 1) {
                out.println("<tr>");
                out.println("<td>" + resultSet.getString("name") + "</td>");
                out.println("<td>" + resultSet.getString("branch") + "</td>");
                out.println("<td>" + resultSet.getString("rollnumber") + "</td>");
                out.println("</tr>");
            }
            count++;
        }
        out.println("</table>");

        // Loop through semesters
        
        for (int i = 1; i <= count; i++) {
           
            
            if (i == 1) {
                sem = "11";
            } else if (i == 2) {
                sem = "12";
            } else if (i == 3) {
                sem = "21";
            } else if (i == 4) {
                sem = "22";
            } else if (i == 5) {
                sem = "31";
            } else if (i == 6) {
                sem = "32";
            } else if (i == 7) {
                sem = "41";
            } else if (i == 8) {
                sem = "42";
            }
            out.println("<table>");
            out.println("<h2>Semester " + sem + " Results</h2>");
            out.println("<tr><th>Subject</th><th>Score</th></tr>");
            // Add conditions for other semesters here

            String query1 = "SELECT * FROM results WHERE name='" + name + "' AND roll_number='" + ht + "' and sem='" + sem + "'";
            ResultSet rs = statement.executeQuery(query1);

            // Display query result for the current semester
            while (rs.next()) {
                s1 = rs.getInt("subject1");
                s2 = rs.getInt("subject2");
                s3 = rs.getInt("subject3");
                s4 = rs.getInt("subject4");
                s5 = rs.getInt("subject5");
                s6 = rs.getInt("subject6");

                // Calculate average and grade
                p = (s1 + s2 + s3 + s4 + s5 + s6) / 6;
                tp=tp+p;

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
                out.println("<tr>");
                out.println("<td>Subject 1</td>");
                out.println("<td>" + s1 + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Subject 2</td>");
                out.println("<td>" + s2 + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Subject 3</td>");
                out.println("<td>" + s3 + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Subject 4</td>");
                out.println("<td>" + s4 + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Subject 5</td>");
                out.println("<td>" + s5 + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Subject 6</td>");
                out.println("<td>" + s6 + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Percentage</td>");
                out.println("<td>" + p + "</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Grade</td>");
                out.println("<td>" + grade + "</td>");
                out.println("</tr>");
                out.println("</table>");

                // Reset variables for the next iteration
                s1 = 0;
                s2 = 0;
                s3 = 0;
                s4 = 0;
                s5 = 0;
                s6 = 0;
                p = 0;
                grade = "";
            }
        }

        // Close resources
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
if (count==8){
	tp=tp/8;
	if (p > 90) {
        grade = "O"; // Assuming "O" represents the top grade
    } else if (tp >= 80) {
        tg = "A+";
    } else if (tp >= 70) {
        grade = "A";
    } else if (tp >= 60) {
        tg = "B+";
    } else if (tp >= 50) {
        tg = "B";
    } else if (tp >= 40) {
        tg = "C";
    } else {
        tg = "FAIL";
    }
	
}
out.println("<table>");
out.println("<tr>");
out.println("<td>overall percentage</td>");
out.println("<td>" + tp + "</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>overall grade</td>");
out.println("<td>" + tg+ "</td>");
out.println("</tr>");

    // Output the count
    
%>
</body>
</html>
