package controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

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
import dao.FavoriteStoreDAO;
import dao.FullReviewDAO;
import dao.MembersDAO;
import dao.PhotoDAO;
import dao.StoreDAO;
import dao.StoreMenuDAO;
import dto.CommentReviewDTO;
import dto.FavoritePageDTO;
import dto.FullReviewDTO;
import dto.NaviDTO;
import dto.PhotoDTO;
import dto.StoreDTO;
import dto.StoreMenuDTO;
import statics.Settings;

@WebServlet("*.store")
public class StoreController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		response.setContentType("text/html; charset=utf8;");

		String cmd = request.getRequestURI();
		Gson g = new Gson();

		try {
			if(cmd.equals("/list.store")) {

			}else if(cmd.equals("/view.store")) {
				int storeID = Integer.parseInt(request.getParameter("storeID"));
				ArrayList<CommentReviewDTO> commentListAll = CommentReviewDAO.getInstance().selectByStoreID(storeID);
				List<FullReviewDTO> fullListAll = FullReviewDAO.getInstance().selectByStoreID(storeID);
				//풀리뷰 추가되면 풀리뷰도 포함해서
				int sum = 0;
				int cnt = commentListAll.size() + fullListAll.size();
				if(cnt != 0) {
					for(CommentReviewDTO i : commentListAll) {
						sum += i.getScore();
					}
					for(FullReviewDTO i : fullListAll) {
						sum += i.getScore();
					}
					StoreDAO.getInstance().updateAvgScore(( Math.round(((double)sum)/cnt*10))/10.0 , storeID);
					StoreDAO.getInstance().updateReviewCount(cnt, storeID);					
				}
				int currentPage = 0;
				if(request.getParameter("cpage") == null) {
					currentPage= 1;
				}else {
					currentPage = Integer.parseInt(request.getParameter("cpage"));
				}
				int start = currentPage * Settings.COMMENTREVIEW_RECORD_COUNT_PER_PAGE - (Settings.COMMENTREVIEW_NAVI_COUNT_PER_PAGE-1);
				int end = currentPage * Settings.COMMENTREVIEW_RECORD_COUNT_PER_PAGE;
				ArrayList<CommentReviewDTO> commentList = CommentReviewDAO.getInstance().selectBound(storeID, start, end);
				NaviDTO pageNavi = CommentReviewDAO.getInstance().getNavi(currentPage, storeID);
				StoreDTO dto = StoreDAO.getInstance().selectOne(storeID);	
				ArrayList<String> userIDList = new ArrayList<>();
				for(int i = 0; i < commentList.size(); i++) {
					userIDList.add(MembersDAO.getInstance().getIDByNo(commentList.get(i).getUserNo()));
				}
				ArrayList<StoreMenuDTO> menuList = StoreMenuDAO.getInstance().selectAllByStoreID(storeID);
				ArrayList<PhotoDTO> imgList = PhotoDAO.getInstance().selectByStoreID(storeID);
				//				ArrayList<String> imgPathList = new ArrayList<>();
				//				for(PhotoDTO i : imgList) {
				//					imgPathList.add("/store/" + i.getSysName());
				//				}
				//				request.setAttribute("imgPathList", imgPathList);
				FavoritePageDTO favorite = null;
				if(request.getSession().getAttribute("userno") != null) {
					favorite = FavoriteStoreDAO.getInstance().isFavoriteStore(storeID, (int)request.getSession().getAttribute("userno"));
				}


				request.setAttribute("dto", dto);
				request.setAttribute("commentList", commentList);
				request.setAttribute("navi", pageNavi);
				request.setAttribute("userIDList", userIDList);
				request.setAttribute("menuList", menuList);
				request.setAttribute("imgList", imgList);
				request.setAttribute("favorite", favorite);
				request.getRequestDispatcher("/store/view.jsp").forward(request, response);

			}else if(cmd.equals("/register.store")) {
				String realPath = request.getServletContext().getRealPath("store");
				int maxSize = 1024 * 1024 * 10; //10Mb
				System.out.println(realPath);
				File realPathFile = new File(realPath);
				if(!realPathFile.exists()) {
					realPathFile.mkdir();
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf8", new DefaultFileRenamePolicy());

				double mapLat = Double.parseDouble(multi.getParameter("mapLat"));
				double mapLng = Double.parseDouble(multi.getParameter("mapLng"));
				int mapDistance = Integer.parseInt(multi.getParameter("mapDistance"));
				String storeName = multi.getParameter("storeName");
				storeName = SecurityUtils.XSSCheck(storeName);
				String storeAddress = multi.getParameter("storeAddress");
				storeAddress = SecurityUtils.XSSCheck(storeAddress);
				String storeIntroduction = multi.getParameter("storeIntroduction");
				storeIntroduction = SecurityUtils.XSSCheck(storeIntroduction);
				String storeCategory = multi.getParameter("storeCategory");
				String storePriceRange = multi.getParameter("storePriceRange");

				int result = StoreDAO.getInstance().insert(new StoreDTO(0, mapDistance, storeName, mapLat, mapLng, storeAddress, 0, storeIntroduction, storeCategory, 0, storePriceRange));
				int currval = StoreDAO.getInstance().getCurrval();

				//				int imgLength = Integer.parseInt(multi.getParameter("imgLength"));
				//				ArrayList<String> oriNames = new ArrayList<>();
				//				ArrayList<String> sysNames = new ArrayList<>();
				//				for(int i = 0; i < imgLength; i++) {
				//					oriNames.add(multi.getOriginalFileName("image"+i));
				//					sysNames.add(multi.getFilesystemName("image"+i));
				//					//imgsDAO~ (imgsDTO()) 추가해줘야 함
				//				}

				Enumeration<String> names = multi.getFileNames();
				while(names.hasMoreElements()) {
					String fileName = names.nextElement();
					if(multi.getFile(fileName) != null){
						String oriName = multi.getOriginalFileName(fileName);
						String sysName = multi.getFilesystemName(fileName);
						PhotoDAO.getInstance().insertByStoreID(oriName, sysName, currval);
					}
				}
				response.sendRedirect("/view.store?storeID="+currval);
			}else if(cmd.equals("/deletePhoto.store")) {
				int imageID = Integer.parseInt(request.getParameter("imageID"));
				int storeID = Integer.parseInt(request.getParameter("storeID"));

				String realPath = request.getServletContext().getRealPath("store");
				File realPathFile = new File(realPath+"/"+PhotoDAO.getInstance().selectByImageID(imageID).getSysName());
				realPathFile.delete();
				PhotoDAO.getInstance().delete(imageID);

				response.sendRedirect("/view.store?storeID="+storeID);
			}else if(cmd.equals("/update.store")) {
				int storeID = Integer.parseInt(request.getParameter("storeID"));
				double mapLat = Double.parseDouble(request.getParameter("mapLat"));
				double mapLng = Double.parseDouble(request.getParameter("mapLng"));
				int mapDistance = Integer.parseInt(request.getParameter("mapDistance"));
				String name = request.getParameter("name");
				name = SecurityUtils.XSSCheck(name);
				String category = request.getParameter("category");
				String priceRange = request.getParameter("priceRange");
				String address = request.getParameter("address");
				address = SecurityUtils.XSSCheck(address);
				String introduction = request.getParameter("introduction");
				introduction = SecurityUtils.XSSCheck(introduction);

				int result = StoreDAO.getInstance().update(new StoreDTO(storeID, mapDistance, name, mapLat, mapLng, address, 0, introduction, category, 0, priceRange));

				response.sendRedirect("/view.store?storeID="+storeID);
			}else if(cmd.equals("/updatePhoto.store")){
				String realPath = request.getServletContext().getRealPath("store");
				int maxSize = 1024 * 1024 * 10; //10Mb
				System.out.println(realPath);
				File realPathFile = new File(realPath);
				if(!realPathFile.exists()) {
					realPathFile.mkdir();
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf8", new DefaultFileRenamePolicy());

				int storeID = Integer.parseInt(multi.getParameter("storeID"));

				//				int imgLength = Integer.parseInt(multi.getParameter("imgLength"));
				//				for(int i = 0; i < imgLength; i++) {
				//					String oriName = multi.getOriginalFileName("image"+i);
				//					System.out.println(oriName);
				//					String sysName = multi.getFilesystemName("image"+i);
				//					System.out.println(sysName);
				//					PhotoDAO.getInstance().insertByStoreID(oriName, sysName, storeID);
				//				}

				Enumeration<String> names = multi.getFileNames();
				while(names.hasMoreElements()) {
					String fileName = names.nextElement();
					if(multi.getFile(fileName) != null){
						String oriName = multi.getOriginalFileName(fileName);
						String sysName = multi.getFilesystemName(fileName);
						PhotoDAO.getInstance().insertByStoreID(oriName, sysName, storeID);
					}
				}
			}
			else if(cmd.equals("/delete.store")) {

				if(request.getSession().getAttribute("loginIsAdmin") != null && (boolean)request.getSession().getAttribute("loginIsAdmin")) {
					int storeID = Integer.parseInt(request.getParameter("storeID"));

					String realPath = request.getServletContext().getRealPath("store");
					ArrayList<PhotoDTO> pdao = PhotoDAO.getInstance().selectByStoreID(storeID);
					if(pdao != null) {
						for(PhotoDTO i : pdao) {
							File realPathFile = new File(realPath +"/"+ i.getSysName());
							realPathFile.delete();
						}
					}
					realPath = request.getServletContext().getRealPath("FullReview");
					List<FullReviewDTO> reviewList = FullReviewDAO.getInstance().selectByStoreID(storeID);
					if(reviewList.size() > 0) {
						for(FullReviewDTO i : reviewList) {
							pdao = PhotoDAO.getInstance().ListByReviewId(storeID);
							for(PhotoDTO j : pdao) {
								File realPathFile = new File(realPath +"/"+ j.getSysName());
								realPathFile.delete();
							}
							PhotoDAO.getInstance().deleteByReviewId(i.getReviewID());
						}
					}
					PhotoDAO.getInstance().deleteByStoreID(storeID);
					CommentReviewDAO.getInstance().deleteByStoreID(storeID);
					FullReviewDAO.getInstance().deleteByStoreID(storeID);

					int result = StoreDAO.getInstance().delete(storeID);

					response.sendRedirect("/searchStoreBySearchBox.store");
				}
			}else if(cmd.equals("/getMainPhoto.store")) {
				int storeID = Integer.parseInt(request.getParameter("storeID"));
				ArrayList<PhotoDTO> list = PhotoDAO.getInstance().selectByStoreID(storeID);
				PhotoDTO dto = null;
				if(list.size() < 1) {
					dto = new PhotoDTO(-1, null, null);
				}else {
					dto = list.get(0);
				}
				String resp = g.toJson(dto);
				response.getWriter().append(resp);
			}


			// 검색 Controller (main_searchResult.jsp / allstore_inquiry.jsp에 같이 사용)
			// 사진 출력 미구현

			// 일반 검색 controller
			else if(cmd.equals("/searchStoreBySearchBox.store")) {
				System.out.println("일반 검색");
				String search = "";
				search = SecurityUtils.XSSCheck(search);
				String searchedBy = "";
				String food_category="";

				int currentpage = 0;
				int start_Record_Row_Num = 0;
				int end_Record_Row_Num = 0;

				if(request.getParameter("searchedBy")!=null) {
					searchedBy = request.getParameter("searchedBy");
					request.getSession().setAttribute("searchedBy", searchedBy);
				}else if(request.getSession().getAttribute("searchedBy")!=null){
					searchedBy = (String) request.getSession().getAttribute("searchedBy");
				}else {
					searchedBy = "mainSearch";
					request.getSession().setAttribute("searchedBy", searchedBy);
				}

				System.out.println("검색경로 : "+searchedBy);

				if(request.getParameter("search")!=null) {
					search = request.getParameter("search");
				}else {
					search = "";
				}

				System.out.println("검색어 : "+search);

				if(request.getParameter("food_category")!=null) {
					food_category = request.getParameter("food_category");
				}else {
					food_category = "";
				}

				System.out.println("카테고리 접근 : "+food_category);

				if(request.getParameter("cpage")!=null) {
					currentpage = Integer.parseInt(request.getParameter("cpage"));
				}else {
					currentpage = 1;
				}
				
				System.out.println("현재 페이지 : "+currentpage);

				// 검색방식에 따라 네비 갯수 변경
				if(searchedBy.equals("mainSearch")) {
					end_Record_Row_Num = currentpage * Settings.SEARCH_STORE_RECORD_COUNT_PER_PAGE;
					start_Record_Row_Num = end_Record_Row_Num - (Settings.SEARCH_STORE_RECORD_COUNT_PER_PAGE-1);
				}else if(searchedBy.equals("mapSearch")) {
					end_Record_Row_Num = currentpage * Settings.SEARCH_STORE_TO_MAP_RECORD_COUNT_PER_PAGE;
					start_Record_Row_Num = end_Record_Row_Num - (Settings.SEARCH_STORE_TO_MAP_RECORD_COUNT_PER_PAGE-1);
				}

				System.out.println("시작넘버 : "+start_Record_Row_Num);
				System.out.println("끝넘버 : "+end_Record_Row_Num);

				List<StoreDTO> search_store_list = StoreDAO.getInstance().searchStore_BySearchBox(search, start_Record_Row_Num, end_Record_Row_Num,food_category);
				String search_store_list_navi = StoreDAO.getInstance().getNavi_BySearchBox(currentpage,search,searchedBy,food_category);
				// 리스트 썸네일 추가
				ArrayList<PhotoDTO> search_store_imgList = PhotoDAO.getInstance().selectSearchStoreThumbnailByStoreID(search_store_list);

				System.out.println("리스트 사이즈 : "+search_store_list.size());
				System.out.println("사진 사이즈 : "+search_store_imgList.size());

				for(StoreDTO s : search_store_list) {
					System.out.println(s.getName());
				}
				System.out.println("===================");

				// 즐겨찾기 여부 확인
				int userno = 0;
				if(request.getSession().getAttribute("userno")!=null) {
					userno = (int) request.getSession().getAttribute("userno");
				}
				System.out.println("유저넘버 : "+userno);

				List<FavoritePageDTO> Favorite_list = FavoriteStoreDAO.getInstance().isFavoriteStore(search_store_list,userno);

				// 필터 기본값 적용 
				request.getSession().setAttribute("sortMethod", "");
				request.getSession().setAttribute("cost_range", "");
				request.getSession().setAttribute("food_category_korean", true);
				request.getSession().setAttribute("food_category_western", true);
				request.getSession().setAttribute("food_category_chinese", true);
				request.getSession().setAttribute("food_category_japanese", true);
				request.getSession().setAttribute("food_category_asian", true);
				request.getSession().setAttribute("food_category_fastfood", true);
				request.getSession().setAttribute("food_category_dessert_drink", true);
				request.getSession().setAttribute("food_category_etc", true);

				request.setAttribute("search_store_list", search_store_list);
				request.setAttribute("search_store_list_navi", search_store_list_navi);
				request.setAttribute("search_store_imgList", search_store_imgList);

				// 사이드바로 접근 시 p태그 내용 변경
				if(request.getParameter("approachBy")!=null) {
					request.setAttribute("approachBy", request.getParameter("approachBy"));
					request.setAttribute("food_category", request.getParameter("food_category"));
				}

				if(searchedBy.equals("mainSearch")) {
					request.setAttribute("Favorite_list", Favorite_list);
					request.getRequestDispatcher("/common/main_storeSearchResult.jsp").forward(request, response);
				}else if(searchedBy.equals("mapSearch")) {
					List<StoreDTO> search_store_infoWindowList =  StoreDAO.getInstance().selectAll(search);
					request.setAttribute("search_store_infoWindowList", search_store_infoWindowList);
					request.getRequestDispatcher("/allstore_inquiry/allstore_inquiry.jsp").forward(request, response);
				}
			}

			// 필터 적용 검색 controller
			else if(cmd.equals("/searchStoreBySearchFilter.store")) {
				System.out.println("필터 검색");

				String search = "";
				String searchedBy = "";
				String sortMethod = "";
				String cost_range = "";
				String food_category_korean = "";
				String food_category_western = "";
				String food_category_chinese = "";
				String food_category_japanese = "";
				String food_category_asian = "";
				String food_category_fastfood = "";
				String food_category_dessert_drink = "";
				String food_category_etc = "";
				int currentpage = 0;
				int start_Record_Row_Num = 0;
				int end_Record_Row_Num = 0;

				//
				if(request.getParameter("searchedBy")!=null) {
					searchedBy = request.getParameter("searchedBy");
					request.getSession().setAttribute("searchedBy", searchedBy);
				}else if(request.getSession().getAttribute("searchedBy")!=null){
					searchedBy = (String) request.getSession().getAttribute("searchedBy");
				}else {
					searchedBy = "mainSearch";
					request.getSession().setAttribute("searchedBy", searchedBy);
				}

				if(request.getParameter("sortMethod")!=null) {
					sortMethod = request.getParameter("sortMethod");
					request.getSession().setAttribute("sortMethod", sortMethod);
				}else if(request.getSession().getAttribute("sortMethod")!=null){
					sortMethod = (String) request.getSession().getAttribute("sortMethod");
				}else {
					sortMethod = "";
					request.getSession().setAttribute("sortMethod", sortMethod);
				}

				if(request.getParameter("cost_range")!=null) {
					cost_range = request.getParameter("cost_range");
					request.getSession().setAttribute("cost_range", cost_range);
				}else if(request.getSession().getAttribute("cost_range")!=null){
					cost_range = (String) request.getSession().getAttribute("cost_range");
				}else {
					cost_range = "";
					request.getSession().setAttribute("cost_range", cost_range);
				}

				if(request.getParameter("food_category_korean")!=null) {
					food_category_korean = request.getParameter("food_category_korean");
					request.getSession().setAttribute("food_category_korean", food_category_korean);
				}else if(request.getSession().getAttribute("food_category_korean")!=null){
					food_category_korean = (String) request.getSession().getAttribute("food_category_korean");
				}else {
					food_category_korean = "true";
					request.getSession().setAttribute("food_category_korean", food_category_korean);
				}

				if(request.getParameter("food_category_western")!=null) {
					food_category_western = request.getParameter("food_category_western");
					request.getSession().setAttribute("food_category_western", food_category_western);
				}else if(request.getSession().getAttribute("food_category_western")!=null){
					food_category_western = (String) request.getSession().getAttribute("food_category_western");
				}else {
					food_category_western = "true";
					request.getSession().setAttribute("food_category_western", food_category_western);
				}

				if(request.getParameter("food_category_chinese")!=null) {
					food_category_chinese = request.getParameter("food_category_chinese");
					request.getSession().setAttribute("food_category_chinese", food_category_chinese);
				}else if(request.getSession().getAttribute("food_category_chinese")!=null){
					food_category_chinese = (String) request.getSession().getAttribute("food_category_chinese");
				}else {
					food_category_chinese = "true";
					request.getSession().setAttribute("food_category_chinese", food_category_chinese);
				}

				if(request.getParameter("food_category_japanese")!=null) {
					food_category_japanese = request.getParameter("food_category_japanese");
					request.getSession().setAttribute("food_category_japanese", food_category_japanese);
				}else if(request.getSession().getAttribute("food_category_japanese")!=null){
					food_category_japanese = (String) request.getSession().getAttribute("food_category_japanese");
				}else {
					food_category_japanese = "true";
					request.getSession().setAttribute("food_category_japanese", food_category_japanese);
				}

				if(request.getParameter("food_category_asian")!=null) {
					food_category_asian = request.getParameter("food_category_asian");
					request.getSession().setAttribute("food_category_asian", food_category_asian);
				}else if(request.getSession().getAttribute("food_category_asian")!=null){
					food_category_asian = (String) request.getSession().getAttribute("food_category_asian");
				}else {
					food_category_asian = "true";
					request.getSession().setAttribute("food_category_asian", food_category_asian);
				}

				if(request.getParameter("food_category_fastfood")!=null) {
					food_category_fastfood = request.getParameter("food_category_fastfood");
					request.getSession().setAttribute("food_category_fastfood", food_category_fastfood);
				}else if(request.getSession().getAttribute("food_category_fastfood")!=null){
					food_category_fastfood = (String) request.getSession().getAttribute("food_category_fastfood");
				}else {
					food_category_fastfood = "true";
					request.getSession().setAttribute("food_category_fastfood", food_category_fastfood);
				}

				if(request.getParameter("food_category_dessert_drink")!=null) {
					food_category_dessert_drink = request.getParameter("food_category_dessert_drink");
					request.getSession().setAttribute("food_category_dessert_drink", food_category_dessert_drink);
				}else if(request.getSession().getAttribute("food_category_dessert_drink")!=null){
					food_category_dessert_drink = (String) request.getSession().getAttribute("food_category_dessert_drink");
				}else {
					food_category_dessert_drink = "true";
					request.getSession().setAttribute("food_category_dessert_drink", food_category_dessert_drink);
				}

				if(request.getParameter("food_category_etc")!=null) {
					food_category_etc = request.getParameter("food_category_etc");
					request.getSession().setAttribute("food_category_etc", food_category_etc);
				}else if(request.getSession().getAttribute("food_category_etc")!=null){
					food_category_etc = (String) request.getSession().getAttribute("food_category_etc");
				}else {
					food_category_etc = "true";
					request.getSession().setAttribute("food_category_etc", food_category_etc);
				}

				System.out.println("검색경로 : "+searchedBy);
				System.out.println("정렬방식 : "+sortMethod);
				System.out.println("가격 : "+cost_range);
				System.out.println("한식 : "+food_category_korean);
				System.out.println("양식 : "+food_category_western);
				System.out.println("중식 : "+food_category_chinese);
				System.out.println("일식 : "+food_category_japanese);
				System.out.println("아시안 : "+food_category_asian);
				System.out.println("패스트푸드 : "+food_category_fastfood);
				System.out.println("디저트/음료 : "+food_category_dessert_drink);
				System.out.println("기타 : "+food_category_etc);


				if(request.getParameter("search")!=null) {
					search = request.getParameter("search");
					request.getSession().setAttribute("search", search);
				}else if(request.getSession().getAttribute("search")!=null){
					search = (String) request.getSession().getAttribute("search");
				}else {
					search = "";
					request.getSession().setAttribute("search", search);
				}

				System.out.println("검색어 : "+search);

				if(request.getParameter("cpage")!=null) {
					currentpage = Integer.parseInt(request.getParameter("cpage"));
				}else {
					currentpage = 1;
				}

				System.out.println("현재 페이지 : "+currentpage);

				// 검색방식에 따라 네비 갯수 변경
				if(searchedBy.equals("mainSearch")) {
					end_Record_Row_Num = currentpage * Settings.SEARCH_STORE_RECORD_COUNT_PER_PAGE;
					start_Record_Row_Num = end_Record_Row_Num - (Settings.SEARCH_STORE_RECORD_COUNT_PER_PAGE-1);
				}else if(searchedBy.equals("mapSearch")) {
					end_Record_Row_Num = currentpage * Settings.SEARCH_STORE_TO_MAP_RECORD_COUNT_PER_PAGE;
					start_Record_Row_Num = end_Record_Row_Num - (Settings.SEARCH_STORE_TO_MAP_RECORD_COUNT_PER_PAGE-1);
				}

				System.out.println("시작넘버 : "+start_Record_Row_Num);
				System.out.println("끝넘버 : "+end_Record_Row_Num);

				List<StoreDTO> search_store_list = StoreDAO.getInstance().searchStore_BySearchFilter(search, start_Record_Row_Num, end_Record_Row_Num,
						sortMethod, cost_range, food_category_korean, food_category_western, food_category_chinese, food_category_japanese, food_category_asian,
						food_category_fastfood, food_category_dessert_drink, food_category_etc);

				String search_store_list_navi = StoreDAO.getInstance().getNavi_BySearchFilter(currentpage,search,searchedBy,sortMethod, cost_range, food_category_korean, 
						food_category_western, food_category_chinese, food_category_japanese, food_category_asian, food_category_fastfood, 
						food_category_dessert_drink, food_category_etc);

				// 리스트 썸네일 추가
				ArrayList<PhotoDTO> search_store_imgList = PhotoDAO.getInstance().selectSearchStoreThumbnailByStoreID(search_store_list);

				System.out.println("리스트 사이즈 : "+search_store_list.size());

				int userno = 0;
				if(request.getSession().getAttribute("userno")!=null) {
					userno = (int) request.getSession().getAttribute("userno");
				}
				List<FavoritePageDTO> Favorite_list = FavoriteStoreDAO.getInstance().isFavoriteStore(search_store_list,userno);

				System.out.println("===================");

				request.setAttribute("search_store_list", search_store_list);
				request.setAttribute("search_store_list_navi", search_store_list_navi);
				request.setAttribute("search_store_imgList", search_store_imgList);
				request.setAttribute("Favorite_list", Favorite_list);

				if(searchedBy.equals("mainSearch")) {
					request.getRequestDispatcher("/common/main_storeSearchResult.jsp").forward(request, response);
				}else if(searchedBy.equals("mapSearch")) {
					List<StoreDTO> search_store_infoWindowList =  StoreDAO.getInstance().selectAll(search, cost_range, food_category_korean, 
							food_category_western, food_category_chinese, food_category_japanese, food_category_asian,
							food_category_fastfood, food_category_dessert_drink, food_category_etc);
					request.setAttribute("search_store_infoWindowList", search_store_infoWindowList);
					request.getRequestDispatcher("/allstore_inquiry/allstore_inquiry.jsp").forward(request, response);
				}
			}


			// 즐겨찾기 추가 controller
			else if(cmd.equals("/addFavoriteStore.store")) {
				int storeID = Integer.parseInt(request.getParameter("addFavorite_storeID"));
				int userno = (int) request.getSession().getAttribute("userno");

				int result = FavoriteStoreDAO.getInstance().addFavoriteStore(storeID, userno);
				if(result>0) {
					System.out.println("즐찾 등록 성공");
					response.getWriter().append("true");
				}
			}


			// 즐겨찾기 삭제 controller
			else if(cmd.equals("/deleteFavoriteStore.store")) {
				int storeID = Integer.parseInt(request.getParameter("addFavorite_storeID"));
				int userno = (int) request.getSession().getAttribute("userno");

				int result = FavoriteStoreDAO.getInstance().deleteFavoriteStore(storeID, userno);
				if(result>0) {
					System.out.println("즐찾 해제 성공");
					response.getWriter().append("true");
				}
			}

			// 마이페이지 즐겨찾기 조회 controller
			else if(cmd.equals("/selectFavoriteStore.store")) {

				int userno = (int) request.getSession().getAttribute("userno");
				int currentpage = 1;
				if(request.getParameter("cpage")!=null) {
					currentpage = Integer.parseInt(request.getParameter("cpage"));
				}

				System.out.println("현재 페이지 : "+currentpage);

				// 검색방식에 따라 네비 갯수 변경
				int end_Record_Row_Num = currentpage * Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE;
				int start_Record_Row_Num = end_Record_Row_Num - (Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE-1);

				String FavoriteStoreList = StoreDAO.getInstance().selectFavoriteStoreToJSP(userno,start_Record_Row_Num,end_Record_Row_Num);
				String FavoriteStoreNavi = StoreDAO.getInstance().selectFavoriteStoreNaviToJSP(userno,currentpage);

				FavoriteStoreList = g.toJson(FavoriteStoreList);
				FavoriteStoreNavi = g.toJson(FavoriteStoreNavi);

				JsonObject resp = new JsonObject();
				resp.addProperty("FavoriteStoreList", FavoriteStoreList);
				resp.addProperty("FavoriteStoreNavi", FavoriteStoreNavi);

				response.getWriter().append(resp.toString());

				// 메인 페이지 랜덤 맛집 카드 3장 출력
			}else if(cmd.equals("/mainSet.store")) {

				Set<Integer> set = new HashSet<>();
				int lastIndex = StoreDAO.getInstance().getLastStoreID();
				int count = 3;
				//				List<StoreDTO> storeList = new ArrayList<>();
				//				List<PhotoDTO> photoList = new ArrayList<>();
				while(count>0) {
					int storeid = (int)((Math.random()*lastIndex)+1);
					if(StoreDAO.getInstance().isValidStoreID(storeid)){
						if(set.add(storeid)) {
							count--;
						}
					}
				}
				System.out.println(set.size());
				Iterator<Integer> it = set.iterator();
				StringBuilder sb = new StringBuilder();
				while(it.hasNext()) {
					StoreDTO dto = StoreDAO.getInstance().selectOne(it.next());
					List<PhotoDTO> photoTemp = PhotoDAO.getInstance().selectByStoreID(dto.getStoreID());
					if(photoTemp.size()>0) {
						sb.append("<div class='col-12 col-md-12 col-lg-6 themed-grid-col cardBox mx-3' style='max-width:300px; height:400px; margin-bottom:20px;'> "
								+ "<div class='imageDiv'>"
								+ "<a href='/view.store?storeID="+dto.getStoreID()+"'>"
								+ "<img src='/store/"+photoTemp.get(0).getSysName()+"' onerror='this.src=/common/khplate2.jpg'>"
								+ "</a>"
								+ "</div>"
								+ "<div class='nanum-gothic textDiv'>"+dto.getName()+"</div>"
								+ "</div>");
					}else {
						sb.append("<div class='col-12 col-md-12 col-lg-6 themed-grid-col cardBox mx-2' style='max-width:300px; margin-bottom:20px;'>"
								+ "<div class='imageDiv'>"
								+ "<a href='/view.store?storeID="+dto.getStoreID()+"'>"
								+ "<img src='/common/khplate2.jpg'>"
								+ "</a>"
								+ "</div>"
								+ "<div class='nanum-gothic textDiv'>"+dto.getName()+"</div>"
								+ "</div>");
					}
				}

				response.getWriter().append(sb.toString());
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
