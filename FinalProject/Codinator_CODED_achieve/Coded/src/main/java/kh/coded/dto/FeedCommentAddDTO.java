package kh.coded.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class FeedCommentAddDTO {
    private int feedCommentId;
    private int userNo;
    private int feedPostId;
    private int parentId;
    private String body;
    private Timestamp writeDate;
    private int depth;
    
    private String userId;
    private String userNickName;
    private String sysName;
    
	public FeedCommentAddDTO() {
		super();
	}

	public FeedCommentAddDTO(int feedCommentId, int userNo, int feedPostId, int parentId, String body,
			Timestamp writeDate, int depth, String userId, String userNickName, String sysName) {
		super();
		this.feedCommentId = feedCommentId;
		this.userNo = userNo;
		this.feedPostId = feedPostId;
		this.parentId = parentId;
		this.body = body;
		this.writeDate = writeDate;
		this.depth = depth;
		this.userId = userId;
		this.userNickName = userNickName;
		this.sysName = sysName;
	}

	public int getFeedCommentId() {
		return feedCommentId;
	}

	public void setFeedCommentId(int feedCommentId) {
		this.feedCommentId = feedCommentId;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getFeedPostId() {
		return feedPostId;
	}

	public void setFeedPostId(int feedPostId) {
		this.feedPostId = feedPostId;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public Timestamp getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getSysName() {
		return sysName;
	}

	public void setSysName(String sysName) {
		this.sysName = sysName;
	}
	
	public String getFormedWriteDate() {
		long diff_date = (System.currentTimeMillis() - this.writeDate.getTime())/1000;
		
		if(diff_date < 60) {
			return "방금 전";
		}else if(diff_date < 60 * 5) {
			return "5분 이내";
		}else if(diff_date < 60 * 60) {
			return "1시간 이내";
		}else if(diff_date < 60 * 60 * 24) {
			return Long.toString(diff_date / (60 * 60)) + "시간 이내"; 
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일");
		return sdf.format(writeDate);
	}
    
}
