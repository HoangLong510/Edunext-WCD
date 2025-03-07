
package dao;

import jakarta.persistence.EntityManager;
import models.Transaction;
import Utils.JPAUtil;

public class TransactionDao {
    public void saveTransaction(Transaction transaction) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(transaction);
        em.getTransaction().commit();
        em.close();
    }
}
