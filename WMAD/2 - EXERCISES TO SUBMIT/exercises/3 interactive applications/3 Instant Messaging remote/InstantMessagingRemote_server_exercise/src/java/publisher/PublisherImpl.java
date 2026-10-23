package publisher;

import util.Subscription_close;
import util.Message;
import util.Topic;
import java.util.ArrayList;
import java.util.List;
import subscriber.Subscriber;
import subscriber.SubscriberImpl;
import javax.websocket.Session;

public class PublisherImpl implements Publisher {

    private List<Subscriber> subscriberSet;
    private int numPublishers;
    private Topic topic;

    public PublisherImpl(Topic topic) {
        subscriberSet = new ArrayList<Subscriber>();
        numPublishers = 1;
        this.topic = topic;
    }

    @Override
    public void incPublishers() {
        this.numPublishers++;
    }

    @Override
    public int decPublishers() {
        return this.numPublishers--;
    }

    @Override
    public void attachSubscriber(Subscriber subscriber) {
        if (!subscriberSet.contains(subscriber)) {
            subscriberSet.add(subscriber);
            this.incPublishers();
        }
    }

    @Override
    public boolean detachSubscriber(Subscriber subscriber) {
        if (subscriberSet.contains(subscriber)) {
            subscriberSet.remove(subscriber);
            this.decPublishers();
            if (numPublishers == 0) {
                detachAllSubscribers();
            }
            return true;
        }
        return false;
    }

    @Override
    public void detachAllSubscribers() {
        for (Subscriber subscriber : subscriberSet) {
            subscriber.onClose(new Subscription_close(topic, Subscription_close.Cause.SUBSCRIBER));
        }
        subscriberSet.clear();
    }

    @Override
    public void publish(Message message) {
        for (Subscriber subscriber : subscriberSet) {
            subscriber.onMessage(message);
        }
    }

    public Subscriber subscriber(Session session) {
        for (Subscriber subscriber : subscriberSet) {
            SubscriberImpl subscriberImpl = (SubscriberImpl) subscriber;
            if (subscriberImpl.session == session) {
                return subscriber;
            }
        }
        return null;
    }
}
