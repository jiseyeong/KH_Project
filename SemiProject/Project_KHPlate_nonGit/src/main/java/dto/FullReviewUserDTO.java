package dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

// FullReviewDTO와 MembersDTO를 합친 DTO

public class FullReviewUserDTO {
	private int reviewID;
	private String title;
	private String reviewBody;
	private int score;
	private int storeID;
	private int userNO;
	private Timestamp writedate;
	
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
	
	public FullReviewUserDTO() {
		super();
	}
	
	public FullReviewUserDTO(int reviewID, int score, int storeID, int userno, Timestamp writedate, String title, String userID, String nickname) {
		super();
		this.reviewID = reviewID;
		this.score = score;
		this.storeID = storeID;
		this.userNO = userno;
		this.writedate = writedate;
		this.title = title;
		this.userID = userID;
		this.nickname = nickname;
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
	
	public int getReviewID() {
		return reviewID;
	}

	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
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

	public int getUserNO() {
		return userNO;
	}

	public void setUserNO(int userNO) {
		this.userNO = userNO;
	}

	public Timestamp getWritedate() {
		return writedate;
	}

	public void setWritedate(Timestamp writedate) {
		this.writedate = writedate;
	}
	
	public String getWritedateToString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  hh:mm");
		return sdf.format(writedate);
	}
}
