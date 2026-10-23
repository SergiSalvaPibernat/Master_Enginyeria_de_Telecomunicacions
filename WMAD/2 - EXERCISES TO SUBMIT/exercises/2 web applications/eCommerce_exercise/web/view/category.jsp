<%@ page import="entity.Category"%>
<%@ page import="entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="cart.ShoppingCart" %>

<head>
    <meta http-equiv="Expires" CONTENT="0">
    <meta http-equiv="Cache-Control" CONTENT="no-cache">
    <meta http-equiv="Pragma" CONTENT="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    
    <title>Products for Category</title>
</head>

<body>
    
 <% Category category1 = (Category)request.getAttribute("category");
    ShoppingCart cart = (ShoppingCart)request.getSession().getAttribute("cart");
    int items = 0;
    if (cart != null){
        items=cart.getNumberOfItems();
    }
    %>
    
    <h2>Products of <%=category1.getName()%></h2>
    
    <p>
        <img src="img/cart.gif"
             alt="shopping cart icon" > <%=items%> items
       
            <a href="viewcart.do">
                View cart
            </a>
        
        <br></br>
        
            <a href="checkout.do">
                Proceed to checkout
            </a>
            
    </p>

    <table width="100%" border="1" bordercolordark="#000000" bordercolorlight="#FFFFFF" cellpadding="3" cellspacing="0">
    <tr>
        <td width="20%" valign="center" align="middle" >
            <table width="100%" border="1" bordercolordark="#000000" bordercolorlight="#FFFFFF" cellpadding="3" cellspacing="0">
               <%
                List<Category> categories = (List<Category>)request.getAttribute("categories");
                for (Category category : categories) {
                %>
                <tr>
                    <td width="10%" valign="center" align="middle" >
                        <a href="category.do?categoryid=<%=category.getId()%>">
                        <%=category.getName() %>
                        </a>
                    </td>
                </tr>
                <% } %>
            </table>
        </td>
        <td width="80%" valign="center" align="middle" >
            <table width="100%" border="1" bordercolordark="#000000" bordercolorlight="#FFFFFF" cellpadding="3" cellspacing="0">
                <%
                List<Product> products = (List<Product>)request.getAttribute("products");
                for (Product product : products) {
                %>
                <tr>
                    <td width="20%" valign="center" align="middle" >
                        <img src="img/products/<%=product.getName()%>.png"
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
                        <form action="neworder.do" method="post">
                            <input type="hidden"
                                   name="productid"
                                   value="<%=product.getId()%>">
                            <input type="hidden"
                                   name="category"
                                   value="<%=product.getCategory()%>">
                            <input type="submit"
                                   name="submit"
                                   value="add to cart">                       
                        </form>
                    </td>
                </tr>
                <% } %>
            </table> 
        </td>
    </tr>
    </table>
</body>
