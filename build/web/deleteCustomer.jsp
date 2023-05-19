<%-- 
    Document   : deleteCustomer
    Created on : 19-May-2023, 12:22:52 pm
    Author     : anujv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.model.dba.MyConnection"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.*"%>

<%
    JSONArray list = new JSONArray();
    int customerId=Integer.parseInt(request.getParameter("CustomerId"));

    Connection connection;
    PreparedStatement ps;
    JSONObject obj = new JSONObject();
    try{
        connection = MyConnection.getConnection();
        ps = connection.prepareStatement("Delete from customerpersonaldetails where CustomerId=?");
        ps.setInt(1, customerId);

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
