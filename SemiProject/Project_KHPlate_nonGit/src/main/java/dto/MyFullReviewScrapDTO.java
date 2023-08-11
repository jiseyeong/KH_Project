package dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class MyFullReviewScrapDTO {

	//scrap
	private int scrapID;
	private int reviewID;
	private int userNO;
	
	//fullreview
	private String title;
	private String reviewBody;
	private int score;
	private int storeID;
	private Timestamp writedate;
	
	//member
	private String userID;
	private String pw;
	private String nickname;
	private String name;
	private String email;
	private String phone;
	private String classes;
	private String selfcomment;
	private String favoriteFood;
	private String isAdmin;
	private String kakao;
	private String naver;
	private String google;
	
	//store
	private int distance;
	private String StoreName;
	private double lat;
	private double lng;
	private String address;
	private double avgScore;
	private String introduction;
	private String category;
	private int reviewCount;
	private String priceRange;
	
	public MyFullReviewScrapDTO() {
		
	}
	
	public MyFullReviewScrapDTO(int scrapID, int reviewID, String title, String userID, String StoreName, Timestamp writedate) {
		this.scrapID = scrapID;
		this.reviewID = reviewID;
		this.title = title;
		this.userID = userID;
		this.StoreName = StoreName;
		this.writedate = writedate;
	}
	
	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public String getStoreName() {
		return StoreName;
	}

	public void setStoreName(String storeName) {
		StoreName = storeName;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public double getAvgScore() {
		return avgScore;
	}

	public void setAvgScore(double avgScore) {
		this.avgScore = avgScore;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public String getPriceRange() {
		return priceRange;
	}

	public void setPriceRange(String priceRange) {
		this.priceRange = priceRange;
	}

	public int getScrapID() {
		return scrapID;
	}
	public void setScrapID(int scrapID) {
		this.scrapID = scrapID;
	}
	public int getReviewID() {
		return reviewID;
	}
	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}
	public int getUserNO() {
		return userNO;
	}
	public void setUserNO(int userNO) {
		this.userNO = userNO;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getReviewBody() {
		return reviewBody;
	}
	public void setReviewBody(String reviewBody) {
		this.reviewBody = reviewBody;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getStoreID() {
		return storeID;
	}
	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}
	public Timestamp getWritedate() {
		return writedate;
	}
	public void setWritedate(Timestamp writedate) {
		this.writedate = writedate;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getClasses() {
		return classes;
	}
	public void setClasses(String classes) {
		this.classes = classes;
	}
	public String getSelfcomment() {
		return selfcomment;
	}
	public void setSelfcomment(String selfcomment) {
		this.selfcomment = selfcomment;
	}
	public String getFavoriteFood() {
		return favoriteFood;
	}
	public void setFavoriteFood(String favoriteFood) {
		this.favoriteFood = favoriteFood;
	}
	public String getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}
	public String getKakao() {
		return kakao;
	}
	public void setKakao(String kakao) {
		this.kakao = kakao;
	}
	public String getNaver() {
		return naver;
	}
	public void setNaver(String naver) {
		this.naver = naver;
	}
	public String getGoogle() {
		return google;
	}
	public void setGoogle(String google) {
		this.google = google;
	}
	
	public String getWritedateToString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  hh:mm");
		return sdf.format(writedate);
	}
}
