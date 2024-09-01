<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Time Tracker</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        margin-top: 20px;
    }

    form {
        margin: 20px auto;
        width: 80%;
        max-width: 600px;
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 10px;
        background-color: #f9f9f9;
    }

    label {
        display: block;
        margin-bottom: 5px;
    }

    input[type="text"],
    input[type="date"],
    input[type="time"] {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    button[type="submit"],
    button[type="button"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 10px;
    }

    button[type="submit"]:hover,
    button[type="button"]:hover {
        background-color: #45a049;
    }

    #taskList {
        margin: 20px auto;
        width: 80%;
        max-width: 600px;
    }

    .task {
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 10px;
        margin-bottom: 10px;
        background-color: #f9f9f9;
    }

    .task p {
        margin: 5px 0;
    }

    .task button {
        background-color: #f44336;
        color: white;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
        margin-left: 5px;
    }

    .task button:hover {
        background-color: #d32f2f;
    }
</style>
</head>
<body>
    <h1>Employee Time Tracker</h1>
    <form id="taskForm">
        <label for="task">Task:</label>
        <input type="text" id="task" required>
        <label for="date">Date:</label>
        <input type="date" id="date" required>
        <label for="time">Time:</label>
        <input type="time" id="time" required>
        <button type="submit">Add Task</button>
    </form>
    <div id="taskList">
        <!-- Tasks will be displayed here -->
    </div>

    <script>
        // Function to add a new task
        function addTask(event) {
            event.preventDefault();
            const taskInput = document.getElementById("task");
            const dateInput = document.getElementById("date");
            const timeInput = document.getElementById("time");
            
            const task = taskInput.value;
            const date = dateInput.value;
            const time = timeInput.value;

            // Create task element
            const taskElement = document.createElement("div");
            taskElement.classList.add("task");
            taskElement.innerHTML = `
                <p><strong>Task:</strong> ${task}</p>
                <p><strong>Date:</strong> ${date}</p>
                <p><strong>Time:</strong> ${time}</p>
                <button onclick="editTask(this)">Edit</button>
                <button onclick="deleteTask(this)">Delete</button>
            `;

            // Append task to the task list
            document.getElementById("taskList").appendChild(taskElement);

            // Clear input fields
            taskInput.value = "";
            dateInput.value = "";
            timeInput.value = "";
        }

        // Function to edit a task
        function editTask(button) {
            const taskElement = button.parentNode;
            const taskInfo = taskElement.querySelectorAll("p");

            const task = taskInfo[0].innerText.split(": ")[1];
            const date = taskInfo[1].innerText.split(": ")[1];
            const time = taskInfo[2].innerText.split(": ")[1];

            // Update form with task information
            document.getElementById("task").value = task;
            document.getElementById("date").value = date;
            document.getElementById("time").value = time;

            // Remove the task from the list
            taskElement.remove();
        }

        // Function to delete a task
        function deleteTask(button) {
            button.parentNode.remove();
        }

        document.getElementById("taskForm").addEventListener("submit", addTask);
    </script>
</body>
</html>
