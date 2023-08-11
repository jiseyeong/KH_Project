package controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

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
import dao.CommentReviewDAO;
import dao.FullReviewDAO;
import dao.FullReviewReplyDAO;
import dao.PhotoDAO;
import dao.StoreDAO;
import dto.CommentReviewDTO;
import dto.FullReviewDTO;
import dto.FullReviewScrapDTO;
import dto.FullReviewUserDTO;
import dto.PhotoDTO;
import dto.ReplyWithUserIdDTO;
import dto.StoreDTO;
import statics.Settings;

@WebServlet("*.fullreview")
public class FullReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=utf8;");

		String cmd = request.getRequestURI();
		System.out.println(cmd);
		FullReviewDAO frdao = FullReviewDAO.getInstance();
		Gson gson = new Gson();
		
		try {

			if(cmd.equals("/write.fullreview")) {
				String realPath = request.getServletContext().getRealPath("FullReview");
				int maxSize = 1024 * 1024 * 10;
				System.out.println(realPath);
				File realPathFile = new File(realPath);
				if(!realPathFile.exists()) {
					realPathFile.mkdir();
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf8", new DefaultFileRenamePolicy());

				String title = multi.getParameter("title");
				title = SecurityUtils.XSSCheck(title);
				String reviewbody = multi.getParameter("reviewBody");
				reviewbody = SecurityUtils.XSSCheck(reviewbody);
				int score = Integer.parseInt(multi.getParameter("score"));
				int storeId = Integer.parseInt(multi.getParameter("storeId"));
				int userNo= Integer.parseInt(multi.getParameter("userNo"));


				int result = frdao.writeFullReview(title,reviewbody,score,storeId,userNo);
				
				ArrayList<CommentReviewDTO> commentListAll = CommentReviewDAO.getInstance().selectByStoreID(storeId);
				List<FullReviewDTO> fullListAll = FullReviewDAO.getInstance().selectByStoreID(storeId);
				
				int sum = 0;
				int cnt = commentListAll.size() + fullListAll.size();
				if(cnt != 0) {
					for(CommentReviewDTO i : commentListAll) {
						sum += i.getScore();
					}
					for(FullReviewDTO i : fullListAll) {
						sum += i.getScore();
					}
					StoreDAO.getInstance().updateAvgScore(( Math.round(((double)sum)/cnt*10))/10.0 , storeId);
					StoreDAO.getInstance().updateReviewCount(cnt, storeId);					
				}
				
				int reviewId = frdao.newReviewId();
				System.out.println("방금작성한 리뷰" + reviewId);

				Enumeration<String> names = multi.getFileNames();

				while(names.hasMoreElements()) {
					String fileName = names.nextElement();
					System.out.println(fileName);
					if(multi.getFile(fileName) != null){
						String oriName = multi.getOriginalFileName(fileName);
						String sysName = multi.getFilesystemName(fileName);
						PhotoDAO.getInstance().insertByFullReviewId(oriName,sysName,reviewId);
						System.out.println("DB입력됨");
					}
				}

				if (result>0) {
					System.out.println("진심리뷰 작성완료");
					response.sendRedirect("/select.fullreview");
				}else {
					response.sendRedirect("error.jsp");
				}

			}else if (cmd.equals("/towrite.fullreview")){
				List<StoreDTO> list = frdao.selectListStore();

				request.setAttribute("store", list);

				request.getRequestDispatcher("/FullReview/writeFullReview.jsp").forward(request, response);


			}else if (cmd.equals("/delete.fullreview")) {
				int reviewid = Integer.parseInt(request.getParameter("reviewid"));
				int storeId = Integer.parseInt(request.getParameter("storeid"));
				
				String realPath = request.getServletContext().getRealPath("FullReview");
				ArrayList<PhotoDTO> pdao = PhotoDAO.getInstance().ListByReviewId(reviewid);
				if(pdao != null) {
					for(PhotoDTO i : pdao) {
						File realPathFile = new File(realPath +"/"+ i.getSysName());
						realPathFile.delete();
					}
				}
				PhotoDAO.getInstance().deleteByReviewId(reviewid);
				int del =  frdao.deleteFullReview(reviewid);
				
				ArrayList<CommentReviewDTO> commentListAll = CommentReviewDAO.getInstance().selectByStoreID(storeId);
				List<FullReviewDTO> fullListAll = FullReviewDAO.getInstance().selectByStoreID(storeId);
				
				int sum = 0;
				int cnt = commentListAll.size() + fullListAll.size();
				if(cnt != 0) {
					for(CommentReviewDTO i : commentListAll) {
						sum += i.getScore();
					}
					for(FullReviewDTO i : fullListAll) {
						sum += i.getScore();
					}
					StoreDAO.getInstance().updateAvgScore(( Math.round(((double)sum)/cnt*10))/10.0 , storeId);
					StoreDAO.getInstance().updateReviewCount(cnt, storeId);					
				}
				
				if (del>0) {
					System.out.println("리뷰 "+reviewid+" 삭제완료");
					response.sendRedirect("/select.fullreview");
				}else {
					response.sendRedirect("error.jsp");
				}
			}else if (cmd.equals("/update.fullreview")){
   
				String realPath = request.getServletContext().getRealPath("FullReview");
				int maxSize = 1024 * 1024 * 10;
				System.out.println(realPath);
				File realPathFile = new File(realPath);
				if(!realPathFile.exists()) {
					realPathFile.mkdir();
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf8", new DefaultFileRenamePolicy());

				String title = multi.getParameter("title");
				title = SecurityUtils.XSSCheck(title);
				String reviewbody = multi.getParameter("reviewbody");
				reviewbody = SecurityUtils.XSSCheck(reviewbody);
				int score = Integer.parseInt(multi.getParameter("score"));
				int storeId = Integer.parseInt(multi.getParameter("storeId"));
				int reviewid= Integer.parseInt(multi.getParameter("reviewid"));

				int result = frdao.update(title, reviewbody, score, storeId, reviewid);

				ArrayList<CommentReviewDTO> commentListAll = CommentReviewDAO.getInstance().selectByStoreID(storeId);
				List<FullReviewDTO> fullListAll = FullReviewDAO.getInstance().selectByStoreID(storeId);
				
				int sum = 0;
				int cnt = commentListAll.size() + fullListAll.size();
				if(cnt != 0) {
					for(CommentReviewDTO i : commentListAll) {
						sum += i.getScore();
					}
					for(FullReviewDTO i : fullListAll) {
						sum += i.getScore();
					}
					StoreDAO.getInstance().updateAvgScore(( Math.round(((double)sum)/cnt*10))/10.0 , storeId);
					StoreDAO.getInstance().updateReviewCount(cnt, storeId);					
				}
				
				Enumeration<String> names = multi.getFileNames();

				while(names.hasMoreElements()) {
					String fileName = names.nextElement();
					System.out.println(fileName);
					if(multi.getFile(fileName) != null){
						String oriName = multi.getOriginalFileName(fileName);
						String sysName = multi.getFilesystemName(fileName);
						PhotoDAO.getInstance().insertByFullReviewId(oriName,sysName,reviewid);
						System.out.println("DB입력됨");
					}
				}

				if (result>0) {
					System.out.println("진심리뷰 수정완료");
					response.sendRedirect("content.fullreview?reviewid="+reviewid);
				}else {
					response.sendRedirect("error.jsp");
				}

				// 리뷰 글 목록 조회 + 검색 조회
			}else if (cmd.equals("/select.fullreview")) {
				int searchUserno = 0;
				String searchFullReviewTitle = "";

				if(request.getParameter("searchUserno")!=null) {
					searchUserno = Integer.parseInt(request.getParameter("searchUserno"));
				}
				if(request.getParameter("search")!=null) {
					searchFullReviewTitle = request.getParameter("search");
				}

				System.out.println("검색 유저 : "+searchUserno);
				System.out.println("검색 제목 : "+searchFullReviewTitle);

				int entpage = 1;

				if(request.getParameter("cpage")!=null) {
					entpage = Integer.parseInt(request.getParameter("cpage"));
				}

				System.out.println("현재 페이지 : "+entpage);

				int end_Record_Row_Num = entpage * Settings.SEARCH_FULLREVIEW_RECORD_COUNT_PER_PAGE;
				int start_Record_Row_Num = end_Record_Row_Num - (Settings.SEARCH_FULLREVIEW_RECORD_COUNT_PER_PAGE-1);

				System.out.println("시작 번호 : "+start_Record_Row_Num);
				System.out.println("끝 번호 : "+end_Record_Row_Num);

				List<FullReviewUserDTO> fullReviewList = frdao.selectFullReview(searchUserno, searchFullReviewTitle,start_Record_Row_Num,end_Record_Row_Num);
				
				List<PhotoDTO> PDTO = new ArrayList<>();
				for(FullReviewUserDTO list : fullReviewList ) {
					int reviewID = list.getReviewID();
					PDTO.add(PhotoDAO.getInstance().DTOByReviewId(reviewID));
				}
				
				String fullReviewNavi = frdao.getFullReviewNavi(entpage, searchUserno, searchFullReviewTitle);

				System.out.println("리스트 사이즈 : "+fullReviewList.size());


				// 로그인된 사용자의 경우 스크랩된 리뷰에 스크랩 마크 표시 추가
				int userno = 0;
				if(request.getSession().getAttribute("userno")!=null) {
					userno = (int) request.getSession().getAttribute("userno");
				}
				List<FullReviewScrapDTO> scrap_list = frdao.isScrapFullReview(fullReviewList,userno);

				request.setAttribute("FullReviewList", fullReviewList);
				request.setAttribute("FullReviewNavi", fullReviewNavi);
				request.setAttribute("scrap_list", scrap_list);
				request.setAttribute("photoList", PDTO);
				request.getRequestDispatcher("/FullReview/FullReviewList.jsp").forward(request, response);

				// 마이페이지에 표시할 fullReviewList 출력
			}else if (cmd.equals("/selectBymypage.fullreview")) {

				int userno = (int) request.getSession().getAttribute("userno");
				int entpage = 1;

				if(request.getParameter("cpage")!=null) {
					entpage = Integer.parseInt(request.getParameter("cpage"));
				}

				System.out.println("현재 페이지 : "+entpage);

				int end_Record_Row_Num = entpage * Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE;
				int start_Record_Row_Num = end_Record_Row_Num - (Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE-1);

				System.out.println("시작 번호 : "+start_Record_Row_Num);
				System.out.println("끝 번호 : "+end_Record_Row_Num);

				List<FullReviewUserDTO> fullReviewListBeforeChange = frdao.selectFullReview(userno, "", start_Record_Row_Num, end_Record_Row_Num);
				String writeFullReviewList = frdao.selectFullReviewListToJSP(fullReviewListBeforeChange);
				String writeFullReviewNavi = frdao.getFullReviewNaviToJSP(entpage, userno, "");

				System.out.println("리스트 사이즈 : "+fullReviewListBeforeChange.size());

				Gson g = new Gson();

				writeFullReviewList = g.toJson(writeFullReviewList);
				writeFullReviewNavi = g.toJson(writeFullReviewNavi);

				JsonObject resp = new JsonObject();
				resp.addProperty("writeFullReviewList", writeFullReviewList);
				resp.addProperty("writeFullReviewNavi", writeFullReviewNavi);

				response.getWriter().append(resp.toString());

			}else if(cmd.equals("/content.fullreview")) {

				int reviewid = Integer.parseInt(request.getParameter("reviewid"));
				System.out.println("선택한 리뷰는 "+reviewid);

				String writer = frdao.userIdByReviewId(reviewid);
				String name = frdao.StoreNameByReviewId(reviewid);
				List<StoreDTO> list = frdao.selectListStore();
				FullReviewDTO contents = frdao.contentByReviewId(reviewid);
				List<ReplyWithUserIdDTO> replyList = FullReviewReplyDAO.getInstance().listReplyByreviewid(reviewid);
				ArrayList<PhotoDTO> imgList = PhotoDAO.getInstance().ListByReviewId(reviewid);

				request.setAttribute("writerName", writer);
				request.setAttribute("storeName", name);
				request.setAttribute("store", list);
				request.setAttribute("contents", contents);
				request.setAttribute("replyList", replyList);
				request.setAttribute("imgList", imgList);				

				request.getRequestDispatcher("/FullReview/FullReviewContent.jsp").forward(request, response);

				// 마이페이지에 표시할 내가 스크랩한 리스트 출력
			} else if (cmd.equals("/selectScrapListBymypage.fullreview")) {

				int userno = (int) request.getSession().getAttribute("userno");
				int entpage = 1;

				if(request.getParameter("cpage")!=null) {
					entpage = Integer.parseInt(request.getParameter("cpage"));
				}

				System.out.println("현재 페이지 : "+entpage);

				int end_Record_Row_Num = entpage * Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE;
				int start_Record_Row_Num = end_Record_Row_Num - (Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE-1);

				System.out.println("시작 번호 : "+start_Record_Row_Num);
				System.out.println("끝 번호 : "+end_Record_Row_Num);

				String myFullReviewScrapList = frdao.selectMyFullReviewScrapList(userno, start_Record_Row_Num, end_Record_Row_Num);
				String myFullReviewScrapNavi = frdao.selectMyFullReviewScrapNaviToJSP(entpage, userno);

				Gson g = new Gson();

				myFullReviewScrapList = g.toJson(myFullReviewScrapList);
				myFullReviewScrapNavi = g.toJson(myFullReviewScrapNavi);

				JsonObject resp = new JsonObject();
				resp.addProperty("myFullReviewScrapList", myFullReviewScrapList);
				resp.addProperty("myFullReviewScrapNavi", myFullReviewScrapNavi);

				response.getWriter().append(resp.toString());

			}

			// 스크랩 추가 controller
			else if(cmd.equals("/addScrapFullReview.fullreview")) {
				int reviewID = Integer.parseInt(request.getParameter("addScrap_reviewID"));
				int userno = (int) request.getSession().getAttribute("userno");

				int result = frdao.addScrapFullReview(reviewID, userno);
				if(result>0) {
					System.out.println("스크랩 등록 성공");
					response.getWriter().append("true");
				}else {
					response.getWriter().append("false");
				}
			}


			// 스크랩 삭제 controller
			else if(cmd.equals("/deleteScrapFullReview.fullreview")) {
				int reviewID = Integer.parseInt(request.getParameter("addScrap_reviewID"));
				int userno = (int) request.getSession().getAttribute("userno");

				int result = frdao.deleteScrapFullReview(reviewID, userno);
				if(result>0) {
					System.out.println("스크랩 해제 성공");
					response.getWriter().append("true");
				}else {
					response.getWriter().append("false");
				}
			}
			
			//main 9개 리스트 출력(ajax)
			else if (cmd.equals("/mainList.fullreview")) {
				
				List<FullReviewDTO> mainList = frdao.mainList();
				String mainListTitle = gson.toJson(mainList);
				response.getWriter().append(mainListTitle);
				
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
