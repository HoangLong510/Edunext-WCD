/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.util.List;
import models.Category;
import models.Product;

/**
 *
 * @author huypg
 */
public class ProductDao {
    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("Edunext");
    public List<Product> getAll(){
        EntityManager em = emf.createEntityManager();
        TypedQuery<Product> query = em.createQuery("SELECT c FROM Product c", Product.class);
        return query.getResultList();
    }
    
    public void create (Product product){
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(product);
        em.getTransaction().commit();
        em.close();
    }
    public Product getOne(int id) {
        EntityManager em = emf.createEntityManager();
        return em.find(Product.class, id);
    }

    public void update(Product product) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(product);
        em.getTransaction().commit();
        em.close();
    }
}
