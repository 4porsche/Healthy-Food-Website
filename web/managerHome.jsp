<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .dashboard-header {
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 1rem 1rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 1.5rem;
            height: 100%;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .card-1 {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
        }
        .card-2 {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
        }
        .card-3 {
            background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            color: white;
        }
        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .btn-dashboard {
            background-color: rgba(255,255,255,0.2);
            border: 1px solid rgba(255,255,255,0.4);
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 2rem;
            transition: all 0.3s;
        }
        .btn-dashboard:hover {
            background-color: rgba(255,255,255,0.3);
            transform: scale(1.05);
        }
        .form-control {
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
        }
    </style>
</head>
<body>
    <div class="dashboard-header text-center">
        <div class="container">
            <h1 class="display-4 fw-bold"><i class="fas fa-tachometer-alt me-3"></i>Manager Dashboard</h1>
            <p class="lead">Welcome to the HealthyFood Management System</p>
        </div>
    </div>

    <div class="container">
        <div class="row g-4">
            <!-- Menu Suggestions Card -->
            <div class="col-md-4">
                <div class="card card-1 text-center p-4">
                    <div class="card-icon">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h3 class="card-title">Menu Suggestions</h3>
                    <p class="card-text">Review and manage nutritionist menu suggestions</p>
                    <a href="MenuSuggestionServlet" class="btn btn-dashboard mt-3">
                        <i class="fas fa-eye me-2"></i>Review Suggestions
                    </a>
                </div>
            </div>
            
            <!-- Revenue Reports Card -->
            <div class="col-md-4">
                <div class="card card-2 text-center p-4">
                    <div class="card-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3 class="card-title">Revenue Reports</h3>
                    <p class="card-text">Generate detailed revenue reports</p>
                    <form action="RevenueReportServlet" method="POST" class="mt-3">
                        <div class="mb-3">
                            <label class="form-label">Start Date</label>
                            <input type="date" name="startDate" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">End Date</label>
                            <input type="date" name="endDate" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-dashboard w-100">
                            <i class="fas fa-file-pdf me-2"></i>Generate Report
                        </button>
                    </form>
                </div>
            </div>
            
            <!-- Order Management Card -->
            <div class="col-md-4">
                <div class="card card-3 text-center p-4">
                    <div class="card-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <h3 class="card-title">Order Management</h3>
                    <p class="card-text">View and manage customer orders</p>
                    <a href="OrderManagementServlet" class="btn btn-dashboard mt-3">
                        <i class="fas fa-list me-2"></i>View Orders
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>