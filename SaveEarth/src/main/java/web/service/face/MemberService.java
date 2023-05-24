package web.service.face;

import web.dto.Member;

public interface MemberService {

	public void join(Member memberParam);

	public boolean login(Member member);
	
	/**
	 * 마이페이지 회언 정보조회
	 * @param loginid
	 * @return
	 */
	public Member info(String loginid);

	/**
	 * 마이페이지 회원 정보수정
	 * @param loginid
	 * @return
	 */
	public Member update(String loginid);

	

	public Member findid(Member member);

	public boolean checkid(Member member);

	

	
	


}
