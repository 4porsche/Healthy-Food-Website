<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Review Menu Suggestion</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .header {
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: white;
            padding: 1.5rem 0;
            margin-bottom: 2rem;
        }
        .suggestion-card {
            background: white;
            border-radius: 0.75rem;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .btn-action {
            padding: 0.75rem 2rem;
            border-radius: 0.5rem;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .btn-approve {
            background: linear-gradient(135deg, #11998e, #38ef7d);
            color: white;
        }
        .btn-reject {
            background: linear-gradient(135deg, #ff416c, #ff4b2b);
            color: white;
        }
        .btn-action:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .suggestion-detail {
            padding: 1.25rem;
            background-color: #f9f9ff;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
        .detail-label {
            font-weight: 600;
            color: #4e54c8;
            min-width: 120px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="h3 mb-0"><i class="fas fa-edit me-2"></i>Review Menu Suggestion</h1>
                <a href="MenuSuggestionServlet" class="btn btn-light">
                    <i class="fas fa-arrow-left me-2"></i>Back to List
                </a>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="suggestion-card">
            <form action="ReviewSuggestionServlet" method="POST">
                <input type="hidden" name="id" value="${suggestion.suggestionId}">
                
                <div class="suggestion-detail">
                    <div class="d-flex align-items-center mb-3">
                        <span class="detail-label">Title:</span>
                        <h3 class="mb-0">${suggestion.title}</h3>
                    </div>
                    
                    <div class="d-flex mb-3">
                        <span class="detail-label">Created Date:</span>
                        <span class="fs-5">${suggestion.createdDate}</span>
                    </div>
                    
                    <div class="mb-3">
                        <span class="detail-label d-block mb-2">Description:</span>
                        <div class="p-3 bg-white rounded border">
                            ${suggestion.description}
                        </div>
                    </div>
                </div>
                
                <div class="d-flex justify-content-center gap-3">
                    <button type="submit" name="action" value="approve" class="btn-action btn-approve">
                        <i class="fas fa-check-circle me-2"></i>Approve
                    </button>
                    <button type="submit" name="action" value="reject" class="btn-action btn-reject">
                        <i class="fas fa-times-circle me-2"></i>Reject
                    </button>
                </div>
            </form>
        </div>
        
        <div class="d-flex justify-content-center">
            <a href="MenuSuggestionServlet" class="btn btn-secondary">
                <i class="fas fa-list me-2"></i>Back to Suggestions List
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>