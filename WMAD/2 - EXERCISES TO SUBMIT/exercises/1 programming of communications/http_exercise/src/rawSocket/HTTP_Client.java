package rawSocket;

import java.io.*;
import java.net.*;

/**
 *
 * @author juanluis
 */
public class HTTP_Client {

  public static void main(String[] args) {

    Socket sc;
    BufferedReader in;
    PrintWriter out;
    try {
//      sc = new Socket("localhost", 8082);
      sc = new Socket("www.google.es",80);
      in = new BufferedReader(new InputStreamReader(sc.getInputStream()));
      out = new PrintWriter(sc.getOutputStream(), true);
    } catch (Exception e) {
      e.printStackTrace();
      return;
    }
    try {
      //try to send other HTTP commands aside from the GET:
      out.println("GET http://www.google.es/ HTTP/1.1");
//      out.println("Content-type: application/x-www-form-urlencoded");
//      out.println("Content-Length: 10");
      out.println("");
//      out.println("hi there");
      while (true) {
        String readEcho = in.readLine();
        System.out.println(readEcho);
        if (readEcho.contains("</html>") || readEcho.contains("</HTML>")) {
          break;
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
