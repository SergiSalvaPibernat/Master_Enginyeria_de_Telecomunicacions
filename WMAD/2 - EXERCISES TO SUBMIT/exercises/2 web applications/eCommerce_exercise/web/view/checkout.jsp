<%-- 
    Document   : checkout
    Created on : Oct 28, 2023, 11:15:26 AM
    Author     : entel
--%>

<%@page import="cart.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>checkout</title>
    </head>
    <body>
        <%Double totalamount = (Double)request.getAttribute("totalamount");%>
        <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
            <input type="hidden" name="cmd" value="_xclick">
            <input type="hidden" name="business" value="sergisp97@gmail.com">
            <input type="hidden" name="item_name" value="Shopping Cart Payment">
            <input type="hidden" name="currency_code" value="EUR">
            <input type="hidden" name="amount" value="<%=totalamount%>">
            <input type="image" src="http://www.paypal.com/en_US/i/btn/x-click-but01.gif" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
        </form>
    </body>
</html>
