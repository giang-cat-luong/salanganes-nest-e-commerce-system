<%-- 
    Document   : showOrderDetail
    Created on : Sep 23, 2022, 11:08:19 PM
    Author     : lequa
--%>
<%@page import="others.OrderDetailDTO"%>
<%@page import="others.Voucher"%>
<%@page import="others.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Show order detail</title>

        <!-- Bootstrap -->
        <link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
        <link href="sellerPage/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="sellerPage/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="sellerPage/vendors/nprogress/nprogress.css" rel="stylesheet">
        <!-- iCheck -->
        <link href="sellerPage/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
        <!-- Datatables -->

        <link href="sellerPage/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
        <link href="sellerPage/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
        <link href="sellerPage/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
        <link href="sellerPage/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
        <link href="sellerPage/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

        <!-- Custom Theme Style -->
        <link href="sellerPage//build/css/custom.min.css" rel="stylesheet">
    </head>

    <body class="nav-md">
        <%
            ArrayList<OrderDTO> orl = (ArrayList<OrderDTO>) request.getAttribute("ORDER_LIST");
            ArrayList<OrderDetailDTO> ordl = (ArrayList<OrderDetailDTO>) request.getAttribute("ORDER_DETAIL_LIST");
        %>
        <div class="container body">
            <div class="main_container">
                <div class="col-md-3 left_col">
                    <div class="left_col scroll-view">
                        <div class="navbar nav_title" style="border: 0;">
                            <a href="index.html" class="site_title"><i class="fa fa-home"></i> <span>Seller Center</span></a>
                        </div>

                        <div class="clearfix"></div>

                        <!-- menu profile quick info -->
                        <div class="profile clearfix">
                            <div class="profile_pic">
                                <img src=${sessionScope.SELLER_LOGIN.avatar} alt="..." class="img-circle profile_img">
                            </div>
                            <div class="profile_info">
                                <span>Welcome,</span>
                                <c:if test="${sessionScope.SELLER_LOGIN != null}">
                                    <h2>${sessionScope.SELLER_LOGIN.name}</h2>            
                                </c:if>                               
                            </div>
                        </div>
                        <!-- /menu profile quick info -->

                        <br />

                        <!-- sidebar menu -->
                        <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
                            <div class="menu_section">
                                <h3>Management</h3>
                                <ul class="nav side-menu">
                                    <li><a><i class="fa fa-home"></i> Shop <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="profile.jsp">Shop profile</a></li>
                                            <li><a href="tables.html">Shop rating</a></li>
                                        </ul>
                                    </li>
                                    </li>
                                    <li><a><i class="fa fa-edit"></i> Order <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="MainController?action=ShowOrders&sellerID=${sessionScope.SELLER_LOGIN.id}">All orders</a></li>
                                            <li><a href="form_advanced.html">Cancellation</a></li>                                           
                                            <li><a href="form_advanced.html">Completed</a></li>                                           
                                        </ul>
                                    </li>
                                    <li><a><i class="fa fa-suitcase"></i> Product <span class="fa fa-chevron-down"></span></a>
                                        <ul class="nav child_menu">
                                            <li><a href="MainController?action=SellingPage&sellerID=${sessionScope.SELLER_LOGIN.id}">My products</a></li>
                                            <li><a href="newProduct.jsp">Add new product</a></li>                                           
                                        </ul>
                                    </li>

                                </ul>
                            </div>

                        </div>
                        <!-- /sidebar menu -->                  
                    </div>
                </div>

                <!-- top navigation -->
                <div class="top_nav">
                    <div class="nav_menu">
                        <div class="nav toggle">
                            <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                        </div>
                        <nav class="nav navbar-nav">
                            <ul class=" navbar-right">
                                <li class="nav-item dropdown open" style="padding-left: 15px;">
                                    <a href="profile.jsp" class="user-profile dropdown-toggle" aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown" aria-expanded="false">
                                        <img src=${sessionScope.SELLER_LOGIN.avatar} alt="">${sessionScope.SELLER_LOGIN.name}
                                    </a>
                                    <div class="dropdown-menu dropdown-usermenu pull-right" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item"  href="profile.jsp"> Profile</a>
                                        <a class="dropdown-item"  href="MainController?action=Logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                                    </div>
                                </li>

                                <li role="presentation" class="nav-item dropdown open">
                                    <a href="javascript:;" class="dropdown-toggle info-number" id="navbarDropdown1" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-envelope-o"></i>
                                        <span class="badge bg-green"></span>
                                    </a>
                                    <ul class="dropdown-menu list-unstyled msg_list" role="menu" aria-labelledby="navbarDropdown1">
                                        <li class="nav-item">
                                            <a class="dropdown-item">
                                                <span class="image"><img src="sellerPage/images/yasuo.jpg" alt="Profile Image" /></span>
                                                <span>
                                                    <span>Yasuo</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Death is like the wind, always by my side.
                                                </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="dropdown-item">
                                                <span class="image"><img src="sellerPage/images/yasuo.jpg" alt="Profile Image" /></span>
                                                <span>
                                                    <span>Yasuo</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Death is like the wind, always by my side.
                                                </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="dropdown-item">
                                                <span class="image"><img src="sellerPage/images/yasuo.jpg" alt="Profile Image" /></span>
                                                <span>
                                                    <span>Yasuo</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Death is like the wind, always by my side.
                                                </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="dropdown-item">
                                                <span class="image"><img src="sellerPage/images/yasuo.jpg" alt="Profile Image" /></span>
                                                <span>
                                                    <span>Yasuo</span>
                                                    <span class="time">3 mins ago</span>
                                                </span>
                                                <span class="message">
                                                    Death is like the wind, always by my side.
                                                </span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <div class="text-center">
                                                <a class="dropdown-item">
                                                    <strong>See All Alerts</strong>
                                                    <i class="fa fa-angle-right"></i>
                                                </a>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- /top navigation -->

                <!-- page content -->
                <div class="right_col" role="main">
                    <div class="">
                        <div class="page-title">
                            <div class="title_left">
                                <h3>Show Customer Orders Detail List </h3>
                            </div>

                            <div class="title_right">
                                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Search for...">
                                        <span class="input-group-btn">
                                            <button class="btn btn-secondary" type="button">Go!</button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>


                        <section class="ftco-section ftco-cart">
                            <form action="MainController" class="subscribe-form">
                                <div class="container">
                                    <% if (orl != null && ordl != null) {
                                            for (int i = 0; i < orl.size(); i++) {%> 
                                    <div class="row border" style="background-color: #fff; margin-top: 10px;border-radius: 10px inset ;border-radius: 10px;box-shadow: 5px 10px #f5f5f5;" >
                                        <div class="col-md-3 ftco-animate" style="margin: 15px 0px 10px 22px">
                                            <label for="Shop 123"><strong ><%= orl.get(i).getCusName()%></strong></label>
                                            <label for="Shop 123"><strong ><%= orl.get(i).getLoc()%></strong></label>
                                        </div>
                                        <div class="col-md-12 ftco-animate">
                                            <div class="cart-list">
                                                <table class="table">
                                                    <thead class="thead-primary">
                                                        <tr class="text-center">

                                                            <th>&nbsp;</th>
                                                            <th>Product name</th>
                                                            <th>Price</th>
                                                            <th>Quantity</th>
                                                            <th>Total</th>
                                                            <th>&nbsp;</th>
                                                        </tr>
                                                    </thead>

                                                    <%
                                                        for (int j = 0; j < ordl.size(); j++) {
                                                            if (ordl.get(j).getOrderID().equalsIgnoreCase(orl.get(i).getOrderID())) {%>
                                                    <tbody>
                                                        <tr class="text-center">

                                                            <td class="image-prod"><div class="img"><img src="<%= ordl.get(j).getImg()%>" width="100px" height="100px" /></div></td>
                                                            <td class="product-name">
                                                                <h3><%= ordl.get(j).getProductName()%></h3>

                                                            </td>
                                                            <td class="price"><%= ordl.get(j).getPrice()%> </td>
                                                            <td class="price"><%= ordl.get(j).getQuantity()%> </td>

                                                            <td class="price"><%= ordl.get(j).getQuantity() * ordl.get(j).getPrice()%></td>
                                                        </tr><!-- END TR-->
                                                    </tbody>
                                                    <%
                                                            }
                                                        }
                                                    %>

                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="orderID" value="<%= orl.get(i).getOrderID()%>"/>
                                    <input type="hidden" name="sellerID" value="${sessionScope.SELLER_LOGIN.id}"/>
                                    <input class="inputApprove float-right" type="submit" name="action" value="Delivery" style="margin: 0px 10px 20px 0px; width: 100px">

                                    <%
                                            }

                                        }
                                    %>

                                </div>
                            </form>
                        </section>
                        <!-- /page content -->                          
                    </div>
                </div>

                <!-- jQuery -->
                <script src="sellerPage/vendors/jquery/dist/jquery.min.js"></script>
                <!-- Bootstrap -->
                <script src="sellerPage/vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
                <!-- FastClick -->
                <script src="sellerPage/vendors/fastclick/lib/fastclick.js"></script>
                <!-- NProgress -->
                <script src="sellerPage/vendors/nprogress/nprogress.js"></script>
                <!-- iCheck -->
                <script src="sellerPage/vendors/iCheck/icheck.min.js"></script>
                <!-- Datatables -->
                <script src="sellerPage/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
                <script src="sellerPage/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
                <script src="sellerPage/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
                <script src="sellerPage/vendors/jszip/dist/jszip.min.js"></script>
                <script src="sellerPage/vendors/pdfmake/build/pdfmake.min.js"></script>
                <script src="sellerPage/vendors/pdfmake/build/vfs_fonts.js"></script>

                <!-- Custom Theme Scripts -->
                <script src="sellerPage/build/js/custom.min.js"></script>

                </body>
                </html> 
