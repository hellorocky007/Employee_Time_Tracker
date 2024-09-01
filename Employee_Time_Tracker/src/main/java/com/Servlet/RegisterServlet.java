package com.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Dao.UserDAO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname = request.getParameter("username");
        String uemail = request.getParameter("email");
        String upass = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        boolean registered = false;
        try {
            registered = userDAO.registerUser(uname, uemail, upass);
            if (registered) {
                request.setAttribute("username", uname);
                request.setAttribute("email", uemail);
                request.setAttribute("message", "Registration successful! Your username is " + uname + " and email is " + uemail);
                request.getRequestDispatcher("success.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error storing user registration data");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error occurred while processing your request");
        }
    }
}
