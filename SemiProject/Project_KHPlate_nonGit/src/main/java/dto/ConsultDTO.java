package dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ConsultDTO {

	private int consultID;
	private String title;
	private String body;
	private int userNO;
	private Timestamp writedate;
	private String category;
	private String reply;

	public ConsultDTO() {
		super();
	}


	public ConsultDTO(int consultID, String title, String body, int userNO, Timestamp writedate, String category,
			String reply) {
		super();
		this.consultID = consultID;
		this.title = title;
		this.body = body;
		this.userNO = userNO;
		this.writedate = writedate;
		this.category = category;
		this.reply = reply;
	}



	public int getConsultID() {
		return consultID;
	}

	public void setConsultID(int consultID) {
		this.consultID = consultID;
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

	public int getUserNO() {
		return userNO;
	}

	public void setUserNO(int userNO) {
		this.userNO = userNO;
	}

	public Timestamp getWritedate() {
		return writedate;
	}

	public void setWritedate(Timestamp writedate) {
		this.writedate = writedate;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}
	
	public String getWritedateToString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  hh:mm");
		return sdf.format(writedate);
	}
}
