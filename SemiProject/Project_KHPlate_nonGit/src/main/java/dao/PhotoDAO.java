package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.PhotoDTO;
import dto.StoreDTO;

public class PhotoDAO {
	private static PhotoDAO instance = null;
	public synchronized static PhotoDAO getInstance() {
		if(instance == null) {
			instance = new PhotoDAO();
		}
		return instance;
	}
	private PhotoDAO() {
		super();
	}
	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}
	
	public int delete(int imageID) throws Exception{
		String sql = "delete from PHOTO where IMAGEID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, imageID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteByStoreID(int storeID) throws Exception{
		String sql = "delete from PHOTO where STOREID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteByuserno(int userno) throws Exception{
		String sql = "delete from PHOTO where userno = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userno);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int deleteByReviewId(int reviewId) throws Exception{
		String sql = "delete from PHOTO where reviewId=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewId);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int insertByStoreID(String oriName, String sysName, int storeID) throws Exception{
		String sql = "insert into PHOTO(IMAGEID, ORINAME, SYSNAME, STOREID)"
				+ " values(PHOTO_IMAGEID_SEQ.nextval, ?, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, oriName);
			pstat.setString(2, sysName);
			pstat.setInt(3, storeID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int insertByConsultID(String oriName, String sysName, int consultID) throws Exception{
		String sql = "insert into PHOTO(IMAGEID, ORINAME, SYSNAME, CONSULTID)"
				+ " values(PHOTO_IMAGEID_SEQ.nextval, ?, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, oriName);
			pstat.setString(2, sysName);
			pstat.setInt(3, consultID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int insertByuserNo(String oriName, String sysName, int userNo) throws Exception{
		String sql = "insert into PHOTO(IMAGEID, ORINAME, SYSNAME, userno)"
				+ " values(PHOTO_IMAGEID_SEQ.nextval, ?, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, oriName);
			pstat.setString(2, sysName);
			pstat.setInt(3, userNo);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public PhotoDTO selectByImageID(int photoID) throws Exception{
		String sql = "select IMAGEID, ORINAME, SYSNAME from PHOTO where IMAGEID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, photoID);
			try(ResultSet rs = pstat.executeQuery();){
				return this.transAllRsToList(rs).get(0);
			}
		}
	}
	
	public PhotoDTO selectByuserNo(int userNo) throws Exception{
		String sql = "select IMAGEID, ORINAME, SYSNAME from PHOTO where userno = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userNo);
			try(ResultSet rs = pstat.executeQuery();){
				return this.transAllRsToList(rs).get(0);
			}
		}
	}
	
	public ArrayList<PhotoDTO> selectByStoreID(int storeID) throws Exception{
		String sql = "select IMAGEID, ORINAME, SYSNAME from PHOTO where STOREID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			try(ResultSet rs = pstat.executeQuery();){
				return this.transAllRsToList(rs);
			}
		}
	}
	
	public ArrayList<PhotoDTO> ListByReviewId(int reviewid) throws Exception{
		String sql = "select IMAGEID, ORINAME, SYSNAME from PHOTO where reviewid = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewid);
			try(ResultSet rs = pstat.executeQuery();){
				return this.transAllRsToList(rs);
			}
		}
	}
	
	public PhotoDTO DTOByReviewId(int reviewid) throws Exception{
		String sql = "select IMAGEID, ORINAME, SYSNAME from PHOTO where reviewid = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewid);
			try(ResultSet rs = pstat.executeQuery();){
				PhotoDTO dto = new PhotoDTO();
				if(rs.next()) {
				dto.setImageID(rs.getInt("imageid"));
				dto.setOriName(rs.getString("oriname"));
				dto.setSysName(rs.getString("sysname"));
				return dto;
				}else {
					dto.setSysName("Logo.png");
					return dto;
				}
				
			}
		}
	}
	
	public PhotoDTO selectByConsultID(int consultID) throws Exception{
		String sql = "select IMAGEID, ORINAME, SYSNAME from PHOTO where CONSULTID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, consultID);
			try(ResultSet rs = pstat.executeQuery();){
				ArrayList<PhotoDTO> temp = this.transAllRsToList(rs);
				if(temp.size() > 0) {
					return temp.get(0);
				}
				return null;
			}
		}
	}
	
	private ArrayList<PhotoDTO> transAllRsToList(ResultSet rs) throws Exception{
		ArrayList<PhotoDTO> result = new ArrayList<>();
		while(rs.next()) {
			int imageID = rs.getInt("IMAGEID");
			String oriName = rs.getString("ORINAME");
			String sysName = rs.getString("SYSNAME");
			result.add(new PhotoDTO(imageID, oriName, sysName));
		}
		return result;
	}
	
	
	public int insertByFullReviewId(String oriName, String sysName, int reviewid) throws Exception{
		String sql = "insert into PHOTO(IMAGEID, ORINAME, SYSNAME, REVIEWID)"
				+ " values(PHOTO_IMAGEID_SEQ.nextval, ?, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, oriName);
			pstat.setString(2, sysName);
			pstat.setInt(3, reviewid);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	// 가거 리스트 출력 시 썸네일로 출력할 가게 사진들 출력
	public ArrayList<PhotoDTO> selectSearchStoreThumbnailByStoreID(List<StoreDTO> search_store_list) throws Exception{
		ArrayList<PhotoDTO> result = new ArrayList<>();
		for(StoreDTO store : search_store_list) {
			String sql = "select IMAGEID, ORINAME, SYSNAME from PHOTO where STOREID = ?";
			try(	Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setInt(1, store.getStoreID());
				try(ResultSet rs = pstat.executeQuery();){
					if(rs.next()) {
						int imageID = rs.getInt("IMAGEID");
						String oriName = rs.getString("ORINAME");
						String sysName = rs.getString("SYSNAME");
						result.add(new PhotoDTO(imageID, oriName, sysName));
					}else {
						result.add(null);
					}
				}
			}
		}
		return result;
	}
	public PhotoDTO selectByUserno(int userno) throws Exception{
		String sql = "select IMAGEID, ORINAME, SYSNAME from PHOTO where userno = ? and STOREID is null and REVIEWID is null";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, userno);
			try(ResultSet rs = pstat.executeQuery();){
				ArrayList<PhotoDTO> temp = this.transAllRsToList(rs);
				if(temp.size() > 0) {
					return temp.get(0);
				}
				return null;
			}
		}
	}
}
