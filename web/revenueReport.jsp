<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Revenue Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .header {
            background: linear-gradient(135deg, #11998e, #38ef7d);
            color: white;
            padding: 1.5rem 0;
            margin-bottom: 2rem;
        }
        .report-card {
            background: white;
            border-radius: 0.75rem;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .summary-card {
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: white;
            border-radius: 0.75rem;
            padding: 1.5rem;
            text-align: center;
            margin-bottom: 2rem;
        }
        .chart-container {
            background: white;
            border-radius: 0.75rem;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            padding: 1.5rem;
            height: 300px;
        }
        .back-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 0.5rem 1.25rem;
            border-radius: 0.5rem;
            transition: all 0.3s;
        }
        .back-btn:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
        }
        .revenue-table {
            width: 100%;
        }
        .revenue-table th {
            background-color: #f1f3ff;
            padding: 0.75rem;
            text-align: left;
        }
        .revenue-table td {
            padding: 0.75rem;
            border-bottom: 1px solid #e9ecef;
        }
        .revenue-table tr:last-child td {
            border-bottom: none;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="h3 mb-0"><i class="fas fa-chart-line me-2"></i>Revenue Report</h1>
                <a href="managerHome.jsp" class="btn btn-light">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="summary-card">
            <h3 class="mb-3">Report Period: ${startDate} to ${endDate}</h3>
            <h1 class="display-4 fw-bold">
                <c:set var="totalRevenue" value="${0}" />
                <c:forEach var="report" items="${reports}">
                    <c:set var="totalRevenue" value="${totalRevenue + report.revenue}" />
                </c:forEach>
                $${totalRevenue}
            </h1>
            <p class="mb-0">Total Revenue</p>
        </div>
        
        <div class="row">
            <div class="col-lg-8">
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="report-card">
                    <h4 class="mb-4">Daily Revenue Details</h4>
                    <table class="revenue-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th style="text-align: right;">Revenue</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="report" items="${reports}">
                                <tr>
                                    <td>${report.date}</td>
                                    <td style="text-align: right;">$${report.revenue}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="d-flex justify-content-center mt-4">
            <a href="managerHome.jsp" class="btn back-btn">
                <i class="fas fa-home me-2"></i>Back to Dashboard
            </a>
        </div>
    </div>

    <script>
        // Prepare data for the chart
        const dates = [];
        const revenues = [];
        
        <c:forEach var="report" items="${reports}">
            dates.push('${report.date}');
            revenues.push(${report.revenue});
        </c:forEach>
        
        // Create revenue chart
        const ctx = document.getElementById('revenueChart').getContext('2d');
        const revenueChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dates,
                datasets: [{
                    label: 'Daily Revenue ($)',
                    data: revenues,
                    backgroundColor: 'rgba(78, 84, 200, 0.7)',
                    borderColor: 'rgba(78, 84, 200, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        ticks: {
                            callback: function(value) {
                                return '$' + value;
                            }
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>