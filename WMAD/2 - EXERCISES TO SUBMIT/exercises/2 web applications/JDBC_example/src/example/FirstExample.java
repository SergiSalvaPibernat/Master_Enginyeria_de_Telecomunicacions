/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package example;

/**
 *
 * @author juanluis
 */
import java.sql.*;

public class FirstExample {

  static final String DB_URL = "jdbc:mysql://localhost:3306/myddbb";
  static final String USER = "ecomm";
  static final String PASS = "ecomm";

  public static void main(String[] args) {

    try {

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
  }
}
