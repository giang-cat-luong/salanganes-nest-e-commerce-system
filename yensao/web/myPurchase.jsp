<%-- 
    Document   : customerProfile
    Created on : Oct 27, 2022, 6:35:29 PM
    Author     : Truong Giang
--%>
<%@page import="others.OrderDetailDTO"%>
<%@page import="others.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
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
        <!-- Font Awesome -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            rel="stylesheet"
            />
        <!-- Google Fonts -->
        <link
            href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
            rel="stylesheet"
            />
        <!-- MDB -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.css"
            rel="stylesheet"
            />

    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <%
            ArrayList<OrderDTO> orl = (ArrayList<OrderDTO>) request.getAttribute("ORL");
            ArrayList<OrderDetailDTO> ordl = (ArrayList<OrderDetailDTO>) request.getAttribute("ORDL");
            String status = "";
            String tmpSeller = "";
            float total = 0;
        %>
        <div class="container">
            <div class="main-body">

                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="main-breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="customerProfile.jsp">Your profile</a></li>
                        <h3 class="float-right" style="color: green; padding-left: 300px">Your balance: ${sessionScope.CUSTOMER_LOGIN.balance}</h3>
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
                                    <h6 class="mb-0"><i class="fa-solid fa-cart-shopping" style="font-size:20px;color:blue;"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></i><a href="myPurchase.jsp"> My purchase </a></h6>
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
                            <!-- Tabs navs -->
                            <ul class="nav nav-tabs nav-justified mb-3" id="ex1" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <a
                                        class="nav-link active"
                                        id="ex3-tab-1"
                                        data-mdb-toggle="tab"
                                        href="#ex3-tabs-1"
                                        role="tab"
                                        aria-controls="ex3-tabs-1"
                                        aria-selected="true"
                                        >All</a
                                    >
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a
                                        class="nav-link"
                                        id="ex3-tab-2"
                                        data-mdb-toggle="tab"
                                        href="#ex3-tabs-2"
                                        role="tab"
                                        aria-controls="ex3-tabs-2"
                                        aria-selected="false"
                                        >Waiting </a
                                    >
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a
                                        class="nav-link"
                                        id="ex3-tab-3"
                                        data-mdb-toggle="tab"
                                        href="#ex3-tabs-3"
                                        role="tab"
                                        aria-controls="ex3-tabs-3"
                                        aria-selected="false"
                                        >Completed</a
                                    >
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a
                                        class="nav-link"
                                        id="ex3-tab-4"
                                        data-mdb-toggle="tab"
                                        href="#ex3-tabs-4"
                                        role="tab"
                                        aria-controls="ex3-tabs-4"
                                        aria-selected="false"
                                        >Rated</a
                                    >
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a
                                        class="nav-link"
                                        id="ex3-tab-5"
                                        data-mdb-toggle="tab"
                                        href="#ex3-tabs-5"
                                        role="tab"
                                        aria-controls="ex3-tabs-5"
                                        aria-selected="false"
                                        >Cancelled</a
                                    >
                                </li>
                            </ul>
                            <!-- Tabs navs -->

                            <!-- Tabs content -->
                            <div class="tab-content" id="ex2-content">
                                <!-- ALL -->
                                <div
                                    class="tab-pane fade show active p-2"
                                    id="ex3-tabs-1"
                                    role="tabpanel"
                                    aria-labelledby="ex3-tab-1"
                                    >
                                    <%
                                        for (int i = 0; i < orl.size(); i++) {
                                            if (orl.get(i).getStatus() == 1) {
                                                status = "WAITING";
                                            } else if (orl.get(i).getStatus() == 3) {
                                                status = "RATED";
                                            } else if (orl.get(i).getStatus() == 2) {
                                                status = "COMPLETED";
                                            } else if (orl.get(i).getStatus() == 4) {
                                                status = "CANCELLED";
                                            }
                                    %>
                                    <div class="border" style="padding:10px; margin-bottom: 10px">
                                        <div>
                                            <div class="d-inline "><h5>Order ID: <%= orl.get(i).getOrderID()%></h5></div>
                                            <div class="d-inline float-end" style="color:#ff5500"><Strong><%= status%></Strong></div>
                                        </div>    
                                        <hr class="hr" />
                                        <%
                                            for (int j = 0; j < ordl.size(); j++) {
                                                if (ordl.get(j).getOrderID().equalsIgnoreCase(orl.get(i).getOrderID())) {
                                        %>
                                        <div>
                                            <% if (!ordl.get(j).getSellerID().equalsIgnoreCase(tmpSeller)) {%>
                                            <div class="d-inline "><%= ordl.get(j).getSellerID()%></div>
                                            <%
                                                    tmpSeller = ordl.get(j).getSellerID();
                                                }
                                            %>

                                        </div>   
                                        <form action="MainController">
                                            <div class="row">
                                                <div class="col-md-4 "><img src="<%= ordl.get(j).getImg()%>" alt="alt" style="width: 200px"/></div>
                                                <div class="col-md-3" >
                                                    <h6 ><%= ordl.get(j).getProductName()%></h6>
                                                </div>
                                                <div class="col-md-2">
                                                    <h5 ><%= ordl.get(j).getPrice()%></h5>
                                                </div>
                                                <div class="col-md-1">
                                                    <h5 ><%= ordl.get(j).getQuantity()%></h5>
                                                </div>
                                                <div class="col-md-2">
                                                    <% if (orl.get(i).getStatus() == 2) {%>
                                                    <button type="button"  class="btn btn-success rateCollapse" data-toggle="collapse" 
                                                            data-target="#<%= ordl.get(j).getProductID()%>"
                                                            aria-expanded="false" aria-controls="<%= ordl.get(j).getProductID()%>">Rate
                                                    </button>
                                                    <% } else if (orl.get(i).getStatus() == 3) {%>
                                                    <div  class="btn btn-success rateCollapse" >Rated</div> 
                                                    <% }%> 
                                                </div>
                                            </div>
                                            <div class="collapse" id="<%= ordl.get(j).getProductID()%>">
                                                <div class="card">

                                                    <div class="row">

                                                        <div class="col-2">


                                                            <img src="https://i.imgur.com/xELPaag.jpg" width="70" class="rounded-circle mt-2" style="margin-left:10px">


                                                        </div>

                                                        <div class="col-10">

                                                            <div class="comment-box ml-2">

                                                                <h4>Add a comment</h4>

                                                                <div class="rating" > 
                                                                    <input type="radio" name="rate" value="5" id="5"><label for="5">☆</label>
                                                                    <input type="radio" name="rate" value="4" id="4"><label for="4">☆</label> 
                                                                    <input type="radio" name="rate" value="3" id="3"><label for="3">☆</label>
                                                                    <input type="radio" name="rate" value="2" id="2"><label for="2">☆</label>
                                                                    <input type="radio" name="rate" value="1" id="1"><label for="1">☆</label>
                                                                </div>

                                                                <div class="comment-area">

                                                                    <textarea class="form-control" name="detail" value="" placeholder="what is your view?" rows="4"></textarea>

                                                                </div>

                                                                <div class="comment-btns mt-2">

                                                                    <div class="row">

                                                                        <div class="col-6">

                                                                            <div class="pull-left">

                                                                                <input type="file" name="img" />

                                                                            </div>

                                                                        </div>

                                                                        <div class="col-6 float-end">

                                                                            <div class="pull-right">
                                                                                <input type="hidden" name="cusID" value="${sessionScope.CUSTOMER_LOGIN.id}" />
                                                                                <input type="hidden" name="orderDetailID" value="<%= ordl.get(j).getOrderDetailID()%>" />
                                                                                <input type="hidden" name="productID" value="<%= ordl.get(j).getProductID()%>" />
                                                                                <button name="action" value="CommentProduct" class="btn btn-success send btn-sm">Send <i class="fa fa-long-arrow-right ml-1"></i></button>      

                                                                            </div>

                                                                        </div>

                                                                    </div>

                                                                </div>


                                                            </div>

                                                        </div>


                                                    </div>

                                                </div>
                                            </div>
                                        </form>
                                        <div style="margin-top:50px">
                                            <hr style="height:2px;border-width:0;color:gray;background-color:gray">
                                        </div>
                                        <%
                                                    total += ordl.get(j).getPrice() * ordl.get(j).getQuantity();
                                                }
                                            }
                                        %>                              
                                    </div>
                                    <div class="d-inline float-end">
                                        <Strong>Order Total:<p class="d-inline" style="color:#ff5500"> <%= total%>$</p></Strong>
                                    </div>
                                    <form action="MainController">
                                        <% if (orl.get(i).getStatus() == 1) {%>
                                        <div>
                                            <input type="hidden" name="cusID" value="${sessionScope.CUSTOMER_LOGIN.id}"/>
                                            <input type="hidden" name="orderID" value="<%= orl.get(i).getOrderID()%>"/>
                                            <button class="btn btn-warning" type="submit" name="action"  value="CancelOrder">Cancel</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </form>
                                    <%
                                        }
                                    %>

                                </div>
                                <!-- WAITING -->
                                <div
                                    class="tab-pane fade"
                                    id="ex3-tabs-2"
                                    role="tabpanel"
                                    aria-labelledby="ex3-tab-2"
                                    >
                                    <%
                                        for (int i = 0; i < orl.size(); i++) {

                                    %>
                                    <div class="border" style="padding:10px; margin-bottom: 10px">
                                        <div>
                                            <% if (orl.get(i).getStatus() == 1) {%>
                                            <div class="d-inline "><h5>Order ID: <%= orl.get(i).getOrderID()%></h5></div>
                                            <%
                                                }
                                                if (orl.get(i).getStatus() == 1) {
                                                    status = "WAITING";
                                                }
                                            %>
                                            <% if (orl.get(i).getStatus() == 1) {%>
                                            <div class="d-inline float-end" style="color:#ff5500"><Strong><%= status%></Strong></div>
                                                    <% } %>
                                        </div>    
                                        <hr class="hr" />
                                        <%
                                            for (int j = 0; j < ordl.size(); j++) {
                                                if (ordl.get(j).getOrderID().equalsIgnoreCase(orl.get(i).getOrderID()) && (orl.get(i).getStatus() == 1)) {
                                        %>
                                        <div>
                                            <% if (!ordl.get(j).getSellerID().equalsIgnoreCase(tmpSeller)) {%>
                                            <div class="d-inline "><%= ordl.get(j).getSellerID()%></div>
                                            <%
                                                    tmpSeller = ordl.get(j).getSellerID();
                                                }
                                            %>

                                        </div>   
                                        <form action="MainController">
                                            <div class="row">
                                                <div class="col-md-4 "><img src="<%= ordl.get(j).getImg()%>" alt="alt" style="width: 200px"/></div>
                                                <div class="col-md-4" >
                                                    <h6 ><%= ordl.get(j).getProductName()%></h6>
                                                </div>
                                                <div class="col-md-2">
                                                    <h5 ><%= ordl.get(j).getProductName()%></h5>
                                                </div>
                                                <div class="col-md-2">
                                                    
                                                </div>
                                            </div>
                                            <div class="collapse" id="<%= ordl.get(j).getProductID()%>">
                                                <div class="card">

                                                    <div class="row">

                                                        <div class="col-2">


                                                            <img src="https://i.imgur.com/xELPaag.jpg" width="70" class="rounded-circle mt-2" style="margin-left:10px">


                                                        </div>

                                                        <div class="col-10">

                                                            <div class="comment-box ml-2">

                                                                <h4>Add a comment</h4>

                                                                <div class="rating" > 
                                                                    <input type="radio" name="rate" value="5" id="5"><label for="5">☆</label>
                                                                    <input type="radio" name="rate" value="4" id="4"><label for="4">☆</label> 
                                                                    <input type="radio" name="rate" value="3" id="3"><label for="3">☆</label>
                                                                    <input type="radio" name="rate" value="2" id="2"><label for="2">☆</label>
                                                                    <input type="radio" name="rate" value="1" id="1"><label for="1">☆</label>
                                                                </div>

                                                                <div class="comment-area">

                                                                    <textarea class="form-control" name="detail" value="" placeholder="what is your view?" rows="4"></textarea>

                                                                </div>

                                                                <div class="comment-btns mt-2">

                                                                    <div class="row">

                                                                        <div class="col-6">

                                                                            <div class="pull-left">

                                                                                <input type="file" name="img" />

                                                                            </div>

                                                                        </div>

                                                                        <div class="col-6 float-end">

                                                                            <div class="pull-right">

                                                                                <button class="btn btn-success send btn-sm">Send <i class="fa fa-long-arrow-right ml-1"></i></button>      

                                                                            </div>

                                                                        </div>

                                                                    </div>

                                                                </div>


                                                            </div>

                                                        </div>


                                                    </div>

                                                </div>
                                            </div>
                                        </form>


                                        <div class="d-inline float-end">
                                            <Strong>Order Total:<p class="d-inline" style="color:#ff5500">  200k</p></Strong>
                                        </div>
                                        <div style="margin-top:50px">
                                            <hr style="height:2px;border-width:0;color:gray;background-color:gray">

                                        </div>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                    <div class="col-md-2">
                                        <% if (orl.get(i).getStatus() == 1) {%>
                                        <input type="hidden" name="cusID" value="${sessionScope.CUSTOMER_LOGIN.id}"/>
                                        <input type="hidden" name="orderID" value="<%= orl.get(i).getOrderID()%>"/>
                                        <button type="button"  class="btn btn-success rateCollapse" value="CancelOrder">Cancel</button>
                                        <% }%>
                                    </div>
                                    <%
                                        }
                                    %>


                                </div>
                                <!-- COMPLETED -->
                                <div
                                    class="tab-pane fade"
                                    id="ex3-tabs-3"
                                    role="tabpanel"
                                    aria-labelledby="ex3-tab-3"
                                    >
                                    <%
                                        for (int i = 0; i < orl.size(); i++) {

                                    %>
                                    <div class="border" style="padding:10px; margin-bottom: 10px">
                                        <div>
                                            <% if (orl.get(i).getStatus() == 2) {%>
                                            <div class="d-inline "><h5>Order ID: <%= orl.get(i).getOrderID()%></h5></div>
                                            <%
                                                }
                                                if (orl.get(i).getStatus() == 2) {
                                                    status = "COMPLETED";
                                                }
                                            %>
                                            <% if (orl.get(i).getStatus() == 2) {%>
                                            <div class="d-inline float-end" style="color:#ff5500"><Strong><%= status%></Strong></div>
                                                    <% } %>
                                        </div>    
                                        <hr class="hr" />
                                        <%
                                            for (int j = 0; j < ordl.size(); j++) {
                                                if (ordl.get(j).getOrderID().equalsIgnoreCase(orl.get(i).getOrderID()) && (orl.get(i).getStatus() == 2)) {
                                        %>
                                        <div>
                                            <% if (!ordl.get(j).getSellerID().equalsIgnoreCase(tmpSeller)) {%>
                                            <div class="d-inline"><%= ordl.get(j).getSellerID()%></div>
                                            <%
                                                    tmpSeller = ordl.get(j).getSellerID();
                                                }
                                            %>

                                        </div>   

                                        <form action="MainController">
                                            <div class="row">
                                                <div class="col-md-4 "><img src="<%= ordl.get(j).getImg()%>" alt="alt" style="width: 200px"/></div>
                                                <div class="col-md-4" >
                                                    <h6 ><%= ordl.get(j).getProductName()%></h6>
                                                </div>
                                                <div class="col-md-2">
                                                    <h5 ><%= ordl.get(j).getProductName()%></h5>
                                                </div>
                                                <div class="col-md-2">
                                                    <input type="hidden" name="cusID" value="${sessionScope.CUSTOMER_LOGIN.id}" />
                                                    <input type="hidden" name="orderDetailID" value="<%= ordl.get(j).getOrderDetailID()%>" />
                                                    <button type="button" name="action" value="CommentProdcut" class="btn btn-success rateCollapse" data-toggle="collapse" 
                                                            data-target="#<%= ordl.get(j).getProductID()%>"
                                                            aria-expanded="false" aria-controls="<%= ordl.get(j).getProductID()%>">Rate</button>

                                                </div>
                                            </div>
                                            <div class="collapse" id="<%= ordl.get(j).getProductID()%>">
                                                <div class="card">

                                                    <div class="row">

                                                        <div class="col-2">


                                                            <img src="https://i.imgur.com/xELPaag.jpg" width="70" class="rounded-circle mt-2" style="margin-left:10px">


                                                        </div>

                                                        <div class="col-10">

                                                            <div class="comment-box ml-2">

                                                                <h4>Add a comment</h4>

                                                                <div class="rating" > 
                                                                    <input type="radio" name="rate" value="5" id="5"><label for="5">☆</label>
                                                                    <input type="radio" name="rate" value="4" id="4"><label for="4">☆</label> 
                                                                    <input type="radio" name="rate" value="3" id="3"><label for="3">☆</label>
                                                                    <input type="radio" name="rate" value="2" id="2"><label for="2">☆</label>
                                                                    <input type="radio" name="rate" value="1" id="1"><label for="1">☆</label>
                                                                </div>

                                                                <div class="comment-area">

                                                                    <textarea class="form-control" name="detail" value="" placeholder="what is your view?" rows="4"></textarea>

                                                                </div>

                                                                <div class="comment-btns mt-2">

                                                                    <div class="row">

                                                                        <div class="col-6">

                                                                            <div class="pull-left">

                                                                                <input type="file" name="img" />

                                                                            </div>

                                                                        </div>

                                                                        <div class="col-6 float-end">

                                                                            <div class="pull-right">

                                                                                <button class="btn btn-success send btn-sm">Send <i class="fa fa-long-arrow-right ml-1"></i></button>      

                                                                            </div>

                                                                        </div>

                                                                    </div>

                                                                </div>


                                                            </div>

                                                        </div>


                                                    </div>

                                                </div>
                                            </div>
                                        </form>

                                        <div class="d-inline float-end">
                                            <Strong>Order Total:<p class="d-inline" style="color:#ff5500">  200k</p></Strong>
                                        </div>
                                        <div style="margin-top:50px">
                                            <hr style="height:2px;border-width:0;color:gray;background-color:gray">

                                        </div>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <!-- RATED -->
                                <div
                                    class="tab-pane fade"
                                    id="ex3-tabs-4"
                                    role="tabpanel"
                                    aria-labelledby="ex3-tab-4"
                                    >
                                    <%
                                        for (int i = 0; i < orl.size(); i++) {

                                    %>
                                    <div class="border" style="padding:10px; margin-bottom: 10px">
                                        <div>
                                            <% if (orl.get(i).getStatus() == 3) {%>
                                            <div class="d-inline "><%= orl.get(i).getOrderID()%></div>
                                            <%
                                                }
                                                if (orl.get(i).getStatus() == 3) {
                                                    status = "RATED";
                                                }
                                            %>
                                            <% if (orl.get(i).getStatus() == 3) {%>
                                            <div class="d-inline float-end" style="color:#ff5500"><Strong><%= status%></Strong></div>
                                                    <% } %>
                                        </div>    
                                        <hr class="hr" />
                                        <%
                                            for (int j = 0; j < ordl.size(); j++) {
                                                if (ordl.get(j).getOrderID().equalsIgnoreCase(orl.get(i).getOrderID()) && (orl.get(i).getStatus() == 3)) {
                                        %>
                                        <div>
                                            <% if (!ordl.get(j).getSellerID().equalsIgnoreCase(tmpSeller)) {%>
                                            <div class="d-inline "><%= ordl.get(j).getSellerID()%></div>
                                            <%
                                                    tmpSeller = ordl.get(j).getSellerID();
                                                }
                                            %>

                                        </div>   
                                        <div class="row">
                                            <div class="col-md-4 "><img src="<%= ordl.get(j).getImg()%>" alt="alt" style="width: 200px"/></div>
                                            <div class="col-md-4" >
                                                <h6 ><%= ordl.get(j).getProductName()%></h6>
                                            </div>
                                            <div class="col-md-2">
                                                <h5 ><%= ordl.get(j).getProductName()%></h5>
                                            </div>
                                            <div class="col-md-2">

                                            </div>
                                        </div>
                                        <div class="collapse" id="<%= ordl.get(j).getProductID()%>">
                                            <div class="card">

                                                <div class="row">

                                                    <div class="col-2">


                                                        <img src="https://i.imgur.com/xELPaag.jpg" width="70" class="rounded-circle mt-2" style="margin-left:10px">


                                                    </div>

                                                    <div class="col-10">

                                                        <div class="comment-box ml-2">

                                                            <h4>Add a comment</h4>

                                                            <div class="rating" > 
                                                                <input type="radio" name="rate" value="5" id="5"><label for="5">☆</label>
                                                                <input type="radio" name="rate" value="4" id="4"><label for="4">☆</label> 
                                                                <input type="radio" name="rate" value="3" id="3"><label for="3">☆</label>
                                                                <input type="radio" name="rate" value="2" id="2"><label for="2">☆</label>
                                                                <input type="radio" name="rate" value="1" id="1"><label for="1">☆</label>
                                                            </div>

                                                            <div class="comment-area">

                                                                <textarea class="form-control" placeholder="what is your view?" rows="4"></textarea>

                                                            </div>

                                                            <div class="comment-btns mt-2">

                                                                <div class="row">

                                                                    <div class="col-6">

                                                                        <div class="pull-left">

                                                                            <input type="file"/>

                                                                        </div>

                                                                    </div>

                                                                    <div class="col-6 float-end">

                                                                        <div class="pull-right">

                                                                            <button class="btn btn-success send btn-sm">Send <i class="fa fa-long-arrow-right ml-1"></i></button>      

                                                                        </div>

                                                                    </div>

                                                                </div>

                                                            </div>


                                                        </div>

                                                    </div>


                                                </div>

                                            </div>
                                        </div>


                                        <div class="d-inline float-end">
                                            <Strong>Order Total:<p class="d-inline" style="color:#ff5500">  200k</p></Strong>
                                        </div>
                                        <div style="margin-top:50px">
                                            <hr style="height:2px;border-width:0;color:gray;background-color:gray">

                                        </div>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                    <%
                                        }
                                    %>

                                </div>
                                <!-- CANCELLED -->
                                <div
                                    class="tab-pane fade"
                                    id="ex3-tabs-5"
                                    role="tabpanel"
                                    aria-labelledby="ex3-tab-5"
                                    >
                                    <%
                                        for (int i = 0; i < orl.size(); i++) {

                                    %>
                                    <div class="border" style="padding:10px; margin-bottom: 10px">
                                        <div>
                                            <% if (orl.get(i).getStatus() == 4) {%>
                                            <div class="d-inline "><%= orl.get(i).getOrderID()%></div>
                                            <%
                                                }
                                                if (orl.get(i).getStatus() == 4) {
                                                    status = "CANCELLED";
                                                }
                                            %>
                                            <% if (orl.get(i).getStatus() == 4) {%>
                                            <div class="d-inline float-end" style="color:#ff5500"><Strong><%= status%></Strong></div>
                                                    <% } %>
                                        </div>    
                                        <hr class="hr" />
                                        <%
                                            for (int j = 0; j < ordl.size(); j++) {
                                                if (ordl.get(j).getOrderID().equalsIgnoreCase(orl.get(i).getOrderID()) && (orl.get(i).getStatus() == 4)) {
                                        %>
                                        <div>
                                            <% if (!ordl.get(j).getSellerID().equalsIgnoreCase(tmpSeller)) {%>
                                            <div class="d-inline "><%= ordl.get(j).getSellerID()%></div>
                                            <%
                                                    tmpSeller = ordl.get(j).getSellerID();
                                                }
                                            %>

                                        </div>   
                                        <div class="row">
                                            <div class="col-md-4 "><img src="<%= ordl.get(j).getImg()%>" alt="alt" style="width: 200px"/></div>
                                            <div class="col-md-4" >
                                                <h6 ><%= ordl.get(j).getProductName()%></h6>
                                            </div>
                                            <div class="col-md-2">
                                                <h5 ><%= ordl.get(j).getProductName()%></h5>
                                            </div>
                                            <div class="col-md-2">

                                            </div>
                                        </div>
                                        <div class="collapse" id="<%= ordl.get(j).getProductID()%>">
                                            <div class="card">

                                                <div class="row">

                                                    <div class="col-2">


                                                        <img src="https://i.imgur.com/xELPaag.jpg" width="70" class="rounded-circle mt-2" style="margin-left:10px">


                                                    </div>

                                                    <div class="col-10">

                                                        <div class="comment-box ml-2">

                                                            <h4>Add a comment</h4>

                                                            <div class="rating" > 
                                                                <input type="radio" name="rate" value="5" id="5"><label for="5">☆</label>
                                                                <input type="radio" name="rate" value="4" id="4"><label for="4">☆</label> 
                                                                <input type="radio" name="rate" value="3" id="3"><label for="3">☆</label>
                                                                <input type="radio" name="rate" value="2" id="2"><label for="2">☆</label>
                                                                <input type="radio" name="rate" value="1" id="1"><label for="1">☆</label>
                                                            </div>

                                                            <div class="comment-area">

                                                                <textarea class="form-control" placeholder="what is your view?" rows="4"></textarea>

                                                            </div>

                                                            <div class="comment-btns mt-2">

                                                                <div class="row">

                                                                    <div class="col-6">

                                                                        <div class="pull-left">

                                                                            <input type="file"/>

                                                                        </div>

                                                                    </div>

                                                                    <div class="col-6 float-end">

                                                                        <div class="pull-right">

                                                                            <button class="btn btn-success send btn-sm">Send <i class="fa fa-long-arrow-right ml-1"></i></button>      

                                                                        </div>

                                                                    </div>

                                                                </div>

                                                            </div>


                                                        </div>

                                                    </div>


                                                </div>

                                            </div>
                                        </div>


                                        <div class="d-inline float-end">
                                            <Strong>Order Total:<p class="d-inline" style="color:#ff5500">  200k</p></Strong>
                                        </div>
                                        <div style="margin-top:50px">
                                            <hr style="height:2px;border-width:0;color:gray;background-color:gray">

                                        </div>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                    <%
                                        }
                                    %>

                                </div>
                            </div>
                            <!-- Tabs content -->
                        </div>


                    </div>
                </div>

            </div>
        </div>
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Select alanganes' Nest Voucher</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div >
                            <div class="coupon bg-white rounded mb-3 d-flex justify-content-between">
                                <div class="kiri p-3">
                                    <div class="icon-container ">
                                        <div class="icon-container_box">
                                            <img src="data:image/png;base64,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" width="85" alt="totoprayogo.com" class="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="tengah py-3 d-flex w-100 justify-content-start">
                                    <div>
                                        <span class="badge badge-success">Valid</span>
                                        <h3 class="lead">dddd</h3>
                                        <p class="text-muted mb-0">ddddd</p>
                                    </div>
                                </div>
                                <div class="kanan">
                                    <div class="info m-3 d-flex align-items-center">
                                        <div class="w-100">
                                            <div class="block">
                                                <span class="time font-weight-light">
                                                    <span>Available: ddd</span>
                                                </span>
                                            </div>
                                            <input type="checkbox" class="voucher" value="dd" onclick="setOne()"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" onclick="getVoucher()" class="btn btn-primary" data-dismiss="modal">Save</button>
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
            .rating {
                display: flex;
                margin-top: -10px;
                flex-direction: row-reverse;
                margin-left: -4px;
                float: left;
            }




            .card1 {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                padding: 20px;
                width: 450px;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border-radius: 6px;
                -moz-box-shadow: 0px 0px 5px 0px rgba(212, 182, 212, 1)
            }

            .comment-box{

                padding:5px;
            }



            .comment-area textarea{
                resize: none;
                border: 1px solid #ad9f9f;
            }


            .form-control:focus {
                color: #495057;
                background-color: #fff;
                border-color: #ffffff;
                outline: 0;
                box-shadow: 0 0 0 1px rgb(255, 0, 0) !important;
            }

            .send {
                color: #fff;
                background-color: #ff0000;
                border-color: #ff0000;
            }

            .send:hover {
                color: #fff;
                background-color: #f50202;
                border-color: #f50202;
            }


            .rating {
                display: flex;
                margin-top: -10px;
                flex-direction: row-reverse;
                margin-left: -4px;
                float: left;
            }

            .rating>input {
                display: none
            }

            .rating>label {
                position: relative;
                width: 19px;
                font-size: 25px;
                color: #ff0000;
                cursor: pointer;
            }

            .rating>label::before {
                content: "\2605";
                position: absolute;
                opacity: 0
            }

            .rating>label:hover:before,
            .rating>label:hover~label:before {
                opacity: 1 !important
            }

            .rating>input:checked~label:before {
                opacity: 1
            }

            .rating:hover>input:checked~label:before {
                opacity: 0.4
            }
        </style>

        <script type="text/javascript">

        </script>
        <script
            type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.0/mdb.min.js"
        ></script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>