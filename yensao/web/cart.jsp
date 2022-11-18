<%-- 
    Document   : cart
    Created on : Sep 19, 2022, 3:12:36 PM
    Author     : lequa
--%>
<%@page import="customer.dto.Customer"%>
<%@page import="others.Voucher"%>
<%@page import="seller.dto.Seller"%>
<%@page import="cart.CartDTO"%>
<%@page import="cart.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Cart</title>
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
        <link rel="stylesheet" href="css/style.css">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            input[type=checkbox]:checked + label {
                color: red;
                font-style: normal;
            }
        </style>
    </head>
    <body class="goto-here">
        <jsp:include page="header.jsp"/>
        <!-- END nav -->
        <% ArrayList<Seller> s = (ArrayList<Seller>) request.getAttribute("SELLER_LIST");
            Cart cart = (Cart) session.getAttribute("CART");
            ArrayList<Voucher> vl = (ArrayList<Voucher>) request.getAttribute("VOUCHER_LIST");
            float cumulative = (float) request.getAttribute("CUMULATIVE");
            Customer cus = (Customer) session.getAttribute("CUSTOMER_LOGIN");
        %>
        <div class="hero-wrap hero-bread" style="background-image: url('images/banner.jpg');">
            <div class="container">
                <div class="row no-gutters slider-text align-items-center justify-content-center">
                    <div class="col-md-9 ftco-animate text-center">
                        <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Cart</span></p>
                        <h1 class="mb-0 bread">My Cart</h1>
                    </div>
                </div>
            </div>
        </div>

        <section class="ftco-section ftco-cart">
            <form action="MainController" class="subscribe-form">
                <div class="container">
                    <% if (s != null && cart != null) {
                            for (int i = 0; i < s.size(); i++) {%> 
                    <div class="row border" style="background-color: #fff; margin-top: 10px;border-radius: 10px inset ;border-radius: 10px;box-shadow: 5px 10px #f5f5f5;" >
                        <div class="col-md-3 ftco-animate" style="margin: 15px 0px 10px 22px">
                            <input type="checkbox" onclick="setAll()" class="sellerName" name="<%= s.get(i).getId()%>" value="" />
                            <img src="<%= s.get(i).getAvatar()%>" class="rounded-circle mb-3" style="width: 80px;margin-left: 9px"
                                 alt="Avatar" />
                            <label for="Shop 123"><strong ><%= s.get(i).getName()%></strong></label>
                        </div>
                        <div class="col-md-12 ftco-animate">
                            <div class="cart-list">
                                <table class="table">
                                    <thead class="thead-primary">
                                        <tr class="text-center">
                                            <th>&nbsp;</th>
                                            <th>&nbsp;</th>
                                            <th>Product name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th>&nbsp;</th>
                                        </tr>
                                    </thead>

                                    <%
                                        for (CartDTO c : cart.getCart().values()) {
                                            if (c.getSellerID().equalsIgnoreCase(s.get(i).getId())) {%>
                                    <tbody>
                                        <tr class="text-center">
                                            <td >
                                                <input type="checkbox" onclick="settotal()" name="<%=c.getName()%>" value="<%= c.getProductID()%>" class= "product" title="<%= c.getSellerID()%>"/>
                                                <input type="hidden" name="<%=c.getName()%>" value="<%= c.getPrice()%>" class= "cost"/>
                                                <input type="hidden" name="<%=c.getName()%>" value="<%= c.getQuantity()%>" class= "number"/>
                                                <input type="hidden" name="no" value="<%= c.getProductID()%>" class= "checkEd" title="<%= c.getSellerID()%>"/>
                                            </td>
                                            <td class="image-prod"><div class="img" style="background-image:url(<%= c.getCover()%>);"></div></td>
                                            <td class="product-name">
                                                <h3><%= c.getName()%></h3>
                                                <p><%= c.getDescription()%></p>
                                            </td>
                                            <td class="price"><%= c.getPrice()%>$ </td>
                                            <td class="quantity">
                                                <div class="input-group mb-3">
                                                    <input type="text" name="quantity" class="quantity form-control input-number" placeholder="<%= c.getQuantity()%>">
                                                </div>
                                            </td>
                                            <td class="total"><%= c.getPrice() * c.getQuantity()%>$</td>
                                            <td class="product-remove"><a href="MainController?action=RemoveCart&productID=<%= c.getProductID()%>&cusID=<%= cus.getId()%>"><span class="ion-ios-close"></span></a></td>
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
                    <%
                            }
                        }
                    %>
                    <div class="row border justify-content-end" style="position: fixed; right: 0;left: 0;bottom: 0; z-index: 100;background-color: #fff; margin-left: 100px;margin-right: 100px">
                        <div class="col-lg-6 mt-1 cart-wrap ftco-animate ">
                            <div class="mb-3">                           
                                <div class="form-group">
                                    <label for=""><span class="icon-developer_board"></span> Platform Voucher</label>
                                    <a type="button" data-toggle="modal" data-target="#exampleModalCenter" style="margin-left: 100px; color: #ff5500">                              
                                        Select coupon : 
                                    </a>
                                    <label for="" id="voucherAffect"></label>
                                </div>
                                <h5>Cumulative points: </h5>
                                <h5>
                                    <input id="cumulativePoint" type="checkbox" value="<%= cumulative%>" onclick="useCumulative()">
                                    <label> <%= cumulative%></label>
                                </h5>

                            </div>
                        </div>
                        <div class="col-lg-6 mt-1 cart-wrap ftco-animate">
                            <p class="d-flex total-price">
                                <span>Total</span>
                            </p>
                            <h3><div id="total" style="color: red" value="0">0</div></h3>
                            <h4><div id="totalDiscount" style="color: red; opacity: 50%; display: none">0</div></h4>
                            <h5><div id="cumulativeDiscount" style="color: red; opacity: 50%; display: none">0</div></h5>
                            <input type="hidden" name="cusID" value ="<%= cus.getId()%>" />
                            <input type="hidden" name="cumulative" value ="0" id="finalCumulative"/>
                            <input type="hidden" name="voucherID" value ="0" id="voucherUse"/>
                            <button type="submit" name="action" value="CheckOut" class="btn btn-primary py-3 px-4" style="color: #fff">Checkout</button>
                            </p>
                        </div>
                    </div>
                </div>
            </form>
        </section>

        <section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
            <div class="container py-4">
                <div class="row d-flex justify-content-center py-5">
                    <div class="col-md-6">
                        <h2 style="font-size: 22px;" class="mb-0">Subcribe to our Newsletter</h2>
                        <span>Get e-mail updates about our latest shops and special offers</span>
                    </div>
                    <div class="col-md-6 d-flex align-items-center">
                        <form action="#" class="subscribe-form">
                            <div class="form-group d-flex">
                                <input type="text" class="form-control" placeholder="Enter email address">
                                <input type="submit" value="Subscribe" class="submit px-3">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <footer class="ftco-footer ftco-section">
            <div class="container">
                <div class="row">
                    <div class="mouse">
                        <a href="#" class="mouse-icon">
                            <div class="mouse-wheel"><span class="ion-ios-arrow-up"></span></div>
                        </a>
                    </div>
                </div>
                <div class="row mb-5">
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Vegefoods</h2>
                            <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia.</p>
                            <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                                <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                                <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                                <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4 ml-md-5">
                            <h2 class="ftco-heading-2">Menu</h2>
                            <ul class="list-unstyled">
                                <li><a href="#" class="py-2 d-block">Shop</a></li>
                                <li><a href="#" class="py-2 d-block">About</a></li>
                                <li><a href="#" class="py-2 d-block">Journal</a></li>
                                <li><a href="#" class="py-2 d-block">Contact Us</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Help</h2>
                            <div class="d-flex">
                                <ul class="list-unstyled mr-l-5 pr-l-3 mr-4">
                                    <li><a href="#" class="py-2 d-block">Shipping Information</a></li>
                                    <li><a href="#" class="py-2 d-block">Returns &amp; Exchange</a></li>
                                    <li><a href="#" class="py-2 d-block">Terms &amp; Conditions</a></li>
                                    <li><a href="#" class="py-2 d-block">Privacy Policy</a></li>
                                </ul>
                                <ul class="list-unstyled">
                                    <li><a href="#" class="py-2 d-block">FAQs</a></li>
                                    <li><a href="#" class="py-2 d-block">Contact</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Have a Questions?</h2>
                            <div class="block-23 mb-3">
                                <ul>
                                    <li><span class="icon icon-map-marker"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
                                    <li><a href="#"><span class="icon icon-phone"></span><span class="text">+2 392 3929 210</span></a></li>
                                    <li><a href="#"><span class="icon icon-envelope"></span><span class="text">info@yourdomain.com</span></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">

                        <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart color-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </p>
                    </div>
                </div>
            </div>
            //model coupon
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
                            <% for (int i = 0; i < vl.size(); i++) {%>
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
                                            <h3 class="lead"><%= vl.get(i).getCodeID()%> </h3>
                                            <p class="text-muted mb-0"><%= vl.get(i).getName()%></p>
                                        </div>
                                    </div>
                                    <div class="kanan">
                                        <div class="info m-3 d-flex align-items-center">
                                            <div class="w-100">
                                                <div class="block">
                                                    <span class="time font-weight-light">
                                                        <span>Available: <%= vl.get(i).getQuantity()%></span>
                                                    </span>
                                                </div>
                                                <input type="checkbox" class="voucher" value="<%= vl.get(i).getCodeID()%>" onclick="setOne()"/>
                                                <input type="hidden"  class="voucherID" value="<%= vl.get(i).getVoucherID()%>" name="<%= vl.get(i).getCodeID()%>"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% }%>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" onclick="getVoucher()" class="btn btn-primary" data-dismiss="modal">Save</button>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                function useCumulative() {
                    let c = document.getElementById('cumulativePoint').attributes[2].value;
                    let c2 = document.getElementById('cumulativePoint');
                    if (c2.checked) {
                        var view = document.getElementById('cumulativeDiscount');
                        if (c > 0) {
                            var newCumulative = Number(c / 100);
                            view.innerHTML = "-" + newCumulative;
                            document.getElementById('cumulativeDiscount').style.display = "block";
                            document.getElementById('finalCumulative').attributes[2].value = c;
                        } else {
                            document.getElementById('cumulativeDiscount').style.display = "none";
                        }
                    } else {
                        document.getElementById('cumulativeDiscount').style.display = "none";
                    }
                }
            </script>
            <script>
                function setCucum() {
                    let c = document.getElementsByClassName('voucher');
                    var codeID;
                    for (var i = 0; i < v.length; i++) {
                        if (v[i].checked) {
                            codeID = v[i].attributes[2].value;
                        }
                    }
                    for (var j = 0; j < v.length; j++) {
                        v[j].checked = false;
                        if (v[j].attributes[2].value === codeID) {
                            v[j].checked = true;
                        }
                    }
                }
            </script>
            <script>
                function setOne() {
                    let v = document.getElementsByClassName('voucher');
                    var codeID;
                    for (var i = 0; i < v.length; i++) {
                        if (v[i].checked) {
                            codeID = v[i].attributes[2].value;
                        }
                    }
                    for (var j = 0; j < v.length; j++) {
                        v[j].checked = false;
                        if (v[j].attributes[2].value === codeID) {
                            v[j].checked = true;
                        }
                    }
                }
            </script>
            <script>
                function getVoucher() {
                    let v = document.getElementsByClassName('voucher');
                    var codeID = "";
                    document.getElementById('voucherUse').attributes[2].value = 0;
                    for (var i = 0; i < v.length; i++) {
                        if (v[i].checked) {
                            codeID = v[i].attributes[2].value;
                            let voucherIDs = document.getElementsByClassName('voucherID');
                            for (var t = 0; t < voucherIDs.length; t++) {
                                if (voucherIDs[t].attributes[3].value === v[i].attributes[2].value) {
                                    document.getElementById('voucherUse').attributes[2].value = voucherIDs[t].attributes[2].value;
                                }
                            }
                        }
                    }
                    var view = document.getElementById('voucherAffect');
                    view.innerHTML = codeID;
                    if (codeID === "cd01rd10ptforvse") {
                        var total = document.getElementById('total').attributes[2].value;
                        var view2 = document.getElementById('totalDiscount');
                        var tmpView2 = Number(total) - Number(total * 10 / 100);
                        view2.innerHTML = tmpView2;
                        document.getElementById('totalDiscount').style.display = "block";
                    } else if (codeID === "cd03rd30ptforvse") {
                        var total2 = document.getElementById('total').attributes[2].value;
                        var view3 = document.getElementById('totalDiscount');
                        var tmpView3 = Number(total2) - Number(total2 * 30 / 100);
                        view3.innerHTML = tmpView3;
                        document.getElementById('totalDiscount').style.display = "block";
                    } else {
                        document.getElementById('totalDiscount').style.display = "none";
                    }
                }
            </script>
            <script>
                function settotal() {
                    let p = document.getElementsByClassName('product');
                    let c = document.getElementsByClassName('checkEd');
                    let q = document.getElementsByClassName('sellerName');
                    var price;
                    var quantity;
                    var total = 0;
                    var bool;
                    for (var i = 0; i < p.length; i++) {
                        for (var m = 0; m < c.length; m++) {
                            if (c[m].attributes[2].value === p[i].attributes[3].value) {
                                if (c[m].attributes[1].value === "yes") {
                                    c[m].attributes[1].value = "no";
                                }
                            }
                        }

                        if (p[i].checked) {
                            for (var n = 0; n < c.length; n++) {
                                if (c[n].attributes[2].value === p[i].attributes[3].value) {
                                    c[n].attributes[1].value = "yes";
                                }
                            }
                            let prices = document.getElementsByClassName('cost');
                            for (var j = 0; j < prices.length; j++) {
                                if (prices[j].attributes[1].value === p[i].attributes[2].value) {
                                    price = prices[j].attributes[2].value;
                                }
                            }
                            let quantitys = document.getElementsByClassName('number');
                            for (var k = 0; k < quantitys.length; k++) {
                                if (quantitys[k].attributes[1].value === p[i].attributes[2].value) {
                                    quantity = quantitys[k].attributes[2].value;
                                }
                            }
                            total += Number(quantity) * Number(price);
                        } else {
                            for (var h = 0; h < q.length; h++) {
                                if (q[h].attributes[3].value === p[i].attributes[5].value) {
                                    q[h].checked = false;
                                }
                            }
                        }
                        var view = document.getElementById('total');
                        view.innerHTML = total;
                        view.attributes[2].value = total;
                    }
                    for (var g = 0; g < q.length; g++) {
                        for (var x = 0; x < p.length; x++) {
                            if (p[x].attributes[5].value === q[g].attributes[3].value) {
                                if (p[x].checked) {
                                    bool = true;
                                } else {
                                    bool = false;
                                    break;
                                }
                            }
                        }
                        if (bool) {
                            q[g].checked = true;
                        }
                    }
                }
            </script>

            <script>
                function setAll() {
                    let n = document.getElementsByClassName('sellerName');
                    let c = document.getElementsByClassName('checkEd');
                    var total = 0;
                    var price;
                    var quantity;
                    for (var i = 0; i < n.length; i++) {
                        if (n[i].checked) {
                            let p = document.getElementsByClassName('product');
                            for (var j = 0; j < p.length; j++) {
                                if (p[j].attributes[5].value === n[i].attributes[3].value) {
                                    p[j].checked = true;

                                    let prices = document.getElementsByClassName('cost');
                                    for (var k = 0; k < prices.length; k++) {
                                        if (prices[k].attributes[1].value === p[j].attributes[2].value) {
                                            price = prices[j].attributes[2].value;
                                        }
                                    }

                                    let quantitys = document.getElementsByClassName('number');
                                    for (var l = 0; l < quantitys.length; l++) {
                                        if (quantitys[l].attributes[1].value === p[j].attributes[2].value) {
                                            quantity = quantitys[l].attributes[2].value;
                                        }
                                    }

                                    total += Number(quantity) * Number(price);
                                    for (var x = 0; x < c.length; x++) {
                                        if (c[x].attributes[2].value === p[j].attributes[3].value) {
                                            c[x].attributes[1].value = "yes";
                                        }
                                    }
                                }
                                var view = document.getElementById('total');
                                view.innerHTML = total;
                                view.attributes[2].value = total;
                            }
                        } else {
                            let p = document.getElementsByClassName('product');
                            for (var j = 0; j < p.length; j++) {
                                if (p[j].attributes[5].value === n[i].attributes[3].value) {
                                    p[j].checked = false;
                                    for (var x = 0; x < c.length; x++) {
                                        if (c[x].attributes[2].value === p[j].attributes[3].value) {
                                            c[x].attributes[1].value = "no";
                                        }
                                    }
                                }
                            }
                            var view = document.getElementById('total');
                            view.innerHTML = total;
                            view.attributes[2].value = total;
                        }
                    }
                }
            </script>

            <script>
                // initially, should be false
                var checked_all = false;

                // cached them, so you can just reference them
                var check_all_button = document.querySelector('#check-all');
                var target_checkboxes = document.querySelectorAll('.checkboxes');

                /*
                 * if the user clicked on one of the checkboxes,
                 * either checked them or unchecked them,
                 * reset checked_all to false
                 */
                target_checkboxes.forEach(function (checkbox) {
                    checkbox.addEventListener('change', function () {

                        var unchecked = Array.prototype.slice.call(target_checkboxes).filter(checkbox => !checkbox.checked);

                        if (unchecked.length) {
                            checked_all = false;
                            check_all_button.checked = false;
                        } else {
                            checked_all = true;
                            check_all_button.checked = true;
                        }
                    });
                });

                /*
                 * when the user clicked on the check all button,
                 * check all the target checkboxes
                 */
                check_all_button.addEventListener('click', function () {
                    checked_all = !checked_all;
                    target_checkboxes.forEach(function (checkbox) {
                        checkbox.checked = checked_all;
                    });
                });
            </script>
        </footer>



        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


        <script src="js/jquery.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/jquery.waypoints.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/jquery.animateNumber.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/scrollax.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>
