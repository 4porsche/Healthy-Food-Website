/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Requests;
import repository.RequestsDao;

/**
 *
 * @author Admin
 */
public class UpdateStatusController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateStatusController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateStatusController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestsDao rd = new RequestsDao();
        try {
            int requestId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            // Lấy thông tin lọc hiện tại
            String search = request.getParameter("search");
            String filterStatus = request.getParameter("filterStatus");

            String pageStr = request.getParameter("page");
            int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;

            Requests req = rd.getConsultationById(requestId);
            String currentStatus = req.getStatus();
            String note = req.getResponseNote();

            // Normalize
            String currentStatusLower = currentStatus.toLowerCase();
            String statusLower = status.toLowerCase();

            // Nếu cập nhật sang Accepted hoặc Rejected mà ghi chú rỗng thì báo lỗi
            if (statusLower.equals("accepted")
                    && (note == null || note.trim().isEmpty())) {
                request.setAttribute("error", "Ghi chú không được để trống khi thay đổi trạng thái.");

                // Gửi lại danh sách theo search/status hiện tại
                List<Requests> list = rd.getFilteredRequests(search, filterStatus, 1, 10);
                int totalRecords = rd.countFilteredRequests(search, filterStatus);
                int totalPages = (int) Math.ceil((double) totalRecords / 10);

                request.setAttribute("list", list);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", 1);
                request.setAttribute("search", search);
                request.setAttribute("status", filterStatus);

                request.getRequestDispatcher("nutritionist.jsp").forward(request, response);
                return;
            }

            // Cập nhật nếu hợp lệ
            if ("accepted".equals(statusLower) && currentStatusLower.equals("pending")) {
                rd.updateResponse(requestId, "Accepted", note);
            } else if ("rejected".equals(statusLower) && currentStatusLower.equals("pending")) {
                rd.updateResponse(requestId, "Rejected", note);
            } else if ("pending".equals(statusLower)
                    && (currentStatusLower.equals("accepted") || currentStatusLower.equals("rejected"))) {
                rd.updateResponse(requestId, "Pending", note);
            }

            // Quay về danh sách mặc định (không lọc)
            response.sendRedirect("requests?page=" + page + "&search=" + (search != null ? search : "") + "&status=" + (filterStatus != null ? filterStatus : ""));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi xử lý trạng thái.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestsDao rd = new RequestsDao();
        try {
            int requestId = Integer.parseInt(request.getParameter("requestID"));
            String newNote = request.getParameter("responseNote");

            // Lấy thông tin lọc hiện tại
            String search = request.getParameter("search");
            String filterStatus = request.getParameter("filterStatus");
            String pageStr = request.getParameter("page");
            int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;

            if (newNote == null || newNote.trim().isEmpty()) {
                request.setAttribute("error", "Ghi chú không được để trống.");

                List<Requests> list = rd.getFilteredRequests(search, filterStatus, 1, 10);
                int totalRecords = rd.countFilteredRequests(search, filterStatus);
                int totalPages = (int) Math.ceil((double) totalRecords / 10);

                request.setAttribute("list", list);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", 1);
                request.setAttribute("search", search);
                request.setAttribute("status", filterStatus);

                request.getRequestDispatcher("nutritionist.jsp").forward(request, response);
                return;
            }

            Requests req = rd.getConsultationById(requestId);
            String currentStatus = req.getStatus();

            rd.updateResponse(requestId, currentStatus, newNote);

            // Quay về danh sách mặc định
            response.sendRedirect("requests?page=" + page + "&search=" + (search != null ? search : "") + "&filterStatus=" + (filterStatus != null ? filterStatus : ""));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi khi cập nhật ghi chú.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
