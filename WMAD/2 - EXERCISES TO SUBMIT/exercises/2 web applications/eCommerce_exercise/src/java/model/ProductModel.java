package model;

import entity.Category;
import entity.Product;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.UserTransaction;


public class ProductModel {

    UserTransaction utx;
    EntityManager em;

    public ProductModel(EntityManager em, UserTransaction utx) {
        this.utx = utx;
        this.em = em;
    }
    
    
    public Product retrieve (int id){
        return em.find(Product.class, id);
    }
    
    public List<Product> retrieveAll(){
        Query q;
        q = em.createQuery("select p from Product as p");
        return q.getResultList();
    }

    public List<Product> retrievebyCategory(Category category){
        Query q = em.createQuery("SELECT p FROM Product p WHERE p.category=:category");
        q.setParameter("category", category);
        return q.getResultList(); 
    }
    
}
