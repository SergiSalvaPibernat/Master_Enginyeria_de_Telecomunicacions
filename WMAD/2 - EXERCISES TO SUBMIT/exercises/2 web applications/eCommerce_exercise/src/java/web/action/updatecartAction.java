package web.action;

import cart.ShoppingCart;
import entity.Category;
import entity.Product;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoryModel;
import model.ProductModel;
import web.ViewManager;


public class updatecartAction implements Action {
    
    ProductModel productModel;
 

    public updatecartAction(ProductModel productModel){

        this.productModel = productModel;
    }
    
    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        
        ShoppingCart cartSession = (ShoppingCart) req.getSession().getAttribute("cart");
        if (cartSession == null){
            cartSession = new ShoppingCart();
            req.getSession().setAttribute("cart", cartSession);
        }
        String product_str_id = (String) req.getParameter("productid");
        int product_id = 0;
        if (product_str_id != null){
            product_id = Integer.parseInt(product_str_id);
        } 
        Product product = productModel.retrieve(product_id);        
        String quantity = (String)req.getParameter("quantity");
        int quant = 0;
        if (quantity != null){
            quant = Integer.parseInt(quantity);
        }
        cartSession.update(product, quant);
        req.getSession().setAttribute("cart", cartSession);
        ViewManager.nextView(req, resp, "/view/shoppingcart.jsp");
        
       
    }
    
}