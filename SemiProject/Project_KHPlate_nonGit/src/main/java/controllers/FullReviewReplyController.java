package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import commons.SecurityUtils;
import dao.FullReviewReplyDAO;
import statics.Settings;

@WebServlet("*.fullreviewreply")
public class FullReviewReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=utf8;");

		String cmd = request.getRequestURI();
		FullReviewReplyDAO frrdao = FullReviewReplyDAO.getInstance();
		System.out.println(cmd);
		
		try {
			if (cmd.equals("/write.fullreviewreply")) {

				String body = request.getParameter("body");
				SecurityUtils.XSSCheck(body);
				int userno = Integer.parseInt(request.getParameter("userno"));
				int reviewid = Integer.parseInt(request.getParameter("reviewid"));

				System.out.println(userno+"가"+reviewid+"에 입력한 덧글"+body);
				
				frrdao.addReply(body, userno, reviewid);

				response.sendRedirect("/content.fullreview?reviewid="+reviewid);

			} else if (cmd.equals("/delete.fullreviewreply")) {

				int reviewid = Integer.parseInt(request.getParameter("reviewid"));
				int commentid = Integer.parseInt(request.getParameter("commentid"));
				System.out.println();
				
				int result = frrdao.deleteReply(commentid);

				if (result == 0) {
					System.out.println(reviewid+"게시글의 "+ commentid + "댓글 삭제 실패");
				} else {
					System.out.println(reviewid+"게시글의 "+ commentid + "댓글 삭제 성공");
				}

				response.sendRedirect("/content.fullreview?reviewid="+reviewid);

			} else if (cmd.equals("/update.fullreviewreply")) {
				String body = request.getParameter("re_list_body");
				body = SecurityUtils.XSSCheck(body);
				int reviewid = Integer.parseInt(request.getParameter("reviewid"));
				int commentid = Integer.parseInt(request.getParameter("commentid")); 
				System.out.println(body+"/"+commentid);

				int result = frrdao.updateReply(body, commentid);
				
				if (result == 0) {
					System.out.println(reviewid + "댓글 수정 실패");
				} else {
					System.out.println(reviewid + "댓글 수정 성공");
				}
				response.sendRedirect("/content.fullreview?reviewid="+reviewid);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
