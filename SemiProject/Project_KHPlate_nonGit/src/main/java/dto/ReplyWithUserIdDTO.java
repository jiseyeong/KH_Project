package dto;

public class ReplyWithUserIdDTO {
	private String userid;
	private int commentid;
	private String body;
	private int userno;
	private int reviewid;
	
	public ReplyWithUserIdDTO() {
		super();
	}
	public ReplyWithUserIdDTO(String userid, int commentid, String body, int userno, int reviewid) {
		super();
		this.userid = userid;
		this.commentid = commentid;
		this.body = body;
		this.userno = userno;
		this.reviewid = reviewid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getCommentid() {
		return commentid;
	}
	public void setCommentid(int commentid) {
		this.commentid = commentid;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public int getUserno() {
		return userno;
	}
	public void setUserno(int userno) {
		this.userno = userno;
	}
	public int getReviewid() {
		return reviewid;
	}
	public void setReviewid(int reviewid) {
		this.reviewid = reviewid;
	}
}
