package web.action;

import cart.ShoppingCart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import web.ViewManager;

public class viewcartAction implements Action{
    
    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        
        ShoppingCart cartSession = (ShoppingCart) req.getSession().getAttribute("cart");
        req.setAttribute("products", cartSession.getItems());
        ViewManager.nextView(req, resp, "/view/shoppingcart.jsp");
    }
    
}
