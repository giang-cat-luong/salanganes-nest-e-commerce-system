<%-- 
    Document   : login
    Created on : Sep 19, 2022, 3:11:03 PM
    Author     : lequa
--%>
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
                                    <input type="text" name="name" placeholder="Your email" class="form-control" ">

                                </div>
                                <div class="form-group last mb-3">
                                    <label for="password"></label>
                                    <input type="password" name="password" placeholder="Password" class="form-control" ">           
                                </div>

                                <div class="d-flex mb-5 align-items-center">
                                    <label class="control control--checkbox mb-0"><span class="caption">Remember me</span>
                                        <input type="checkbox" checked="checked"/>
                                        <div class="control__indicator"></div>
                                    </label>
                                    <span class="ml-auto"><a href="#" class="forgot-pass">Forgot Password</a></span> 
                                </div>

                                <input type="submit" value="Login" name="action" class="btn btn-block btn-primary">

                                <span class="d-block text-center my-4 text-muted">&mdash; or &mdash;</span>

                                <div class="social-login">
                                    <a href="#" class="facebook btn d-flex justify-content-center align-items-center">
                                        <span class="icon-facebook mr-3"></span> Login with Facebook
                                    </a>
                                    <a href="#" class="twitter btn d-flex justify-content-center align-items-center">
                                        <span class="icon-twitter mr-3"></span> Login with  Twitter
                                    </a>
                                    
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&redirect_uri=http://localhost:8084/YenSao/MainController?action=LoginGoogle&response_type=code
                                       &client_id=21869139590-10eceo92hka99ggo84toc28qmlod195b.apps.googleusercontent.com&approval_prompt=force" class="google btn d-flex justify-content-center align-items-center"><span class="icon-google mr-3"></span>Login With Google</a>
                                </div>
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