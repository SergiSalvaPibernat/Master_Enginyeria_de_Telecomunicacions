package web.action;

import cart.ShoppingCart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import web.ViewManager;

public class clearcartAction implements Action{
    
    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        
        ShoppingCart cartSession = (ShoppingCart) req.getSession().getAttribute("cart");
        cartSession.clear();
        ViewManager.nextView(req, resp, "/view/shoppingcart.jsp");
    }
    
}
