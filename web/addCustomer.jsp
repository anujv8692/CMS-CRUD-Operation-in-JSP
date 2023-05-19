<%-- 
    Document   : add
    Created on : 06-May-2023, 6:07:41 pm
    Author     : anujv
--%>

<%@page import="com.model.dba.MyConnection"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <%
            JSONArray list = new JSONArray();
            String customerName = request.getParameter("customername");
            String customerEmail = request.getParameter("customeremail");
            String customerGender = request.getParameter("customergender");
            String customerPhone = request.getParameter("customerphone");

            Connection connection;
            PreparedStatement ps;
            ResultSet rs;
            JSONObject obj = new JSONObject();
            try
            {
                connection=MyConnection.getConnection();
                ps = connection.prepareStatement("insert into customerpersonaldetails(CustomerName,CustomerEmail,CustomerGender,CustomerPhone)values(?,?,?,?)");
                ps.setString(1, customerName);
                ps.setString(2, customerEmail);
                ps.setString(3, customerGender);
                ps.setString(4, customerPhone);
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

