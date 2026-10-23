package webSocketService;

import com.google.gson.Gson;
import entity.Message;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import util.Subscription_request;
import entity.Topic;
import util.Subscription_close;
import entity.service.TopicFacadeREST;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

@ServerEndpoint("/ws")
public class WebSocketServer {

    TopicFacadeREST topicFacadeREST = lookupTopicFacadeRESTBean();

    // to store the open websocket sessions with the clients:
    private static Set<Session> sessions = new HashSet<Session>();

    // to store the subscriptions to the different topics of the connected clients:
    private static Map<Session, List<Topic>> subscriptions = new HashMap<Session, List<Topic>>();

    @OnMessage
    public void onMessage(String message, Session session) throws IOException, SQLException {

        Subscription_request s_req = new Gson().fromJson(message, Subscription_request.class);

        if (!topicFacadeREST.isTopic(s_req.topic).isOpen) {
            return;
        }

        if (s_req.type == Subscription_request.Type.ADD) {
            if (!subscriptions.get(session).contains(s_req.topic)) {
                subscriptions.get(session).add(s_req.topic);
            }
        } else if (s_req.type == Subscription_request.Type.REMOVE) {
            if (subscriptions.get(session).contains(s_req.topic)) {
                Subscription_close subs_close = new Subscription_close(s_req.topic, Subscription_close.Cause.SUBSCRIBER);
                session.getBasicRemote().sendText(new Gson().toJson(subs_close));
                subscriptions.get(session).remove(s_req.topic);
            }
        }
    }

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        subscriptions.put(session, new ArrayList<Topic>());
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        subscriptions.remove(session);
    }

    public static void notifyNewMessage(Message message) {
        String json_message = new Gson().toJson(message);
        Topic topic = message.getTopic();

        try {

            ArrayList<Session> closed = new ArrayList<>();
            for (Session session : sessions) {
                if (session.isOpen()) {
                    if (subscriptions.containsKey(session) && subscriptions.get(session).contains(topic)) {
                        session.getBasicRemote().sendText(json_message);
                    }
                } else {
                    closed.add(session);
                }
            }
            sessions.removeAll(closed);
            subscriptions.remove(closed);
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

    public static void notifyTopicClose(Subscription_close subs_close) {
        Gson gson = new Gson();
        String json_subs_close = gson.toJson(subs_close);
        Topic topic = subs_close.topic;

        try {
            ArrayList<Session> closed = new ArrayList<>();
            for (Session session : sessions) {
                if (session.isOpen()) {
                    if (subscriptions.containsKey(session) && subscriptions.get(session).contains(topic)) {
                        session.getBasicRemote().sendText(json_subs_close);
                    }
                } else {
                    closed.add(session);
                }
            }
            sessions.removeAll(closed);
            subscriptions.remove(closed);
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }

    private TopicFacadeREST lookupTopicFacadeRESTBean() {
        try {
            Context c = new InitialContext();
            return (TopicFacadeREST) c.lookup("java:global/InstantMessagingRemote_server_with_ddbb_exercise/TopicFacadeREST!entity.service.TopicFacadeREST");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

}
