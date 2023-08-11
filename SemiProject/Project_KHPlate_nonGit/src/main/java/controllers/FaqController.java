package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import commons.SecurityUtils;
import dao.FaqDAO;
import dto.ConsultDTO;
import dto.FaqDTO;
import dto.NaviDTO;
import statics.Settings;

@WebServlet("*.faq")
public class FaqController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI();
		
		try {
			if(cmd.equals("/register.faq")) {
				String title = request.getParameter("title");
				title = SecurityUtils.XSSCheck(title);
				String body = request.getParameter("body");
				body = SecurityUtils.XSSCheck(body);
				
				int result = FaqDAO.getInstance().insert(new FaqDTO(0, title, body));
				response.sendRedirect("/view.faq");
			}else if(cmd.equals("/view.faq")) {
				int currentPage = 0;
				if(request.getParameter("cpage") == null) {
					currentPage = 1;
				}else {
					currentPage = Integer.parseInt(request.getParameter("cpage"));
				}
				
				int start = currentPage * Settings.FAQ_RECORD_COUNT_PER_PAGE - (Settings.FAQ_NAVI_COUNT_PER_PAGE-1);
				int end = currentPage * Settings.FAQ_RECORD_COUNT_PER_PAGE;
				ArrayList<FaqDTO> list = null;
				NaviDTO navi = null;
				
				list = FaqDAO.getInstance().selectBound(start, end);
				navi = FaqDAO.getInstance().getNavi(currentPage);
				
				request.setAttribute("list", list);
				request.setAttribute("navi", navi);
				request.getRequestDispatcher("/adminPage/FAQView.jsp").forward(request, response);
			}else if(cmd.equals("/delete.faq")) {
				if(request.getSession().getAttribute("loginIsAdmin") != null && (boolean)request.getSession().getAttribute("loginIsAdmin")) {
					int qaID = Integer.parseInt(request.getParameter("id"));
					
					int result = FaqDAO.getInstance().delete(qaID);
					response.sendRedirect("/view.faq");					
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
