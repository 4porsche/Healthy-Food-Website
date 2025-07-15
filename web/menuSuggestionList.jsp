<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Suggestions</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        .table-container {
            background: white;
            border-radius: 0.75rem;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        .table thead {
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: white;
        }
        .table th {
            font-weight: 600;
        }
        .status-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .btn-review {
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: white;
            border: none;
            padding: 0.35rem 1rem;
            border-radius: 0.5rem;
            transition: all 0.3s;
        }
        .btn-review:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
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
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="h3 mb-0"><i class="fas fa-clipboard-list me-2"></i>Pending Menu Suggestions</h1>
                <a href="managerHome.jsp" class="btn btn-light">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="table-container">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Created Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="suggestion" items="${suggestions}">
                        <tr>
                            <td>${suggestion.suggestionId}</td>
                            <td>${suggestion.title}</td>
                            <td>${suggestion.createdDate}</td>
                            <td>
                                <span class="status-badge status-pending">Pending</span>
                            </td>
                            <td>
                                <a href="ReviewSuggestionServlet?id=${suggestion.suggestionId}" class="btn btn-review">
                                    <i class="fas fa-edit me-1"></i>Review
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="d-flex justify-content-center mt-4">
            <a href="managerHome.jsp" class="btn back-btn">
                <i class="fas fa-home me-2"></i>Back to Dashboard
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>