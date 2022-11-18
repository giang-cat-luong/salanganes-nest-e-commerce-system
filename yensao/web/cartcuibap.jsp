<%@page import="product.dto.Product"%>
<%@page import="product.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<body>
    <%   ArrayList<Product> pl = new ArrayList<>();
        Product p1 = new Product("Y1", "Yen Sao", 3, 10);
        Product p2 = new Product("Y2", "Yen Nuoc", 2, 10);
        Product p3 = new Product("Y3", "Yen Yen Tinh Che", 7, 10);
        Product p4 = new Product("Y4", "Yen Colagen", 10, 10);
        pl.add(p1);
        pl.add(p2);
        pl.add(p3);
        pl.add(p4);
        for (Product pr : pl) {
    %>
    <input type="checkbox" onclick="settotal()" name="<%= pr.getProductName()%>" value="<%= pr.getPrice()%>" class= "product"/> <%= pr.getProductName()%> </br>
    <%= pr.getProductID()%> </br>
    <%= pr.getPrice()%> </br>
    <%= pr.getQuantity()%> </br>
    <input type ="hidden" class ="price" name="<%= pr.getProductName()%>" value="<%= pr.getPrice()%>" />
    <input type ="hidden" class ="quantity" name="<%= pr.getProductName()%>" value="<%= pr.getQuantity()%>" />
    <input type="hidden"  name="productID"  value="0" />
    <% }%>
    <br>
    <div id="total" style="color: red">0</div>


    </br>
</body>