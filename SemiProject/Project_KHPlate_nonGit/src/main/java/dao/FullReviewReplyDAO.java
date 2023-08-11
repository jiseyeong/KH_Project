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

import dto.CommentReviewUserDTO;
import dto.ReplyWithUserIdDTO;
import statics.Settings;

public class FullReviewReplyDAO {
	private static FullReviewReplyDAO instance = null;

	public synchronized static FullReviewReplyDAO getInstance() {
		if (instance == null) {
			instance = new FullReviewReplyDAO();
		}
		return instance;
	}

	private FullReviewReplyDAO() {
		super();
	}

	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource) iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}

	public int addReply(String body, int userno, int reviewid) throws Exception {
		String sql = "insert into fullreviewreply values(fullreviewreply_commentid_seq.nextval,?,?,?)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, body);
			pstat.setInt(2, userno);
			pstat.setInt(3, reviewid);
			int result = pstat.executeUpdate();

			return result;
		}
	};

	public int updateReply(String body, int commentid) throws Exception {
		String sql = "update fullreviewreply set body = ? where commentid= ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, body);
			pstat.setInt(2, commentid);
			int result = pstat.executeUpdate();
			return result;
		}
	}

	public int deleteReply(int commentid) throws Exception {
		String sql = "delete from fullreviewreply where commentid = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, commentid);
			int result = pstat.executeUpdate();
			return result;
		}
	}


	public List<ReplyWithUserIdDTO> listReplyByreviewid(int reviewid) throws Exception {
		String sql = "select * from (select m.userid, f.commentid, f.body, f.userno, f.reviewid from members m, fullreviewreply f where m.userno=f.userno) where reviewid = ?";
		try (Connection con = this.getConnection(); 
				PreparedStatement pstat = con.prepareStatement(sql);){
					pstat.setInt(1, reviewid);
				try(ResultSet rs = pstat.executeQuery();) {
				List<ReplyWithUserIdDTO> result = new ArrayList<>();
				while (rs.next()) {
					
					ReplyWithUserIdDTO rdto = new ReplyWithUserIdDTO();
					rdto.setUserid(rs.getString("userid"));
					rdto.setCommentid(rs.getInt("commentid"));
					rdto.setBody(rs.getString("body"));
					rdto.setUserno(rs.getInt("userno"));
					rdto.setReviewid(rs.getInt("reviewid"));
					result.add(rdto);
				}
				return result;
			}
		}
	}
	
	
}
