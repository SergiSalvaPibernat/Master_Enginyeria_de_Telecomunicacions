package web.action;

import entity.Category;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoryModel;
import model.ProductModel;
import web.ViewManager;


public class categoryAction implements Action {
    
    CategoryModel categoryModel;
    ProductModel productModel;

    public categoryAction(CategoryModel categoryModel, ProductModel productModel){
        this.categoryModel = categoryModel;
        this.productModel = productModel;
    }

    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        String category_str_id = (String) req.getParameter("categoryid");
        int category_id=0;
        if (category_str_id != null){
            category_id = Integer.parseInt(category_str_id);
        }             
        Category category = categoryModel.retrieve(category_id);
        req.setAttribute("category", category);
        req.setAttribute("categories", categoryModel.retrieveAll());
        req.setAttribute("products", productModel.retrievebyCategory(category));
        ViewManager.nextView(req, resp, "/view/category.jsp");       
    }
}