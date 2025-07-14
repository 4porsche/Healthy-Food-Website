<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Consultation Requests</title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/nutri.css" rel="stylesheet">
    </head>
    <body>
        <div class="container d-flex justify-content-center">
            <div class="col-md-12">
                <h2 class="text-center text-success mt-4 mb-3">Yêu cầu tư vấn khách hàng</h2>

                <!-- Search and Filter Form -->
                <form action="requests" method="get" class="d-flex gap-2 mb-3 align-items-end">
                    <div class="flex-grow-1">
                        <label for="search" class="form-label">Tìm kiếm</label>
                        <input type="text" name="search" id="search" class="form-control"
                               placeholder="Tìm kiếm theo tên khách hàng..."
                               value="${param.search != null ? param.search : ''}">
                    </div>
                    <div>
                        <label for="status" class="form-label">Trạng thái</label>
                        <select name="status" id="status" class="form-select">
                            <option value="" ${empty param.status ? 'selected' : ''}>Tất cả</option>
                            <option value="Accepted" ${param.status == 'Accepted' ? 'selected' : ''}>Chấp nhận</option>
                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Đang chờ</option>
                            <option value="Rejected" ${param.status == 'Rejected' ? 'selected' : ''}>Hủy</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Áp dụng</button>
                </form>

                <!-- Error -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center align-middle">
                        <thead class="table-info">
                            <tr>

                                <th>Tên khách hàng</th>
                                <th>Thông tin</th>
                                <th>Ngày mong muốn tư vấn</th>
                                <th>Trạng thái</th>
                                <th style="width:35%">Ghi chú tư vấn</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${list}">
                                <tr>
                                    <td>${c.customerName}</td>
                                    <td>
                                        <a class="btn btn-primary btn-sm" href="profile?userid=${c.customerID}">Xem</a>
                                    </td>
                                    <td>${c.preferredDate}</td>
                                    <td class="text-capitalize">
                                        <span class="badge
                                              ${c.status == 'Accepted' ? 'bg-success' :
                                                c.status == 'Pending' ? 'bg-warning text-dark' :
                                                c.status == 'Rejected' ? 'bg-danger' : 'bg-secondary'}">
                                                  ${c.status}
                                              </span>
                                        </td>
                                        <td class="text-center">


                                            <c:choose>
                                                <c:when test="${c.status == 'Pending'}">
                                                    <button type="button" class="btn btn-warning btn-sm"
                                                            data-bs-toggle="modal" data-bs-target="#editModal${c.requestID}">
                                                        Thay đổi
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                <button type="button" class="btn btn-sm btn-secondary"
                                                        disabled">
                                                    Thay đổi
                                                </button>
                                                </c:otherwise>
                                            </c:choose>


                                            <!-- Modal -->
                                            <div class="modal fade" id="editModal${c.requestID}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <form action="updatestatus" method="post">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Chỉnh sửa ghi chú</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <input type="hidden" name="requestID" value="${c.requestID}" />
                                                                <input type="hidden" name="search" value="${param.search}" />
                                                                <input type="hidden" name="filterStatus" value="${param.status}" />
                                                                <input type="hidden" name="page" value="${currentPage}" />

                                                                <div class="mb-3">
                                                                    <label class="form-label">Ghi chú phản hồi</label>
                                                                    <textarea class="form-control" name="responseNote" rows="4">${c.responseNote}</textarea>
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
                                            <c:choose>
                                                <c:when test="${c.status == 'Pending'}">
                                                    <c:choose>
                                                        <c:when test="${empty c.responseNote}">
                                                            <button class="btn btn-sm btn-secondary mb-1" disabled>Chấp nhận</button>
                                                            <button class="btn btn-sm btn-secondary" disabled>Hủy</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a class="btn btn-sm btn-success mb-1"
                                                               href="updatestatus?id=${c.requestID}&status=accepted&search=${param.search}&filterStatus=${param.status}&page=${currentPage}">Chấp nhận</a>
                                                            <a class="btn btn-sm btn-danger"
                                                               href="updatestatus?id=${c.requestID}&status=rejected&search=${param.search}&filterStatus=${param.status}&page=${currentPage}"
                                                               onclick="return confirmDelete()">Hủy</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:when test="${c.status == 'Accepted' || c.status == 'Rejected'}">

                                                    <a class="btn btn-sm btn-warning mb-1"
                                                       href="updatestatus?id=${c.requestID}&status=pending&search=${param.search}&filterStatus=${param.status}&page=${currentPage}">Sửa</a>
                                                    <a class="btn btn-sm btn-danger"
                                                       href="deleteconsultation?id=${c.requestID}"
                                                       onclick="return confirmDelete()">Xóa</a>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages >= 1}">
                        <nav>
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="requests?page=${currentPage - 1}&search=${param.search}&status=${param.status}">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="requests?page=${i}&search=${param.search}&status=${param.status}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="requests?page=${currentPage + 1}&search=${param.search}&status=${param.status}">Next</a>
                                    </li>
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

                // JS validation khi bấm "Lưu" mà chưa có ghi chú
                document.querySelectorAll("form[action='updatestatus']").forEach(form => {
                    form.addEventListener("submit", function (e) {
                        const note = form.querySelector("textarea[name='responseNote']").value.trim();
                        if (note === "") {
                            e.preventDefault();
                            alert("Vui lòng nhập ghi chú trước khi lưu.");
                        }
                    });
                });
            </script>
        </body>
    </html>
