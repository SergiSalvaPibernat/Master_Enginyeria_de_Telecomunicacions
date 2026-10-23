/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.service;

import entity.Publisher;
import entity.Topic;
import util.Subscription_close;
import entity.User;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import webSocketService.WebSocketServer;

/**
 *
 * @author juanluis
 */
@Stateless
@Path("entity.publisher")
public class PublisherFacadeREST extends AbstractFacade<Publisher> {

    @PersistenceContext(unitName = "PubSubWebServerPU")
    private EntityManager em;

    public PublisherFacadeREST() {
        super(Publisher.class);
    }

    @POST
    @Path("create")
    @Consumes({"application/xml", "application/json"})
    @Produces({"application/xml", "application/json"})
    public void create(Publisher entity) {

        Query q = em.createQuery("select t from Topic t where t.name=:name");
        q.setParameter("name", entity.getTopic().getName());
        List list = q.getResultList();
        if (list.size()==0) {
            em.persist(entity.getTopic());
            em.flush();
        } else {
            Topic topic = (Topic) list.get(0);
            entity.setTopic(topic);
        }
       
        Query q1 = em.createQuery("select p from Publisher p where p.user=:user");
        q1.setParameter("user", entity.getUser());
        List list1 = q1.getResultList();
        if (list1.size()==0) {
            em.persist(entity);
            em.flush();
        } else {
            em.merge(entity);
            em.flush();
        }
    }

    @POST
    @Path("delete")
    @Consumes({"application/xml", "application/json"})
    public void delete(Publisher entity) {

        Query q = em.createQuery("select p from Publisher p where p.user=:user");
        q.setParameter("user", entity.getUser());
        List<Publisher> list = q.getResultList();
        if (list.size()==0) {
            return;
        } else {
            Publisher publisher = list.get(0);
            super.delete(publisher);
            Query q1 = em.createQuery("select p from Publisher p where p.topic=:topic");
            Topic topic = publisher.getTopic();
            q1.setParameter("topic", topic);
            List list1 = q1.getResultList();
            if (list1.size()==0) {
                Query q2 = em.createQuery("delete from Topic t where t.name=:name");
                q2.setParameter("name", topic.getName());
                q2.executeUpdate();
                Subscription_close subs_close = new Subscription_close(topic, Subscription_close.Cause.PUBLISHER);
                WebSocketServer.notifyTopicClose(subs_close);
            }
        }
    }

    @POST
    @Path("publisherOf")
    @Consumes({"application/xml", "application/json"})
    @Produces({"application/xml", "application/json"})
    public Publisher publisherOf(User entity) {

        Query q = em.createQuery("select p from Publisher p where p.user=:user");
        q.setParameter("user", entity);
        List list = q.getResultList();
        if (list.size()==0) {
            return null;
        } else {
            return (Publisher) list.get(0);
        }

    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

}
