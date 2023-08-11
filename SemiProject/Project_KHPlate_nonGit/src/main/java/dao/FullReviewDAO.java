package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.FavoritePageDTO;
import dto.FullReviewDTO;
import dto.FullReviewScrapDTO;
import dto.FullReviewUserDTO;
import dto.MyFullReviewScrapDTO;
import dto.StoreDTO;
import statics.Settings;

public class FullReviewDAO {

	private static FullReviewDAO instance = null;
	public synchronized static FullReviewDAO getInstance() {
		if(instance == null) {
			instance = new FullReviewDAO();
		}
		return instance;
	}
	private FullReviewDAO() {
		super();
	}
	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}

	public int writeFullReview(String title,String reviewbody, int score, int storeId, int userNo) throws Exception {
		String sql = "insert into FullReview values (fullreview_reviewid_seq.nextval,?,?,?,?,sysdate,?)";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, reviewbody);
			pstat.setInt(2, score);
			pstat.setInt(3, storeId);
			pstat.setInt(4, userNo);
			pstat.setString(5, title);
			int result = pstat.executeUpdate();
			return result;
		}
	}


	public int newReviewId()throws Exception{
		String sql = "select reviewid from fullreview order by 1 desc";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery()){
			rs.next();
			int reviewid = rs.getInt("reviewid");
			return reviewid;
		}
	}

	public String StoreNameByReviewId(int reviewid) throws Exception{
		String sql = "select name from store where storeid =(select storeid from fullreview where reviewid=?)";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewid);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				String name = rs.getString("name");
				return name;
			}
		}
	}

	public String userIdByReviewId(int reviewid) throws Exception{
		String sql = "select userid from members where userno = (select userno from fullreview where reviewid = ?)";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewid);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				String name = rs.getString("userid");
				return name;
			}
		}
	}

	public List<FullReviewDTO> mainList() throws Exception {
		String sql = "select reviewid, title from fullreview order by reviewid desc";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			try(ResultSet rs = pstat.executeQuery()){
				List<FullReviewDTO> ListTitle = new ArrayList<>();
				
				while(rs.next()) {
					if(ListTitle.size()<10) {
					FullReviewDTO dto = new FullReviewDTO();
					dto.setReviewID(rs.getInt("reviewid"));
					dto.setTitle(rs.getString("title"));
					ListTitle.add(dto);
					}
					else {
					break;}
				}
				
				return  ListTitle;
			}
		}
	}


	public List<StoreDTO> selectListStore()throws Exception{
		String sql = "select * from store order by name";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){

			List<StoreDTO> result = new ArrayList<>();
			while(rs.next()) {
				StoreDTO dto = new StoreDTO();
				dto.setStoreID(rs.getInt("storeid"));
				dto.setDistance(rs.getInt("distance"));
				dto.setName(rs.getString("name"));
				dto.setLat(rs.getDouble("lat"));
				dto.setLng(rs.getDouble("lng"));
				dto.setAddress(rs.getString("address"));
				dto.setAvgScore(rs.getDouble("avgscore"));
				dto.setIntroduction(rs.getString("introduction"));
				dto.setCategory(rs.getString("category"));
				dto.setReviewCount(rs.getInt("reviewcount"));
				dto.setPriceRange(rs.getString("pricerange"));
				result.add(dto);
			}
			return result;
		}
	}



	public int deleteFullReview(int reviewId) throws Exception {
		String sql = "delete from fullreview where reviewid = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewId);
			int result = pstat.executeUpdate();
			return result;
		}
	}
	
	public int deleteByStoreID(int storeID) throws Exception{
		String sql = "delete from FULLREVIEW where STOREID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int update(String title, String reviewbody, int score, int storeid, int reviewId) throws Exception {
		String sql = "update fullreview set title=?, reviewbody=?, score=? ,storeid=? where reviewid = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, title);
			pstat.setString(2, reviewbody);
			pstat.setInt(3, score);
			pstat.setInt(4, storeid);
			pstat.setInt(5, reviewId);
			int result = pstat.executeUpdate();
			return result;
		}
	}


	// 블로그 리뷰 조회
	public List<FullReviewUserDTO> selectFullReview(int searchUserno, String searchFullReviewTitle, int start_Record_Row_Num, int end_Record_Row_Num) throws Exception {
		String sql="";

		if(searchUserno==0) {
			sql = "select * from"
					+" (select fullreview.*, row_number() over(order by reviewID desc) row_num from fullreview where title like ?)"
					+" f join members m on f.userno = m.userno"
					+" where row_num between ? and ?";
		}else {
			sql = "select * from"
					+" (select fullreview.*, row_number() over(order by reviewID desc) row_num from fullreview where title like ? and userno = ?)"
					+" f join members m on f.userno = m.userno"
					+" where row_num between ? and ?";
		}

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, "%"+searchFullReviewTitle+"%");
			if(searchUserno==0) {
				pstat.setInt(2, start_Record_Row_Num);
				pstat.setInt(3, end_Record_Row_Num);
			}else {
				pstat.setInt(2, searchUserno);
				pstat.setInt(3, start_Record_Row_Num);
				pstat.setInt(4, end_Record_Row_Num);
			}

			try(ResultSet rs = pstat.executeQuery();){
				List<FullReviewUserDTO> result = new ArrayList<>();
				while(rs.next()) {
					int reviewID = rs.getInt("reviewid");
					int score = rs.getInt("score");
					int storeID = rs.getInt("storeid");
					int userno = rs.getInt("userno");
					Timestamp writedate = rs.getTimestamp("writedate");
					String title = rs.getString("title");
					String userID = rs.getString("userid");
					String nickname = rs.getString("nickname");
					result.add(new FullReviewUserDTO(reviewID,score,storeID,userno,writedate,title,userID,nickname));
				}
				return result;
			}
		}
	}

	public String getFullReviewNavi(int currentpage, int searchUserno, String searchFullReviewTitle) throws Exception {

		int record_total_count = getSearchdFullReview_RecordCount(searchUserno,searchFullReviewTitle);
		int record_count_per_page = Settings.SEARCH_FULLREVIEW_RECORD_COUNT_PER_PAGE; // 15
		int navi_count_per_page = Settings.SEARCH_FULLREVIEW_NAVI_COUNT_PER_PAGE; // 10

		System.out.println("리스트 전체 글 개수 : "+record_total_count);

		int page_total_count = 0;

		// 총 페이지의 수
		if(record_total_count%record_count_per_page==0) {
			page_total_count = record_total_count/record_count_per_page;
		}else {	
			page_total_count = (record_total_count/record_count_per_page)+1;
		}

		// 페이지 범위 초과 시 자동 조정 (필수 x)
		if(currentpage<1)
			currentpage = 1;
		else if(currentpage > page_total_count)
			currentpage=page_total_count;

		int startNavi = ((currentpage - 1)/navi_count_per_page * navi_count_per_page)+1;
		int endNavi = startNavi + (navi_count_per_page - 1);

		if(startNavi<1)
			startNavi = 1;
		else if(endNavi>page_total_count)
			endNavi = page_total_count;

		StringBuilder sb = new StringBuilder();

		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi == 1)
			needPrev = false;
		if(endNavi == page_total_count)
			needNext = false;

		if(needPrev) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<a href='/select.fullreview?cpage="+(startNavi-1)+"&search="+searchFullReviewTitle+"'>"
					+ "				<button class='navigator_direction_btn'>"
					+ "					<i class='fa-solid fa-angle-left'></i>"
					+ "				</button>"
					+ "			</a>"
					+ "		</div>"
					+ "</li>");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<a class='item' href='/select.fullreview?cpage="+i+"&search="+searchFullReviewTitle+"'>"
					+ 			"<div class='navigator_list_item_btn_layout'>"+i+"</div>"
					+ 		"</a>"
					+ "</li>");
		}
		if(needNext) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<a href='/select.fullreview?cpage="+(endNavi+1)+"&search="+searchFullReviewTitle+"'>"
					+ "				<button class='navigator_direction_btn'>"
					+ "					<i class='fa-solid fa-angle-right'></i>"
					+ "				</button>"
					+ "			</a>"
					+ "		</div>"
					+ "</li>");
		}
		return sb.toString();

	}

	// 일반 검색 Record 수
	public int getSearchdFullReview_RecordCount(int searchUserno, String searchFullReviewTitle) throws Exception{
		String sql = "";
		if(searchUserno==0) {
			sql = "select count(*) from fullreview where title like ?";
		}else {
			sql = "select count(*) from fullreview where title like ? and userno = ?";
		}
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,"%"+searchFullReviewTitle+"%");
			if(searchUserno!=0) {
				pstat.setInt(2, searchUserno);
			}
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}


	private List<FullReviewDTO> transToList(ResultSet rs) throws Exception {
		List<FullReviewDTO> result = new ArrayList<>();
		while(rs.next()) {
			int reviewID = rs.getInt("reviewid");
			String title = rs.getString("title");
			String reviewBody = rs.getString("reviewbody");
			int score = rs.getInt("score");
			int storeID = rs.getInt("storeID");
			int userno = rs.getInt("userno");
			Timestamp writedate = rs.getTimestamp("writedate");
			result.add(new FullReviewDTO(reviewID,title,reviewBody,score,storeID,userno,writedate));
		}
		return result;
	}


	public FullReviewDTO contentByReviewId(int reviewid) throws Exception {
		String sql = "select * from fullreview where reviewid = ?";
		try (Connection con = this.getConnection(); 
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, reviewid);
			FullReviewDTO result = new FullReviewDTO();
			try (ResultSet rs = pstat.executeQuery()) {
				rs.next();

				String title = rs.getString("title");
				int rsreviewid = rs.getInt("reviewid");
				String rsreviewbody = rs.getString("reviewbody");
				int rsscore = rs.getInt("score");
				int rsstoreid = rs.getInt("storeid");
				int rsuserno = rs.getInt("userno");
				Timestamp writedate = rs.getTimestamp("writedate");

				result.setTitle(title);
				result.setReviewID(rsreviewid);
				result.setReviewBody(rsreviewbody);
				result.setScore(rsscore);
				result.setStoreID(rsstoreid);
				result.setUserNO(rsuserno);
				result.setWritedate(writedate);

				return result;
			}
		}
	};

	public String selectFullReviewListToJSP(List<FullReviewUserDTO> fullReviewList) throws Exception {

		StringBuilder sb = new StringBuilder();
		for(FullReviewUserDTO user : fullReviewList) {
			sb.append("<tr>");
			sb.append("<td>"+user.getReviewID()+"</td>");
			sb.append("<td><a href='content.fullreview?reviewid="+user.getReviewID()+"'>"+user.getTitle()+"</a></td>");
			sb.append("<td>"+user.getUserID()+"</td>");
			sb.append("<td>"+user.getWritedateToString()+"</td>");
			sb.append("</tr>");
		}
		return sb.toString();
	}

	public String getFullReviewNaviToJSP(int currentpage, int searchUserno, String searchFullReviewTitle) throws Exception {

		int record_total_count = getSearchdFullReview_RecordCount(searchUserno,searchFullReviewTitle);
		int record_count_per_page = Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE; // 10
		int navi_count_per_page = Settings.MYPAGE_LIST_NAVI_COUNT_PER_PAGE; // 10

		System.out.println("리스트 전체 글 개수 : "+record_total_count);

		int page_total_count = 0;

		// 총 페이지의 수
		if(record_total_count%record_count_per_page==0) {
			page_total_count = record_total_count/record_count_per_page;
		}else {	
			page_total_count = (record_total_count/record_count_per_page)+1;
		}

		// 페이지 범위 초과 시 자동 조정 (필수 x)
		if(currentpage<1)
			currentpage = 1;
		else if(currentpage > page_total_count)
			currentpage=page_total_count;

		int startNavi = ((currentpage - 1)/navi_count_per_page * navi_count_per_page)+1;
		int endNavi = startNavi + (navi_count_per_page - 1);

		if(startNavi<1)
			startNavi = 1;
		else if(endNavi>page_total_count)
			endNavi = page_total_count;

		StringBuilder sb = new StringBuilder();

		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi == 1)
			needPrev = false;
		if(endNavi == page_total_count)
			needNext = false;

		if(needPrev) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn navigator_direction_btn' searchto='writeFullReviewList' location='"+(startNavi-1)+"'>"
					+ "				<i class='fa-solid fa-angle-left'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn item' searchto='writeFullReviewList' location='"+i+"'>"+i+"</button>"
					+ "		</div>"
					+ "</li>");
		}
		if(needNext) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn navigator_direction_btn' searchto='writeFullReviewList' location='"+(endNavi+1)+"'>"
					+ "				<i class='fa-solid fa-angle-right'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		return sb.toString();
	}


	public String selectMyFullReviewScrapList(int userno, int start_Record_Row_Num, int end_Record_Row_Num) throws Exception {
		String sql = "select * from "
				+ "(select total.*, row_number() over(order by total.storeID desc) row_num from "
				+ "(select * from (select * from (select * from fullreview "
				+ "join store using (storeid)) c join members m on m.userno = c.userno) a "
				+ "join fullreviewscrap f on a.reviewid = f.reviewid where userno = ?) total) " 
				+ "where row_num between ? and ?";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userno);
			pstat.setInt(2, start_Record_Row_Num);
			pstat.setInt(3, end_Record_Row_Num);
			try(ResultSet rs = pstat.executeQuery();){
				List<MyFullReviewScrapDTO> result = new ArrayList<>();
				while(rs.next()) {
					int scrapID = rs.getInt("scrapID");
					int reviewID = rs.getInt("reviewID");
					String title = rs.getString("title");
					String userID = rs.getString("userid");
					String StoreName = rs.getString(9);
					Timestamp writedate = rs.getTimestamp("writedate");
					result.add(new MyFullReviewScrapDTO(scrapID,reviewID,title,userID,StoreName,writedate));
				}
				return selectMyFullReviewScrapListToJSP(result);
			}
		}
	}

	public String selectMyFullReviewScrapListToJSP(List<MyFullReviewScrapDTO> MyFullReviewScrapList) throws Exception {

		StringBuilder sb = new StringBuilder();
		for(MyFullReviewScrapDTO user : MyFullReviewScrapList) {
			sb.append("<tr>");
			sb.append("<td>"+user.getReviewID()+"</td>");
			sb.append("<td><a href='/content.fullreview?reviewid="+user.getReviewID()+"'>"+user.getTitle()+"</a></td>");
			sb.append("<td>"+user.getUserID()+"</td>");
			sb.append("<td>"+user.getStoreName()+"</td>");
			sb.append("<td>"+user.getWritedateToString()+"</td>");
			sb.append("</tr>");
		}
		return sb.toString();
	}

	public String selectMyFullReviewScrapNaviToJSP(int currentpage, int userno) throws Exception {

		int record_total_count = getMyFullReviewScrapNavi_RecordCount(userno);
		int record_count_per_page = Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE; // 10
		int navi_count_per_page = Settings.MYPAGE_LIST_NAVI_COUNT_PER_PAGE; // 10

		System.out.println("리스트 전체 글 개수 : "+record_total_count);

		int page_total_count = 0;

		// 총 페이지의 수
		if(record_total_count%record_count_per_page==0) {
			page_total_count = record_total_count/record_count_per_page;
		}else {	
			page_total_count = (record_total_count/record_count_per_page)+1;
		}

		// 페이지 범위 초과 시 자동 조정 (필수 x)
		if(currentpage<1)
			currentpage = 1;
		else if(currentpage > page_total_count)
			currentpage=page_total_count;

		int startNavi = ((currentpage - 1)/navi_count_per_page * navi_count_per_page)+1;
		int endNavi = startNavi + (navi_count_per_page - 1);

		if(startNavi<1)
			startNavi = 1;
		else if(endNavi>page_total_count)
			endNavi = page_total_count;

		StringBuilder sb = new StringBuilder();

		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi == 1)
			needPrev = false;
		if(endNavi == page_total_count)
			needNext = false;

		if(needPrev) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn navigator_direction_btn' searchto='writeMyFullReviewScrapList' location='"+(startNavi-1)+"'>"
					+ "				<i class='fa-solid fa-angle-left'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn item' searchto='writeMyFullReviewScrapList' location='"+i+"'>"+i+"</button>"
					+ "		</div>"
					+ "</li>");
		}
		if(needNext) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn navigator_direction_btn' searchto='writeMyFullReviewScrapList' location='"+(endNavi+1)+"'>"
					+ "				<i class='fa-solid fa-angle-right'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		return sb.toString();
	}

	public int getMyFullReviewScrapNavi_RecordCount(int userno) throws Exception{
		String sql = "select count(*) from fullreviewscrap where userno = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userno);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}



	// FullReview 스크랩 기능 추가
	public List<FullReviewScrapDTO> isScrapFullReview(List<FullReviewUserDTO> fullReviewList, int userno) throws Exception {

		List<FullReviewScrapDTO> result = new ArrayList<>();

		for(FullReviewUserDTO fullReview : fullReviewList) {
			String sql = "select * from fullreviewscrap where reviewID = ? and userno = ?";
			try(	Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setInt(1, fullReview.getReviewID());
				pstat.setInt(2, userno);
				try(ResultSet rs = pstat.executeQuery();){
					if(rs.next()) {
						int scrapID = rs.getInt(1);
						result.add(new FullReviewScrapDTO(scrapID,fullReview.getReviewID(),userno));
					}
				}
			}
		}
		return result;
	}


	// 스크랩 등록 dao
	public int addScrapFullReview(int reviewID, int userno) throws Exception {
		String sql = "insert into fullreviewscrap values (fullreviewscrap_scrapid_seq.nextval, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, reviewID);
			pstat.setInt(2, userno);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	// 스크랩 삭제 dao
	public int deleteScrapFullReview(int reviewID, int userno) throws Exception {
		String sql = "delete from fullreviewscrap where reviewID = ? and userno = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, reviewID);
			pstat.setInt(2, userno);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	//리뷰 평점 계산용
	public List<FullReviewDTO> selectByStoreID(int storeID) throws Exception{
		String sql = "select * from FULLREVIEW where STOREID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			try(ResultSet rs = pstat.executeQuery();){
				return this.transToList(rs);
			}
		}
	}
}
