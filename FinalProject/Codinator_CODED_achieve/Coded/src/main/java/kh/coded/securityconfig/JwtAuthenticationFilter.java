package kh.coded.securityconfig;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kh.coded.dto.MemberDTO;
import kh.coded.security.JwtProvider;
import kh.coded.services.MemberService;
import utils.CookieUtil;
import utils.StaticValue;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter{


	private final static String HEADER_AUTHORIZATION = "Authorization";
	private final static String TOKEN_PREFIX = "Bearer ";

	@Autowired
	private MemberService memberService;
	@Autowired
	private JwtProvider jwtProvider;

	private static final List<String> EXCLUDE_URL = Collections.unmodifiableList(
			Arrays.asList(
					"/static/**",
					"/favicon.ico",
					
					"/",
					"/login",
					"/register",
					"/auth/member",
					"/auth/login",
					"/auth/oauth/**",
					"/login/oauth2/**",
					"/auth/refresh",
					"/auth/isMember",
					"/auth/isMemberByEmail",
					"/auth/send-mail/pw",
					"/auth/getAddress1List",
					"/auth/getAddress2List",
					"/weather/todayNonMem"
					));

	@Override
	protected void doFilterInternal(
			HttpServletRequest request,
			HttpServletResponse response,
			FilterChain filterChain)
					throws ServletException, IOException {

		String authorizationHeader = request.getHeader(HEADER_AUTHORIZATION);
		if(authorizationHeader != null) {
			String accessToken = this.getAccessToken(authorizationHeader);
			MemberDTO member = null;
			if(accessToken != null) {
				if(jwtProvider.validateToken(accessToken)) {
					try {
						member = memberService.selectByUserNo(jwtProvider.getLoginUserNo(accessToken));
					}catch(Exception e) {
						e.printStackTrace();
					}				
				}else {
					System.out.println("JWT 토큰이 유효하지 않습니다.");
				}
			}else {
				System.out.println("JWT 토큰이 Bearer String 으로 시작하지 않습니다. target : " + request.getRequestURI());
			}			
			try {
				if(member != null) {
					if(jwtProvider.validateToken(accessToken)) {
						UserDetails authentication = memberService.loadUserByUsername(member.getUserId());
						Authentication auth = new UsernamePasswordAuthenticationToken(authentication.getUsername(), null, authentication.getAuthorities());
						SecurityContextHolder.getContext().setAuthentication(auth);
					}
					
					if(CookieUtil.getCookie(request, StaticValue.REFRESH_TOKEN_COOKIE_NAME).isPresent()) {
						String refreshToken = CookieUtil.getCookie(request, StaticValue.REFRESH_TOKEN_COOKIE_NAME).get().getValue();
						if(refreshToken != null && refreshToken.startsWith("Bearer ")) {
							CookieUtil.deleteCookie(request, response, StaticValue.REFRESH_TOKEN_COOKIE_NAME);
						}
						CookieUtil.addCookie(response, StaticValue.REFRESH_TOKEN_COOKIE_NAME, "Bearer " + jwtProvider.createLoginRefreshToken(member), StaticValue.REFRESH_TIME);
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		filterChain.doFilter(request, response);
	}

	@Override
	protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
		return EXCLUDE_URL.stream().anyMatch(exclude -> exclude.equalsIgnoreCase(request.getServletPath()));
	}

	private String getAccessToken(String authorizationHeader) {
		if(authorizationHeader != null && authorizationHeader.startsWith(TOKEN_PREFIX) && authorizationHeader.length() > 7) {
			return authorizationHeader.substring(TOKEN_PREFIX.length(), authorizationHeader.length());
		}
		return null;
	}
}
