/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.transaction.UserTransaction;
import model.CustomerModel;
import model.OrderModel;

/**
 * Web application lifecycle listener.
 *
 * @author upcnet
 */
public class NewServletListener implements ServletContextListener {

  @Resource
  public UserTransaction utx;

  @PersistenceContext
  public EntityManager em;

  @Override
  public void contextInitialized(ServletContextEvent sce) {
    ServletContext context = sce.getServletContext();
    context.setAttribute("customerModel", new CustomerModel(utx,em));
    context.setAttribute("orderModel", new OrderModel(utx,em));
  }

  @Override
  public void contextDestroyed(ServletContextEvent sce) {
  }
}
