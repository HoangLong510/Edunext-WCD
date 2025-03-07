
package servlets;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import dao.OrderDao;
import dao.TransactionDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import models.Transaction;

import java.io.IOException;
import java.sql.Timestamp;


public class SepayWebhookServlet extends HttpServlet {
    private final TransactionDao transactionDao = new TransactionDao();
    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = mapper.readTree(req.getReader());

        if (jsonNode == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"success\":false,\"message\":\"No data\"}");
            return;
        }

        String gateway = jsonNode.get("gateway").asText();
        Timestamp transactionDate = Timestamp.valueOf(jsonNode.get("transactionDate").asText());
        String accountNumber = jsonNode.get("accountNumber").asText();
        String subAccount = jsonNode.get("subAccount").asText();
        String transferType = jsonNode.get("transferType").asText();
        double transferAmount = jsonNode.get("transferAmount").asDouble();
        double accumulated = jsonNode.get("accumulated").asDouble();
        String code = jsonNode.get("code").asText();
        String transactionContent = jsonNode.get("content").asText();
        String referenceNumber = jsonNode.get("referenceCode").asText();
        String body = jsonNode.get("description").asText();

        double amountIn = 0;
        double amountOut = 0;

        if ("in".equals(transferType)) {
            amountIn = transferAmount;
        } else if ("out".equals(transferType)) {
            amountOut = transferAmount;
        }

        Transaction transaction = new Transaction();
        transaction.setGateway(gateway);
        transaction.setTransactionDate(transactionDate);
        transaction.setAccountNumber(accountNumber);
        transaction.setSubAccount(subAccount);
        transaction.setAmountIn(amountIn);
        transaction.setAmountOut(amountOut);
        transaction.setAccumulated(accumulated);
        transaction.setCode(code);
        transaction.setTransactionContent(transactionContent);
        transaction.setReferenceNumber(referenceNumber);
        transaction.setBody(body);
        transaction.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        transactionDao.saveTransaction(transaction);

        String regex = "DH(\\d+)";
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(regex);
        java.util.regex.Matcher matcher = pattern.matcher(transactionContent);
        if (matcher.find()) {
            int payOrderId = Integer.parseInt(matcher.group(1));

            try {
                Order order = orderDao.findOrderByIdAndTotal(payOrderId, amountIn);
                orderDao.updateOrderStatus(order.getId(), "Paid");
                resp.getWriter().write("{\"success\":true}");
            } catch (Exception e) {
                resp.getWriter().write("{\"success\":false,\"message\":\"Order not found. Order_id " + payOrderId + "\"}");
            }
        } else {
            resp.getWriter().write("{\"success\":false,\"message\":\"Order not found.\"}");
        }
    }
}
