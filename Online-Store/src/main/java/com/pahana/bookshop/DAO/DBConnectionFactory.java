package com.pahana.bookshop.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionFactory {

    private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/pahanaDB";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";


    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ JDBC Driver loaded");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ JDBC Driver not found.");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
    
    
}
