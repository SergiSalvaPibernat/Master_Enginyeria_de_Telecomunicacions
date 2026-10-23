package web.action;

import cart.ShoppingCart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import web.ViewManager;


public class checkoutAction implements Action{
     @Override
     public void perform(HttpServletRequest req, HttpServletResponse resp){
        ShoppingCart cartSession = (ShoppingCart) req.getSession().getAttribute("cart");
        if (cartSession == null){
            cartSession = new ShoppingCart();
            req.getSession().setAttribute("cart", cartSession);
        }
        double amount=cartSession.getTotal();
        req.setAttribute("totalamount", amount);
        ViewManager.nextView(req, resp, "/view/checkout.jsp");
     }
}
