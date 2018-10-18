package com.globant.bootcamp;

import java.sql.*;

public class ConnectionToDB {
    private Connection conn;
    //private static final String driver = "com.mysql.jdbc.Driver";
    private static final String user = "root";
    private static final String password = "password";
    private static final String url = "jdbc:mysql://db:3306/highSchoolDb";
    
    public ConnectionToDB(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url,user,password);
            if (conn != null){
                System.out.println("Successful connection");
            }
        } catch (Exception e) {
            System.out.println("Connection ERROR" + e);
        }
    }
    
    public Connection getConnection() {
        return conn;
    }
    
    public void Dissconnect() {
        conn = null;
        if (conn == null) {
            System.out.println("Connection finished");
        }
    }
}