<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" href="styles.css">
</head>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.popup {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

.popup-content {
    background-color: rgb(16,13,37);
    margin:auto; 
    margin-top:100px;
    /* 20% from the top and centered */
    padding: 80px;
    border: 1px solid #888;
    width: 25%; /* Could be more or less, depending on screen size */
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    border-radius: 10px;
    text-align: center;
    position: relative;
    color:#fff;
    
}



.close:hover,
.close:focus {
    color: DodgerBlue;
    text-decoration: none;
    cursor: pointer;
}

.error-icon {
    color: red;
    font-size: 48px;
    margin-bottom: 20px;
}

.success-icon {
    color: green;
    font-size: 48px;
    margin-bottom: 20px;
}

#errorMessage {
    color: #fff;
    font-weight: bold;
}
</style>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">
    <div id="popup" class="popup">
        <div class="popup-content">
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage == null || errorMessage.isEmpty()) {
            %>
                    <div class="success-icon close">✔</div>
                    <p id="errorMessage">Success!</p>
            <% 
                } else {
            %>
                    <div class="error-icon close">✖</div>
                    <p id="errorMessage"><%= errorMessage %></p>
            <% 
                }
            %>
        </div>
    </div>
    <script>
        // Get the popup
        var popup = document.getElementById("popup");

        // Get the <span> element that closes the popup
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on <span> (x), close the popup and redirect to the previous page
        span.onclick = function() {
            popup.style.display = "none";
            window.history.back();
        }

        // When the user clicks anywhere outside of the popup, close it and redirect to the previous page
        window.onclick = function(event) {
            if (event.target == popup) {
                popup.style.display = "none";
                window.history.back();
            }
        }

        // Show the popup on page load
        window.onload = function() {
            popup.style.display = "block";
        }
    </script>
</body>
</html>