<%-- 
    Document   : editCustomer
    Created on : 15-May-2023, 6:03:59 pm
    Author     : anujv
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.model.dba.MyConnection"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    JSONArray list = new JSONArray();
    Connection connection = MyConnection.getConnection();
    PreparedStatement ps;
    ResultSet rs;

    int CustomerId = Integer.parseInt(request.getParameter("CustomerId"));
    ps = connection.prepareStatement("select CustomerId,CustomerName,CustomerEmail,CustomerGender,CustomerPhone from customerpersonaldetails where CustomerId=?");
    ps.setInt(1, CustomerId);
    rs = ps.executeQuery();

    if (rs.next() == true) {
        int CustomerIdGetFromDB = rs.getInt(1);
        String CustomerNameGetFromDB = rs.getString(2);
        String CustomerEmailGetFromDB = rs.getString(3);
        String CustomerGenderGetFromDB = rs.getString(4);
        String CustomerPhoneGetFromDB = rs.getString(5);
        JSONObject obj = new JSONObject();
        obj.put("CustomerIdGetFromDB", CustomerIdGetFromDB);
        obj.put("CustomerNameGetFromDB", CustomerNameGetFromDB);
        obj.put("CustomerEmailGetFromDB", CustomerEmailGetFromDB);
        obj.put("CustomerGenderGetFromDB", CustomerGenderGetFromDB);
        obj.put("CustomerPhoneGetFromDB", CustomerPhoneGetFromDB);
        list.add(obj);
    }
    
    out.print(list.toJSONString());
    out.flush();
%>
