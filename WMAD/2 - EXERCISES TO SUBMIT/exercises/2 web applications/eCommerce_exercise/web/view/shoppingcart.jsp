<%-- 
    Document   : shoppingcart
    Created on : Oct 10, 2023, 4:43:07 PM
    Author     : entel
--%>

<%@page import="cart.ShoppingCartItem"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<%@ page import="entity.Category"%>
<%@ page import="entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="cart.ShoppingCart" %>

<head>
    <meta http-equiv="Expires" CONTENT="0">
    <meta http-equiv="Cache-Control" CONTENT="no-cache">
    <meta http-equiv="Pragma" CONTENT="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    
    <title>ShoppingCart</title>
</head>

<body>
    
 <% Category category1 = (Category)request.getAttribute("category");
    ShoppingCart cart = (ShoppingCart)request.getSession().getAttribute("cart");
    int items = 0;
    if (cart != null){
        items=cart.getNumberOfItems();
    }
    %>
    
    <h2>Your shopping cart contains <%=items%> items</h2>
    
    <p>
        <img src="img/cart.gif"
             alt="shopping cart icon" > <%=items%> items
       
        
        <br></br>
        
            <a href="clearcart.do">
                Clear cart
            </a>
        
        <br></br>
        
            <a href="init.do">
                Continue shopping
            </a>
        
        <br></br>
        
            <a href="checkout.do">
                Proceed to checkout
            </a>
      
    </p>

    <table width="100%" border="1" bordercolordark="#000000" bordercolorlight="#FFFFFF" cellpadding="3" cellspacing="0">
    <tr>
        <td>Product</td>
        <td>Name</td>
        <td>Price</td>
        <td>Quantity</td>
                <%
                List<ShoppingCartItem> shoppingcart = cart.getItems();
                for (ShoppingCartItem cart1 : shoppingcart) {
                    Product product=cart1.getProduct();
                    int quantity=cart1.getQuantity();
                %>
                <tr>
                    <td width="20%" valign="center" align="middle" >
                        <img src="img/products/<%=product.getName() %>.png"
                             alt="<%=product.getName()%>" >
                    </td>
                    <td width="20%" valign="center" align="middle" >
                        <h3><%=product.getName()%></h3>
                        <p><%=product.getDescription()%></p>
                    </td>
                    <td width="20%" valign="center" align="middle" >
                        <p><%=product.getPrice()%> euros </p>
                    </td>
                    <td width="20%" valign="center" align="middle" >
                        <form action="updatecart.do" method="post">
                            <input type=text
                                   name="quantity"
                                   value="<%=quantity%>">
                            <input type="hidden"
                                   name="productid"
                                   value="<%=product.getId()%>">
                            <input type="submit"
                                   name="update"
                                   value="update">                       
                        </form>
                    </td>
                </tr>
                <% } %>
            </table> 
        </td>
    </tr>
    </table>
    <p>Total amount: <%=String.format("%.2f", cart.getTotal())%> euros</p>
</body>
