package dto;

public class FavoritePageDTO {
	
	private int favoriteID;
	private int storeID;
	private int userNO;
	
	public FavoritePageDTO() {
		super();
	}

	public FavoritePageDTO(int favoriteID, int storeID, int userNO) {
		super();
		this.favoriteID = favoriteID;
		this.storeID = storeID;
		this.userNO = userNO;
	}

	public int getFavoriteID() {
		return favoriteID;
	}

	public void setFavoriteID(int favoriteID) {
		this.favoriteID = favoriteID;
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
