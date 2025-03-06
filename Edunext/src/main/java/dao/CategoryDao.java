/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import Utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import models.Category;
import models.Brand;

/**
 *
 * @author huypg
 */
public class CategoryDao {

    public List<Category> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        List<Category> category = em.createQuery("SELECT c FROM Category c", Category.class)
                .getResultList();
        em.close();
        return category;
    }

    public void create(Category cate) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction ts = em.getTransaction();
        try {
            ts.begin();
            em.persist(cate);
            ts.commit();
        } catch (Exception e) {
            ts.rollback();
        } finally {
            em.close();
        }
    }

    public Category getOne(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        Category cate = em.find(Category.class, id);
        em.close();
        return cate;
    }

    public void update(Category cate) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction ts = em.getTransaction();
        try {
            ts.begin();
            em.merge(cate);
            ts.commit();
        } catch (Exception e) {
            ts.rollback();
        } finally {
            em.close();
        }
    }

//    public List<Category> getCategoryByBrand(int brandId) {
//        EntityManager em = JPAUtil.getEntityManager();
//        List<Category> categories = null;
//        try {
//            TypedQuery<Category> query = em.createQuery(
//                    "SELECT c FROM Category c WHERE c.brand.id = :brandId", Category.class
//            );
//            query.setParameter("brandId", brandId);
//            categories = query.getResultList();
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            em.close();
//        }
//        return categories;
//    }
    
    

}
