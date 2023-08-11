package dto;

public class FullReviewScrapDTO {
	
	private int scrapID;
	private int reviewID;
	private int userNO;
	
	public FullReviewScrapDTO() {
		super();
	}

	public FullReviewScrapDTO(int scrapID, int reviewID, int userNO) {
		super();
		this.scrapID = scrapID;
		this.reviewID = reviewID;
		this.userNO = userNO;
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
	
	
	
}
