package servlets;

import dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import services.MailService;

import java.io.IOException;
import javax.mail.MessagingException;

public class CheckPaymentStatusServlet extends HttpServlet {
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdParam = req.getParameter("orderId");
        if (orderIdParam != null && orderIdParam.matches("\\d+")) {
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderDao.findOrderById(orderId);
            if (order != null && "Paid".equals(order.getPaymentStatus())) {

                String subject = "Payment Successful";
                String content = String.format("<p>Dear %s,</p><p>We are pleased to inform you that your payment has been successfully processed. Below are your order details:</p>"
                                                + "<p><strong>Order ID:</strong> DH%d<br>"
                                                + "<strong>Recipient Name:</strong> %s<br>"
                                                + "<strong>Phone Number:</strong> %d<br>"
                                                + "<strong>Address:</strong> %s<br>"
                                                + "<strong>Total Amount:</strong> %.2f<br>"
                                                + "<strong>Payment Status:</strong> Paid Successfully</p>"
                                                + "<p>If you have any questions or concerns, please feel free to contact us.</p>",
                                                order.getName(), order.getId(), order.getName(), order.getPhone(), order.getAddress(), order.getTotal());
                try {
                    MailService.SendMail(order.getEmail(), subject, content);
                } catch (MessagingException e) {
                    e.printStackTrace();
                }

                resp.setContentType("application/json");
                resp.getWriter().write("{\"success\":true}");
            } else {
                resp.setContentType("application/json");
                resp.getWriter().write("{\"success\":false}");
            }
        } else {
            resp.setContentType("application/json");
            resp.getWriter().write("{\"success\":false}");
        }
    }
}
