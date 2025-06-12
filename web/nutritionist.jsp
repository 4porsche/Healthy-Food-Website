<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Consultation Requests</title>
        <link rel="stylesheet" href="styles.css">
        <link href="stylecss.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="col-md-12">
                <h2 class="text-primary text-center btn-success">Customer Consultation Requests</h2>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center">
                        <thead class="table table-info">
                            <tr>
                                <th>#</th>
                                <th>Customer</th>
                                <th>Nutritionist</th>
                                <th>Request Date</th>
                                <th>Status</th>
                                <th>Notes</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${consultationList}" var="c" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${c.customerName}</td>
                                    <td>${c.nutritionistName}</td>
                                    <td>${c.requestDate}</td>
                                    <td>${c.status}</td>
                                    <td>${c.notes}</td>
                                    <td>
                                        <a class="btn btn-warning btn-sm" href="updateConsultation?id=${c.consultationID}">Update</a>
                                        <a class="btn btn-danger btn-sm" href="deleteConsultation?id=${c.consultationID}" onclick="return confirmDelete()">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${not empty totalPages}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item"><a class="page-link" href="consultationManager?page=${currentPage - 1}">Previous</a></li>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="consultationManager?page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item"><a class="page-link" href="consultationManager?page=${currentPage + 1}">Next</a></li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>

        <script>
            function confirmDelete() {
                return confirm('Are you sure you want to delete this consultation request?');
            }
        </script>

    </body>
</html>
