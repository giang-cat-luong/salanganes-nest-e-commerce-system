<%-- 
    Document   : sellerPage
    Created on : Sep 23, 2022, 2:40:57 PM
    Author     : lequa
--%>
<%@page import="others.SellerInforRelative"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="images/favicon.ico" type="image/ico" />

        <title>Seller Page</title>

        <!-- Bootstrap -->
        <link href="sellerPage/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="sellerPage/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="sellerPage/vendors/nprogress/nprogress.css" rel="stylesheet">
        <!-- iCheck -->
        <link href="sellerPage/vendors/iCheck/skins/flat/green.css" rel="stylesheet">

        <!-- bootstrap-progressbar -->
        <link href="sellerPage/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
        <!-- JQVMap -->
        <link href="sellerPage/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
        <!-- bootstrap-daterangepicker -->
        <link href="sellerPage/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

        <!-- Custom Theme Style -->
        <link href="sellerPage/build/css/custom.min.css" rel="stylesheet">
    </head>

    <body class="nav-md">
        <%  SellerInforRelative sir = (SellerInforRelative) session.getAttribute("SELLER_INFOR_RELATIVE");%>
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
                                            <li><a href="sellerPage.jsp">Shop rating</a></li>
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
                    <!-- top tiles -->
                    <div class="row" style="display: inline-block;" >
                        <div class="tile_count">
                            <div class="col-md-3 col-sm-4  tile_stats_count">
                                <span class="count_top"><i class="fa fa-user"></i> Total Products</span>
                                <div class="count">  <%= sir.getTotalProduct()%>  </div>

                            </div>
                            <div class="col-md-3 col-sm-4  tile_stats_count">
                                <span class="count_top"><i class="fa fa-clock-o"></i> Total Sold</span>
                                <div class="count"><%= sir.getTotalSold()%></div>

                            </div>
                            <div class="col-md-3 col-sm-4  tile_stats_count">
                                <span class="count_top"><i class="fa fa-user"></i> Total Profit</span>
                                <div class="count green"><%= sir.getTotalFrofit()%><i class="fa fa-dollar"></i></div>

                            </div>
                            <div class="col-md-3 col-sm-4  tile_stats_count">
                                <span class="count_top"><i class="fa fa-user"></i> Average Rate</span>
                                <%  float roundAverage = Math.round(sir.getAverageRate());%>
                                <div class="count red"><%= roundAverage%> <i class="fa fa-star"></i></div>
                            </div>
                            <div class="col-md-3 col-sm-4  tile_stats_count">
                                <span class="count_top"><i class="fa fa-user"></i> Total Comments</span>
                                <div class="count"><%= sir.getTotalComment()%></div>

                            </div>
                        </div>
                    </div>
                    <!-- /top tiles -->

                    <div class="row">
                        <div class="col-md-12 col-sm-12 ">
                            <div class="dashboard_graph">

                                <div class="row x_title">
                                    <div class="col-md-6">
                                        <h3>Selling Activities </h3>
                                    </div>
                                    <div class="col-md-6">
                                        <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                                            <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                            <span>December 30, 2014 - January 28, 2015</span> <b class="caret"></b>
                                        </div>
                                    </div>
                                </div>


                                <div class="col-md-3 col-sm-3  bg-white">
                                    <div class="x_title">
                                        <h2>Top Campaign Performance</h2>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="col-md-12 col-sm-12 ">
                                        <div>
                                            <p>Facebook Campaign</p>
                                            <div class="">
                                                <div class="progress progress_sm" style="width: 76%;">
                                                    <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="0"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <p>Twitter Campaign</p>
                                            <div class="">
                                                <div class="progress progress_sm" style="width: 76%;">
                                                    <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="0"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 col-sm-12 ">
                                        <div>
                                            <p>Conventional Media</p>
                                            <div class="">
                                                <div class="progress progress_sm" style="width: 76%;">
                                                    <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="0"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <p>Bill boards</p>
                                            <div class="">
                                                <div class="progress progress_sm" style="width: 76%;">
                                                    <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="0"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="clearfix"></div>
                            </div>
                        </div>

                    </div>
                    <br />







                </div>
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
        <!-- Chart.js -->
        <script src="sellerPage/vendors/Chart.js/dist/Chart.min.js"></script>
        <!-- gauge.js -->
        <script src="sellerPage/vendors/gauge.js/dist/gauge.min.js"></script>
        <!-- bootstrap-progressbar -->
        <script src="sellerPage/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
        <!-- iCheck -->
        <script src="sellerPage/vendors/iCheck/icheck.min.js"></script>
        <!-- Skycons -->
        <script src="sellerPage/vendors/skycons/skycons.js"></script>
        <!-- Flot -->
        <script src="sellerPage/vendors/Flot/jquery.flot.js"></script>
        <script src="sellerPage/vendors/Flot/jquery.flot.pie.js"></script>
        <script src="sellerPage/vendors/Flot/jquery.flot.time.js"></script>
        <script src="sellerPage/vendors/Flot/jquery.flot.stack.js"></script>
        <script src="sellerPage/vendors/Flot/jquery.flot.resize.js"></script>
        <!-- Flot plugins -->
        <script src="sellerPage/vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
        <script src="sellerPage/vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
        <script src="sellerPage/vendors/flot.curvedlines/curvedLines.js"></script>
        <!-- DateJS -->
        <script src="sellerPage/vendors/DateJS/build/date.js"></script>
        <!-- JQVMap -->
        <script src="sellerPage/vendors/jqvmap/dist/jquery.vmap.js"></script>
        <script src="sellerPage/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
        <script src="sellerPage/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
        <!-- bootstrap-daterangepicker -->
        <script src="sellerPage/vendors/moment/min/moment.min.js"></script>
        <script src="sellerPage/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

        <!-- Custom Theme Scripts -->
        <script src="sellerPage/build/js/custom.min.js"></script>

    </body>
</html>

