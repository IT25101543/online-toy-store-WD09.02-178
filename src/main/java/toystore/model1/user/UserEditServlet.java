package toystore.user;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/UserEditServlet")
public class UserEditServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String userId = request.getParameter("userId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        // Create updated User object
        User user = new User(userId, fullName, email, password, address);

        // Update in file
        userService.updateUser(user);

        // Redirect to view users page
        response.sendRedirect("view-users.jsp");
    }
}