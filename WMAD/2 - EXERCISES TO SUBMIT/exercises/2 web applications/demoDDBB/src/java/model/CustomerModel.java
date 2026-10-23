package model;

import entity.Customer;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.UserTransaction;

/**
 *
 * @author juanluis
 */
public class CustomerModel {

  UserTransaction utx;
  EntityManager em;

  public CustomerModel(UserTransaction utx, EntityManager em) {
    this.utx = utx;
    this.em = em;
  }

  public void create(Customer customer) throws Exception {
    utx.begin();
    em.persist(customer);
    em.flush();
    utx.commit();
  }
  public Customer retrieve(int id) {
    return em.find(Customer.class, id);
  }
  public void update(Customer customer) throws Exception {
    utx.begin();
    em.merge(customer);
    em.flush();
    utx.commit();
  }
  public void delete(Customer customer) throws Exception {
    utx.begin();
    customer = em.merge(customer);
    em.remove(customer);
    em.flush();
    utx.commit();
  }
  public List<Customer> retrieveAllCustomers() throws Exception {
    Query q = em.createQuery("select o from Customer as o");
    return q.getResultList();
  }
  public List<Customer> retrieveCustomersByName(String name) throws Exception {
    Query q = em.createQuery("select o from Customer as o where o.name=:the_name");
    q.setParameter("the_name", name);
    return q.getResultList();
  }

}
