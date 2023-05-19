<%-- 
    Document   : updateCustomer
    Created on : 15-May-2023, 7:03:07 pm
    Author     : anujv
--%>

<%@page import="com.model.dba.MyConnection"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    JSONArray list = new JSONArray();
    int customerId=Integer.parseInt(request.getParameter("CustomerId"));
    String customerName = request.getParameter("customername");
    String customerEmail = request.getParameter("customeremail");
    String customerGender = request.getParameter("customergender");
    String customerPhone = request.getParameter("customerphone");

    Connection connection;
    PreparedStatement ps;
    ResultSet rs;
    JSONObject obj = new JSONObject();
    try{
        connection = MyConnection.getConnection();
        ps = connection.prepareStatement("update customerpersonaldetails set CustomerName=?,CustomerEmail=?,CustomerGender=?,CustomerPhone=? where CustomerId=?");
        ps.setString(1, customerName);
        ps.setString(2, customerEmail);
        ps.setString(3, customerGender);
        ps.setString(4, customerPhone);
        ps.setInt(5, customerId);
        ps.executeUpdate();
        obj.put("name", "success");
        list.add(obj);
        out.println(list.toJSONString());  
        out.flush();

    } catch (Exception e)
    {
        e.printStackTrace();
    }


%>
