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


                <h2 class="text-center text-primary mt-4 mb-3">Yêu cầu tư vấn khách hàng</h2>

                <div class="container">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle text-center">
                            <thead class="table-info">
                                <tr>
                                    <th>Tên khách hàng</th>
                                    <th>Thông tin khách hàng</th>
                                    <th>Ngày yêu cầu</th>
                                    <th>Trạng thái</th>
                                    <th style="width: 35%;">Ghi chú tư vấn</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${requests}">
                                    <tr>
                                        <td>${c.customerName}</td>
                                        <td class="text-center">
                                            <a type="button" class="btn btn-primary btn-sm" href="profile">
                                                Xem
                                            </a>
                                        </td>

                                        <td>${c.requestDate}</td>
                                        <td class="text-capitalize">
                                            <span class="badge
                                                  ${c.status == 'Accepted' ? 'bg-success' : 
                                                    c.status == 'Pending' ? 'bg-warning text-dark' : 
                                                    c.status == 'Rejected' ? 'bg-danger' : 'bg-secondary'}">
                                                      ${c.status}
                                                  </span>
                                            </td>
                                            <td class="text-start text-center">

                                                <!-- Nút Thay đổi -->
                                                <button type="button" class="btn btn-warning btn-sm ms-1"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#editModal${c.requestID}">
                                                    Thay đổi
                                                </button>

                                             

                                                <!-- Modal Thay đổi -->
                                                <div class="modal fade" id="editModal${c.requestID}" tabindex="-1" aria-labelledby="editModalLabel${c.requestID}" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <form action="updateresponse" method="post">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="editModalLabel${c.requestID}">Chỉnh sửa ghi chú</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <input type="hidden" name="requestID" value="${c.requestID}" />
                                                                    <div class="mb-3">
                                                                        <label for="responseNote${c.requestID}" class="form-label">Ghi chú phản hồi</label>
                                                                        <textarea class="form-control" name="responseNote" id="responseNote${c.requestID}" rows="4">${c.responseNote}</textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-success">Lưu</button>
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </td>



                                            <td>

                                                <a class="btn btn-sm btn-success mb-1" href="updateconsultation?id=${c.requestID}">Chấp nhận</a>
                                                <a class="btn btn-sm btn-danger" href="deleteconsultation?id=${c.requestID}" onclick="return confirmDelete()">Hủy</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <script>
                        function confirmDelete() {
                            return confirm("Bạn có chắc chắn muốn hủy yêu cầu này?");
                        }
                    </script>


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
                    return confirm("Bạn có chắc chắn muốn hủy yêu cầu này?");
                }
            </script>

        </body>
    </html>
