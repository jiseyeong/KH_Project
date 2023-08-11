package dto;

public class StoreMenuDTO {
	
	private int menuID;
	private String menuName;
	private int menuPrice;
	private int storeID;
	
	public StoreMenuDTO() {
		super();
	}

	public StoreMenuDTO(int menuID, String menuName, int menuPrice, int storeID) {
		super();
		this.menuID = menuID;
		this.menuName = menuName;
		this.menuPrice = menuPrice;
		this.storeID = storeID;
	}

	public int getMenuID() {
		return menuID;
	}

	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public int getMenuPrice() {
		return menuPrice;
	}

	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}

	public int getStoreID() {
		return storeID;
	}

	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}
	
	
	
}
