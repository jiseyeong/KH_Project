package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.ConsultDTO;
import dto.FaqDTO;
import dto.NaviDTO;
import statics.Settings;

public class FaqDAO {
	private static FaqDAO instance = null;
	public synchronized static FaqDAO getInstance() {
		if(instance == null) {
			instance = new FaqDAO();
		}
		return instance;
	}
	
	private FaqDAO() {
		super();
	}
	
	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}
	
	public int insert(FaqDTO dto) throws Exception {
		String sql = "insert into FAQ(QAID, TITLE, BODY)"
				+ " values(FAQ_QAID_SEQ.nextval, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getBody());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public ArrayList<FaqDTO> selectAll() throws Exception{
		String sql = "select * from FAQ";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			return this.transAllRsToList(rs);
		}
	}
	
	public int delete(int qaID) throws Exception{
		String sql = "delete from FAQ where QAID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, qaID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public ArrayList<FaqDTO> selectBound(int start, int end) throws Exception{
		String sql = "select *"
				+ " from"
				+ " (select FAQ.*, row_number() over(order by QAID desc) rn"
				+ " from FAQ)"
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
	
	private int getRecoredCount() throws Exception{
		String sql = "select COUNT(*) from FAQ";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}
	
	public NaviDTO getNavi(int currentPage) throws Exception{
		int recordTotalCount = this.getRecoredCount();
		int recordCountPerPage = Settings.FAQ_RECORD_COUNT_PER_PAGE;
		int naviCountPerPage = Settings.FAQ_NAVI_COUNT_PER_PAGE;
		
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
	
	private ArrayList<FaqDTO> transAllRsToList(ResultSet rs) throws Exception{
		ArrayList<FaqDTO> result = new ArrayList<>();
		while(rs.next()) {
			int qaID = rs.getInt("qaID");
			String title = rs.getString("title");
			String body = rs.getString("body");
			
			result.add(new FaqDTO(qaID, title, body));
		}
		return result;
	}
}
