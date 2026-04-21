package toystore.model1;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/ToyDeleteServlet")
public class ToyDeleteServlet extends HttpServlet {

    private ToyService toyService = new ToyService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the toy ID from the URL parameter
        String id = request.getParameter("id");

        // Delete the toy
        toyService.deleteToy(id);

        // Redirect back to the toy list
        response.sendRedirect("view-toys.jsp");
    }
}