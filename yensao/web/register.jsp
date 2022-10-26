<%-- 
    Document   : register
    Created on : Sep 19, 2022, 3:11:18 PM
    Author     : lequa
--%>

<%@page import="customer.dto.CustomerError"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="fonts1/icomoon/style.css">

        <link rel="stylesheet" href="css1/owl.carousel.min.css">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css1/bootstrap.min.css">

        <!-- Style -->
        <link rel="stylesheet" href="css1/style.css">

        <title>Login</title>
    </head>
    <body>
         <% CustomerError cusError = (CustomerError) session.getAttribute("CUS_ERROR");
            if (cusError == null) {
                cusError = new CustomerError();
                cusError.setName("");
                cusError.setPassword("");
                cusError.setEmail("");
            }
        %>
        <jsp:include page="header.jsp"/>
        <div class="d-lg-flex half">
            <div class="bg order-1 order-md-2" style="background-image: url('images/banner_login.png');"></div>
            <div class="contents order-2 order-md-1">

                <div class="container">
                    <div class="row align-items-center justify-content-center">
                        <div class="col-md-7">
                            <div class="mb-4">
                                <h3>Sign In</h3>
                                <p class="mb-4">or <a href="register.jsp">Create account</a></p>
                            </div>
                            <form action="MainController" method="post">
                                <div class="form-group first">
                                    <label for="username"></label>
                                    <input type="text" name="name" placeholder="Your name" class="form-control" required="">
                                </div>
                                 <%= cusError.getName()%>
                                <div class="form-group last mb-3">
                                    <label for="password"></label>
                                    <input type="password" name="password" placeholder="Password" class="form-control" required="">           
                                </div>
                                 <%= cusError.getPassword()%>
                                 <div class="form-group last mb-3">
                                    <label for="confirm"></label>
                                    <input type="password" name="confirm" placeholder="Confirm password" class="form-control" required="">                                    
                                </div>
                                <%= cusError.getEmail()%>
                                <div class="form-group first">
                                    <label for="gender"></label>
                                    <select name="gender">
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                        <option value="other">Other</option>
                                    </select>
                                </div>
                                <div class="form-group first">
                                    <label for="email"></label>
                                    <input type="text" name="email"  placeholder="Your email" class="form-control" required="">
                                </div>
<!--                                <div class="form-group first">
                                    <label for="address"></label>
                                    <input type="text" name="txtaddress" maxlength="100" placeholder="Your address" class="form-control" required="">
                                </div>-->
                                

                                

                                <input type="submit" value="Register" name="action" class="btn btn-block btn-primary">

                                <tr>Having an account? <a href="login.jsp"> Click here to login</a></tr>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <jsp:include page="footer.jsp"/>
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>