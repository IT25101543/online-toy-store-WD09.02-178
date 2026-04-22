package toystore.order;

import java.io.*;
import java.time.LocalDateTime;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/OrderEditServlet")
public class OrderEditServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderID = request.getParameter("orderID");
        String userID = request.getParameter("userID");
        String toyID = request.getParameter("toyID");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String status = request.getParameter("status");
        LocalDateTime orderDate = LocalDateTime.now();

        Order order = new Order(orderID, userID, toyID, quantity, orderDate, status);
        orderService.updateOrder(order);
        response.sendRedirect("view-orders.jsp");
    }
}