<%-- 
    Document   : checkout
    Created on : Oct 14, 2022, 3:01:41 AM
    Author     : Truong Giang
--%>
<%@page import="customer.dto.Customer"%>
<%@page import="others.OtherDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Checkout</title>
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
    </head>
    <body class="goto-here">
        <%
            String[] productID = (String[]) request.getAttribute("PRODUCT_ID_LIST");
            int voucherID = (int) request.getAttribute("VOUCHER_ID");
            if (voucherID == 0) {
                voucherID = 0;
            }
            float cumulative = (float) request.getAttribute("CUMULATIVE");
            if (cumulative == 0) {
                cumulative = 0;
            }
            float total = (float) request.getAttribute("TOTAL");
            Customer cus = (Customer) session.getAttribute("CUSTOMER_LOGIN");
        %>
        <jsp:include page="header.jsp"/>
        <!-- END nav -->

        <div class="hero-wrap hero-bread" style="background-image: url('images/YẾN THÔ LOẠI 2.jpg');">
            <div class="container">
                <div class="row no-gutters slider-text align-items-center justify-content-center">
                    <div class="col-md-9 ftco-animate text-center">
                        <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Checkout</span></p>
                        <h1 class="mb-0 bread">Checkout</h1>
                    </div>
                </div>
            </div>
        </div>

        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-7 ftco-animate">
                        <form action="#" class="billing-form">
                            <h3 class="mb-4 billing-heading">Billing Details</h3>
                            <div class="row align-items-end">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="firstname">First Name</label>
                                        <input type="text" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="lastname">Last Name</label>
                                        <input type="text" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div class="w-100"></div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="country">Province</label>
                                        <div class="select-wrap">
                                            <div class="icon"><span class="ion-ios-arrow-down"></span></div>
                                            <select name="" id="" class="form-control">
                                                <option value="">TP Hồ Chí Minh</option>
                                                <option value="">Đà Nẵng</option>
                                                <option value="">Cần Thơ</option>
                                                <option value="">Bà Rịa</option>
                                                <option value="">Hà Nội</option>
                                                <option value="">Kiên Giang</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="w-100"></div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="streetaddress">Street Address</label>
                                        <input type="text" class="form-control" placeholder="House number and street name">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="Appartment, suite, unit etc: (optional)">
                                    </div>
                                </div>
                                <div class="w-100"></div>

                                <div class="w-100"></div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="phone">Phone</label>
                                        <input type="text" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="emailaddress">Email Address</label>
                                        <input type="text" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div class="w-100"></div>

                            </div>
                        </form><!-- END -->
                    </div>
                    <div class="col-xl-5">
                        <div class="row mt-5 pt-3">
                            <div class="col-md-12 d-flex mb-5">
                                <div class="cart-detail cart-total p-3 p-md-4">
                                    <h3 class="billing-heading mb-4">Cart Total</h3>
                                    <p class="d-flex">
                                        <span>Subtotal</span>
                                        <span>$<%= total%></span>
                                    </p>
                                    <p class="d-flex">
                                        <span>Cumulative</span>
                                        <%
                                            float newTotal = 0;
                                            float newCumulative = 0;
                                            if (cumulative != 0) {
                                                newCumulative = cumulative / 100;
                                            }
                                        %>
                                        <span>- $<%= newCumulative%></span>
                                    </p>
                                    <p class="d-flex">
                                        <%
                                            String keyCode = "";
                                            if (voucherID != 0) {
                                                keyCode = OtherDAO.getKeyCode(voucherID);
                                            }
                                            if (keyCode.equalsIgnoreCase("RD10PT")) {
                                                newTotal = total / 10;
                                            } else if (keyCode.equalsIgnoreCase("RD20PT")) {
                                                newTotal = (total * 2) / 10;
                                            } else if (keyCode.equalsIgnoreCase("RD30PT")) {
                                                newTotal = (total * 3) / 10;
                                            }
                                        %>

                                        <span>Discount</span>
                                        <span>$<%= newTotal%></span>
                                        <% newTotal = total - newTotal - newCumulative;%>
                                    </p>
                                    <hr>
                                    <p class="d-flex total-price">
                                        <span>Total</span>
                                        <span>$<%= newTotal%></span>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="cart-detail p-3 p-md-4">
                                    <form action="MainController">
                                        <h3 class="billing-heading mb-4">Payment Method</h3>
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="radio">
                                                    <label><input type="checkbox"  name="CheckOut" class="mr-2" id="DirectCash" onclick="selectMethod()"> Direct Cash</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="radio" id="paypal-button">
                                                    <input type="checkbox" name="optradio" value="PayPal" class="mr-2" id="PayPal" onclick="selectMethod()">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="checkbox">
                                                    <label><input type="checkbox" class="mr-2" id="CheckTerm"> I have read and accept the terms and conditions</label>                                               
                                                </div>
                                            </div>
                                        </div>

                                        <div>
                                            <%
                                                for (String s : productID) {
                                            %>
                                            <input type="hidden" name="productID" value="<%= s%>" />
                                            <% }%>
                                            <input type="hidden" name="cumulative" value="<%= cumulative%>" />
                                            <input type="hidden" name="voucherID" value="<%= voucherID%>" />
                                            <input type="hidden" name="cusID" value="<%= cus.getId()%>" />
                                            <input type="submit" placeholder="Accept Checkout" name="action" value="" class="btn btn-primary py-3 px-4" id="ConFirm" />
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div> <!-- .col-md-8 -->
                </div>
            </div>
        </section> <!-- .section -->

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
        <!-- Replace "test" with your own sandbox Business account app client ID -->
        <script src="https://www.paypal.com/sdk/js?client-id=test&currency=USD"></script>
        <!-- Set up a container element for the button -->

        <script src="https://www.paypalobjects.com/api/checkout.js"></script>
        <script>
                                function selectMethod() {
                                    let p = document.getElementById("PayPal");
                                    let d = document.getElementById("DirectCash");
                                    let a = document.getElementById("ConFirm");
                                    if (p.checked) {
                                        a.attributes[3].value = p.attributes[2].value;
                                    } else if (d.checked) {
                                        a.attributes[3].value = d.attributes[1].value;
                                    } else {
                                        a.attributes[3].value = " ";
                                    }
                                }
        </script>
        <script>
            paypal.Button.render({
                // Configure environment
                env: 'sandbox',
                client: {
                    sandbox: 'AVLAAoy6DuzTIh6JnQx7DrqQM-F7e9L_P9-Ydb8TWpxqanWa_sP-DxIc5cUmxXxjM8sT8sQo0oKe87no',
                    production: 'demo_production_client_id'
                },
                // Customize button (optional)
                locale: 'en_US',
                style: {
                    size: 'small',
                    color: 'gold',
                    shape: 'pill',
                },

                // Enable Pay Now checkout flow (optional)
                commit: true,

                // Set up a payment
                payment: function (data, actions) {
                    return actions.payment.create({
                        transactions: [{
                                amount: {
                                    total: '17.60',
                                    currency: 'USD'
                                }
                            }]
                    });
                },
                // Execute the payment
                onAuthorize: function (data, actions) {
                    return actions.payment.execute().then(function () {
                        // Show a confirmation message to the buyer
                        window.alert('Thank you for your purchase!');
                    });
                }
            }, '#paypal-button');

        </script>

        <script>
            // Set up a payment
            payment: function (data, actions) {
                return actions.payment.create({
                    transactions: [{
                            amount: {
                                total: '30.11',
                                currency: 'USD',
                                details: {
                                    subtotal: '30.00',
                                    tax: '0.07',
                                    shipping: '0.03',
                                    handling_fee: '1.00',
                                    shipping_discount: '-1.00',
                                    insurance: '0.01'
                                }
                            },
                            description: 'The payment transaction description.',
                            custom: '90048630024435',
                            //invoice_number: '12345', Insert a unique invoice number
                            payment_options: {
                                allowed_payment_method: 'INSTANT_FUNDING_SOURCE'
                            },
                            soft_descriptor: 'ECHI5786786',
                            item_list: {
                                items: [
                                    {
                                        name: 'hat',
                                        description: 'Brown hat.',
                                        quantity: '5',
                                        price: '3',
                                        tax: '0.01',
                                        sku: '1',
                                        currency: 'USD'
                                    },
                                    {
                                        name: 'handbag',
                                        description: 'Black handbag.',
                                        quantity: '1',
                                        price: '15',
                                        tax: '0.02',
                                        sku: 'product34',
                                        currency: 'USD'
                                    }],
                                shipping_address: {
                                    recipient_name: 'Brian Robinson',
                                    line1: '4th Floor',
                                    line2: 'Unit #34',
                                    city: 'San Jose',
                                    country_code: 'US',
                                    postal_code: '95131',
                                    phone: '011862212345678',
                                    state: 'CA'
                                }
                            }
                        }],
                    note_to_payer: 'Contact us for any questions on your order.'
                });
            }
            ,
        </script>
    </body>
</html>
