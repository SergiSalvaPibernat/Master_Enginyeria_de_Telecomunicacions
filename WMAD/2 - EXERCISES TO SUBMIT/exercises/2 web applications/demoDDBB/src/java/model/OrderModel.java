package model;

import entity.Customer;
import entity.TheOrder;
import entity.TheOrder;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.UserTransaction;

/**
 *
 * @author juanluis
 */
public class OrderModel {

  UserTransaction utx;
  EntityManager em;

  public OrderModel(UserTransaction utx, EntityManager em) {
    this.utx = utx;
    this.em = em;
  }

  public void create(TheOrder theOrder) throws Exception {
    utx.begin();
    em.persist(theOrder);
    em.flush();
    utx.commit();
  }
  public TheOrder retrieve(int id) {
    return em.find(TheOrder.class, id);
  }
  public void update(TheOrder theOrder) throws Exception {
    utx.begin();
    em.merge(theOrder);
    em.flush();
    utx.commit();
  }
  public void delete(TheOrder theOrder) throws Exception {
    utx.begin();
    theOrder = em.merge(theOrder);
    em.remove(theOrder);
    em.flush();
    utx.commit();
  }
  public List<TheOrder> retrieveAllTheOrders() throws Exception {
    Query q = em.createQuery("select o from TheOrder as o");
    return q.getResultList();
  }
  public List<TheOrder> retrieveTheOrdersFromCustomer(Customer customer) throws Exception {
    Query q = em.createQuery("select o from TheOrder as o where o.customer=:customer");
    q.setParameter("customer", customer);
    return q.getResultList();
  }

}
