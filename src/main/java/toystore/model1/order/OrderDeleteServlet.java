package toystore.order;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/OrderDeleteServlet")
public class OrderDeleteServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderID = request.getParameter("orderID");
        orderService.deleteOrder(orderID);
        response.sendRedirect("view-orders.jsp");
    }
}