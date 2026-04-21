package toystore.user;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/UserDeleteServlet")
public class UserDeleteServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get user ID from URL parameter
        String userId = request.getParameter("userId");

        // Delete the user
        userService.deleteUser(userId);

        // Redirect back to user list
        response.sendRedirect("view-users.jsp");
    }
}