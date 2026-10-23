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

/**
 * Web application lifecycle listener.
 *
 * @author juanluis
 */
public class NewServletListener implements ServletContextListener {

  @Resource
  public UserTransaction utx;

  @PersistenceContext
  public EntityManager em;

  @Override
  public void contextInitialized(ServletContextEvent sce) {
    //To change body of generated methods, choose Tools | Templates.
    ServletContext context = sce.getServletContext();
    context.setAttribute("utx", utx);
    context.setAttribute("em", em);

  }

  @Override
  public void contextDestroyed(ServletContextEvent sce) {
    //To change body of generated methods, choose Tools | Templates.
  }
}
