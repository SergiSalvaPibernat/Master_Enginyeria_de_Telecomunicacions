package demo.impl;

import demo.spec.Message;
import demo.spec.MessageWall;
import demo.spec.RemoteLogin;
import demo.spec.UserAccess;
import java.util.ArrayList;
import java.util.List;

public class MessageWall_and_RemoteLogin_Impl implements RemoteLogin, MessageWall {

    private List<Message> messages;

    public MessageWall_and_RemoteLogin_Impl() {
        messages = new ArrayList<Message>();
    }

    @Override
    public UserAccess connect(String usr, String passwd) {
        UserAccess_Impl userAccess = new UserAccess_Impl(this, usr);
        return userAccess;
    }

    @Override
    public void put(String user, String msg) {
        Message_Impl message = new Message_Impl(user, msg);
        this.messages.add(message);
    }

    @Override
    public boolean delete(String user, int index) {
        int counter = 0;
        for(int i = 0; i<messages.size();  i++){
            if(this.messages.get(i).getOwner() == user){
                if(counter == index){
                    this.messages.remove(counter);
                    return true;
                }
                counter++;
            }
        }
        return false;
    }

    @Override
    public Message getLast() {
        if(this.messages.size() > 0){
            return this.messages.get(this.messages.size()-1);
        }else{
            return new Message_Impl("","");
        }
    }

    @Override
    public int getNumber() {
        return this.messages.size();
    }

    @Override
    public List<Message> getAllMessages() {
        return messages;
    }

}
