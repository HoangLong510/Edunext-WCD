
package dao;

import jakarta.persistence.EntityManager;
import models.Order;
import Utils.JPAUtil;

public class OrderDao {
    public void saveOrder(Order order) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(order);
        em.getTransaction().commit();
        em.close();
    }

    public Order findOrderById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        Order order = em.find(Order.class, id);
        em.close();
        return order;
    }

    public Order findOrderByIdAndTotal(int id, double total) {
        EntityManager em = JPAUtil.getEntityManager();
        Order order = em.createQuery("SELECT o FROM Order o WHERE o.id = :id AND o.total = :total AND o.paymentStatus = 'Unpaid'", Order.class)
                .setParameter("id", id)
                .setParameter("total", total)
                .getSingleResult();
        em.close();
        return order;
    }

    public void updateOrderStatus(int id, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        Order order = em.find(Order.class, id);
        order.setPaymentStatus(status);
        em.getTransaction().commit();
        em.close();
    }
}
