package _main;

public class Client {

  public static void main(String[] args) {
    javax.swing.SwingUtilities.invokeLater(new Runnable() {
      public void run() {
        SwingClient client = new SwingClient();
        client.createAndShowGUI();
      }
    });
  }
}
