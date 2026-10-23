package topicmanager;

import util.Subscription_check;
import util.Topic;
import util.Topic_check;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import publisher.Publisher;
import publisher.PublisherImpl;
import subscriber.Subscriber;

public class TopicManagerImpl implements TopicManager {

    private Map<Topic, Publisher> topicMap;

    public TopicManagerImpl() {
        topicMap = new HashMap<Topic, Publisher>();
    }

    @Override
    public Publisher addPublisherToTopic(Topic topic) {
        if (topicMap.containsKey(topic)) {
            return topicMap.get(topic);
        } else {
            Publisher publisher = new PublisherImpl(topic);
            topicMap.put(topic, publisher);
            return publisher;
        }
    }

    @Override
    public void removePublisherFromTopic(Topic topic) {
        this.topicMap.remove(topic);
    }

    @Override
    public Topic_check isTopic(Topic topic) {
        boolean isOpen = topicMap.containsKey(topic);
        return new Topic_check(topic, isOpen);
    }

    @Override
    public List<Topic> topics() {
        List<Topic> topiclist = new ArrayList<Topic>();
        for (Topic topics : this.topicMap.keySet()) {
            topiclist.add(topics);
        }
        return topiclist;
    }

    @Override
    public Subscription_check subscribe(Topic topic, Subscriber subscriber) {
        if (this.isTopic(topic).isOpen) {
            this.topicMap.get(topic).attachSubscriber(subscriber);
            return new Subscription_check(topic, Subscription_check.Result.OKAY);
        } else {
            return new Subscription_check(topic, Subscription_check.Result.NO_TOPIC);
        }
    }

    @Override
    public Subscription_check unsubscribe(Topic topic, Subscriber subscriber) {
        Topic_check topicCheck = isTopic(topic);
        if (topicCheck.isOpen) {
            Publisher publisher = topicMap.get(topic);
            boolean success = publisher.detachSubscriber(subscriber);
            if (success) {
                return new Subscription_check(topic, Subscription_check.Result.OKAY);
            } else {
                return new Subscription_check(topic, Subscription_check.Result.NO_SUBSCRIPTION);
            }
        } else {
            return new Subscription_check(topic, Subscription_check.Result.NO_TOPIC);
        }
    }

    public Publisher publisher(Topic topic) {
        return topicMap.get(topic);
    }

}
