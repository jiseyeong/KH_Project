package dto;

public class KhCoordsDTO {
	
	private int KHlat;
	private int KHlng;
	
	public KhCoordsDTO() {
		super();
	}

	public KhCoordsDTO(int kHlat, int kHlng) {
		super();
		KHlat = kHlat;
		KHlng = kHlng;
	}

	public int getKHlat() {
		return KHlat;
	}

	public void setKHlat(int kHlat) {
		KHlat = kHlat;
	}

	public int getKHlng() {
		return KHlng;
	}

	public void setKHlng(int kHlng) {
		KHlng = kHlng;
	}
	
	
	
}
