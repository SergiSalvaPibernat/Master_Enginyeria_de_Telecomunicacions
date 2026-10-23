package demo.impl;

import demo.spec.Message;

public class Message_Impl implements Message, java.io.Serializable {

  private String user, message;

  public Message_Impl(String usr, String msg) {
    user = usr;
    message = msg;
  }

  @Override
  public String getContent() {
    return this.message;
  }

  @Override
  public String getOwner() {
    return this.user;
  }

}
