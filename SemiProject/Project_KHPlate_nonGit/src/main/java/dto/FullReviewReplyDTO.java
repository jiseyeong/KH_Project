package dto;

public class FullReviewReplyDTO {
	
	private int commentID;
	private String body;
	private int userNO;
	private int reviewID;
	
	public FullReviewReplyDTO() {
		super();
	}

	public FullReviewReplyDTO(int commentID, String body, int userNO, int reviewID) {
		super();
		this.commentID = commentID;
		this.body = body;
		this.userNO = userNO;
		this.reviewID = reviewID;
	}

	public int getCommentID() {
		return commentID;
	}

	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public int getUserNO() {
		return userNO;
	}

	public void setUserNO(int userNO) {
		this.userNO = userNO;
	}

	public int getReviewID() {
		return reviewID;
	}

	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}
	
	
	
}
