package controllers;
import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import commons.Gmail;
import commons.SecurityUtils;
import dao.MembersDAO;
import dao.PhotoDAO;
import dto.MembersDTO;
import dto.PhotoDTO;



@WebServlet("*.members")
public class MembersController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8"); 
		String cmd = request.getRequestURI();
		System.out.println(cmd);
		Gson g = new Gson();

		try {
			MembersDAO dao = MembersDAO.getInstance();
			
				// 가입 확인 후 이메일 인증 절차로 보내는 controller
			if(cmd.equals("/join.members")) {
				String userid = request.getParameter("id");
				String pw = request.getParameter("pw");
				String sha512pw = SecurityUtils.sha512(pw);
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String classes = request.getParameter("classes");
				
				int result = dao.join(userid,sha512pw,name,email,classes);
				
				if(result>0) {
					System.out.println(userid +" 회원가입 완료");
					request.setAttribute("userid", userid);
					request.setAttribute("email", email);
					request.getRequestDispatcher("/emailSend.members").forward(request, response);
				}else {
					System.out.println(userid +" 회원가입 실패");
				}

				// 인증 이메일 보내는 Controller
			}else if(cmd.equals("/emailSend.members")) {
				String userid = (String) request.getAttribute("userid");
				String email = (String) request.getAttribute("email");

				String host = "http://khplate.duckdns.org:8090/";
				String from = "khplatesemi@gmail.com";
				String to = email;
				String subject ="이메일 인증 입니다";
				String content = "다음 링크에 접속하여 이메일인증을 진행하세요" +
						"<br><a href='" + host + "emailVerified.members?code="+ SecurityUtils.sha512(userid)+ "'>이메일 인증하기</a>";

				// [ SMTP 서버 정보 설정 ]
				Properties p = new Properties();
				// 로그인시 TLS를 사용할 것인지 설정
				p.put("mail.smtp.starttls.enable", "true");

				// TLS의 포트번호는 587이며 SSL의 포트번호는 465이다.
				p.put("mail.smtp.port", "587");

				// TLS 버전을 지정, TLS 버전 1.0 이나 1.1은 주요 브라우저에서 지원 중단하였다.
				p.put("mail.smtp.ssl.protocols", "TLSv1.2");

				// 이메일 발송을 처리해줄 SMTP서버
				p.put("mail.smtp.host", "smtp.gmail.com");

				// SMTP 서버의 인증을 사용한다는 의미
				p.put("mail.smtp.auth", "true");

				Authenticator auth = new Gmail();
				Session ses = Session.getInstance(p,auth);
				ses.setDebug(true);
				MimeMessage msg = new MimeMessage(ses);
				msg.setSubject(subject);
				Address fromAddr = new InternetAddress(from);
				msg.setFrom(fromAddr);
				Address toAddr = new InternetAddress(to);
				msg.addRecipient(Message.RecipientType.TO,toAddr);
				msg.setContent(content,"text/html;charset=UTF8");
				Transport.send(msg);
				// 이메일 전송 완료

				// 이후 가입 완료 페이지 띄우고 이메일 인증 절차 요구
				request.setAttribute("userid", userid);
				request.setAttribute("email", email);
				request.getRequestDispatcher("/joinform/needEmailVerify.jsp").forward(request, response);
				
				// 인증 이메일 링크 접속 시 controller 수행
			}else if(cmd.equals("/emailVerified.members")) {
				String code = request.getParameter("code");
				
				// code에 해당하는 유저 정보 추출
				String userid = dao.getUserEmailVerified(code);
				
				if(userid.equals("")) {
					System.out.println("인증실패");
				}else {
					System.out.println("인증성공");
					
					// 이메일 인증 확인 dao
					int result = dao.updateuserEmailChecked(userid);
					
					// 이후 인증완료 페이지로 이동
					request.setAttribute("userid", userid);
					request.getRequestDispatcher("/joinform/joinComplete.jsp").forward(request, response);
				}

				
				
			}else if(cmd.equals("/update.members")) {
				
				int userno = (int)request.getSession().getAttribute("userno");
				String nickname = request.getParameter("nickname");
				String email = request.getParameter("email");
				String selfcomment = request.getParameter("selfcomment");
				String favoriteFood = request.getParameter("favoriteFood");
				
				int result = dao.update(new MembersDTO(userno,nickname,email,selfcomment,favoriteFood));
				
				if(result>0) {
					request.setAttribute("modyInfo", true);
				}
				request.getRequestDispatcher("/mypage.members").forward(request, response);

			}else if(cmd.equals("/memberout.members")) { 
				
				String userId = request.getParameter("userId");
				String userPw = SecurityUtils.sha512(request.getParameter("userPw"));
				
				// ID 체크
				boolean idCheck = dao.isIdExist(userId);
				
				if(!idCheck) {
					response.getWriter().append("1");
					return;
				}
				
				// 비밀번호 체크
				boolean pwCheck = dao.isPwExist(userId, userPw);
				
				if(!pwCheck) {
					response.getWriter().append("2");
					return;
					
				}else {
//					회원탈퇴한 유저 인지 체크
					int result = dao.memberout(userId,userPw);
					if(result>0) {
						request.getSession().removeAttribute("userId");
						request.getSession().removeAttribute("userno");
						request.getSession().removeAttribute("loginIsAdmin");
						if(request.getSession().getAttribute("naverid")!=null) {
							request.getSession().removeAttribute("naverid");
							request.setAttribute("naverLogin", true);
						}
						if(request.getSession().getAttribute("kakaoid")!=null) {
							request.getSession().removeAttribute("kakaoid");
							request.setAttribute("kakaoLogin", true);
						}
						response.getWriter().append("3");
						return;
					}
				}
				
				//프로필사진 ajax
			}else if (cmd.equals("/profilePicUpdate.members")) {

				String realPath = request.getServletContext().getRealPath("mypagepic");
				int maxSize = 1024 * 1024 * 10;
				System.out.println(realPath);
				File realPathFile = new File(realPath);
				if(!realPathFile.exists()) {
					realPathFile.mkdir();
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf8", new DefaultFileRenamePolicy());

				int userNo= Integer.parseInt(multi.getParameter("userNo"));
				System.out.println("유저넘버"+userNo);
				Enumeration<String> names = multi.getFileNames();
				
				PhotoDAO.getInstance().deleteByuserno(userNo);
				
				while(names.hasMoreElements()) {
					String fileName = names.nextElement();
					System.out.println(fileName);
					if(multi.getFile(fileName) != null){
						String oriName = multi.getOriginalFileName(fileName);
						String sysName = multi.getFilesystemName(fileName);
						PhotoDAO.getInstance().insertByuserNo(oriName,sysName,userNo);
						System.out.println("DB입력됨");
					}
				}
				
				PhotoDTO pdto = PhotoDAO.getInstance().selectByuserNo(userNo);
				String photodto = g.toJson(pdto);
				response.getWriter().append(photodto);
				
				
				
			}else if(cmd.equals("/mypage.members")) {
				int userno = 0;
				// 다른 사람의 유저 정보로 접근 할 때,
				if(request.getParameter("userno")!=null) {
					userno = Integer.parseInt(request.getParameter("userno"));
				// 마이 페이지로 접근 할 때,
				}else {
					userno = (int)request.getSession().getAttribute("userno");
				}
				MembersDTO my = MembersDAO.getInstance().selectById(userno);
				PhotoDTO profileImage = PhotoDAO.getInstance().selectByUserno(userno);
				request.setAttribute("my",my);
				request.setAttribute("profileImage", profileImage);
				if(request.getAttribute("modyInfo")!=null) {
					request.getRequestDispatcher("/mypage/myPageVer2.jsp?modyInfo=true").forward(request, response);
				}else
				request.getRequestDispatcher("/mypage/myPageVer2.jsp").forward(request, response);
				
				// 로그인 기능 AJAX
			}else if(cmd.equals("/login.members")) {
				String userId = request.getParameter("id");
				String pw = request.getParameter("password");
				String EncryptionPw = SecurityUtils.sha512(pw);
				
				// ID 체크
				boolean idCheck = dao.isIdExist(userId);
				
				if(!idCheck) {
					System.out.println("아이디가 틀렸습니다.");
					response.getWriter().append("1");
					return;
				}
				
				// 비밀번호 체크
				boolean pwCheck = dao.isPwExist(userId, EncryptionPw);
				
				if(!pwCheck) {
					System.out.println("비밀번호가 틀렸습니다.");
					response.getWriter().append("2");
					return;
					
				}
				boolean emailVerify = dao.emailVerify(userId);
				
				if(!emailVerify) {	
					System.out.println("이메일 미인증");
					response.getWriter().append("3");
					return;
				}else {
					System.out.println("로그인에 성공하였습니다.");
					request.getSession().setAttribute("userId", userId);
					int userno = dao.getUserno(userId);
					request.getSession().setAttribute("userno", userno);
					request.getSession().setAttribute("loginIsAdmin", dao.getIsAdminByNo(userno));
					response.getWriter().append("4");
					return;
				}
			}
				// 로그아웃 시 세션에 저장된 유저넘버와 유저ID를 삭제
			else if(cmd.equals("/logout.members")) {
				request.getSession().removeAttribute("userId");
				request.getSession().removeAttribute("userno");
				request.getSession().removeAttribute("loginIsAdmin");
				if(request.getSession().getAttribute("naverid")!=null) {
					request.getSession().removeAttribute("naverid");
					request.setAttribute("naverLogin", true);
				}
				if(request.getSession().getAttribute("kakaoid")!=null) {
					request.getSession().removeAttribute("kakaoid");
					request.setAttribute("kakaoLogin", true);
				}
				request.getRequestDispatcher("/page/main.jsp").forward(request, response);
			}
			
			else if(cmd.equals("/IdCheck.members")) {
				String id = request.getParameter("id");
				System.out.println("입력 id = " + id);
				boolean result;
				if(id.isBlank()) {
					result = true;
				}else {
					result = dao.isIdExist(id);
				}
				request.setAttribute("result", result);
				request.getRequestDispatcher("/joinform/isIdExist.jsp").forward(request, response);
			}
			
			//
			
			else if (cmd.equals("/idsearch.members")) {
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String userid = dao.idsearch(name,email);
				request.setAttribute("userid", userid);
				request.getRequestDispatcher("/login/idconfirm.jsp").forward(request, response);
			} else if (cmd.equals("/pwsearch.members")) {
				String pwname = request.getParameter("pwname");
				String pwemail = request.getParameter("pwemail");
				String pwid = request.getParameter("pwid");
				String userid = dao.pwsearch(pwname,pwemail,pwid);
				if (userid==null) {
					response.sendRedirect("/login/wrongpw.jsp");
				} else {
					request.setAttribute("userid",userid);
					request.getRequestDispatcher("/memberSearch/newpassword.jsp").forward(request, response);
				}
				
			}else if(cmd.equals("/newpwset.members")) {
				String pw = request.getParameter("pw2");
				String pw2 = SecurityUtils.sha512(pw);
				String userid =request.getParameter("userid"); 
				int result=dao.updatepw(pw2,userid);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/memberSearch/idpwsearch.jsp").forward(request, response);
				
				// 네이버로 로그인
			}else if(cmd.equals("/loginByNaver.members")) {
				String naverid = request.getParameter("naverid");
				String userId = dao.searchNaverID(naverid);
				System.out.println(userId);
				// 네이버 로그인이 처음인지 확인
				if(userId==null||userId.isBlank()) {

					System.out.println("(네이버)미 회원가입 사용자");
					response.getWriter().append("1");
					return;
				}else {
					// 이메일 체크
					boolean emailVerify = dao.emailVerify(userId);
					if(!emailVerify) {	
						System.out.println("(네이버)이메일 미인증");
						response.getWriter().append("2");
						return;
					}else {
						System.out.println("(네이버)로그인 성공");
						request.getSession().setAttribute("userId", userId);
						int userno = dao.getUserno(userId);
						request.getSession().setAttribute("userno", userno);
						request.getSession().setAttribute("loginIsAdmin", dao.getIsAdminByNo(userno));
						request.getSession().setAttribute("naverid", naverid);
						response.getWriter().append("3");
						return;
					}
				}
			}else if(cmd.equals("/loginByKakao.members")) {
				String kakaoid = request.getParameter("kakaoid");
				String userId = dao.searchKakaoID(kakaoid);
				// 네이버 로그인이 처음인지 확인
				if(userId==null||userId.isBlank()) {
					System.out.println("(카카오)미 회원가입 사용자");
					response.getWriter().append("1");
					return;
				}else {
					// 이메일 체크
					boolean emailVerify = dao.emailVerify(userId);
					if(!emailVerify) {	
						System.out.println("(카카오)이메일 미인증");
						response.getWriter().append("2");
						return;
					}else {
						System.out.println("(카카오)로그인 성공");
						request.getSession().setAttribute("userId", userId);
						int userno = dao.getUserno(userId);
						request.getSession().setAttribute("userno", userno);
						request.getSession().setAttribute("loginIsAdmin", dao.getIsAdminByNo(userno));
						request.getSession().setAttribute("kakaoid", kakaoid);
						response.getWriter().append("3");
						return;
					}
				}
			}else if(cmd.equals("/joinWithLoginAPI.members")) {
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String classes = request.getParameter("classes");
				String userid = request.getParameter("id");
				
				// 카카오, 네이버 간편로그인으로 접근 시 추가 등록
				int result = 0;
				if(request.getParameter("naverid")!=null) {
					//userid = request.getParameter("naverid");
					String naverid = request.getParameter("naverid");
					result = dao.joinWithNaver(name,email,classes,naverid, userid);
				}else if(request.getParameter("kakaoid")!=null) {
					//userid = request.getParameter("kakaoid");
					String kakaoid = request.getParameter("kakaoid");
					result = dao.joinWithKakao(name,email,classes,kakaoid,userid);
				}
				
				if(result>0) {
					System.out.println(userid +" 회원가입 완료");
					request.setAttribute("userid", userid);
					request.setAttribute("email", email);
					request.getRequestDispatcher("/emailSend.members").forward(request, response);
				}else {
					System.out.println(userid +" 회원가입 실패");
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
