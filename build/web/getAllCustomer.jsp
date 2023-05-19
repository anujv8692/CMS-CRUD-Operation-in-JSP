<%-- 
    Document   : getallcustomer
    Created on : 12-May-2023, 1:52:27 pm
    Author     : anujv
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.model.dba.MyConnection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    JSONArray list = new JSONArray();
    Connection connection = MyConnection.getConnection();
    ResultSet rs;

    
    String query = "select * from customerpersonaldetails";
    Statement statement = connection.createStatement();
    rs = statement.executeQuery(query);
    
    while (rs.next()) {        
        JSONObject obj=new JSONObject();
        String id= String.valueOf(rs.getInt("CustomerId"));
        String name=rs.getString("CustomerName");
        String email=rs.getString("CustomerEmail");
        String gender=rs.getString("CustomerGender");
        String phone=rs.getString("CustomerPhone");
        
        obj.put("id", id);
        obj.put("name", name);
        obj.put("email", email);
        obj.put("gender", gender);
        obj.put("phone", phone);
        
        list.add(obj);
        
    }
        out.println(list.toJSONString());
        out.flush();
    

%>

