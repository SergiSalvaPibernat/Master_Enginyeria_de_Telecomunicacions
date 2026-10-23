/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity.service;

import entity.Message;
import entity.Topic;
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
@Path("entity.message")
public class MessageFacadeREST extends AbstractFacade<Message> {

    @PersistenceContext(unitName = "PubSubWebServerPU")
    private EntityManager em;

    public MessageFacadeREST() {
        super(Message.class);
    }

    @POST
    @Path("create")
    @Consumes({"application/xml", "application/json"})
    public void create(Message entity) {

        Query q = em.createQuery("select t from Topic t where t.name=:name");
        q.setParameter("name", entity.getTopic().getName());
        List<Topic> list = q.getResultList();
        if(list.size()>0) {
            Message message_ok = new Message();
            message_ok.setTopic(list.get(0));
            message_ok.setContent(entity.getContent());
            em.persist(message_ok);
            em.flush();
            WebSocketServer.notifyNewMessage(entity);
        }
    }

    @POST
    @Path("messagesFromTopic")
    @Consumes({"application/xml", "application/json"})
    @Produces({"application/xml", "application/json"})
    public List<Message> messagesFrom(Topic entity) {
        
        Query q = em.createQuery("select t from Topic t where t.name=:name");
        q.setParameter("name", entity.getName());
        List<Topic> list = q.getResultList();
        if (list.size()>0) {
            q = em.createQuery("select m from Message m where m.topic=:topic");
            q.setParameter("topic", list.get(0));
            return q.getResultList();
        } else {
            return null;
        }

    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

}
