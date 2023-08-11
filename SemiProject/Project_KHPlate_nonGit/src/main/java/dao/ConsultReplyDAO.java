package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.ConsultReplyDTO;

public class ConsultReplyDAO {
	private static ConsultReplyDAO instance;
	public synchronized static ConsultReplyDAO getInstance() {
		if(instance == null) {
			instance = new ConsultReplyDAO();
		}
		return instance;
	}
	private ConsultReplyDAO() {
		super();
	}
	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}
	public int insert(ConsultReplyDTO dto) throws Exception{
		String sql = "insert into CONSULTREPLY(REPLYID, TITLE, BODY, CONSULTID, USERNO, WRITEDATE)"
				+ " values(CONSULTREPLY_REPLYNO_SEQ.nextval, ?, ?, ?, ?, sysdate)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getBody());
			pstat.setInt(3, dto.getConsultID());
			pstat.setInt(4, dto.getUserNo());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	public ConsultReplyDTO selectOneByConsultID(int consultID) throws Exception {
		String sql = "select * from CONSULTREPLY where CONSULTID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, consultID);
			try(ResultSet rs = pstat.executeQuery();){
				ArrayList<ConsultReplyDTO> temp = this.transAllRsToList(rs);
				if(temp.size() > 0) {
					return temp.get(0);
				}
				return null;
			}
		}
	}
	
	public int deleteByConsultID(int consultID) throws Exception{
		String sql = "delete from CONSULTREPLY where CONSULTID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, consultID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	private ArrayList<ConsultReplyDTO> transAllRsToList(ResultSet rs) throws Exception{
		ArrayList<ConsultReplyDTO> result = new ArrayList<>();
		while(rs.next()) {
			int replyID = rs.getInt("REPLYID");
			String title = rs.getString("TITLE");
			String body = rs.getString("BODY");
			int consultID = rs.getInt("CONSULTID");
			int userNo = rs.getInt("USERNO");
			Timestamp writeDate = rs.getTimestamp("WRITEDATE");
			
			result.add(new ConsultReplyDTO(replyID, title, body, consultID, userNo, writeDate));
		}
		return result;
	}
}
