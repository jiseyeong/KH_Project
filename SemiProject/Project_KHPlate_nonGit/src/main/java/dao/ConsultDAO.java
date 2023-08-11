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

import dto.ConsultDTO;
import dto.NaviDTO;
import statics.Settings;

public class ConsultDAO {
	private static ConsultDAO instance = null;
	public synchronized static ConsultDAO getInstance() {
		if(instance == null) {
			instance = new ConsultDAO();
		}
		return instance;
	}
	private ConsultDAO() {
		super();
	}
	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}
	
	public int getCurrval() throws Exception{
		String sql = "select CONSULT_CONSULTID_SEQ.currval from DUAL";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}
	
	public int insert(ConsultDTO dto) throws Exception{
		String sql = "insert into CONSULT(CONSULTID, TITLE, BODY, USERNO, WRITEDATE, CATEGORY, REPLY)"
				+ " values(CONSULT_CONSULTID_SEQ.nextval, ?, ?, ?, sysdate, ?, 'N')";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getBody());
			pstat.setInt(3, dto.getUserNO());
			pstat.setString(4, dto.getCategory());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public ArrayList<ConsultDTO> selectAll() throws Exception{
		String sql = "select * from CONSULT";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			return this.transAllRsToList(rs);
		}
	}
	
	public ConsultDTO selectOne(int consultID) throws Exception{
		String sql = "select * from CONSULT where CONSULTID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, consultID);
			try(ResultSet rs = pstat.executeQuery();){
				ArrayList<ConsultDTO> result = this.transAllRsToList(rs);
				if(result.size() > 0) {
					return result.get(0);
				}
				return null;
			}
		}
	}
	
	public ArrayList<ConsultDTO> selectBound(int start, int end) throws Exception{
		String sql = "select *"
				+ " from"
				+ " (select CONSULT.*, row_number() over(order by CONSULTID desc) rn"
				+ " from CONSULT)"
				+ " where rn between ? and ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, start);
			pstat.setInt(2, end);
			try(ResultSet rs = pstat.executeQuery()){
				return this.transAllRsToList(rs);
			}
		}
	}
	
	public ArrayList<ConsultDTO> selectBoundByUserNo(int start, int end, int userNo) throws Exception{
		String sql = "select *"
				+ " from"
				+ " (select CONSULT.*, row_number() over(order by CONSULTID desc) rn"
				+ " from CONSULT"
				+ " where USERNO=?)"
				+ " where rn between ? and ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userNo);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			try(ResultSet rs = pstat.executeQuery()){
				return this.transAllRsToList(rs);
			}
		}
	}
	
	private int getRecoredCount() throws Exception{
		String sql = "select COUNT(*) from CONSULT";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}
	
	private int getRecordCountByUserNo(int userNo) throws Exception{
		String sql = "select COUNT(*) from CONSULT where USERNO=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userNo);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	
	public NaviDTO getNavi(int currentPage) throws Exception{
		int recordTotalCount = this.getRecoredCount();
		int recordCountPerPage = Settings.CONSULT_NAVI_COUNT_PER_PAGE;
		int naviCountPerPage = Settings.CONSULT_RECORD_COUNT_PER_PAGE;
		
		int pageTotalCount = recordTotalCount % recordCountPerPage > 0 ?
				recordTotalCount/recordCountPerPage + 1
				:recordTotalCount/recordCountPerPage;
		
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = (currentPage-1)/naviCountPerPage*naviCountPerPage+1;
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
	
	public NaviDTO getNaviByUserNo(int currentPage, int userNo) throws Exception{
		int recordTotalCount = this.getRecordCountByUserNo(userNo);
		int recordCountPerPage = Settings.CONSULT_NAVI_COUNT_PER_PAGE;
		int naviCountPerPage = Settings.CONSULT_RECORD_COUNT_PER_PAGE;
		
		int pageTotalCount = recordTotalCount % recordCountPerPage > 0 ?
				recordTotalCount/recordCountPerPage + 1
				:recordTotalCount/recordCountPerPage;
		
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = (currentPage-1)/naviCountPerPage*naviCountPerPage+1;
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
	
	public int updateReply(int consultID, String reply) throws Exception{
		String sql = "update CONSULT set REPLY = ? where CONSULTID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, reply);
			pstat.setInt(2, consultID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int delete(int consultID) throws Exception{
		String sql = "delete from CONSULT where CONSULTID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, consultID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	private ArrayList<ConsultDTO> transAllRsToList(ResultSet rs) throws Exception{
		ArrayList<ConsultDTO> result = new ArrayList<>();
		while(rs.next()) {
			int consultID = rs.getInt("CONSULTID");
			String title = rs.getString("TITLE");
			String body = rs.getString("BODY");
			int number = rs.getInt("USERNO");
			Timestamp writeDate = rs.getTimestamp("WRITEDATE");
			String category = rs.getString("CATEGORY");
			String reply = rs.getString("REPLY");
			
			result.add(new ConsultDTO(consultID, title, body, number, writeDate, category, reply));
		}
		return result;
	}
	
	
	// 마이페이지 1:1 문의 리스트, 네비 출력
	public String selectMyConsultList(int userno, int start_Record_Row_Num, int end_Record_Row_Num) throws Exception {
		String sql = "select * from "
				+ "(select consult.*, row_number() over(order by consultid desc) row_num from consult where userno = ?)"
				+ "where row_num between ? and ?";
		
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setInt(1, userno);
				pstat.setInt(2, start_Record_Row_Num);
				pstat.setInt(3, end_Record_Row_Num);
			try(ResultSet rs = pstat.executeQuery();){
				List<ConsultDTO> result = new ArrayList<>();
				while(rs.next()) {
					int consultID = rs.getInt("consultID");
					String title = rs.getString("title");
					Timestamp writedate = rs.getTimestamp("writedate");
					String category = rs.getString("category");
					String reply = rs.getString("reply");
					result.add(new ConsultDTO(consultID,title,"",0,writedate,category,reply));
				}
				System.out.println("리스트 : "+result.size());
				return selectMyConsultListToJSP(result);
			}
		}
	}
	
	public String selectMyConsultListToJSP(List<ConsultDTO> myConsultList) throws Exception {
		
		StringBuilder sb = new StringBuilder();
		for(ConsultDTO user : myConsultList) {
			sb.append("<tr>");
			sb.append("<td>"+user.getConsultID()+"</td>");
			sb.append("<td><a href='/view.consult?consultID="+user.getConsultID()+"'>"+user.getTitle()+"</a></td>");
			sb.append("<td>"+user.getCategory()+"</td>");
			if(user.getReply().equals("t")) {
				sb.append("<td>답변 완료</td>");
			}else {
				sb.append("<td>답변 미완료</td>");
			}
			sb.append("<td>"+user.getWritedateToString()+"</td>");
			sb.append("</tr>");
		}
		return sb.toString();
	}
	
	public String selectMyConsultNaviToJSP(int currentpage, int userno) throws Exception {

		int record_total_count = getMyConsultNavi_RecordCount(userno);
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
					+ "			<button class='navibtn navigator_direction_btn' searchto='myConsultList' location='"+(startNavi-1)+"'>"
					+ "				<i class='fa-solid fa-angle-left'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn item' searchto='myConsultList' location='"+i+"'>"+i+"</button>"
					+ "		</div>"
					+ "</li>");
		}
		if(needNext) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn navigator_direction_btn' searchto='myConsultList' location='"+(endNavi+1)+"'>"
					+ "				<i class='fa-solid fa-angle-right'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		return sb.toString();
	}
	
	public int getMyConsultNavi_RecordCount(int userno) throws Exception{
		String sql = "select count(*) from consult where userno = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setInt(1, userno);
				try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}
}
