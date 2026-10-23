package web.action;

import cart.ShoppingCart;
import entity.Category;
import entity.Product;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoryModel;
import model.ProductModel;
import web.ViewManager;

public class neworderAction implements Action{
    
    CategoryModel categoryModel;
    ProductModel productModel;

    public neworderAction(CategoryModel categoryModel, ProductModel productModel){
        this.categoryModel = categoryModel;
        this.productModel = productModel;
    }
    
    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        String product_str_id = (String) req.getParameter("productid");
        int product_id = 0;
        if (product_str_id != null){
            product_id = Integer.parseInt(product_str_id);
        }        
        Product product=productModel.retrieve(product_id);
        Category category=categoryModel.retrieve(product.getCategory().getId());
        req.setAttribute("category", category);
        req.setAttribute("products", productModel.retrievebyCategory(category));
        req.setAttribute("categories", categoryModel.retrieveAll());
        ShoppingCart cartSession = (ShoppingCart) req.getSession().getAttribute("cart");
        if (cartSession == null){
            cartSession = new ShoppingCart();
            req.getSession().setAttribute("cart", cartSession);
        }
        cartSession.addItem(product);
        ViewManager.nextView(req, resp, "/view/category.jsp"); 
        
    }
}
