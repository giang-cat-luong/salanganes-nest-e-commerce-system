<%@page import="java.util.ArrayList"%>
<%@page import="seller.dto.Seller"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Sufee Admin - HTML5 Admin Template</title>
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
                            <h1>Dashboard</h1>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="page-header float-right">
                        <div class="page-title">
                            <ol class="breadcrumb text-right">
                                <li><a href="#">Dashboard</a></li>
                                <li><a href="#">User Management</a></li>
                                <li class="active">Seller List</li>
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
                                    <strong class="card-title">Seller Table</strong>
                                    <button style=" float:right; background-color:#ff5500; border: 1px solid; border-radius: 6px;" type="button" class="btn btn-secondary mb-1" data-toggle="modal"
                                            data-target="#scrollmodal">
                                        Add new seller
                                    </button>
                                </div>
                                <div class="card-body">
                                    <c:if test="${requestScope.BAN_SUCCESS != null}">
                                        <div class="col-sm-12">
                                            <div class="alert  alert-success alert-dismissible fade show" role="alert">
                                                <span class="badge badge-pill badge-success">Success</span> ${requestScope.BAN_SUCCESS}
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </div>
                                    </c:if>                                   
                                    <c:if test="${requestScope.LIST_NORMAL_SELLER != null}">
                                        <c:if test="${not empty requestScope.LIST_NORMAL_SELLER}">
                                            <table id="bootstrap-data-table-export" class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>Name</th>
                                                        <th>Password</th>
                                                        <th>Email</th>
                                                        <th>Avatar</th>
                                                        <th>Phone</th>
                                                        <th>Gender</th>
                                                        <th>Loc</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="seller" varStatus="counter" items="${requestScope.LIST_NORMAL_SELLER}"> 
                                                    <form action="MainController">
                                                        <tr>
                                                            <td>${counter.count}</td>
                                                            <td>${seller.name}</td>
                                                            <td>${seller.password}</td>
                                                            <td>${seller.email}</td>
                                                            <td><img class="avatar-seller" src="${seller.avatar}" alt="alt"/></td>
                                                            <td>${seller.phone}</td>
                                                            <td>${seller.gender}</td>
                                                            <td>${seller.location}</td>
                                                            <td><c:url var="deleteLink" value="MainController">
                                                                    <c:param name="action" value="Remove"></c:param>
                                                                    <c:param name="sellerID" value="${seller.id}"></c:param>
                                                                </c:url>
                                                                <c:url var="banLink" value="MainController">
                                                                    <c:param name="action" value="Ban"></c:param>
                                                                    <c:param name="sellerID" value="${seller.id}"></c:param>
                                                                </c:url>
                                                                <a href="${deleteLink}"><button type="button" class="btn btn-danger">Delete</button></a>
                                                                <a href="${banLink}"><button type="button" class="btn btn-warning">Ban</button></a>
                                                            </td>
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
                </div><!-- .animated -->
            </div><!-- .content -->

            <div class="content mt-3">
                <div class="animated fadeIn">
                    <div class="row">

                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong class="card-title">Banned Seller Table</strong>                                   
                                </div>
                                <div class="card-body">
                                    <c:if test="${requestScope.LIST_BAN_SELLER != null}">
                                        <c:if test="${not empty requestScope.LIST_BAN_SELLER}">
                                            <table id="bootstrap-data-table-export" class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>No</th>
                                                        <th>Name</th>
                                                        <th>Password</th>
                                                        <th>Email</th>
                                                        <th>Avatar</th>
                                                        <th>Phone</th>
                                                        <th>Gender</th>
                                                        <th>Loc</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="banseller" varStatus="counter" items="${requestScope.LIST_BAN_SELLER}"> 
                                                    <form action="MainController">
                                                        <tr>
                                                            <td>${counter.count}</td>
                                                            <td>${banseller.name}</td>
                                                            <td>${banseller.password}</td>
                                                            <td>${banseller.email}</td>
                                                            <td><img class="avatar-seller" src="${banseller.avatar}" alt="alt"/></td>
                                                            <td>${banseller.phone}</td>
                                                            <td>${banseller.gender}</td>
                                                            <td>${banseller.location}</td>
                                                            <td>
                                                                <c:url var="deleteLink" value="MainController">
                                                                    <c:param name="action" value="Remove"></c:param>
                                                                    <c:param name="sellerID" value="${banseller.id}"></c:param>
                                                                </c:url>
                                                                <c:url var="banLink" value="MainController">
                                                                    <c:param name="action" value="Unban"></c:param>
                                                                    <c:param name="sellerID" value="${banseller.id}"></c:param>
                                                                </c:url>                                                   
                                                                <a href="${deleteLink}"><button type="button" class="btn btn-danger">Delete</button></a>
                                                                <a href="${banLink}"><button type="button" class="btn btn-warning">Unban</button></a>
                                                            </td>
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
                </div><!-- .animated -->
            </div><!-- .content -->


            <div class="modal fade" id="scrollmodal" tabindex="-1" role="dialog" aria-labelledby="scrollmodalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div class="content mt-3">
                                <div class="animated fadeIn">
                                    <!--/.col-->

                                    <div class="card">
                                        <div class="card-header">
                                            <strong>Create user</strong> (seller)
                                        </div>
                                        <div class="card-body card-block">
                                            <form action="MainController" method="post"
                                                  class="form-horizontal">
                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label for="text-input"
                                                                                     class=" form-control-label"><i
                                                                class="fa fa-calendar"></i> Seller name</label>
                                                    </div>
                                                    <div class="col-12 col-md-6"><input type="text"
                                                                                        id="text-input" name="name"
                                                                                        placeholder="Enter Username"
                                                                                        class="form-control"><small
                                                                                        class="form-text text-muted">Seller name</small>
                                                    </div>
                                                    ${sessionScope.ERROR_CREATE.name}
                                                </div>
                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label for="text-input"
                                                                                     class=" form-control-label">Password</label></div>
                                                    <div class="col-12 col-md-6"><input type="password"
                                                                                        id="text-input" name="password"
                                                                                        placeholder="Enter Password"
                                                                                        class="form-control"><small
                                                                                        class="form-text text-muted">Password</small>
                                                    </div>
                                                </div>
                                                ${sessionScope.ERROR_CREATE.password}
                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label for="email-input"
                                                                                     class=" form-control-label">Email
                                                        </label></div>
                                                    <div class="col-12 col-md-6"><input type="email"
                                                                                        id="email-input" name="email"
                                                                                        placeholder="Enter Email"
                                                                                        class="form-control"><small
                                                                                        class="form-text text-muted">Email</small>
                                                    </div>
                                                </div>
                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label for="file-input"
                                                                                     class=" form-control-label">Avatar</label></div>
                                                    <div class="col-12 col-md-6"><input type="file"
                                                                                        id="file-input" name="avatar"
                                                                                        class="form-control-file"></div>
                                                </div>

                                                <%--%>
                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label for="text-input"
                                                                                     class=" form-control-label">Avatar</label></div>
                                                    <div class="col-12 col-md-6"><input type="text"
                                                                                        id="text-input" name="avatar"
                                                                                        class="form-control-file"></div>
                                                </div>
                                                --%>
                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label for="text-input"
                                                                                     class=" form-control-label">Phone
                                                        </label></div>  
                                                    <div class="col-12 col-md-6"><input type="text"
                                                                                        id="text-input" name="phone"
                                                                                        placeholder="Enter Phone"
                                                                                        class="form-control"><small
                                                                                        class="form-text text-muted">Phone</small>
                                                    </div>
                                                </div>
                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label
                                                            class=" form-control-label">Gender</label></div>
                                                    <div class="col col-md-3">
                                                        <div class="form-check">
                                                            <div class="radio">
                                                                <label for="radio1" class="form-check-label ">
                                                                    <input type="radio" id="radio1"
                                                                           name="gender" value="male"
                                                                           class="form-check-input">Male
                                                                </label>
                                                            </div>
                                                            <div class="radio">
                                                                <label for="radio2" class="form-check-label ">
                                                                    <input type="radio" id="radio2"
                                                                           name="gender" value="female"
                                                                           class="form-check-input">Female
                                                                </label>
                                                            </div>
                                                            <div class="radio">
                                                                <label for="radio3" class="form-check-label ">
                                                                    <input type="radio" id="radio3"
                                                                           name="gender" value="other"
                                                                           class="form-check-input">Others
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label for="text-input"
                                                                                     class=" form-control-label">Location
                                                        </label></div>
                                                    <div class="col-12 col-md-6"><input type="text"
                                                                                        id="text-input" name="loc"
                                                                                        placeholder="Enter Location"
                                                                                        class="form-control"><small
                                                                                        class="form-text text-muted">Location</small>
                                                    </div>
                                                </div>

                                                <div class="row form-group">
                                                    <div class="col col-md-3"><label for="select"
                                                                                     class=" form-control-label">Role</label></div>
                                                    <div class="col-12 col-md-3">
                                                        <select name="role" id="select" class="form-control">
                                                            <option value="0">Please select</option>
                                                            <option value="SE">Seller</option>
                                                        </select>
                                                    </div>
                                                </div>                                              
                                                <div class="card-footer">
                                                    <button type="submit" value="Add" name="action"  class="btn btn-primary btn-sm">
                                                        <i class="fa fa-dot-circle-o"></i> Create
                                                    </button>
                                                    <button type="reset" class="btn btn-danger btn-sm">
                                                        <i class="fa fa-ban"></i> Reset
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- .animated -->
                        </div>
                    </div>

                </div>
            </div>
        </div>

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
