package dao;


import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.util.List;
import models.Category;
import models.Product;

public class CategoryDao {
    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("Edunext");
    public List<Category> getAll(){
        EntityManager em = emf.createEntityManager();
        TypedQuery<Category> query = em.createQuery("SELECT c FROM Category c", Category.class);
        return query.getResultList();
    }
    
    public void create (Category category){
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(category);
        em.getTransaction().commit();
        em.close();
    }
    public Category getOne(int id) {
        EntityManager em = emf.createEntityManager();
        return em.find(Category.class, id);
    }
    
    public void update(Category category) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(category);
        em.getTransaction().commit();
        em.close();
    }
    
    public List<Product> getProductByCategory(int categoryId){
        EntityManager em = emf.createEntityManager();
        TypedQuery<Product> query = em.createQuery("SELECT p FROM Product p Where p.category.id = :categoryId", Product.class);
        query.setParameter("categoryId", categoryId);
        return query.getResultList();
    }
}
