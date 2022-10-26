<%-- 
    Document   : customer
    Created on : Sep 19, 2022, 3:11:39 PM
    Author     : lequa
--%>

<%@page import="customer.dto.Customer"%>
<%@page import="google.GoogleDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Page</title>
    </head>
    <body>


        <%
            Customer cus1 = (Customer) request.getAttribute("CUSTOMER_LOGIN");
            Customer cus2 = (Customer) request.getAttribute("GOOGLE_LOGIN");
            Customer cus3 = (Customer) request.getAttribute("GOOGLE_REGISTER");
            if (cus1 != null) {
        %>
        <%= cus1.getName()%>
        <%= cus1.getPassword()%>
        <%= cus1.getGender()%>
        <img src="<%= cus1.getAvatar()%>" />
        <% } else if (cus2 != null) {%>
        <%= cus2.getName()%>
        <%= cus2.getEmail()%>
        <%= cus2.getGender()%>
        <img src="<%= cus2.getAvatar()%>" />
        <% } else if (cus3 != null) {%>
        <%= cus3.getName()%>
        <%= cus3.getEmail()%>
        <%= cus3.getGender()%>
        <img src="<%= cus3.getAvatar()%>" />
        <% }%>
    </body>
</html>
