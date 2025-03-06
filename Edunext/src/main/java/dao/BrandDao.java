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
public class BrandDao {

    public List<Brand> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        List<Brand> brands = em.createQuery("SELECT b FROM Brand b", Brand.class)
                .getResultList();
        em.close();
        return brands;
    }

    public void create(Brand brand) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction ts = em.getTransaction();
        try {
            ts.begin();
            brand.setStatus(true);
            em.persist(brand);
            ts.commit();
        } catch (Exception e) {
            ts.rollback();
        } finally {
            em.close();
        }
    }

    public Brand getOne(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        Brand brand = em.find(Brand.class, id);
        em.close();
        return brand;
    }

    public void update(Brand brand) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction ts = em.getTransaction();
        try {
            ts.begin();
            em.merge(brand);
            ts.commit();
        } catch (Exception e) {
            ts.rollback();
        } finally {
            em.close();
        }
    }

    public List<Category> getCategoryByBrand(int brandId) {
        EntityManager em = JPAUtil.getEntityManager();
        List<Category> categories = null;
        try {
            TypedQuery<Category> query = em.createQuery(
                    "SELECT c FROM Category c WHERE c.brand.id = :brandId", Category.class
            );
            query.setParameter("brandId", brandId);
            categories = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return categories;
    }

    public void deactivateBrand(int brandId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction ts = em.getTransaction();
        try {
            ts.begin();

            Brand brand = em.find(Brand.class, brandId);

            if (brand != null) {
                boolean currentStatus = brand.isStatus();
                brand.setStatus(!currentStatus);
                em.merge(brand);

                List<Category> categories = brand.getCategories();
                for (Category category : categories) {
                    category.setStatus(!currentStatus);
                    em.merge(category);
                }

                ts.commit();
            } else {
                System.out.println("Brand not found");
            }
        } catch (Exception e) {
            ts.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Brand> getBrandsByStatus(boolean status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String queryStr = "SELECT b FROM Brand b WHERE b.status = :status";
            TypedQuery<Brand> query = em.createQuery(queryStr, Brand.class);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

}
