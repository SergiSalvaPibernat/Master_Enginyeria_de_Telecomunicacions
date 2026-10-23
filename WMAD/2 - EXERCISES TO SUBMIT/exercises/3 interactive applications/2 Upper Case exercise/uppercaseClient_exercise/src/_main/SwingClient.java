package _main;

import apiREST.apiREST_Sentence;
import entity.Sentence;
import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.util.List;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import webSocketService.WebSocketClient;

public class SwingClient {

  JFrame     frame;
  JTextArea  sentencesTextArea;
  JTextField sentenceTextField;
  JButton    sendButton;
  JButton    updateButton;
  JButton    closeButton;

  public void createAndShowGUI() {
    
    frame = new JFrame("Uppercase");
    frame.setSize(300, 300);
    frame.addWindowListener(new CloseWindowHandler());

    sentencesTextArea = new JTextArea(20, 20);
    sentenceTextField = new JTextField(25);
    
    sendButton   = new JButton("Send Sentence");
    updateButton = new JButton("Refresh");
    closeButton  = new JButton("Close App");

    sendButton.addActionListener(new SendSentenceHandler());
    updateButton.addActionListener(new UpdateSentencesHandler());
    closeButton.addActionListener(new CloseAppHandler());

    JPanel buttonsPannel = new JPanel();
    buttonsPannel.setLayout(new FlowLayout());
    buttonsPannel.add(updateButton);
    buttonsPannel.add(closeButton);

    JPanel showSentencesPanel = new JPanel();
    showSentencesPanel.setLayout(new BoxLayout(showSentencesPanel, BoxLayout.Y_AXIS));
    showSentencesPanel.add(new JLabel("Sentences: "));
    showSentencesPanel.add(new JScrollPane(sentencesTextArea));
    
    JPanel enterSentencePanel = new JPanel();
    enterSentencePanel.setLayout(new FlowLayout());
    enterSentencePanel.add(new JLabel("  Enter sentence:  "));
    enterSentencePanel.add(sentenceTextField);
    enterSentencePanel.add(sendButton);    

    Container mainPanel = frame.getContentPane();
    mainPanel.add(showSentencesPanel, BorderLayout.PAGE_START);
    mainPanel.add(buttonsPannel, BorderLayout.CENTER);
    mainPanel.add(enterSentencePanel, BorderLayout.PAGE_END);
    
    //...

    frame.pack();
    frame.setVisible(true);
  }

  public void updateSentences(List<Sentence> sentences) {
    
    //...
    
  }

  class SendSentenceHandler implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      
      //...
      
    }
  }

  class UpdateSentencesHandler implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      
      //...
      
    }
  }

  static class CloseAppHandler implements ActionListener {
    public void actionPerformed(ActionEvent e) {
      System.exit(0);
    }
  }

  class CloseWindowHandler implements WindowListener {
    public void windowDeactivated(WindowEvent e) {}
    public void windowActivated(WindowEvent e) {}
    public void windowIconified(WindowEvent e) {}
    public void windowDeiconified(WindowEvent e) {}
    public void windowClosed(WindowEvent e) {}
    public void windowOpened(WindowEvent e) {}
    public void windowClosing(WindowEvent e) {
      System.exit(0);
    }
  }

}
