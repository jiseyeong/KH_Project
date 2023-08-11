package dto;

import java.sql.Timestamp;

public class FullReviewDTO {
	
	private int reviewID;
	private String title;
	private String reviewBody;
	private int score;
	private int storeID;
	private int userNO;
	private Timestamp writedate;
	
	public FullReviewDTO() {
		super();
	}

	public FullReviewDTO(int reviewID, String title, String reviewBody, int score, int storeID, int userNO, Timestamp writedate) {
		super();
		this.reviewID = reviewID;
		this.title = title;
		this.reviewBody = reviewBody;
		this.score = score;
		this.storeID = storeID;
		this.userNO = userNO;
		this.writedate = writedate;
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
	
	
	
	
}
