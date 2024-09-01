<!DOCTYPE html>
<html>
<head>
    <title>Project Hours Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="css/chartcss.css">
    <style>
   
        .chart-container {
            max-width: 80%; /* Adjusts to 80% of parent container's width */
            margin: auto;
            margin-bottom: 20px;
            background-color: rgb(16,13,37);
            padding: 30px;
            border-radius: 10px;
            color:#ffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column; /* Aligns items vertically */
            align-items: center; /* Centers the content horizontally */
        }
        .chartButton{
      margin:30px;
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
        h2{
        text-align:center;
        }
        h4{
        color:#ffff;
        }
        #dailyChart {
    display: block;
    box-sizing: border-box;
    height: 300px;
    width: 300px;
    
    padding-bottom:40px;
}

        .charts {
            display: flex;
            flex-direction: row;
            align-items: center;
            flex-wrap: wrap; /* Allows wrapping to fit smaller charts */
        }

        canvas {
            max-width: 300px; /* Adjust the width of the canvas */
            max-height: 300px; /* Adjust the height of the canvas */
        }

        /* Add media queries for responsiveness */
        @media only screen and (max-width: 768px) {
            .chart-container {
                max-width: 70%; /* Reduce width on smaller screens */
                padding: 5px; /* Reduce padding on smaller screens */
            }
        }

        @media only screen and (max-width: 480px) {
            .chart-container {
                max-width: 90%; /* Reduce width on very small screens */
                padding: 2px; /* Reduce padding on very small screens */
            }
            .charts {
                font-size: 0.8em; /* Reduce font size on very small screens */
            }
        }
        h1{
        color:white}
    </style>
</head>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">
    <form action="chart1.jsp" method="get" style="display:inline;">
        <input type="hidden" name="userId" value="<%= session.getAttribute("uid") %>">
        <i class="fas fa-chart-line nav_icon"></i>
        <button type="submit" class="chartButton">Previous Charts</button>
    </form>
    <div class="container">
        <h2 class="text-center">Task Durations Chart</h2>
        <div class="charts">
            <div class="chart-container">
                <h4 class="text-center">Pie Chart</h4>
                <canvas id="dailyChart"></canvas>
            </div>
            <div class="chart-container">
                <h4 class="text-center">Bar Chart (Weekly)</h4>
                <canvas id="weeklyChart"></canvas>
            </div>
            <div class="chart-container">
                <h4 class="text-center">Bar Chart (Monthly)</h4>
                <canvas id="monthlyChart"></canvas>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Fetch the JSON data from the request attribute
            const jsonData = JSON.parse('<%= request.getAttribute("jsonData") %>');

            // Extract data for daily chart
            const dailyLabels = jsonData.daily.map(item => item.task);
            const dailyData = jsonData.daily.map(item => item.daily_hours);

            // Extract data for weekly chart
            const weeklyLabels = jsonData.weekly.map(item => item.task);
            const weeklyData = jsonData.weekly.map(item => item.weekly_hours);

            // Extract data for monthly chart
            const monthlyLabels = jsonData.monthly.map(item => item.task);
            const monthlyData = jsonData.monthly.map(item => item.monthly_hours);

            // Create daily pie chart
            const dailyCtx = document.getElementById('dailyChart').getContext('2d');
            new Chart(dailyCtx, {
                type: 'pie',
                data: {
                    labels: dailyLabels,
                    datasets: [{
                        label: 'Daily Hours',
                        data: dailyData,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.6)',
                            'rgba(54, 162, 235, 0.6)',
                            'rgba(255, 206, 86, 0.6)',
                            'rgba(75, 192, 192, 0.6)',
                            'rgba(153, 102, 255, 0.6)',
                            'rgba(255, 159, 64, 0.6)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    animation: {
                        duration: 0 // Disable animation
                    }
                }
            });

            // Create weekly bar chart
            const weeklyCtx = document.getElementById('weeklyChart').getContext('2d');
            new Chart(weeklyCtx, {
                type: 'bar',
                data: {
                    labels: weeklyLabels,
                    datasets: [{
                        label: 'Weekly Hours',
                        data: weeklyData,
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    animation: {
                        duration: 0 // Disable animation
                    }
                }
            });

            // Create monthly bar chart
            const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
            new Chart(monthlyCtx, {
                type: 'bar',
                data: {
                    labels: monthlyLabels,
                    datasets: [{
                        label: 'Monthly Hours',
                        data: monthlyData,
                        backgroundColor: 'rgba(153, 102, 255, 0.6)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    animation: {
                        duration: 0 // Disable animation
                    }
                }
            });
        });
    </script>
</body>
</html>
