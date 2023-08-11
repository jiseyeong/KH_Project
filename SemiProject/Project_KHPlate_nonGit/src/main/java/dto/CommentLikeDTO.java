package dto;

public class CommentLikeDTO {

	private String likeID;
	private String isLike;
	private int storeID;
	private int userNO;

	public CommentLikeDTO() {
		super();
	}

	public CommentLikeDTO(String likeID, String isLike, int storeID, int userNO) {
		super();
		this.likeID = likeID;
		this.isLike = isLike;
		this.storeID = storeID;
		this.userNO = userNO;
	}

	public String getLikeID() {
		return likeID;
	}

	public void setLikeID(String likeID) {
		this.likeID = likeID;
	}

	public String getIsLike() {
		return isLike;
	}

	public void setIsLike(String isLike) {
		this.isLike = isLike;
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

}
