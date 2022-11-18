<%-- 
    Document   : header
    Created on : Sep 30, 2022, 12:40:09 AM
    Author     : Truong Giang
--%>
<%@page import="cart.CartDTO"%>
<%@page import="cart.Cart"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>SALANGANES' NESTS</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
        <link rel="stylesheet" href="css/animate.css">

        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">

        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/ionicons.min.css">

        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="css/jquery.timepicker.css">


        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/icomoon.css">
        <link rel="stylesheet" href="css/Style.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <div class="py-1 bg-primary">
            <div class="container">
                <div class="row no-gutters d-flex align-items-start align-items-center px-md-0">
                    <div class="col-lg-12 d-block">
                        <div class="row d-flex">
                            <div class="col-md-3 pr-3 d-flex topper align-items-center">
                                <div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-phone2"></span></div>
                                <span class="text">+ 1235 2355 98</span>
                            </div>
                            <div class="col-md-3 pr-3 d-flex topper align-items-center">
                                <div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-paper-plane"></span></div>
                                <span class="text">yensaorachgia@email.com</span>
                            </div>
                            <div class="col-md-3 pr-3 d-flex topper align-items-center text-lg-right">
                                <span class="text">Express delivery in 2 hours</span>
                            </div>
                            <div class="col-md-3 pr-3 d-flex topper align-items-center text-lg-right">
                                <span class="text">Return &amp; Exchange in 7 days</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="homePage.jsp">SALANGANES' NESTS</a>
                <div class="sidebar-box1">
                    <form action="#" class="search-form">
                        <div class="form-group">
                            <span class="icon ion-ios-search"></span>
                            <input type="text" class="form-control" placeholder="What do you need?...">
                        </div>
                    </form>
                </div>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>
                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active"><a href="homePage.jsp" class="nav-link">Home</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Shop</a>
                            <div class="dropdown-menu" aria-labelledby="dropdown04">
                                <a class="dropdown-item" href="MainController?action=Shopping">Shop</a>
                                <a class="dropdown-item" href="MainController?action=WishList">Wishlist</a>
                                <c:if test="${sessionScope.CUSTOMER_LOGIN != null }">
                                    <a class="dropdown-item" href="MainController?action=ViewCart&cusID=${sessionScope.CUSTOMER_LOGIN.id}">Cart</a>
                                </c:if>
                                <a class="dropdown-item" href="checkout.jsp">Checkout</a>
                            </div>
                        </li>
                        <li class="nav-item"><a href="MainController?action=Blog" class="nav-link">Blog</a></li>
                        <li class="nav-item"><a href="contact.jsp" class="nav-link">Contact</a></li>
                            <c:if test="${sessionScope.CUSTOMER_LOGIN != null }">
                                <% Cart c = (Cart) session.getAttribute("CART");
                                    int count = 0;
                                    if (c != null) {
                                        for (CartDTO ct : c.getCart().values()) {
                                            count++;
                                        }
                                    }

                                %>
                            <li class="nav-item cta cta-colored"><a href="MainController?action=ViewCart&cusID=${sessionScope.CUSTOMER_LOGIN.id}" class="nav-link"><span class="icon-shopping_cart"></span>[<%=count%>]</a></li>
                            </c:if>
                            <c:if test="${sessionScope.CUSTOMER_LOGIN == null }">

                            <li class="nav-item cta cta-colored"><a href="login.jsp" class="nav-link"><span class="icon-shopping_cart"></span>[0]</a></li>
                            </c:if>    
                            <c:if test="${sessionScope.CUSTOMER_LOGIN == null }">
                            <li class="nav-item"><a href="login.jsp" class="nav-link">Login</a></li>
                            </c:if>   
                            <c:if test="${sessionScope.CUSTOMER_LOGIN != null }">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${sessionScope.CUSTOMER_LOGIN.name}</a>
                                <div class="dropdown-menu" aria-labelledby="dropdown04">
                                    <a class="dropdown-item" href="customerProfile.jsp">Profile </a>
                                    <a class="dropdown-item" href="MainController?action=ViewPurchase&cusID=${sessionScope.CUSTOMER_LOGIN.id}">My Purchase </a>
                                    <a class="dropdown-item" href="MainController?action=Logout">Logout</a>
                                </div>
                            </li>
                        </c:if>  
                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>
