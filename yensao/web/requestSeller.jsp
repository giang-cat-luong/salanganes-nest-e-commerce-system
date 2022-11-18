<%-- 
    Document   : requestSeller
    Created on : Oct 19, 2022, 2:33:46 PM
    Author     : lequa
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Educational registration form</title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet">
        <style>

            html, body {
                min-height: 100%;
            }
            body, div, form, input, select, p {
                padding: 0;
                margin: 0;
                outline: none;
                font-family: Roboto, Arial, sans-serif;
                font-size: 16px;
                color: #eee;
            }
            h1, h2 {
                text-transform: uppercase;
                font-weight: 400;
            }
            h2 {

                margin: 0 0 0 8px;
            }
            .main-block {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100%;
                padding: 25px;
                background: rgba(0, 0, 0, 0.5);
            }
            .left-part, form {
                padding: 25px;
            }
            .left-part {
                text-align: center;
            }
            .fa-users {
                font-size: 72px;
            }
            .form-register {
                border: 1px solid;
                border-radius: 20px;
                background: rgba(0, 0, 0, 0.7);
            }
            .title {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .info {
                display: flex;
                flex-direction: column;
            }
            input, select {
                padding: 5px;
                margin-bottom: 30px;
                background: transparent;
                border: none;
                border-bottom: 1px solid #eee;
            }
            input::placeholder {
                color: #eee;
            }
            option:focus {
                border: none;
            }
            option {
                background: black;
                border: none;
            }
            .checkbox input {
                margin: 0 10px 0 0;
                vertical-align: middle;
            }
            .checkbox a {
                color: #26a9e0;
            }
            .checkbox a:hover {
                color: #85d6de;
            }
            .btn-item, button {
                padding: 10px 5px;
                margin-top: 20px;
                border-radius: 5px;
                border: none;
                background: #26a9e0;
                text-decoration: none;
                font-size: 15px;
                font-weight: 400;
                color: #fff;
            }
            .btn-item {
                display: inline-block;
                margin: 20px 5px 0;
            }
            button {
                width: 100%;
            }
            button:hover, .btn-item:hover {
                background: #85d6de;
            }
            @media (min-width: 568px) {
                html, body {
                    height: 100%;
                }
                .main-block {
                    flex-direction: row;
                    height: calc(100% - 50px);
                }
                .left-part, form {
                    flex: 1;
                    height: auto;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="main-block" style="background-color: #fff;background: url(images/seller.png)">
            <div class="left-part">
                <i class="fa-solid fa-users"></i>
                <h1>Register to be a seller </h1>
                <p>Register to participate in the largest e-commerce system in Vietnam, become a seller to receive countless incentives.</p>
                <div class="btn-group">
                    <a class="btn-item" href="customerProfile.jsp">Profile</a>
                </div>
            </div>
            <form action="MainController" class="form-register">
                <div class="title">
                    <i class="fas fa-pencil-alt"></i> 
                    <h2 style="color: #fff;">Register here</h2>
                </div>
                <div class="info">
                    <input class="fname" type="text" value="" name="name" placeholder="Full name">
                    <label for="w3review">Write your desire here:</label>
                    <textarea id="id" name="detail" value="" rows="5" cols="10"></textarea>

                </div>
                <div class="checkbox">
                    <input type="checkbox" name="checkbox"><span>I agree to the <a href="#">Privacy Policy for Salanganes Nest.</a></span>
                    <c:if test="${requestScope.REQUEST_INFOR != null}">
                        <div style="background: #26a9e0;border: 1px solid;border-radius: 5px; margin-bottom: 10px;text-align: center">
                            <h6 style="color:#fff;padding: 5px"><i class="fa fa-pencil-alt"></i>${requestScope.REQUEST_INFOR}</h6>                
                        </div>
                                     
                    </c:if>
                </div>
                <input type="hidden" name="cusID" value="${sessionScope.CUSTOMER_LOGIN.id}" />
                <button type="submit" name="action" value="AddRequest" href="customerProfile.jsp" style="background-color:  #FF5500;">Submit</button>
            </form>
        </div>
    </body>
</html>
