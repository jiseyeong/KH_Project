package kh.coded.security;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import kh.coded.dto.MemberDTO;

@Component
public class JwtProvider {
	@Value("${jwt.secret.key}")
	private String salt;
//	@Autowired
//	private MemberService memberService;
	
	private Key secretKey;
	private static final long ACCESS_TIME = 1000L * 60 * 30; // 30분
	private static final long REFRESH_TIME = 1000L * 7 * 24 * 60 * 60; // 7일 
	private static final String PRE_WORD = "Bearer ";
	
	@PostConstruct
	protected void init() {
		secretKey = Keys.hmacShaKeyFor(salt.getBytes(StandardCharsets.UTF_8));
	}
	
	public String createLoginAccessToken(MemberDTO member) {
//		MemberDTO member = memberService.selectByID(userId);
		Claims claims = Jwts.claims().setSubject(Integer.toString(member.getUserNo()));
		claims.put("userId", member.getUserId());
		Date now = new Date();
		return Jwts.builder()
				.setHeaderParam(Header.TYPE, Header.JWT_TYPE)
				.setIssuer("Coded Site")
				.setIssuedAt(now)
				.setExpiration(new Date(now.getTime() + ACCESS_TIME))
				.setClaims(claims)
				.signWith(secretKey, SignatureAlgorithm.HS256)
				.compact();
	}
	
	public String createLoginRefreshToken(MemberDTO member) {
		Date now = new Date();
		return Jwts.builder()
				.setHeaderParam(Header.TYPE, Header.JWT_TYPE)
				.setIssuer("Coded Site")
				.setIssuedAt(now)
				.setExpiration(new Date(now.getTime() + REFRESH_TIME))
				.setSubject(Integer.toString(member.getUserNo()))
				.signWith(secretKey, SignatureAlgorithm.HS256)
				.compact();
	}
	
	public boolean validateToken(String token) {
		try {
			Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token);
			return true;
	    } catch (MalformedJwtException e) {
	      System.out.println("Invalid JWT token");
	      e.printStackTrace();
	    } catch (ExpiredJwtException e) {
	      System.out.println("Expired JWT token");
	      e.printStackTrace();
	    } catch (UnsupportedJwtException e) {
	      System.out.println("Unsupported JWT token");
	      e.printStackTrace();
	    } catch (IllegalArgumentException e) {
	      System.out.println("JWT claims string is empty.");
	      e.printStackTrace();
	    } catch(Exception e) {
	    	System.out.println("JWT Error");
	    	e.printStackTrace();
	    }
	    return false;
	}
//		
//	public Authentication getAuthentication(String token) {
//		UserDetails member = memberService.loadUserByUsername(this.getLoiginUserID(token));
//		return new UsernamePasswordAuthenticationToken(member, "", member.getAuthorities());
//	}
	
	private Claims parseJwtToken(String token) {
		return Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token).getBody();
	}
	
	public Date getExpirationDateFromToken(String token) {
		return this.parseJwtToken(token).getExpiration();
	}
	
	//엑세스와 리프레시 토큰 모두에 사용 가능
	public int getLoginUserNo(String token) {
		return Integer.parseInt(this.parseJwtToken(token).getSubject());
	}
	
	//엑세스 토큰에만 사용 가능
	public String getLoginUserID(String token) {
		return this.parseJwtToken(token).get("userId", String.class);
	}
	

}
