package com.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Dao.DeleteDAO;

@WebServlet("/DeleteAction")
public class DeleteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("task_id"));
        DeleteDAO deleteDAO = new DeleteDAO();
        boolean deleted = deleteDAO.deleteTask(taskId);

        if (deleted) {
            response.getWriter().write("Task deleted successfully");
        } else {
            response.getWriter().write("Error deleting task");
        }
    }
}
