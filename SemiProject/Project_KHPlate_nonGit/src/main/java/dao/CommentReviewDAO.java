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

import dto.CommentReviewDTO;
import dto.CommentReviewUserDTO;
import dto.NaviDTO;
import statics.Settings;

public class CommentReviewDAO {
	private static CommentReviewDAO instance = null;
	public synchronized static CommentReviewDAO getInstance() {
		if(instance == null) {
			instance = new CommentReviewDAO();
		}
		return instance;
	}

	private CommentReviewDAO() {
		super();
	}

	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}

	public int insert(CommentReviewDTO dto) throws Exception{
		String sql = "insert into COMMENTREVIEW(REVIEWID, BODY, SCORE, STOREID, USERNO, WRITEDATE, TOTALLIKE)"
				+ " values(COMMENTREVIEW_REVIEWID_SEQ.nextval, ?, ?, ?, ?, sysdate, 0)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getBody());
			pstat.setInt(2, dto.getScore());
			pstat.setInt(3, dto.getStoreID());
			pstat.setInt(4, dto.getUserNo());
			int result = pstat.executeUpdate();
			con.commit();
			
			return result;
		}
	}

	public int update(int reviewID, String body, int score) throws Exception{
		String sql = "update COMMENTREVIEW"
				+ " set BODY=?, SCORE=?"
				+ " where REVIEWID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, body);
			pstat.setInt(2, score);
			pstat.setInt(3, reviewID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public ArrayList<CommentReviewDTO> selectByStoreID(int storeID) throws Exception{
		String sql = "select * from COMMENTREVIEW where STOREID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			try(ResultSet rs = pstat.executeQuery();){
				return this.transAllRsToList(rs);
			}
		}
	}

	public ArrayList<CommentReviewDTO> selectByUserNo(int userNo) throws Exception{
		String sql = "select * from COMMENTREVIEW where USERNO = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userNo);
			try(ResultSet rs = pstat.executeQuery();){
				return this.transAllRsToList(rs);
			}
		}
	}

	public int getCurrval() throws Exception{
		String sql = "select COMMENTREVIEW_REVIEWID_SEQ.currval from dual";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}

	public int delete(int reviewID) throws Exception{
		String sql = "delete from COMMENTREVIEW where REVIEWID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteByStoreID(int storeID) throws Exception{
		String sql = "delete from COMMENTREVIEW where STOREID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}


	private ArrayList<CommentReviewDTO> transAllRsToList(ResultSet rs) throws Exception{
		ArrayList<CommentReviewDTO> result = new ArrayList<>();
		while(rs.next()) {
			int reviewID = rs.getInt("REVIEWID");
			String body = rs.getString("BODY");
			int score = rs.getInt("SCORE");
			int storeID = rs.getInt("STOREID");
			int userNo = rs.getInt("USERNO");
			Timestamp writeDate = rs.getTimestamp("WRITEDATE");
			int totalLike = rs.getInt("TOTALLIKE");

			result.add(new CommentReviewDTO(reviewID, body, score, storeID, userNo, writeDate, totalLike));
		}
		return result;
	}


	// 마이페이지에 표시될 나의 댓글 리스트 출력, 네비 출력 사항
	public String selectwriteCommentListToJSP(int userno, int start_Record_Row_Num, int end_Record_Row_Num) throws Exception {

		List<CommentReviewUserDTO> userList = selectwriteCommentList(userno, start_Record_Row_Num, end_Record_Row_Num);
		StringBuilder sb = new StringBuilder();

		for(CommentReviewUserDTO user : userList) {
			sb.append("<tr>");
			sb.append("<td>"+user.getReviewID()+"</td>");
			sb.append("<td><a href='/view.store?storeID="+user.getStoreID()+"'>"+user.getStoreName()+"</a></td>");
			sb.append("<td>"+user.getBody()+"</td>");
			sb.append("<td>"+user.getScore()+"</td>");
			sb.append("<td>"+user.getWritedateToString()+"</td>");
			sb.append("</tr>");
		}
		return sb.toString();
	}

	public List<CommentReviewUserDTO> selectwriteCommentList(int userno, int start_Record_Row_Num, int end_Record_Row_Num) throws Exception {
		String sql = "select * from "
				+ "(select a.*, row_number() over(order by a.storeID desc) row_num from"
				+ "(select * from members m join"
				+ "(select * from commentreview join store using (storeid)) c on m.userno = c.userno where c.userno = ?) a)"
				+ "where row_num between ? and ?";
		try (Connection con = this.getConnection(); 
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userno);
			pstat.setInt(2, start_Record_Row_Num);
			pstat.setInt(3, end_Record_Row_Num);
			try(ResultSet rs = pstat.executeQuery();) {
				List<CommentReviewUserDTO> result = new ArrayList<>();
				while (rs.next()) {
					int reviewID = rs.getInt("reviewid");
					int storeID = rs.getInt("storeID");
					String StoreName = rs.getString(23);
					String body = rs.getString("body");
					int score = rs.getInt("score");
					Timestamp writeDate = rs.getTimestamp("writedate");
					result.add(new CommentReviewUserDTO(reviewID,storeID,StoreName,body,score,writeDate));
				}
				return result;
			}
		}
	}

	public String selectwriteCommentNaviToJSP(int currentpage, int searchUserno) throws Exception {

		int record_total_count = selectwriteCommentList_RecordCount(searchUserno);
		int record_count_per_page = Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE; // 15
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
					+ "			<button class='navibtn navigator_direction_btn' searchto='writeMyCommentList' location='"+(startNavi-1)+"'>"
					+ "				<i class='fa-solid fa-angle-left'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn item' searchto='writeMyCommentList' location='"+i+"'>"+i+"</button>"
					+ "		</div>"
					+ "</li>");
		}
		if(needNext) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn navigator_direction_btn' searchto='writeMyCommentList' location='"+(endNavi+1)+"'>"
					+ "				<i class='fa-solid fa-angle-right'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		return sb.toString();
	}

	private int selectwriteCommentList_RecordCount(int searchUserno) throws Exception{
		String sql = "select count(*) from commentreview where userno = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, searchUserno);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);	
			}
		}
	}
	
	private int getRecoredCount(int storeID) throws Exception{
		String sql = "select COUNT(*) from COMMENTREVIEW where storeID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			try(ResultSet rs = pstat.executeQuery();){
				if(rs.next()) {
					return rs.getInt(1);									
				}
				return 0;
			}
		}
	}
	
	public NaviDTO getNavi(int currentPage, int storeID) throws Exception{
		int recordTotalCount = this.getRecoredCount(storeID);
		int recordCountPerPage = Settings.COMMENTREVIEW_RECORD_COUNT_PER_PAGE;
		int naviCountPerPage = Settings.COMMENTREVIEW_NAVI_COUNT_PER_PAGE;
		
		int pageTotalCount = recordTotalCount % recordCountPerPage > 0 ?
				recordTotalCount/recordCountPerPage + 1
				:recordTotalCount/recordCountPerPage;
		
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = ((currentPage-1)/naviCountPerPage*naviCountPerPage)+1;
		int endNavi = startNavi + (naviCountPerPage-1);
		
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		
		boolean needPrev = true;
		boolean needNext = true;
		ArrayList<Integer> list = new ArrayList<>();
		
		if(startNavi == 1) {needPrev = false;}
		if(endNavi == pageTotalCount) {needNext = false;}
		for(int i = startNavi; i <= endNavi; i++) {
			list.add(i);
		}
		return new NaviDTO(list, needPrev, needNext);
	}
	
	public ArrayList<CommentReviewDTO> selectBound(int storeID, int start, int end) throws Exception{
		String sql = "select *"
				+ " from"
				+ " (select COMMENTREVIEW.*, row_number() over(order by REVIEWID desc) rn"
				+ " from COMMENTREVIEW"
				+ " where STOREID = ?)"
				+ " where rn between ? and ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			try(ResultSet rs = pstat.executeQuery()){
				return this.transAllRsToList(rs);
			}
		}
	}
}
