package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.StoreMenuDTO;

public class StoreMenuDAO {
	private static StoreMenuDAO instance = null;
	public synchronized static StoreMenuDAO getInstance() {
		if(instance == null) {
			instance = new StoreMenuDAO();
		}
		return instance;
	}
	private StoreMenuDAO() {
		super();
	}
	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}
	public int insert(StoreMenuDTO dto) throws Exception{
		String sql = "insert into STOREMENU(MENUID, MENUNAME, MENUPRICE, STOREID)"
				+ " values(STOREMENU_MENUID_SEQ.nextval, ?, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getMenuName());
			pstat.setInt(2, dto.getMenuPrice());
			pstat.setInt(3, dto.getStoreID());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	public ArrayList<StoreMenuDTO> selectAllByStoreID(int storeID) throws Exception{
		String sql = "select * from STOREMENU where STOREID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			try(ResultSet rs = pstat.executeQuery();){
				return this.transAllRsToList(rs);
			}
		}
	}
	public int deleteByID(int menuID) throws Exception{
		String sql = "delete from STOREMENU where MENUID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, menuID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	public int update(StoreMenuDTO dto) throws Exception{
		String sql = "update STOREMENU set MENUNAME=?, MENUPRICE=? where MENUID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getMenuName());
			pstat.setInt(2, dto.getMenuPrice());
			pstat.setInt(3, dto.getMenuID());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	private ArrayList<StoreMenuDTO> transAllRsToList(ResultSet rs) throws Exception{
		ArrayList<StoreMenuDTO> result = new ArrayList<>();
		while(rs.next()) {
			int menuID = rs.getInt("MENUID");
			String menuName = rs.getString("MENUNAME");
			int menuPrice = rs.getInt("MENUPRICE");
			int storeID = rs.getInt("STOREID");
			result.add(new StoreMenuDTO(menuID, menuName, menuPrice, storeID));
		}
		return result;
	}
}
