package dto;

public class MembersDTO {

	private int userNO;
	private String userID;
	private String pw;
	private String nickname;
	private String name;
	private String email;
	private String classes;
	private String selfcomment;
	private String favoriteFood;
	private String isAdmin;
	private String kakao;
	private String naver;
	
	public MembersDTO() {
		super();
	}

	public MembersDTO(int userno, String nickname,String email,
					  String selfcomment, String favoriteFood) {
		//마이페이지에서 회원정보 수정할때 받을 DTO

		this.userNO = userno;
		this.nickname = nickname;
		this.email = email;
		this.selfcomment = selfcomment;
		this.favoriteFood = favoriteFood;
	}
	
	public MembersDTO(String userID, String pw, String nickname,String name, String email,
			String classes, String selfcomment, String favoriteFood) {//회원가입할때 받을 DTO

		this.userID = userID;
		this.pw = pw;
		this.nickname = nickname;
		this.name = name;
		this.email = email;
		this.classes = classes;
		this.selfcomment = selfcomment;
		this.favoriteFood = favoriteFood;


	}
	
	public MembersDTO(int userno, String userID, String pw, String nickname,String name, String email,
			String classes, String selfcomment, String favoriteFood) {//회원가입할때 받을 DTO
		
		this.userNO = userno;
		this.userID = userID;
		this.pw = pw;
		this.nickname = nickname;
		this.name = name;
		this.email = email;
		this.classes = classes;
		this.selfcomment = selfcomment;
		this.favoriteFood = favoriteFood;


	}
	
	public MembersDTO(int userNO, String userID, String pw, String nickname, String name, String email,
			String classes, String selfcomment, String favoriteFood, String isAdmin, String kakao, String naver) {
		super();
		this.userNO = userNO;
		this.userID = userID;
		this.pw = pw;
		this.nickname = nickname;
		this.name = name;
		this.email = email;
		this.classes = classes;
		this.selfcomment = selfcomment;
		this.favoriteFood = favoriteFood;
		this.isAdmin = isAdmin;
		this.kakao = kakao;
		this.naver = naver;
	}

	public int getUserNO() {
		return userNO;
	}

	public void setUserNO(int userNO) {
		this.userNO = userNO;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getClasses() {
		return classes;
	}

	public void setClasses(String classes) {
		this.classes = classes;
	}

	public String getSelfcomment() {
		return selfcomment;
	}

	public void setSelfcomment(String selfcomment) {
		this.selfcomment = selfcomment;
	}

	public String getFavoriteFood() {
		return favoriteFood;
	}

	public void setFavoriteFood(String favoriteFood) {
		this.favoriteFood = favoriteFood;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}


	public String getKakao() {
		return kakao;
	}

	public void setKakao(String kakao) {
		this.kakao = kakao;
	}

	public String getNaver() {
		return naver;
	}

	public void setNaver(String naver) {
		this.naver = naver;
	}
}
