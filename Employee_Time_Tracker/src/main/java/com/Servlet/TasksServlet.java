package com.Servlet;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Task;

import java.io.IOException;
import java.util.List;

import Dao.showDAO;

@WebServlet("/tasks")
public class TasksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        showDAO taskDAO = new showDAO();
        List<Task> tasks = taskDAO.getTasks();

        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("/WEB-INF/views/tasks.jsp").forward(request, response);
    }
}
