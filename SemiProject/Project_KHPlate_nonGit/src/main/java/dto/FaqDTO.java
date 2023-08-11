package dto;

public class FaqDTO {
	
	private int qaID;
	private String title;
	private String body;
	
	public FaqDTO() {
		super();
	}

	public FaqDTO(int qaID, String title, String body) {
		super();
		this.qaID = qaID;
		this.title = title;
		this.body = body;
	}

	public int getQaID() {
		return qaID;
	}

	public void setQaID(int qaID) {
		this.qaID = qaID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}
}
