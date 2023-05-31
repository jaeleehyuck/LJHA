package web.service.face;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import web.dto.Admin;
import web.dto.Free;
import web.dto.FreeFile;
import web.dto.Member;
import web.util.Paging;

public interface AdminService {
	
	/**
	 * 관리자
	 * @param adminParam
	 * @return
	 */
    public boolean login(Admin admin);

	public Paging getPaging(int curPage);

	public List<Map<String, Object>> list(Paging paging);

	public Map<String, Object> getView(Free freeBoard);

	public List<FreeFile> getFreeFile(Free freeBoard);


	public Paging getPaging2(int curPage);

	/**
	 * 게시글 작성 
	 * @param free - 작성한 게시글 정보
	 * @param files - 파일 정보
	 * @param memberInfo - 로그인 회원정보
	 */
	public void freeWrite(Free free, List<MultipartFile> files, Admin memberInfo, Member member);

	/**
	 * 관리자 정보 불러오기
	 * @param loginId
	 * @return
	 */
	public Admin info(String loginId);

	public void delete(Free free);


	
	




}