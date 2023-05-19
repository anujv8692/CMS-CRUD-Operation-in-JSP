package com.model.dba;

import java.sql.*;

public class MyConnection {

    public static Connection getConnection() {
        Connection connection = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/crudjsp", "root", "Root@123");

        } catch (Exception e){
            e.printStackTrace();
        }
        return connection;
    }

}
