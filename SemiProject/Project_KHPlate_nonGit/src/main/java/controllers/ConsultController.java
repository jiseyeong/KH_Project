package controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import commons.SecurityUtils;
import dao.ConsultDAO;
import dao.ConsultReplyDAO;
import dao.MembersDAO;
import dao.PhotoDAO;
import dto.ConsultDTO;
import dto.ConsultReplyDTO;
import dto.NaviDTO;
import dto.PhotoDTO;
import statics.Settings;

@WebServlet("*.consult")
public class ConsultController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=utf8;");
		Gson g = new Gson();
		
		String cmd = request.getRequestURI();
		
		try {
			if(cmd.equals("/register.consult")) {
				String realPath = request.getServletContext().getRealPath("consult");
				int maxSize = 1024 * 1024 * 10; //10Mb
				System.out.println(realPath);
				File realPathFile = new File(realPath);
				if(!realPathFile.exists()) {
					realPathFile.mkdir();
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf8", new DefaultFileRenamePolicy());
				
				String category = multi.getParameter("category");
				String title = multi.getParameter("title");
				title = SecurityUtils.XSSCheck(title);
				Integer userNo = Integer.parseInt(multi.getParameter("writer"));
				String body = multi.getParameter("body");
				body = SecurityUtils.XSSCheck(body);
				
				int result = ConsultDAO.getInstance().insert(new ConsultDTO(0, title, body, userNo, null, category, "N"));
				int currval = ConsultDAO.getInstance().getCurrval();
				
				Enumeration<String> names = multi.getFileNames();
				while(names.hasMoreElements()) {
					String fileName = names.nextElement();
					if(multi.getFile(fileName) != null){
						String oriName = multi.getOriginalFileName(fileName);
						String sysName = multi.getFilesystemName(fileName);
						PhotoDAO.getInstance().insertByConsultID(oriName, sysName, currval);
					}
				}
				
				response.sendRedirect("/list.consult");
			}else if(cmd.equals("/list.consult")) {
				int currentPage = 0;
				if(request.getParameter("cpage") == null) {
					currentPage = 1;
				}else {
					currentPage = Integer.parseInt(request.getParameter("cpage"));
				}
				int start = currentPage * Settings.CONSULT_RECORD_COUNT_PER_PAGE - (Settings.CONSULT_NAVI_COUNT_PER_PAGE-1);
				int end = currentPage * Settings.CONSULT_RECORD_COUNT_PER_PAGE;
				ArrayList<ConsultDTO> list = null;
				NaviDTO navi = null;
				ArrayList<String> writerList = new ArrayList<>();
				if(request.getSession().getAttribute("loginIsAdmin") != null && (boolean)request.getSession().getAttribute("loginIsAdmin")) {
					list = ConsultDAO.getInstance().selectBound(start, end);
					navi = ConsultDAO.getInstance().getNavi(currentPage);
				}else if(request.getSession().getAttribute("userno") != null) {
					int userNo = (int)request.getSession().getAttribute("userno");
					list = ConsultDAO.getInstance().selectBoundByUserNo(start, end, userNo);
					navi = ConsultDAO.getInstance().getNaviByUserNo(currentPage, userNo);
				}else {
					response.sendRedirect("/login/login.jsp");
					return;
				}
				
				
				for(ConsultDTO i : list) {
					writerList.add(MembersDAO.getInstance().getIDByNo(i.getUserNO()));
				}
				request.setAttribute("list", list);
				request.setAttribute("writerList", writerList);
				request.setAttribute("navi", navi);
				request.getRequestDispatcher("/adminPage/consultList.jsp").forward(request, response);
			}else if(cmd.equals("/view.consult")) {
				int consultID = Integer.parseInt(request.getParameter("consultID"));
				ConsultDTO dto = ConsultDAO.getInstance().selectOne(consultID);
				String writer = MembersDAO.getInstance().getIDByNo(dto.getUserNO());				
				ConsultReplyDTO replyDTO = ConsultReplyDAO.getInstance().selectOneByConsultID(consultID);
				String replyWriter = null;
				if(replyDTO != null) {
					replyWriter = MembersDAO.getInstance().getIDByNo(replyDTO.getUserNo());
				}
				
				request.setAttribute("dto", dto);
				request.setAttribute("writer", writer);
				request.setAttribute("replyDTO", replyDTO);
				request.setAttribute("replyWriter", replyWriter);
				//이미지 추가해야 함.
				PhotoDTO photo = PhotoDAO.getInstance().selectByConsultID(consultID);
				request.setAttribute("image", photo);
				request.getRequestDispatcher("/adminPage/consultView.jsp").forward(request, response);
			}else if(cmd.equals("/replyForm.consult")) {
				int consultID = Integer.parseInt(request.getParameter("consultID"));
				ConsultDTO parentDTO = ConsultDAO.getInstance().selectOne(consultID);
				String parentWriter = MembersDAO.getInstance().getIDByNo(parentDTO.getUserNO());
				
				request.setAttribute("parentDTO", parentDTO);
				request.setAttribute("parentWriter", parentWriter);
				//이미지 추가해야 함
				PhotoDTO photo = PhotoDAO.getInstance().selectByConsultID(consultID);
				request.setAttribute("parentImage", photo);
				request.getRequestDispatcher("/adminPage/consultReplyRegister.jsp").forward(request, response);
			}else if(cmd.equals("/replyRegister.consult")) {
				int userNo = Integer.parseInt(request.getParameter("writer"));
				int consultID = Integer.parseInt(request.getParameter("consultID"));
				String title = request.getParameter("title");
				title = SecurityUtils.XSSCheck(title);
				String body = request.getParameter("body");
				body = SecurityUtils.XSSCheck(body);
				
				int result = ConsultReplyDAO.getInstance().insert(new ConsultReplyDTO(0, title, body, consultID, userNo, null));
				int replyResult = ConsultDAO.getInstance().updateReply(consultID, "Y");
				response.sendRedirect("/view.consult?consultID="+consultID);
				
				
				// 마이 페이지에서 1:1문의 리스트 출력
			}else if(cmd.equals("/selectConsultListBymypage.consult")) {
				int userno = (int) request.getSession().getAttribute("userno");
				int currentpage = 1;

				if(request.getParameter("cpage")!=null) {
					currentpage = Integer.parseInt(request.getParameter("cpage"));
				}

				System.out.println("현재 페이지 : "+currentpage);

				int end_Record_Row_Num = currentpage * Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE;
				int start_Record_Row_Num = end_Record_Row_Num - (Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE-1);

				System.out.println("시작 번호 : "+start_Record_Row_Num);
				System.out.println("끝 번호 : "+end_Record_Row_Num);

				String myConsultList = ConsultDAO.getInstance().selectMyConsultList(userno, start_Record_Row_Num, end_Record_Row_Num);
				String myConsultNavi = ConsultDAO.getInstance().selectMyConsultNaviToJSP(currentpage, userno);

				myConsultList = g.toJson(myConsultList);
				myConsultNavi = g.toJson(myConsultNavi);

				JsonObject resp = new JsonObject();
				resp.addProperty("myConsultList", myConsultList);
				resp.addProperty("myConsultNavi", myConsultNavi);

				response.getWriter().append(resp.toString());
			}else if(cmd.equals("/delete.consult")) {
				if((request.getSession().getAttribute("loginIsAdmin") != null && (boolean)request.getSession().getAttribute("loginIsAdmin"))
						|| (request.getSession().getAttribute("userno")!=null && request.getParameter("userNo") != null && Integer.parseInt(request.getParameter("userNo")) == (int)request.getSession().getAttribute("userno"))) {
					int consultID = Integer.parseInt(request.getParameter("consultID"));
					
					int result = ConsultDAO.getInstance().delete(consultID);
					int replyResult = ConsultReplyDAO.getInstance().deleteByConsultID(consultID);
					
					response.sendRedirect("/list.consult");
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
