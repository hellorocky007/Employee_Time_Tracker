package com.Servlet;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Task;

import java.io.IOException;

import Dao.UpdateDAO;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/UpdateAction")
public class UpdateAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("task_id"));
        UpdateDAO updateDAO = new UpdateDAO();
        Task task = updateDAO.getTask(taskId);

        if (task!= null) {
            request.setAttribute("task", task);
            RequestDispatcher dispatcher = request.getRequestDispatcher("update.jsp");
            dispatcher.forward(request, response);
        } else {
            response.getWriter().write("Task not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("task_id"));
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String description = request.getParameter("description");

        UpdateDAO updateDAO = new UpdateDAO();
        boolean updated = updateDAO.updateTask(taskId, startTime, endTime, description);

        if (updated) {
            response.sendRedirect("Home.jsp"); // Redirect to a page after successful update
        } else {
            response.getWriter().write("Error updating task");
        }
    }
}
