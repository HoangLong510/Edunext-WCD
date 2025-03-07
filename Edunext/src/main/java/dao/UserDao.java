package dao;

import Utils.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import java.util.List;
import models.User;

public class UserDao {

    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("Edunext");

    public void create(User user) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(user);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        } finally {
            em.close();
        }
    }

    public User login(String email, String password) {
        EntityManager em = emf.createEntityManager();
        try {
            User user = em.createQuery("SELECT u FROM User u WHERE u.email = :email AND u.password = :password", User.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
            return user;
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public boolean checkEmailExists(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            User user = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return true;
        } catch (NoResultException e) {
            return false;
        } catch (Exception e) {
            return false;
        } finally {
            em.close();
        }
    }
    
    public List<User> getAll(){
        EntityManager em = JPAUtil.getEntityManager();
        List<User> users = em.createQuery("SELECT u FROM User u", User.class)
                .getResultList();
        em.close();
        return users;
    }
    
    public void deleteUser(int id){
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction ts = em.getTransaction();
        try {
            ts.begin();
            User user = em.find(User.class, id);
            em.remove(user);
            ts.commit();
        } catch (Exception e) {
            ts.rollback();
        } finally {
            em.close();
        }
    }
    
    public User getUserById(int id){
        EntityManager em = JPAUtil.getEntityManager();
        User user = em.find(User.class, id);
        em.close();
        return user;
    }
    
    public void editUser(User user){
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction ts = em.getTransaction();
        try {
            ts.begin();
            em.merge(user);
            ts.commit();
        } catch (Exception e) {
            ts.rollback();
        } finally {
            em.close();
        }
    }
}
