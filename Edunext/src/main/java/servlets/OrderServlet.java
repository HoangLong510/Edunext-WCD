package servlets;

import dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;

import java.io.IOException;
import java.sql.Timestamp;

public class OrderServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && idParam.matches("\\d+")) {
            int orderId = Integer.parseInt(idParam);
            Order order = orderDao.findOrderById(orderId);
            if (order != null) {
                req.setAttribute("order", order);
                req.getRequestDispatcher("/payment/checkout.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
            }
        } else {
            req.getRequestDispatcher("/payment/orderForm.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        long phone = Long.parseLong(req.getParameter("phone"));
        String address = req.getParameter("address");
        double total = Double.parseDouble(req.getParameter("total"));

        Order order = new Order();
        order.setName(name);
        order.setEmail(email);
        order.setPhone(phone);
        order.setAddress(address);
        order.setTotal(total);
        order.setPaymentStatus("Unpaid");
        order.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        orderDao.saveOrder(order);

 
        resp.sendRedirect("/Edunext/order?id=" + order.getId());
    }
}
