package dto;

public class PhotoDTO {
	private int imageID;
	private String oriName;
	private String sysName;
	
	
	
	public PhotoDTO() {
		super();
	}
	public PhotoDTO(int imageID, String oriName, String sysName) {
		super();
		this.imageID = imageID;
		this.oriName = oriName;
		this.sysName = sysName;
	}
	public int getImageID() {
		return imageID;
	}
	public void setImageID(int imageID) {
		this.imageID = imageID;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}
	public String getSysName() {
		return sysName;
	}
	public void setSysName(String sysName) {
		this.sysName = sysName;
	}
}
