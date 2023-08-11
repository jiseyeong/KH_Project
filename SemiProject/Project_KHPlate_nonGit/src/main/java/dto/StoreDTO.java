package dto;

public class StoreDTO {
	private int storeID;
	private int distance;
	private String name;
	private double lat;
	private double lng;
	private String address;
	private double avgScore;
	private String introduction;
	private String category;
	private int reviewCount;
	private String priceRange;

	public StoreDTO() {
		super();
	}

	public StoreDTO(int storeID, int distance, String name, double lat, double lng, String address, double avgScore,
			String introduction, String category, int reviewCount, String priceRange) {
		super();
		this.storeID = storeID;
		this.distance = distance;
		this.name = name;
		this.lat = lat;
		this.lng = lng;
		this.address = address;
		this.avgScore = avgScore;
		this.introduction = introduction;
		this.category = category;
		this.reviewCount = reviewCount;
		this.priceRange = priceRange;
	}

	public int getStoreID() {
		return storeID;
	}

	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
	
	public String getPriceRange() {
		return priceRange;
	}

	public void setPriceRange(String priceRange) {
		this.priceRange = priceRange;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public double ratingToPercent() {
		double score = this.avgScore * 20;
		return score;
	}
}
