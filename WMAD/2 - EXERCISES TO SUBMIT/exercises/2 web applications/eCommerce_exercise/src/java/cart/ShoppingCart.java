package cart;

import static com.sun.faces.config.WebConfiguration.DisableUnicodeEscaping.False;
import entity.Product;
import java.util.*;

/**
 *
 * @author juanluis
 */
public class ShoppingCart {
    
    List<ShoppingCartItem> cart= new ArrayList<ShoppingCartItem>();

    public synchronized void addItem(Product product){
        ShoppingCartItem cartproduct = new ShoppingCartItem(product);
        boolean found = false;
        for(int i=0;i<cart.size();i++){
            if (cart.get(i).getProduct().getId()==product.getId()){
                    cart.get(i).quantity++;
                    found=true;
            }
        }
        if(found){
            
        }else{
            cart.add(cartproduct);
        } 
    }

    public synchronized void update(Product product, int quantity){
        for(int i=0;i<cart.size();i++){
            if (cart.get(i).cartproduct.getId()==product.getId()){
                cart.get(i).quantity=quantity;
            }
        }
    }

    public synchronized List<ShoppingCartItem> getItems(){
        return cart;
    }
    
    public synchronized int getNumberOfItems(){
        int quantity=0;
        for(int i=0;i<cart.size();i++){
            quantity=quantity+cart.get(i).getQuantity();
        }
        return quantity;
    }
    
    public synchronized double getTotal(){
        double total=0;
        for(int i=0;i<cart.size();i++){
            total=total+cart.get(i).getTotal();
        }
        return total;
    }
    
    public synchronized void clear(){
        cart.clear();
    }

}