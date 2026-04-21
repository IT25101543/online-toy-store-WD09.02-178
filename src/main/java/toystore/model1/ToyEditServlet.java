package toystore.model1;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/ToyEditServlet")
public class ToyEditServlet extends HttpServlet {

    private ToyService toyService = new ToyService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from the form
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String brand = request.getParameter("brand");

        // Create updated Toy object
        Toy toy = new Toy(id, name, category, price, stock, brand);

        // Update in file
        toyService.updateToy(toy);

        // Redirect to view toys page
        response.sendRedirect("view-toys.jsp");
    }
}