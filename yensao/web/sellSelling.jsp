<%-- 
    Document   : showOrderDetail
    Created on : Sep 23, 2022, 11:08:19 PM
    Author     : lequa
--%>
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

        <title>Selling page</title>

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
        <link href="sellerPage/build/css/custom.min.css" rel="stylesheet">
    </head>

    <body class="nav-md">
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
                    <div class="">
                        <div class="page-title">
                            <div class="title_left">
                                <h3>Show All Product Status </h3>
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

                        <div class="row">
                            <div class="col-md-12 col-sm-12 ">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>All orders <small>In sell</small></h2>
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                            </li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="card-box table-responsive">
                                                    <c:if test="${requestScope.IN_SELL != null}">
                                                        <c:if test="${not empty requestScope.IN_SELL}">
                                                            <table id="datatable" class="table table-striped table-bordered" style="width:100%">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Product ID</th>
                                                                        <th>Product name</th>
                                                                        <th>Category</th>
                                                                        <th>Image</th>
                                                                        <th>Quantity</th>
                                                                        <th>Price</th>
                                                                        <th>Description</th>
                                                                        <th>Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="insell" varStatus="counter" items="${requestScope.IN_SELL}"> 

                                                                        <tr>
                                                                            <td>${insell.productID}</td>
                                                                            <td>${insell.productName}</td>
                                                                            <td>${insell.cateName}</td>
                                                                            <td><img class="avatar-seller" src="${insell.cover}" alt="alt"/></td>
                                                                            <td>${insell.quantity}</td>
                                                                            <td>${insell.price}</td>
                                                                            <td>${insell.description}</td>
                                                                    <form action="MainController">
                                                                        <td>
                                                                            <input type="hidden" name="productID" value="${insell.productID}"/>
                                                                            <input type="hidden" name="sellerID" value="${insell.sellerID}"/>
                                                                            <input class="inputApprove" type="submit" name="action" value="Remove Product">
                                                                        </td>
                                                                    </form>
                                                                    </tr>

                                                                </c:forEach>                     
                                                                </tbody>
                                                            </table>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 col-sm-12 ">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>All orders <small>In stock</small></h2>
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                            </li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="card-box table-responsive">
                                                    <c:if test="${requestScope.IN_STOCK != null}">
                                                        <c:if test="${not empty requestScope.IN_STOCK}">
                                                            <table id="datatable" class="table table-striped table-bordered" style="width:100%">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Product ID</th>
                                                                        <th>Product name</th>
                                                                        <th>Category</th>
                                                                        <th>Image</th>
                                                                        <th>Quantity</th>
                                                                        <th>Price</th>
                                                                        <th>Description</th>
                                                                        <th>Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="instock" varStatus="counter" items="${requestScope.IN_STOCK}"> 

                                                                        <tr>
                                                                            <td>${instock.productID}</td>
                                                                            <td>${instock.productName}</td>
                                                                            <td>${instock.cateName}</td>
                                                                            <td><img class="avatar-seller" src="${instock.cover}" alt="alt"/></td>
                                                                            <td>${instock.quantity}</td>
                                                                            <td>${instock.price}</td>
                                                                            <td>${instock.description}</td>
                                                                    <form action="MainController">
                                                                        <td>
                                                                            <input type="hidden" name="requestID" value="${product.orderDetailID}"/>
                                                                            
                                                                            <input type="hidden" name="productID" value="${instock.productID}"/>
                                                                            <input type="hidden" name="sellerID" value="${instock.sellerID}"/>
                                                                            <input class="inputApprove" type="submit" name="action" value="Add Selling">
                                                                        </td>
                                                                    </form>
                                                                    </tr>

                                                                </c:forEach>                     
                                                                </tbody>
                                                            </table>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 col-sm-12 ">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>All orders <small>Not approved</small></h2>
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                            </li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="card-box table-responsive">
                                                    <c:if test="${requestScope.UN_APPROVAL != null}">
                                                        <c:if test="${not empty requestScope.UN_APPROVAL}">
                                                            <table id="datatable" class="table table-striped table-bordered" style="width:100%">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Product ID</th>
                                                                        <th>Product name</th>
                                                                        <th>Category</th>
                                                                        <th>Image</th>
                                                                        <th>Quantity</th>
                                                                        <th>Price</th>
                                                                        <th>Description</th>
                                                                        <th>Status</th>

                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="unapprove" varStatus="counter" items="${requestScope.UN_APPROVAL}"> 
                                                                    <form action="MainController">
                                                                        <tr>
                                                                            <td>${unapprove.productID}</td>
                                                                            <td>${unapprove.productName}</td>
                                                                            <td>${unapprove.cateName}</td>
                                                                            <td><img class="avatar-seller" src="${unapprove.cover}" alt="alt"/></td>
                                                                            <td>${unapprove.quantity}</td>
                                                                            <td>${unapprove.price}</td>
                                                                            <td>${unapprove.description}</td>
                                                                            <td>${unapprove.status}</td>
                                                                        </tr>
                                                                    </form>
                                                                </c:forEach>                     
                                                                </tbody>
                                                            </table>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /page content -->      
                    </div>
                </div>
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
