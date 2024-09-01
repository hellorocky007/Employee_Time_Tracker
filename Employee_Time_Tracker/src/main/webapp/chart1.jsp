<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject, org.json.simple.JSONArray" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style2.css">
    <title>Task Graphs</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            max-width: 80%;
            margin: auto;
            background-color: rgb(16,13,37);
            padding: 30px;
            border-radius: 10px;
            color: #ffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h1, h2 {
            text-align: center;
            color: white;
        }
        h4 {
            color: #ffff;
        }
        .chartButton {
            margin: 30px;
            background: rgb(21,16,48);
            color: #ffff;
            font-weight: 900;
            font-size: 12px;
            padding: 8px 35px;
            border: 1px solid #262533;
            text-align: center;
            cursor: pointer;
            border-radius: 5px;
        }
        .charts {
            display: flex;
            flex-direction: row;
            align-items: center;
            flex-wrap: wrap;
        }
        canvas {
            max-width: 300px;
            max-height: 300px;
        }
        .chart-container {
            max-width: 80%;
            margin: auto;
            margin-bottom: 20px;
            background-color: rgb(16,13,37);
            padding: 30px;
            border-radius: 10px;
            color: #ffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        #dailyChart {
            display: block;
            box-sizing: border-box;
            height: 300px;
            width: 308px;
        }
        @media only screen and (max-width: 768px) {
            .chart-container {
                max-width: 70%;
                padding: 5px;
            }
        }
        @media only screen and (max-width: 480px) {
            .chart-container {
                max-width: 90%;
                padding: 2px;
            }
            .charts {
                font-size: 0.8em;
            }
        }
    </style>
</head>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">
    <div class="container">
        <h2>Task Graph</h2>
        <form id="dateForm" action="SearchGraph" method="get">
            <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
            <label for="start_date">Start Date:</label>
            <input type="date" id="start_date" name="start_date" value="<%= request.getParameter("start_date") %>" required>
            <label for="end_date">End Date:</label>
            <input type="date" id="end_date" name="end_date" value="<%= request.getParameter("end_date") %>" required>
            <button type="submit" class="chartButton">Fetch Data</button>
        </form>
        <div class="chart-container">
            <canvas id="taskChart" width="400" height="200"></canvas>
        </div>
        <script>
            // Check if jsonData exists and is valid JSON
            var jsonData = '<%= request.getAttribute("jsonData") != null ? request.getAttribute("jsonData").toString().replaceAll("\"", "\\\\\"") : "" %>';
            if (jsonData && jsonData.trim() !== '') {
                try {
                    var parsedData = JSON.parse(jsonData.replace(/&quot;/g, '"'));
                    var tasks = parsedData.tasks || [];

                    // Extract labels and data for the chart
                    var labels = [];
                    var data = [];
                    
                    tasks.forEach(function(task) {
                        labels.push(task.task);
                        data.push(task.total_hours);
                    });

                    // Create the chart
                    var ctx = document.getElementById('taskChart').getContext('2d');
                    var taskChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Total Hours Worked',
                                data: data,
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                } catch (e) {
                    console.error("Error parsing JSON data: ", e);
                    document.getElementById('taskChart').innerHTML = "<p>Error loading data for the selected date range.</p>";
                }
            } else {
                // Handle case where no data is available
                document.getElementById('taskChart').innerHTML = "<p>No data available for the selected date range.</p>";
            }
        </script>
    </div>
</body>
</html>
