<%-- 
    Document   : customerProfile
    Created on : Oct 27, 2022, 6:35:29 PM
    Author     : Truong Giang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <!--  This file has been downloaded from bootdey.com @bootdey on twitter -->
        <!--  All snippets are MIT license http://bootdey.com/license -->
        <title>profile with data and skills - Bootdey.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flat-ui/2.3.0/css/flat-ui.min.css" integrity="sha512-6f7HT84a/AplPkpSRSKWqbseRTG4aRrhadjZezYQ0oVk/B+nm/US5KzQkyyOyh0Mn9cyDdChRdS9qaxJRHayww==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container">
            <div class="main-body">

                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="main-breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="customerProfile.jsp">Your profile</a></li>
                        <h3 class="float-right" style="color: green; padding-left: 300px">Your balance: ${sessionScope.CUSTOMER_LOGIN.balance}$</h3>
                    </ol>
                </nav>
                <!-- /Breadcrumb -->

                <div class="row gutters-sm">
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <img src="${sessionScope.CUSTOMER_LOGIN.avatar}" alt="Admin" class="rounded-circle" width="150">
                                    <a href="customerProfile.jsp"><h6>Edit profile</h6></a>
                                    <div class="mt-3">
                                        <h4>${sessionScope.CUSTOMER_LOGIN.name}</h4>
                                        <p class="text-secondary mb-1">${sessionScope.CUSTOMER_LOGIN.email}</p>
                                        <p class="text-muted font-size-sm">${sessionScope.CUSTOMER_LOGIN.location}</p>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card mt-3">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0"><i class="fa-solid fa-key" style="font-size:20px;color:#dbd448;"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></i><a href="changePassword.jsp"> Change password </a></h6></a>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0"><i class="fa-solid fa-cart-shopping" style="font-size:20px;color:blue;"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></i><a href="MainController?action=ViewPurchase&cusID=${sessionScope.CUSTOMER_LOGIN.id}"> My purchase </a></h6>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0"><i class="fa-brands fa-bitcoin" style="font-size:20px;color:red;"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></i><a href="MainController?action=Cumulative&cusID=${sessionScope.CUSTOMER_LOGIN.id}"> My cumulative </a></h6>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                                    <h6 class="mb-0"><i class="fa-solid fa-users" style="font-size:17px;color:green;"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></i><a href="requestSeller.jsp"> Request to be a seller </a></h6>
                                </li>

                            </ul>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-sm-9 ">
                                        <h1>Cumulative available:</h1>
                                    </div>
                                    <div class="col-sm-6 text-secondary"style="padding-left: 170px">
                                        <i class="fa-brands fa-bitcoin" style="font-size:120px;color:red;"><h1 style="color: #ebcf34; padding-left:13px">${sessionScope.TOTAL_CUMULATIVE}</h1></i>
                                    </div>

                                    <div class="col-sm-9 ">
                                        <h3 style="color: #ff5500">Claim History</h3>
                                    </div>
                                    <c:if test="${requestScope.CUMULATIVE != null}">
                                        <c:if test="${not empty requestScope.CUMULATIVE}">
                                            <c:forEach var="cu"  items="${requestScope.CUMULATIVE}">
                                                <div class="col-sm-9 ">
                                                    <p>You get ${cu.infor} points at ${cu.time}</p>
                                                </div>
                                                <div class="col-sm-3 text-secondary">
                                                    <i class="fa-brands fa-bitcoin" style="font-size:50px;color:red;"><h1 style="color: #ebcf34">+${cu.infor}</h1></i>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </c:if>
                                </div>

                            </div>
                        </div>


                    </div>
                </div>

            </div>
        </div>

        <style type="text/css">
            body{
                color: #1a202c;
                text-align: left;

            }
            .main-body {
                padding: 15px;
            }
            .card {
                box-shadow: 0 1px 3px 0 rgba(0,0,0,.1), 0 1px 2px 0 rgba(0,0,0,.06);
            }

            .card {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 0 solid rgba(0,0,0,.125);
                border-radius: .25rem;
            }

            .card-body {
                flex: 1 1 auto;
                min-height: 1px;
                padding: 1rem;
            }

            .gutters-sm {
                margin-right: -8px;
                margin-left: -8px;
            }

            .gutters-sm>.col, .gutters-sm>[class*=col-] {
                padding-right: 8px;
                padding-left: 8px;
            }
            .mb-3, .my-3 {
                margin-bottom: 1rem!important;
            }

            .bg-gray-300 {
                background-color: #e2e8f0;
            }
            .h-100 {
                height: 100%!important;
            }
            .shadow-none {
                box-shadow: none!important;
            }

        </style>

        <script type="text/javascript">

        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
