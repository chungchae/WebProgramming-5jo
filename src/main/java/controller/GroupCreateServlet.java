package controller;

import dao.GroupDAO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/groupCreate")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class GroupCreateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId"); // 세션에 저장된 userId를 가져옴
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp"); // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int maxMembers = Integer.parseInt(request.getParameter("maxMembers"));

        // 카테고리 데이터 가져오기
        String[] categories = request.getParameterValues("categories[]");

        // 운영 시간 데이터 가져오기
        String[] days = request.getParameterValues("days[]");
        String[] startTimes = request.getParameterValues("startTimes[]");
        String[] endTimes = request.getParameterValues("endTimes[]");
        String imageUrl = "";
        GroupDAO groupDAO = new GroupDAO();

        // 그룹 생성 및 groupId 반환
        int groupId = groupDAO.createGroupAndGetId(title, description, imageUrl, maxMembers, categories, days, startTimes, endTimes, userId);
        if (groupId == -1) {
            response.getWriter().write("<script>alert('생성 중 오류가 발생했습니다. 다시 시도해주세요.'); location.href='/groupCreate';</script>");
            return;
        }

        // 파일 저장 처리
        Part filePart = request.getPart("imageUrl");
        if (filePart != null && filePart.getSize() > 0) {
            // 저장 경로 설정
            String uploadPath = getServletContext().getRealPath("/") + "media/";
            String fileName = "group" + groupId + ".png";
            File fileSaveDir = new File(uploadPath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs();
            }

            // 파일 저장
            filePart.write(uploadPath + fileName);

        }

        // 성공 시 알림창 띄우고 메인으로 리다이렉트
        response.getWriter().write("<script>alert('성공적으로 생성되었습니다!'); location.href='/main';</script>");
    }

}

