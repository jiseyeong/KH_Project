package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.FavoritePageDTO;
import dto.StoreDTO;

public class FavoriteStoreDAO {
	private static FavoriteStoreDAO instance = null;
	public synchronized static FavoriteStoreDAO getInstance() {
		if(instance == null) {
			instance = new FavoriteStoreDAO();
		}
		return instance;
	}

	private FavoriteStoreDAO() {
		super();
	}
	
	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}
	
	
	public List<FavoritePageDTO> isFavoriteStore(List<StoreDTO> search_store_list, int userno) throws Exception {
		
		List<FavoritePageDTO> result = new ArrayList<>();
		
		for(StoreDTO store : search_store_list) {
			String sql = "select * from favoritepage where StoreID = ? and userno = ?";
			try(	Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setInt(1, store.getStoreID());
				pstat.setInt(2, userno);
				try(ResultSet rs = pstat.executeQuery();){
					if(rs.next()) {
						int favoriteID = rs.getInt(1);
						result.add(new FavoritePageDTO(favoriteID,store.getStoreID(),userno));
					}
				}
			}
		}
		return result;
	}
	
	public FavoritePageDTO isFavoriteStore(int storeID, int userNo) throws Exception{
		String sql = "select * from FAVORITEPAGE where STOREID=? and USERNO=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			pstat.setInt(2, userNo);
			try(ResultSet rs = pstat.executeQuery();){
				if(rs.next()) {
					int favoriteID = rs.getInt(1);
					return new FavoritePageDTO(favoriteID, storeID, userNo);
				}
				return null;
			}
		}
	}
	

	// 즐겨찾기 등록 dao
	public int addFavoriteStore(int storeID, int userno) throws Exception {
		String sql = "insert into favoritepage values (favoritepage_favoriteid_seq.nextval, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, storeID);
			pstat.setInt(2, userno);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	// 즐겨찾기 삭제 dao
	public int deleteFavoriteStore(int storeID, int userno) throws Exception {
		String sql = "delete from favoritepage where storeID = ? and userno = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, storeID);
			pstat.setInt(2, userno);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	// 즐겨찾기 ResultSet=>List 자동 변환
	private List<FavoritePageDTO> transToList(ResultSet rs)throws Exception{
		List<FavoritePageDTO> result = new ArrayList<>();
		while(rs.next()) {
			int favoriteID = rs.getInt(1);
			int storeID = rs.getInt(2);
			int userNO = rs.getInt(3);
			result.add(new FavoritePageDTO(favoriteID,storeID,userNO));
		}
		return result;
	}
		
}
