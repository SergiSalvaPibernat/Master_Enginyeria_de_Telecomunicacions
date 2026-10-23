package demo.impl;

import demo.spec.Message;
import demo.spec.MessageWall;
import demo.spec.UserAccess;
import java.util.List;

public class UserAccess_Impl implements UserAccess {

    private String user;
    private MessageWall messageWall;

    public UserAccess_Impl(MessageWall mw, String usr) {
        messageWall = mw;
        user = usr;
    }

    @Override
    public String getUser() {
        return this.user;
    }

    @Override
    public Message getLast() {
        return this.messageWall.getLast();
    }

    @Override
    public int getNumber() {
        return this.messageWall.getNumber();
    }

    @Override
    public void put(String msg) {
        this.messageWall.put(user, msg);
    }

    @Override
    public boolean delete(int index) {
        return this.messageWall.delete(user, index);
    }

    @Override
    public List<Message> getAllMessages() {
        return this.messageWall.getAllMessages();

    }

}
