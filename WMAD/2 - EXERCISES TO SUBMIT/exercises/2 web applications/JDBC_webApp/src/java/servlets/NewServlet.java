/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author juanluis
 */
public class NewServlet extends HttpServlet {

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    try {

      String DB_URL = "jdbc:mysql://localhost:3306/myddbb?useSSL=false&serverTimezone=UTC";
      String USER = "ecomm";
      String PASS = "ecomm";

      Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
      Statement stmt = conn.createStatement();

      stmt.execute("INSERT INTO user (name, surname) VALUES ('joan', 'garcia')");
      stmt.execute("INSERT INTO user (name, surname) VALUES ('pere', 'pomes')");
      stmt.execute("INSERT INTO user (name, surname) VALUES ('anna', 'espriu')");

      String insert1 = "INSERT INTO user (name, surname) VALUES (?, ?)";
      PreparedStatement pst = conn.prepareStatement(insert1);
      pst.setString(1, "john");
      pst.setString(2, "smith");
      pst.executeUpdate();

      ResultSet rs = stmt.executeQuery("SELECT * FROM user");

      while (rs.next()) {
        System.out.println("name: " + rs.getString("name") + " , surname: " + rs.getString("surname"));
      }

      java.util.Date utilDate = new java.util.Date();
      java.sql.Timestamp sqlTS = new java.sql.Timestamp(utilDate.getTime());
      String insert2 = "INSERT INTO message (content, date, sender, receiver) VALUES (?,?,?,?)";

      PreparedStatement pst2 = conn.prepareStatement(insert2);
      pst2.setString(1, "hola");
      pst2.setString(2, sqlTS.toString());
      pst2.setString(3, "1");
      pst2.setString(4, "2");
      pst2.executeUpdate();

      rs = stmt.executeQuery("SELECT content FROM message WHERE sender='2'");

      while (rs.next()) {
        System.out.println("content: " + rs.getString("content"));
      }

      conn.close();

    } catch (SQLException e) {
      e.printStackTrace();
    }

    response.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = response.getWriter()) {
      /* TODO output your page here. You may use following sample code. */
      out.println("<!DOCTYPE html>");
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet NewServlet</title>");
      out.println("</head>");
      out.println("<body>");
      out.println("<h1>Servlet NewServlet at " + request.getContextPath() + "</h1>");
      out.println("</body>");
      out.println("</html>");
    }
  }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    processRequest(request, response);
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

}
