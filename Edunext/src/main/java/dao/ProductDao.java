package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import models.Product;
import Utils.JPAUtil;

/**
 *
 * @author huypg
 */
public class ProductDao {
    
    public List<Product> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        TypedQuery<Product> query = em.createQuery("SELECT p FROM Product p", Product.class);
        return query.getResultList();
    }

    public void create(Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(product);
        em.getTransaction().commit();
        em.close();
    }

    public Product getOne(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        return em.find(Product.class, id);
    }

    public void update(Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(product);
        em.getTransaction().commit();
        em.close();
    }
}
