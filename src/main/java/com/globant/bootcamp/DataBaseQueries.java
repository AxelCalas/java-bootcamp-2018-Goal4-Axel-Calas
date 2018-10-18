package com.globant.bootcamp;

import java.sql.*;

public class DataBaseQueries {
    private static Connection conn;
    private Statement stmt;
    
    public void printTeachers() {
        try {
            ConnectionToDB conne = new ConnectionToDB();
            conn = conne.getConnection();
            stmt = conn.createStatement();
        
            String query = "SELECT first_name,last_name FROM Teacher";
            ResultSet rs;
        
            rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                String fn = rs.getString("first_name");
                String ln = rs.getString("last_name");
                System.out.println(ln + ", " + fn); 
            }
            
        } catch (SQLException e) {  e.printStackTrace(); }
    }
    
    public void printTeacherShedule() {
        try {
            ConnectionToDB conne = new ConnectionToDB();
            conn = conne.getConnection();
            stmt = conn.createStatement();
            ResultSet rs;
            String query;
            String str;

            String queryTeachers = "SELECT DISTINCT assigned_teacher FROM Weekly_Diagram " + 
                        "INNER JOIN Course ON Weekly_Diagram.course_id2 = course_id";
            
            rs = stmt.executeQuery(queryTeachers);
            int numTeachers = 0;
            while (rs.next()) {
                numTeachers ++;
            }
            
            int count = 1;
            while (count <= numTeachers) {
                query = "SELECT DISTINCT first_name,last_name FROM Weekly_Diagram " + 
                        "INNER JOIN Course ON Weekly_Diagram.course_id2 = course_id " +
                        "INNER JOIN Teacher ON Course.assigned_teacher = id WHERE id = " + count;
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    str = rs.getString("last_name");
                    str = str + ", " + rs.getString("first_name");
                    System.out.println("Teacher: " + str + "\n");
                }                   
                
                query = "SELECT course_name,day_of_week,start_time,ending_time FROM Weekly_Diagram " + 
                        "INNER JOIN Course ON Weekly_Diagram.course_id2 = course_id " +
                        "WHERE assigned_teacher = " + count + " ORDER BY day_of_week";
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    str = rs.getString("day_of_week");
                    str = str + " " + rs.getString("start_time");
                    str = str + " - " + rs.getString("ending_time");
                    str = str + "  Course: " + rs.getString("course_name");
                    System.out.println(str + "\n");
                }    
                
                count ++;
            }
        } catch (SQLException e) {  e.printStackTrace(); }
    }
}
