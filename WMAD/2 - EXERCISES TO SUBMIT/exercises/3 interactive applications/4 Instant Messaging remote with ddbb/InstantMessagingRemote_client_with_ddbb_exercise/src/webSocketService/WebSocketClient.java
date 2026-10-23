package webSocketService;

import apiREST.Cons;
import com.google.gson.Gson;
import entity.Message;
import entity.Topic;
import util.Subscription_close;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;
import javax.websocket.ClientEndpoint;
import javax.websocket.ContainerProvider;
import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;
import subscriber.Subscriber;
import util.Subscription_request;

@ClientEndpoint
public class WebSocketClient {

    static Map<Topic, Subscriber> subscriberMap;
    static Session session;

    public static void newInstance() {
        subscriberMap = new HashMap<Topic, Subscriber>();
        try {
            WebSocketContainer container = ContainerProvider.getWebSocketContainer();
            session = container.connectToServer(WebSocketClient.class, URI.create(Cons.SERVER_WEBSOCKET));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void close() {
        try {
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static synchronized void addSubscriber(Topic topic, Subscriber subscriber) {
        try {

            Subscription_request subscriptionRequest = new Subscription_request(topic, Subscription_request.Type.ADD);
            session.getBasicRemote().sendText(new Gson().toJson(subscriptionRequest));
            subscriberMap.put(topic, subscriber);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static synchronized void removeSubscriber(Topic topic) {
        try {

            Subscription_request unsubscriptionRequest = new Subscription_request(topic, Subscription_request.Type.REMOVE);
            session.getBasicRemote().sendText(new Gson().toJson(unsubscriptionRequest));
            subscriberMap.remove(topic);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnMessage
    public void onMessage(String json) {

        Gson gson = new Gson();
        Subscription_close subs_close = gson.fromJson(json, Subscription_close.class);

        if (subs_close.cause == null) {
            Message message = gson.fromJson(json, Message.class);
            Topic topic = message.topic;
            Subscriber subscriber = subscriberMap.get(topic);
            if (subscriber != null) {
                subscriber.onMessage(message);
            }
        } else {
            Topic topic = subs_close.topic;
            Subscriber subscriber = subscriberMap.get(topic);
            if (subscriber != null) {
                subscriber.onClose(subs_close);
                subscriberMap.remove(topic);
            }
        }
    }

}
