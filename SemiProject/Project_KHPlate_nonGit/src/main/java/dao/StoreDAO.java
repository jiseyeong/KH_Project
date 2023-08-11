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
import dto.PhotoDTO;
import dto.StoreDTO;
import statics.Settings;

public class StoreDAO {
	private static StoreDAO instance = null;
	public synchronized static StoreDAO getInstance() {
		if(instance == null) {
			instance = new StoreDAO();
		}
		return instance;
	}

	private StoreDAO() {
		super();
	}

	private Connection getConnection() throws Exception {
		Context iContext = new InitialContext();
		DataSource ds = (DataSource)iContext.lookup("java:/comp/env/jdbc/ora");
		return ds.getConnection();
	}

	public int insert(StoreDTO dto) throws Exception {
		String sql = "insert into store(StoreID, distance, name, lat, lng, address, avgScore, introduction, category, priceRange)"
				+ " values(store_storeid_seq.nextval, ?, ?, ?, ?, ?, 0, ?, ?, ?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, dto.getDistance());
			pstat.setString(2, dto.getName());
			pstat.setDouble(3, dto.getLat());
			pstat.setDouble(4, dto.getLng());
			pstat.setString(5, dto.getAddress());
			pstat.setString(6, dto.getIntroduction());
			pstat.setString(7, dto.getCategory());
			pstat.setString(8, dto.getPriceRange());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int getCurrval() throws Exception{
		String sql = "select store_storeid_seq.currval from dual";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}

	public StoreDTO selectOne(int storeID) throws Exception {
		String sql = "select * from STORE where STOREID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			try(ResultSet rs = pstat.executeQuery();){
				ArrayList<StoreDTO> temp = this.transAllRsToList(rs);
				if(temp.size()>0) {
					return temp.get(0);
				}
				return null;
			}
		}
	}

	public int update(StoreDTO dto) throws Exception{
		String sql = "update STORE set DISTANCE=?, LAT=?, LNG=?, NAME=?, ADDRESS=?, INTRODUCTION=?, CATEGORY=?, PRICERANGE=?"
				+ " where STOREID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, dto.getDistance());
			pstat.setDouble(2, dto.getLat());
			pstat.setDouble(3, dto.getLng());
			pstat.setString(4, dto.getName());
			pstat.setString(5, dto.getAddress());
			pstat.setString(6, dto.getIntroduction());
			pstat.setString(7, dto.getCategory());
			pstat.setString(8, dto.getPriceRange());
			pstat.setInt(9, dto.getStoreID());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int updateAvgScore(double avgScore, int storeID) throws Exception{
		String sql = "update STORE set AVGSCORE=? where STOREID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setDouble(1, avgScore);
			pstat.setInt(2, storeID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int delete(int storeID) throws Exception{
		String sql = "delete from STORE where STOREID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int updateReviewCount(int reviewCount, int storeID) throws Exception{
		String sql = "update STORE set REVIEWCOUNT=? where STOREID=?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, reviewCount);
			pstat.setInt(2, storeID);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	private ArrayList<StoreDTO> transAllRsToList(ResultSet rs) throws Exception{
		ArrayList<StoreDTO> result = new ArrayList<>();
		while(rs.next()) {
			int storeID = rs.getInt("STOREID");
			int distance = rs.getInt("DISTANCE");
			String name = rs.getString("NAME");
			double lat = rs.getDouble("LAT");
			double lng = rs.getDouble("LNG");
			String address = rs.getString("ADDRESS");
			double avgScore = rs.getDouble("AVGSCORE");
			String introduction = rs.getString("INTRODUCTION");
			String category = rs.getString("CATEGORY");
			int reviewCount = rs.getInt("REVIEWCOUNT"); 
			String priceRange = rs.getString("priceRange");
			result.add(new StoreDTO(storeID, distance, name, lat, lng, address, avgScore, introduction, category, reviewCount,priceRange));
		}
		return result;
	}




	// 일반 검색 & 사이드바 카테고리 접근
	public List<StoreDTO> searchStore_BySearchBox(String search, int start_Record_Row_Num, int end_Record_Row_Num, String food_category) throws Exception{
		String sql = "select * from "
				+ "(select store.*, row_number() over(order by storeID desc) row_num from store where name like ? and category like ?)"
				+ "where row_num between ? and ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1,"%"+search+"%");
			pstat.setString(2, "%"+food_category+"%");
			pstat.setInt(3, start_Record_Row_Num);
			pstat.setInt(4, end_Record_Row_Num);
			try (	ResultSet rs = pstat.executeQuery();){
				return transAllRsToList(rs);
			}
		}
	}

	// 일반 검색 네비게이터
	public String getNavi_BySearchBox(int currentpage, String search, String searchedBy, String food_category) throws Exception {

		int record_total_count = getSearchdStore_RecordCount_BySearchBox(search,food_category);
		int record_count_per_page = 0;
		int navi_count_per_page = 0;
		System.out.println("리스트 전체 글 개수 : "+record_total_count);
		if(searchedBy.equals("mainSearch")) {
			record_count_per_page = Settings.SEARCH_STORE_RECORD_COUNT_PER_PAGE; // 15
			navi_count_per_page = Settings.SEARCH_STORE_NAVI_COUNT_PER_PAGE; // 10
		}else if(searchedBy.equals("mapSearch")) {
			record_count_per_page = Settings.SEARCH_STORE_TO_MAP_RECORD_COUNT_PER_PAGE; // 5
			navi_count_per_page = Settings.SEARCH_STORE_TO_MAP_NAVI_COUNT_PER_PAGE; // 10
		}

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
					+ "			<a href='/searchStoreBySearchBox.store?cpage="+(startNavi-1)+"&search="+search+"&food_category="+food_category+"'>"
					+ "				<button type='button' class='navigator_direction_btn'>"
					+ "					<i class='fa-solid fa-angle-left'></i>"
					+ "				</button>"
					+ "			</a>"
					+ "		</div>"
					+ "</li>");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<a class='naviItem' href='/searchStoreBySearchBox.store?cpage="+i+"&search="+search+"&food_category="+food_category+"'>"
					+ "			<div class='navigator_list_item_btn_layout'>"+i+"</div>"
					+ "		</a>"
					+ "</li>");
		}
		if(needNext) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<a href='/searchStoreBySearchBox.store?cpage="+(endNavi+1)+"&search="+search+"&food_category="+food_category+"'>"
					+ "				<button type='button' class='navigator_direction_btn'>"
					+ "					<i class='fa-solid fa-angle-right'></i>"
					+ "				</button>"
					+ "			</a>"
					+ "		</div>"
					+ "</li>");
		}
		return sb.toString();

	}

	// 일반 검색 Record 수
	public int getSearchdStore_RecordCount_BySearchBox(String search, String food_category) throws Exception{
		String sql = "select count(*) from store where name like ? and category like ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,"%"+search+"%");
			pstat.setString(2, "%"+food_category+"%");
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}


	// 필터 검색
	public List<StoreDTO> searchStore_BySearchFilter(String search, int start_Record_Row_Num, int end_Record_Row_Num,
			String sortMethod,String cost_range,String food_category_korean, String food_category_western, String food_category_chinese, 
			String food_category_japanese, String food_category_asian, String food_category_fastfood,String food_category_dessert_drink, 
			String food_category_etc) throws Exception{
		String sql = "";

		// Order BY에서는 PreparedStatement를 사용할 수 없음
		// 정렬 기준만 sql문을 if로 별도로 구분
		if(sortMethod.equals("order_by_distance")) {
			sql = "select * from "
					+ "(select store.*, row_number() over(order by distance asc) row_num from store where name like ? and pricerange like ? and category in (?,?,?,?,?,?,?,?)) "
					+ "where row_num between ? and ?";
		}else if(sortMethod.equals("order_by_score")){
			sql = "select * from "
					+ "(select store.*, row_number() over(order by avgscore desc) row_num from store where name like ? and pricerange like ? and category in (?,?,?,?,?,?,?,?)) "
					+ "where row_num between ? and ?";
		}else if(sortMethod.equals("order_by_review")) {
			sql = "select * from "
					+ "(select store.storeid, count(*), row_number() over(order by count(commentreview.reviewid) desc) row_num from store "
					+ "left outer join commentreview on store.storeid = commentreview.storeid where name like ? and pricerange like ? and category in (?,?,?,?,?,?,?,?) group by store.storeid) "
					+ "top_stores inner join store on top_stores.storeid = store.storeid "
					+ "where top_stores.row_num between ? and ?";
		}else {
			sql = "select * from "
					+ "(select store.*, row_number() over(order by storeID desc) row_num from store where name like ? and pricerange like ? and category in (?,?,?,?,?,?,?,?)) "
					+ "where row_num between ? and ?";
		}

		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){

			System.out.println("검색어 : "+search);
			pstat.setString(1,"%"+search+"%");

			if(cost_range.equals("")) {
				pstat.setString(2, "%%");
			}else {
				pstat.setString(2, cost_range);
			}

			if(food_category_korean.equals("true")) {
				pstat.setString(3, "한식");
				System.out.println("한식 확인");
			}else {
				pstat.setString(3, "");
			}

			if(food_category_western.equals("true")) {
				pstat.setString(4, "양식");
			}else {
				pstat.setString(4, "");
			}

			if(food_category_chinese.equals("true")) {
				pstat.setString(5, "중식");
			}else {
				pstat.setString(5, "");
			}

			if(food_category_japanese.equals("true")) {
				pstat.setString(6, "일식");
			}else {
				pstat.setString(6, "");
			}

			if(food_category_asian.equals("true")) {
				pstat.setString(7, "아시안");
			}else {
				pstat.setString(7, "");
			}

			if(food_category_fastfood.equals("true")) {
				pstat.setString(8, "패스트푸드");
			}else {
				pstat.setString(8, "");
			}

			if(food_category_dessert_drink.equals("true")) {
				pstat.setString(9, "디저트/음료");
			}else {
				pstat.setString(9, "");
			}

			if(food_category_etc.equals("true")) {
				pstat.setString(10, "기타");
			}else {
				pstat.setString(10, "");
			}

			pstat.setInt(11, start_Record_Row_Num);
			pstat.setInt(12, end_Record_Row_Num);
			try (	ResultSet rs = pstat.executeQuery();){
				return transAllRsToList(rs);
			}
		}
	}

	//	필터 검색 네비게이터
	public String getNavi_BySearchFilter(int currentpage, String search, String searchedBy, String sortMethod, String cost_range, String food_category_korean, 
			String food_category_western, String food_category_chinese, String food_category_japanese, String food_category_asian, String food_category_fastfood, 
			String food_category_dessert_drink, String food_category_etc) throws Exception{

		int record_total_count = getSearchdStore_RecordCount_BySearchFilter(search, cost_range, food_category_korean, food_category_western, 
				food_category_chinese, food_category_japanese, food_category_asian, food_category_fastfood, food_category_dessert_drink, food_category_etc);
		int record_count_per_page = 0;
		int navi_count_per_page = 0;
		System.out.println("리스트 전체 글 개수 : "+record_total_count);
		if(searchedBy.equals("mainSearch")) {
			record_count_per_page = Settings.SEARCH_STORE_RECORD_COUNT_PER_PAGE; // 15
			navi_count_per_page = Settings.SEARCH_STORE_NAVI_COUNT_PER_PAGE; // 10
		}else if(searchedBy.equals("mapSearch")) {
			record_count_per_page = Settings.SEARCH_STORE_TO_MAP_RECORD_COUNT_PER_PAGE; // 5
			navi_count_per_page = Settings.SEARCH_STORE_TO_MAP_NAVI_COUNT_PER_PAGE; // 10
		}

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
					+ "			<a href='/searchStoreBySearchFilter.store?cpage="+(startNavi-1)+"&search="+search+"'>"
					+ "				<button type='button' class='navigator_direction_btn'>"
					+ "					<i class='fa-solid fa-angle-left'></i>"
					+ "				</button>"
					+ "			</a>"
					+ "		</div>"
					+ "</li>");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<a class='naviItem' href='/searchStoreBySearchFilter.store?cpage="+i+"&search="+search+"'>"
					+ "			<div class='navigator_list_item_btn_layout'>"+i+"</div>"
					+ "		</a>"
					+ "</li>");
		}
		if(needNext) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<a href='/searchStoreBySearchFilter.store?cpage="+(endNavi+1)+"&search="+search+"'>"
					+ "				<button type='button' class='navigator_direction_btn'>"
					+ "					<i class='fa-solid fa-angle-right'></i>"
					+ "				</button>"
					+ "			</a>"
					+ "		</div>"
					+ "</li>");
		}
		return sb.toString();

	}

	//	필터 검색 Record 수 
	public int getSearchdStore_RecordCount_BySearchFilter(String search, String cost_range, String food_category_korean, String food_category_western, 
			String food_category_chinese, String food_category_japanese, String food_category_asian, String food_category_fastfood, 
			String food_category_dessert_drink, String food_category_etc) throws Exception{
		String sql = "select count(*) from store where name like ? and pricerange like ? and category in (?,?,?,?,?,?,?,?)";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,"%"+search+"%");

			if(cost_range.equals("")) {
				pstat.setString(2, "%%");
			}else {
				pstat.setString(2, cost_range);
			}

			if(food_category_korean.equals("true")) {
				pstat.setString(3, "한식");
			}else {
				pstat.setString(3, "");
			}

			if(food_category_western.equals("true")) {
				pstat.setString(4, "양식");
			}else {
				pstat.setString(4, "");
			}

			if(food_category_chinese.equals("true")) {
				pstat.setString(5, "중식");
			}else {
				pstat.setString(5, "");
			}

			if(food_category_japanese.equals("true")) {
				pstat.setString(6, "일식");
			}else {
				pstat.setString(6, "");
			}

			if(food_category_asian.equals("true")) {
				pstat.setString(7, "아시안");
			}else {
				pstat.setString(7, "");
			}

			if(food_category_fastfood.equals("true")) {
				pstat.setString(8, "패스트푸드");
			}else {
				pstat.setString(8, "");
			}

			if(food_category_dessert_drink.equals("true")) {
				pstat.setString(9, "디저트/음료");
			}else {
				pstat.setString(9, "");
			}

			if(food_category_etc.equals("true")) {
				pstat.setString(10, "기타");
			}else {
				pstat.setString(10, "");
			}
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}

	public List<StoreDTO> selectAll(List<FavoritePageDTO> FavoriteStoreList) throws Exception {
		String sql = "select * from STORE where STOREID = ?";
		List<StoreDTO> result = new ArrayList<>();
		for(FavoritePageDTO favorite : FavoriteStoreList) {
			try(	Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setInt(1, favorite.getStoreID());
				try(ResultSet rs = pstat.executeQuery();){
					while(rs.next()) {
						int storeID = rs.getInt("STOREID");
						int distance = rs.getInt("DISTANCE");
						String name = rs.getString("NAME");
						double lat = rs.getDouble("LAT");
						double lng = rs.getDouble("LNG");
						String address = rs.getString("ADDRESS");
						double avgScore = rs.getDouble("AVGSCORE");
						String introduction = rs.getString("INTRODUCTION");
						String category = rs.getString("CATEGORY");
						int reviewCount = rs.getInt("REVIEWCOUNT"); 
						String priceRange = rs.getString("priceRange");
						result.add(new StoreDTO(storeID, distance, name, lat, lng, address, avgScore, introduction, category, reviewCount,priceRange));
					}
				}
			}
		}
		return result;
	}

	// 즐겨찾기된 가게 정보들 조회
	public String selectFavoriteStoreToJSP(int userno, int start_Record_Row_Num, int end_Record_Row_Num) throws Exception {
		String sql = "select * from "
				+ "(select store.*,row_number() over (order by store.storeid desc) row_num "
				+ "from store join favoritepage on store.storeid = favoritepage.storeid where userno = ?)"
				+ "where row_num between ? and ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, userno);
			pstat.setInt(2, start_Record_Row_Num);
			pstat.setInt(3, end_Record_Row_Num);

			try(ResultSet rs = pstat.executeQuery();){
				StringBuilder sb = new StringBuilder();
				while(rs.next()) {
					sb.append("<tr>");
					sb.append("<td>"+rs.getInt("STOREID")+"</td>");
					sb.append("<td><a href='view.store?storeID="+rs.getInt("STOREID")+"'>"+rs.getString("NAME")+"</a></td>");
					sb.append("<td>"+rs.getString("ADDRESS")+"</td>");
					sb.append("<td>"+rs.getString("CATEGORY")+"</td>");
					sb.append("<td>"+rs.getDouble("AVGSCORE")+"</td>");
					sb.append("</tr>");
				}
				return sb.toString();
			}
		}
	}

	// 즐겨찾기 리스트 네비게이터
	public String selectFavoriteStoreNaviToJSP(int userno, int currentpage) throws Exception {
		int record_total_count = getFavoriteStoreRecordCount(userno);
		int record_count_per_page = Settings.MYPAGE_LIST_RECORD_COUNT_PER_PAGE;
		int navi_count_per_page = Settings.MYPAGE_LIST_NAVI_COUNT_PER_PAGE;

		System.out.println(record_total_count);

		int page_total_count = 0;

		if(record_total_count%record_count_per_page==0) {
			page_total_count = record_total_count/record_count_per_page;
		}else {	
			page_total_count = (record_total_count/record_count_per_page)+1;
		}

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
					+ "			<button class='navibtn navigator_direction_btn' searchto='FavoriteStoreList' location='"+(startNavi-1)+"'>"
					+ "				<i class='fa-solid fa-angle-left'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		for(int i = startNavi ; i <= endNavi ; i++) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn item' searchto='FavoriteStoreList' location='"+i+"'>"+i+"</button>"
					+ "		</div>"
					+ "</li>");
		}
		if(needNext) {
			sb.append("<li class='navigator_list_item'>"
					+ "		<div class='navigator_list_item_btn_layout'>"
					+ "			<button class='navibtn navigator_direction_btn' searchto='FavoriteStoreList' location='"+(endNavi+1)+"'>"
					+ "				<i class='fa-solid fa-angle-right'></i>"
					+ "			</button>"
					+ "		</div>"
					+ "</li>");
		}
		return sb.toString();
	}
	// 즐겨찾기 리스트 Record 수
	public int getFavoriteStoreRecordCount(int userno) throws Exception{
		String sql = "select count(*) from favoritepage where userno = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1,userno);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
	}


	// 마지막 storeid 가져오기
	public int getLastStoreID() throws Exception{
		String sql = "select * from store order by storeid desc";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt("storeid");
		}
	}

	public boolean isValidStoreID(int storeID) throws Exception {
		String sql = "select * from STORE where STOREID = ?";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, storeID);
			try(ResultSet rs = pstat.executeQuery();){
				return rs.next();
			}
		}
	}

	public List<StoreDTO> selectAll(String search) throws Exception {
		String sql = "select * from STORE where name like ? order by storeid asc";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, "%"+search+"%");
			try(ResultSet rs = pstat.executeQuery();){
				return transAllRsToList(rs);
			}
		}
	}

	public List<StoreDTO> selectAll(String search, String cost_range, String food_category_korean, String food_category_western, 
			String food_category_chinese, String food_category_japanese, String food_category_asian, String food_category_fastfood, 
			String food_category_dessert_drink, String food_category_etc) throws Exception {
		String sql = "select * from STORE where name like ? and pricerange like ? and category in (?,?,?,?,?,?,?,?) order by storeid asc";
		try(	Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1,"%"+search+"%");

			if(cost_range.equals("")) {
				pstat.setString(2, "%%");
			}else {
				pstat.setString(2, cost_range);
			}

			if(food_category_korean.equals("true")) {
				pstat.setString(3, "한식");
			}else {
				pstat.setString(3, "");
			}

			if(food_category_western.equals("true")) {
				pstat.setString(4, "양식");
			}else {
				pstat.setString(4, "");
			}

			if(food_category_chinese.equals("true")) {
				pstat.setString(5, "중식");
			}else {
				pstat.setString(5, "");
			}

			if(food_category_japanese.equals("true")) {
				pstat.setString(6, "일식");
			}else {
				pstat.setString(6, "");
			}

			if(food_category_asian.equals("true")) {
				pstat.setString(7, "아시안");
			}else {
				pstat.setString(7, "");
			}

			if(food_category_fastfood.equals("true")) {
				pstat.setString(8, "패스트푸드");
			}else {
				pstat.setString(8, "");
			}

			if(food_category_dessert_drink.equals("true")) {
				pstat.setString(9, "디저트/음료");
			}else {
				pstat.setString(9, "");
			}

			if(food_category_etc.equals("true")) {
				pstat.setString(10, "기타");
			}else {
				pstat.setString(10, "");
			}
			try(ResultSet rs = pstat.executeQuery();){
				return transAllRsToList(rs);
			}
		}
	}
}
