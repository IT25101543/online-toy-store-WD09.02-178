package toystore.order;

import java.io.*;
import java.time.LocalDateTime;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String orderID = request.getParameter("orderID");
        String userID = request.getParameter("userID");
        String toyID = request.getParameter("toyID");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        LocalDateTime orderDate = LocalDateTime.now();
        String status = "Pending";

        // Create Order object
        Order order = new Order(orderID, userID, toyID, quantity, orderDate, status);

        // Save to file
        orderService.saveOrder(order);

        // Redirect to view orders page
        response.sendRedirect("view-orders.jsp");
    }
}