<%-- 
    Document   : singleProduct
    Created on : Oct 28, 2022, 8:37:57 AM
    Author     : Truong Giang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Single Product</title>
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

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">

        <script src="https:/xc//cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body class="goto-here">
        <jsp:include page="header.jsp"/>
        <div class="hero-wrap hero-bread" style="background-image: url('images/banner.jpg');">
            <div class="container">
                <div class="row no-gutters slider-text align-items-center justify-content-center">
                    <div class="col-md-9 ftco-animate text-center">
                        <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span class="mr-2"><a href="index.html">Product</a></span> <span>Product Single</span></p>
                        <h1 class="mb-0 bread">Product Single</h1>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${requestScope.SINGLE_PRODUCT != null}">
            <c:if test="${not empty requestScope.SINGLE_PRODUCT}">
                <section class="ftco-section" >
                    <div class="container" >
                        <div class="row border" style="padding: 10px 10px 0px 10px;border-radius: 10px;border :30px outset #fff ;">
                            <div class="col-lg-6 mb-5 ftco-animate">
                                <a href="https://toyenkhanhhoa.vn/wp-content/uploads/2019/01/2-400x400.jpg" class="image-popup"><img style="height: 400px" src="${requestScope.SINGLE_PRODUCT.cover}" class="img-fluid" alt="Colorlib Template"></a>
                            </div>

                            <div class="col-lg-6 product-details pl-md-5 ftco-animate">
                                <form id="SBF" action="MainController">
                                    <h3 >${requestScope.SINGLE_PRODUCT.productName}</h3>
                                    <div class="rating d-flex">
                                        <p class="text-left mr-4">
                                            <a href="#" class="mr-2" style="border-bottom: 2px solid #ff5500; ">${requestScope.SUM_RATE}</a>
                                            <a href="#"><span class="ion-ios-star-outline"></span></a>
                                            <a href="#"><span class="ion-ios-star-outline"></span></a>
                                            <a href="#"><span class="ion-ios-star-outline"></span></a>
                                            <a href="#"><span class="ion-ios-star-outline"></span></a>
                                            <a href="#"><span class="ion-ios-star-outline"></span></a>
                                        </p>

                                        <a href="#" class="mr-2" style="color: #000;"><p style="border-bottom: 2px solid #ff5500; margin-bottom: 0">100<p/><span style="color: #bbb;"> Rating </span></a>

                                        <p class="text-left">
                                            <a href="#" class="mr-2" style="color: #000;margin-left: 10px">${requestScope.TOTAL_SELL}<span style="color: #bbb;"> Sold</span></a>
                                        </p>
                                    </div>
                                    <p class="price"><span>${requestScope.SINGLE_PRODUCT.price}$</span></p>
                                    <p>${requestScope.SINGLE_PRODUCT.description}
                                    </p>
                                    <div class="row mt-4">
                                        <div class="input-group col-md-6 d-flex mb-3">
                                            <span class="input-group-btn mr-2">
                                                <button type="button" onclick="setMinus()" class="quantity-left-minus btn"  data-type="minus" data-field="">
                                                    <i class="ion-ios-remove"></i>
                                                </button>
                                            </span>
                                            <input type="text" id="number" name="quantity" class="form-control input-number" value="1" min="1" max="100">
                                            <span class="input-group-btn ml-2">
                                                <button type="button" onclick="setAdd()"class="quantity-right-plus btn" data-type="plus" data-field="">
                                                    <i class="ion-ios-add"></i>
                                                </button>
                                            </span>
                                        </div>
                                        <div class="w-100"></div>

                                    </div>
                                    <div class="col-md-12 d-flex mb-3" style="margin-top: 50px">
                                        <c:if test="${sessionScope.CUSTOMER_LOGIN != null }">
                                            <p><a href="MainController?action=AddWishList&productID=${requestScope.SINGLE_PRODUCT.productID}&quantity=1&cusID=${sessionScope.CUSTOMER_LOGIN.id}" class="btn btn-black py-3 px-3">Add to Wishlist</a></p>
                                            <input type="hidden" name="productID" value="${requestScope.SINGLE_PRODUCT.productID}"/>
                                            <input type="hidden" name="sellerID" value="${requestScope.SINGLE_PRODUCT.sellerID}"/>
                                            <input type="hidden" name="cover" value="${requestScope.SINGLE_PRODUCT.cover}"/>
                                            <input type="hidden" name="productName" value="${requestScope.SINGLE_PRODUCT.productName}"/>
                                            <input type="hidden" name="cateName" value="${requestScope.SINGLE_PRODUCT.cateName}"/>
                                            <input type="hidden" name="description" value="${requestScope.SINGLE_PRODUCT.description}"/>
                                            <input type="hidden" name="price" value="${requestScope.SINGLE_PRODUCT.price}"/>
                                            <button type="submit" name="action" value="AddToCart" style="
                                                    border-radius: 30px;
                                                    color: #ff5500;
                                                    margin-left: 5px;
                                                    padding-bottom: 40px;
                                                    padding-top: 18px
                                                    ">Add To Cart</button>
                                        </c:if>
                                        <c:if test="${sessionScope.CUSTOMER_LOGIN == null }">
                                            <p><a href="login.jsp" class="btn btn-black py-3 px-3">Add to Wishlist</a></p>
                                            <p><a href="login.jsp" class="btn btn-black py-3 px-3" style="margin-left: 5px">Add to Cart</a></p>
                                        </c:if>
                                    </div>
                                </form>
                            </div>

                        </div>

                        <div class="row border" style="background-color: #fff; margin-top: 10px;border-radius: 10px inset ;border-radius: 10px;box-shadow: 5px 10px #f5f5f5;" >

                            <div class="col-md-3 ftco-animate" style="margin: 10px 0px 10px 50px">
                                <div class='row'>
                                    <div class="col">
                                        <img src="${requestScope.SELLER_PRODUCT.avatar}" class="rounded-circle mb-3" style="width: 80px;"
                                             alt="Avatar" />
                                        <h5><strong >${requestScope.SELLER_PRODUCT.name}</strong></h5>
                                    </div>
                                    <div class="col">
                                        <span class="badge text-bg-danger" style="margin-top: 1px; font-size: 15px "><span class="icon-backward"> 15 Days Return</span></span>
                                        <span class="badge text-bg-warning" style="margin-top: 20px;font-size: 15px"><span class="icon-check"/> 100% Authentic</span></span>
                                        <span class="badge text-bg-success" style="margin-top: 20px;font-size: 15px"><span class="icon-ambulance"/> Free Shipping</span></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" style="margin: 10px 0px 10px 50px">
                                <p class="fw-bolder"><span class="icon-phone">  ${requestScope.SELLER_PRODUCT.phone}.</p>
                                <p class="fw-bolder"><span class="icon-envelope">  ${requestScope.SELLER_PRODUCT.email}.</p>
                                <p class="fw-bolder"><span class="icon-address-card">  ${requestScope.SELLER_PRODUCT.location}.</p>
                            </div>
                            <div class="col-md-4" style="margin: 10px 0px 10px 50px;border-left: 1px solid #ff5500">
                                <p class="fw-bolder" style="padding-left: 70px"> <span style="color: #ff5500">Response Rate</span> 86%</p>
                                <p class="fw-bolder" style="padding-left: 70px"> <span style="color: #ff5500">Response Time</span> within hours</p>
                                <p class="fw-bolder" style="padding-left: 70px"> <span style="color: #ff5500">Products</span> 12</p>
                            </div>
                        </div>

                    </div>
                </section>
            </c:if>
        </c:if>
        <div class="container">
            <div class="row ">
                <h3>Product Ratings</h3>
            </div>
        </div>

        <div class="container mt-1">

            <div class="row ">

                <div class="col-md-12">
                    <c:forEach var="cmt" items="${requestScope.ALL_RATE}">
                        <div class="card">
                            <ul class="list-unstyled">
                                <!--FIRST LIST ITEM-->
                                <li class="media"> <span class="round pt-2"><img src="${cmt.cover}" class="align-self-start mr-3" style="width: 100px"></span>
                                    <div class="media-body">
                                        <div class="row d-flex">
                                            <h6 class="user pt-2">${cmt.cusName}</h6>
                                            <div class="ml-auto">
                                                <p class="text">3m</p>
                                            </div>
                                        </div>
                                        <p class="text">${cmt.detail}</p>
                                        <div class="images mt-2"> <img src="${cmt.img}" /> <img src="https://img.icons8.com/bubbles/100/000000/check-male.png" /> <img src="https://img.icons8.com/bubbles/100/000000/lock-female-user.png" /> <img src="https://img.icons8.com/bubbles/100/000000/lock-male-user.png" /> </div>
                                    </div>
                                </li>
                                <hr style="height:1px;border-width:0;color:gray;background-color:gray;margin-left:50px;margin-right:50px">

                            </ul>
                        </div>
                    </c:forEach>
                </div>

            </div>

        </div>

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
        <script>
                                function myFunction() {
                                    document.getElementById("GFG").submit();
                                }
        </script>
        <script>
            function setAdd() {
                let a = document.getElementById('number');
                var currentQuantity = a.attributes[4].value;
                var newQuantity = Number(currentQuantity) + 1;
                a.attributes[4].value = newQuantity;
            }
        </script>
        <script>
            function setMinus() {
                let a = document.getElementById('number');
                var newQuantity = 0;
                var currentQuantity = a.attributes[4].value;
                if (Number(currentQuantity) > 0) {
                    newQuantity = Number(currentQuantity) - 1;
                } else {
                    newQuantity = Number(currentQuantity);
                }
                a.attributes[4].value = newQuantity;
            }
        </script>
        <script>
            $(document).ready(function () {

                var quantity = 0;
                $('.quantity-right-plus').click(function (e) {

                    // Stop acting like a button

                    // Get the field name
                    var quantity = parseInt($('#quantity').val());

                    // If is not undefined

                    $('#quantity').val(quantity + 1);


                    // Increment

                });

                $('.quantity-left-minus').click(function (e) {
                    // Stop acting like a button
                    e.preventDefault();
                    // Get the field name
                    var quantity = parseInt($('#quantity').val());

                    // If is not undefined

                    // Increment
                    if (quantity > 0) {
                        $('#quantity').val(quantity - 1);
                    }
                });

            });
        </script>

    </body>
</html>
