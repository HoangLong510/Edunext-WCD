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
import models.Brand;


/**
 *
 * @author huypg
 */
public class BrandDao {
    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("Edunext");
    public List<Brand> getAll(){
        EntityManager em = emf.createEntityManager();
        TypedQuery<Brand> query = em.createQuery("SELECT b FROM Brand b", Brand.class);
        return query.getResultList();
    }
    
    public void create (Brand brand){
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(brand);
        em.getTransaction().commit();
        em.close();
    }
    public Brand getOne(int id) {
        EntityManager em = emf.createEntityManager();
        return em.find(Brand.class, id);
    }
    public void update(Brand brand) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(brand);
        em.getTransaction().commit();
        em.close();
    }
    public List<Category> getCategoryByBrand(int brandId){
        EntityManager em = emf.createEntityManager();
        TypedQuery<Category> query = em.createQuery("SELECT p FROM Category p Where p.brand.id = :brandId", Category.class);
        query.setParameter("brandId", brandId);
        return query.getResultList();
    }
}
