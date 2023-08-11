package dto;

import java.sql.Timestamp;

public class CommentReviewDTO {
	private int reviewID;
	private String body;
	private int score;
	private int storeID;
	private int userNo;
	private Timestamp writeDate;
	private int totalLike;

	public CommentReviewDTO() {
		super();
	}

	public CommentReviewDTO(int reviewID, String body, int score, int storeID, int userNo, Timestamp writeDate,
			int totalLike) {
		super();
		this.reviewID = reviewID;
		this.body = body;
		this.score = score;
		this.storeID = storeID;
		this.userNo = userNo;
		this.writeDate = writeDate;
		this.totalLike = totalLike;
	}

	public int getReviewID() {
		return reviewID;
	}

	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
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

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public Timestamp getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}

	public int getTotalLike() {
		return totalLike;
	}

	public void setTotalLike(int totalLike) {
		this.totalLike = totalLike;
	}

	public double ratingToPercent() {
		double score = this.score * 20;
		return score;
	}
}
