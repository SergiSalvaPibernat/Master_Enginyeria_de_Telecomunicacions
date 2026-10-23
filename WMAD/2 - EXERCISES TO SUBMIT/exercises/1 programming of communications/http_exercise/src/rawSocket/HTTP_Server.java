package rawSocket;

import java.io.*;
import java.net.*;

/**
 *
 * @author juanluis
 */
public class HTTP_Server {

  public static void main(String args[]) {
    try {
      //use the web browser accessing to: http://localhost:8082/
      //we do not use the 80 port because it's usually taken by another server
      ServerSocket ss = new ServerSocket(8082);
      int counter = 0;

      while (true) {
        System.out.println("waiting for a new connection...");
        Socket sc = ss.accept();
        Reader rd = new InputStreamReader(sc.getInputStream());
        BufferedReader in = new BufferedReader(rd);
        int content_length = 0;
        while (true) {
          String newline = in.readLine();
          System.out.println(newline);
          if (newline.length() == 0) {
            break; // end of headers print out
          }
          if (newline.startsWith("Content-Length: ")) {
            String cl_string = newline.substring(16);
            content_length = Integer.parseInt(cl_string);
          }
        }
        if (content_length != 0) {  //if there's any message body, print it out
          char[] cbuf = new char[content_length];
          in.read(cbuf);
          System.out.print(cbuf);
        }

        System.out.println("\nsending same reply independently of the request...");
        PrintWriter out = new PrintWriter(sc.getOutputStream(), true);
        String body = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
                + "<HTML><HEAD>"
                + "<TITLE>The title appearing at the superior browser bar</TITLE>"
                + "</HEAD><BODY><H1>Hello World!!! "
                + counter++
                + "</H1></BODY></HTML>";

        out.println("HTTP/1.1 200 OK");
        out.println("Content-Length: " + body.length());
        out.println("Set-cookie: id=hello");
        out.println("");
        out.println(body);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
