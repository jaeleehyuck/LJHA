package web.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import com.google.gson.JsonObject;

import javax.servlet.http.HttpSession;

import com.google.gson.JsonParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import web.dto.Member;
import web.service.face.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {

	private final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	MemberService memberService;

	@GetMapping("/login")
	public void loginpage() {

	}

	@PostMapping("/login")

	public String login(Member member, HttpSession session) {

		logger.info("/member/login");
		logger.info("{}", member);
		boolean isLogin = memberService.login(member);

		member = memberService.info(member.getUserId());
		System.out.println(member);
		System.out.println("유저번호" + member.getUserNo());

		if (isLogin) {
			session.setAttribute("isLogin", isLogin);
			session.setAttribute("loginId", member.getUserId());
			session.setAttribute("loginNo", member.getUserNo());

		} else {
			session.invalidate();
		}

		return "redirect:/saveearth/main";
	}

	@GetMapping("/join")
	public void joinpage() {

	}

	@PostMapping("/join")
	public String join(Member memberParam) {
		memberParam.setUserLogintype("basic");
		memberService.join(memberParam);

		return "redirect:./login";
	}

	@GetMapping("/findid")
	public void findidpage() {

	}

	@PostMapping("/findid")
	public String findid(Member member, Model model) {
		System.out.println(member.getUserName());
		System.out.println(member.getUserEmail());
		boolean check = memberService.checkid(member);
		System.out.println(check);

		if (check) {
			Member userId = memberService.findid(member);

			System.out.println(userId);

			model.addAttribute("id", userId);

			return "./member/findViewid";
		} else {

			return "./member/findid";

		}

	}

	@GetMapping("/findViewid")
	public void findViewid() {

	}

	@GetMapping("/findpw")
	public void findpwview() {

	}

//	pw찾기 id,email확인해서 있는지		
	@PostMapping("/findpw")
	public void findpw() {

	}

//	pw찾기 id,email확인해서 있는지	
	@ResponseBody
	@GetMapping("/findIdEmail")
	public int checkIdEmail(Member member, String id, String userId) {
		System.out.println("멤버값" + member);
		System.out.println("유저아이디" + userId);
		System.out.println(id);
		int result = memberService.checkIdEmail(member);

		if (result == 1) {

			// 비밀번호 난수생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			System.out.println(pw);
			member.setUserPw(pw);

			// 비밀번호 난수로 변경(update)
			memberService.temPw(member);
			System.out.println(member);

			// 이메일 발송()
			memberService.mailSend(member);

			return result;

		} else {
			return result;
		}

	}

	@RequestMapping("logout")
	public String logout(HttpSession session) {
		logger.info("/logout");

		session.invalidate();

		return "redirect:/saveearth/main";
	}

//	   20230525추가 id 중복 

	@ResponseBody
	@GetMapping("/idCheck")
	public int overlappendID(Member member) {
		int result = memberService.overlappedID(member);
		System.out.println(result);
		return result;
	}

//  20230529추가 이메일 중복 	
	@ResponseBody
	@GetMapping("/emailCheck")
	public int emailCheck(Member member) {
		int result = memberService.overlappedEmail(member);
		System.out.println(result);

		return result;
	}

	@GetMapping("/kakao")
	public String kakaocode(@RequestParam("code") String code, HttpSession session) {

		System.out.println("code : " + code);

		// CODE로 access 토큰 가져오기
		String access_token = memberService.getToken(code);

		System.out.println("받아온:accestoken:" + access_token);

		// -------------------------------------------------------------------------

		// 토큰으로 정보 가지고 오기

		Member member = memberService.getKaKaoinfo(access_token);

		String kakaoId = member.getUserId();
		String kakaoEmail = member.getUserEmail();
		String password = access_token.substring(5, 12);

		member.setUserPw(password);
		System.out.println(password);
		// 유저 타입 설정
		member.setUserLogintype("kakao");

		System.out.println("가져온 유저 아이디 : " + kakaoId);
		System.out.println("가져온 유저 이메일 : " + kakaoEmail);
		System.out.println("가져온 유저 이름 : " + member.getUserName());
		System.out.println("가져온 유저 닉네임 : " + member.getUserNick());
		System.out.println(member);

		// *************************2023-05-26 금요일 kakao정보가져오기까지 이정보로 로그인하기 다음 구현
		// *************************
//			1   DB 없으면 가입 시키고 로그인
//			2   DB 에 있다는 경우    여기도 이게     
//			2-1 (일반,다른 소셜 로그인 인지) -  로그인 실패 이미 존재    
//			2-2 kakao인지   -  로그인 시켜

//			가져온 이메일이 이미 있으면 카카오 로그인 x  true =존재하는 이메일 없음, false는 이미 존재하는 회원

		// 정보 조회
		boolean isLogin = memberService.kakaoExist(member);
		System.out.println("membercontroller =" + isLogin);

		if (isLogin) {
			// 없으니까 가입 시키고 로그인
			memberService.join(member);
			session.setAttribute("isLogin", isLogin);
			session.setAttribute("loginId", member.getUserId());
			session.setAttribute("loginNo", member.getUserNo());

		} else {
			// 있는데 다른 로그인 타입이있다
			// 로그인 타입 알아아오기!
			String logintype = memberService.getType(member);
			System.out.println(logintype);

			if (logintype == "kakao") {
				session.setAttribute("isLogin", true);
				session.setAttribute("loginId", member.getUserId());
				session.setAttribute("loginNo", member.getUserNo());
			} else {
				// 로그인 타입이 일반이나 네이버일경우
				// 추가해야함 이제 알리기 이미 존재하는아이디의 이메일이 회원가입이 되어있다고 알리기
				session.invalidate();
			}

		}
		return "redirect:/saveearth/main";
	}

	@RequestMapping("/kakaoToken")
	public void kakotoken() {

	}

	@GetMapping("/naver")
	public String naver(@RequestParam("code") String code, @RequestParam("state") String state) throws Exception {
		System.out.println(code);
		System.out.println(state);
		
		// 네이버 access_token 가져오기
		String access_token = memberService.getnaverToken(code,state);
		System.out.println("컨트롤러"+access_token);
		
		// 네이버 API 엔드포인트 URL
		String apiUrl = "https://openapi.naver.com/v1/nid/me";

		try {
		    URL url = new URL(apiUrl);
		    HttpURLConnection con = (HttpURLConnection) url.openConnection();
		    con.setRequestMethod("GET");
		    con.setRequestProperty("Authorization", "Bearer " + access_token);
		    int responseCode = con.getResponseCode();
		    
		    BufferedReader br;
		    if (responseCode == 200) { // 정상 호출
		        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		    } else { // 에러 발생
		        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		    }
		    
		    StringBuilder response = new StringBuilder();
		    String line;
		    while ((line = br.readLine()) != null) {
		        response.append(line);
		    }
		    br.close();
		    
		    // API 응답 결과를 파싱하여 원하는 정보를 추출
		    JsonParser parser = new JsonParser();
		    JsonObject profileObject = parser.parse(response.toString()).getAsJsonObject();
		    JsonObject responseObject = profileObject.getAsJsonObject("response");
		    

		    
		    String naverId = responseObject.get("id").getAsString();
		    String naverName = responseObject.get("name").getAsString();
		    String naverEmail = responseObject.get("email").getAsString();
		    
		    
		    System.out.println(naverId);
		    System.out.println(naverName);
		    System.out.println(naverEmail);
		    
		} catch (Exception e) {
		    // Exception 처리
		}

	
		return "member/login";
	}

}
