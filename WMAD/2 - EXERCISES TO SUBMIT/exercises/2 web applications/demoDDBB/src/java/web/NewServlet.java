/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import entity.Customer;
import entity.TheOrder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CustomerModel;
import model.OrderModel;

/**
 *
 * @author juanluis
 */
public class NewServlet extends HttpServlet {

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    
    try  {
      CustomerModel cm = (CustomerModel) getServletContext().getAttribute("customerModel");
      OrderModel om = (OrderModel) getServletContext().getAttribute("orderModel");
      
      Customer c = new Customer();
      c.setName("john");
      c.setSurname("smith");
      cm.create(c);

      c.setPhone(1234567);
      cm.update(c);
      
      c = cm.retrieve(1);
      cm.delete(c);
      
      TheOrder theOrder = new TheOrder();
      c = cm.retrieve(1);
      theOrder.setCustomer(c);
      theOrder.setDescription("this is the description");
      om.create(theOrder);
      
      response.setContentType("text/html;charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<!DOCTYPE html>");
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet NewServlet</title>");      
      out.println("</head>");
      out.println("<body>");
      out.println("<h1>Servlet executed... " + request.getContextPath() + "</h1>");
      
      for(Customer customer : cm.retrieveCustomersByName("john"))
        out.println("<br> Customer name: "+customer.getName()+" surname: "+customer.getSurname());
      
      out.println("<br>");
      for(TheOrder order : om.retrieveTheOrdersFromCustomer(c))
        out.println("<br> Order from: "+order.getCustomer().getName()+" description: "+order.getDescription());
      
      out.println("</body>");
      out.println("</html>");
      
    }
    catch(Exception e){
      e.printStackTrace();
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    processRequest(request, response);
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    processRequest(request, response);
  }


}
