package cart;

import entity.Product;

/**
 *
 * @author juanluis
 */
public class ShoppingCartItem {

    Product cartproduct = new Product();
    int quantity;
    double price;
    
    public ShoppingCartItem(Product product){
        cartproduct=product;
        quantity=1;
        price=product.getPrice();
    }
    
    public Product getProduct(){
        return cartproduct;
    }
    
    public int getQuantity(){
        return quantity;        
    }
    
    public void setQuantity(int quantity){
        this.quantity=quantity;
    }
    
    public double getTotal(){
        return price*quantity;
    }
    

}