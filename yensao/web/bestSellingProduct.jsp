<%@page import="java.util.ArrayList"%>
<%@page import="seller.dto.Seller"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Best-selling products</title>
        <meta name="description" content="Sufee Admin - HTML5 Admin Template">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="apple-touch-icon" href="apple-icon.png">
        <link rel="shortcut icon" href="adminPage/favicon.ico">


        <link rel="stylesheet" href="adminPage/vendors/bootstrap/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="adminPage/vendors/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="adminPage/vendors/themify-icons/css/themify-icons.css">
        <link rel="stylesheet" href="adminPage/vendors/flag-icon-css/css/flag-icon.min.css">
        <link rel="stylesheet" href="adminPage/vendors/selectFX/css/cs-skin-elastic.css">
        <link rel="stylesheet" href="adminPage/vendors/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="adminPage/vendors/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">

        <link rel="stylesheet" href="adminPage/assets/css/style.css">

        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>
    </head>

    <body>
        <!-- Left Panel -->

        <aside id="left-panel" class="left-panel">
            <nav class="navbar navbar-expand-sm navbar-default">

                <div class="navbar-header">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main-menu" aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="fa fa-bars"></i>
                    </button>
                    <a class="navbar-brand" href="./"><img src="adminPage/S.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="adminPage/S.png" alt="Logo"></a>
                </div>

                <div id="main-menu" class="main-menu collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="index.html"> <i class="menu-icon fa fa-dashboard"></i>Dashboard </a>
                        </li>
                        <h3 class="menu-title">Management</h3><!-- /.menu-title -->

                        <li class="menu-item-has-children dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="menu-icon fa fa-align-justify"></i>User management</a>
                            <ul class="sub-menu children dropdown-menu">
                                <li><i class="fa fa-user"></i><a href="tables-basic.html">Customer list</a></li>
                                <li><i class="fa fa-users"></i><a href="MainController?action=Show">Seller list</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="MainController?action=Request"><i class="menu-icon fa fa-check-square"></i>Approve selling request</a>
                        </li>
                        <li>
                            <a href="MainController?action=High"><i class="menu-icon fa fa-thumbs-up"></i>Best-selling products</a>
                        </li>
     
                        <li>
                            <a href="MainController?action=Report"><i class="menu-icon fa fa-flag"></i>Customer report</a>
                        </li>
                        <li>
                            <a href="MainController?action=Check"><i class="menu-icon fa fa-check-circle"></i>Check Product Application</a>
                        </li>

                    </ul>
                </div><!-- /.navbar-collapse -->
            </nav>
        </aside><!-- /#left-panel -->

        <!-- Left Panel -->

        <!-- Right Panel -->

        <div id="right-panel" class="right-panel">

            <!-- Header-->
            <header id="header" class="header">

                <div class="header-menu">

                    <div class="col-sm-7">
                        <a id="menuToggle" class="menutoggle pull-left"><i class="fa fa fa-tasks"></i></a>
                        <div class="header-left">
                            <button class="search-trigger"><i class="fa fa-search"></i></button>
                            <div class="form-inline">
                                <form class="search-form">
                                    <input class="form-control mr-sm-2" type="text" placeholder="Search ..." aria-label="Search">
                                    <button class="search-close" type="submit"><i class="fa fa-close"></i></button>
                                </form>
                            </div>

                            <div class="dropdown for-notification">
                                <button class="btn btn-secondary dropdown-toggle" type="button" id="notification" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-bell"></i>
                                    <span class="count bg-danger">3</span>
                                </button>
                                <div class="dropdown-menu" aria-labelledby="notification">
                                    <p class="red">You have 3 Notifications</p>
                                    <a class="dropdown-item media bg-flat-color-1" href="#">
                                        <i class="fa fa-check"></i>
                                        <p>Yasuo sent a request to become seller.</p>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-4" href="#">
                                        <i class="fa fa-info"></i>
                                        <p>Taylor swift sent a request to become seller.</p>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-5" href="#">
                                        <i class="fa fa-warning"></i>
                                        <p>Ronaldo sent a request to become seller.</p>
                                    </a>
                                </div>
                            </div>

                            <div class="dropdown for-message">
                                <button class="btn btn-secondary dropdown-toggle" type="button"
                                        id="message"
                                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="ti-email"></i>
                                    <span class="count bg-primary">4</span>
                                </button>
                                <div class="dropdown-menu" aria-labelledby="message">
                                    <p class="red">You have 4 Mails</p>
                                    <a class="dropdown-item media bg-flat-color-1" href="#">
                                        <span class="photo media-left"><img class="avatar-header" alt="avatar" src="adminPage/images/avatar/1.jpg"></span>
                                        <span class="message media-body">
                                            <span class="name float-left">Adam</span>
                                            <span class="time float-right">Just now</span>
                                            <p>Hello, I want to be a seller</p>
                                        </span>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-4" href="#">
                                        <span class="photo media-left"><img class="avatar-header" alt="avatar" src="adminPage/images/avatar/2.jpg"></span>
                                        <span class="message media-body">
                                            <span class="name float-left">Yasuo</span>
                                            <span class="time float-right">5 minutes ago</span>
                                            <p>Do wanna solo Yasuo?</p>
                                        </span>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-5" href="#">
                                        <span class="photo media-left"><img class="avatar-header" alt="avatar" src="adminPage/images/avatar/3.jpg"></span>
                                        <span class="message media-body">
                                            <span class="name float-left">Ronaldo</span>
                                            <span class="time float-right">10 minutes ago</span>
                                            <p>Siuuuuuuuuuuuuuuuuuuu</p>
                                        </span>
                                    </a>
                                    <a class="dropdown-item media bg-flat-color-3" href="#">
                                        <span class="photo media-left"><img class="avatar-header" alt="avatar" src="adminPage/images/avatar/4.jpg"></span>
                                        <span class="message media-body">
                                            <span class="name float-left">Bin Laden</span>
                                            <span class="time float-right">15 minutes ago</span>
                                            <p>Bank 500k or Boom!!!</p>
                                        </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-5">
                        <div class="user-area dropdown float-right">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img class="user-avatar rounded-circle" src="adminPage/images/admin.jpg" alt="User Avatar">
                            </a>

                            <div class="user-menu dropdown-menu">
                                <a class="nav-link" href="#"><i class="fa fa-user"></i> My Profile</a>

                                <a class="nav-link" href="#"><i class="fa fa-user"></i> Notifications <span class="count">13</span></a>

                                <a class="nav-link" href="#"><i class="fa fa-cog"></i> Settings</a>

                                <a class="nav-link" href="#"><i class="fa fa-power-off"></i> Logout</a>
                            </div>
                        </div>

                        <div class="language-select dropdown" id="language-select">
                            <a class="dropdown-toggle" href="#" data-toggle="dropdown"  id="language" aria-haspopup="true" aria-expanded="true">
                                <i class="flag-icon flag-icon-vn"></i>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="language">
                                <div class="dropdown-item">
                                    <span class="flag-icon flag-icon-fr"></span>
                                </div>
                                <div class="dropdown-item">
                                    <i class="flag-icon flag-icon-es"></i>
                                </div>
                                <div class="dropdown-item">
                                    <i class="flag-icon flag-icon-us"></i>
                                </div>
                                <div class="dropdown-item">
                                    <i class="flag-icon flag-icon-it"></i>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </header><!-- /header -->
            <!-- Header-->


            <div class="breadcrumbs">
                <div class="col-sm-4">
                    <div class="page-header float-left">
                        <div class="page-title">
                            <h1>Best-selling products</h1>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="page-header float-right">
                        <div class="page-title">
                            <ol class="breadcrumb text-right">
                                <li><a href="#">Dashboard</a></li>
                               
                                <li class="active">Best-selling Products</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content mt-3">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong class="card-title">Data Table</strong>
                                </div>
                                <div class="card-body">
                                    <c:if test="${requestScope.HIGH_PRODUCT_LIST != null}">
                                        <c:if test="${not empty requestScope.HIGH_PRODUCT_LIST}">
                                            <table id="bootstrap-data-table-export" class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Product Id</th>
                                                        <th>Name</th>
                                                        <th>Image</th>
                                                        <th>Seller Id</th>
                                                        <th>Category</th>
                                                        <th>Description</th>
                                                        <th>Price</th>
                                                        <th>Total quantity sold</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="product" varStatus="counter" items="${requestScope.HIGH_PRODUCT_LIST}"> 
                                                        <tr>
                                                            <td>${product.productID}</td>
                                                            <td>${product.productName}</td>
                                                            <td><img class="avatar-seller" src="${product.cover}" alt="alt"/></td>
                                                            <td>${product.sellerID}</td>
                                                            <td>${product.cateName}</td>
                                                            <td>${product.description}</td>
                                                            <td>${product.price}</td>
                                                            <td>${product.sumSold}</td>
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
                </div><!-- .animated -->
            </div><!-- .content -->


        </div><!-- /#right-panel -->

        <!-- Right Panel -->


        <script src="adminPage/vendors/jquery/dist/jquery.min.js"></script>
        <script src="adminPage/vendors/popper.js/dist/umd/popper.min.js"></script>
        <script src="adminPage/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="adminPage/assets/js/main.js"></script>


        <script src="adminPage/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="adminPage/vendors/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
        <script src="adminPage/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
        <script src="adminPage/vendors/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js"></script>
        <script src="adminPage/vendors/jszip/dist/jszip.min.js"></script>
        <script src="adminPage/vendors/pdfmake/build/pdfmake.min.js"></script>
        <script src="adminPage/vendors/pdfmake/build/vfs_fonts.js"></script>
        <script src="adminPage/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
        <script src="adminPage/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
        <script src="adminPage/vendors/datatables.net-buttons/js/buttons.colVis.min.js"></script>
        <script src="adminPage/assets/js/init-scripts/data-table/datatables-init.js"></script>
    </body>
</html>

