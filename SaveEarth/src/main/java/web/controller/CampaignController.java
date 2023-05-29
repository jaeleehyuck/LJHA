package web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import web.dto.Calendar;
import web.dto.Campaign;
import web.dto.Certification;
import web.service.face.CampService;
import web.util.Paging;

@Controller
@RequestMapping("/campaign")
public class CampaignController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired CampService campService;
	
	@GetMapping("/main")
	public void campMainGet(HttpSession session, Model model, @RequestParam(defaultValue = "0") int curPage) {
		logger.info("/campaign/main [GET]");
		logger.info("curPage : {}", curPage);
		
		Paging paging = campService.getPaging(curPage);
		
		//캠페인 불러오기
		List<Campaign> campList = campService.getCampList(paging);
		
		
		for(Campaign c : campList) {
			logger.info("{}", c);
		}
		
		model.addAttribute("campList", campList);
		
		//달력 불러오기
		if(session.getAttribute("isLogin") != null) {
//			List<Certification> certList = campService.getcertList(session.getAttribute("loginId"));
		} else {
			List<Calendar> calList = campService.getCalendar();
			
			for(Calendar c : calList) {
				logger.info("{}", c);
			}
			
			model.addAttribute("calList", calList);
			
		}
		
	}
	
	@PostMapping("/main")
	public String campMainPost(MultipartFile partFile, Certification certification ) {
		logger.info("/campaign/main [POST]");
		logger.info("{}", partFile);
		logger.info("********** {}", certification);
		
		campService.writePart(certification, partFile);
		
		
		return "redirect:/campaign/main";
	}
	
	@RequestMapping("/detail")
	public void campDetail(Model model, int campno) {
		logger.info("/campaign/detail [GET]");
		logger.info("campno : {}", campno);
		
		Map<String, Object> campDetail = campService.getCampDetail(campno);
		logger.info("{}", campDetail);
		
		model.addAttribute("campDetail", campDetail);
		
	}
	
	@RequestMapping("/preface")
	public String campList(Model model, @RequestParam(defaultValue = "0") int curPage, String state) {
		logger.info("/campaign/preface [GET]");
		logger.info("{}", curPage);
		logger.info("{}", state);
		
		List<Campaign> campList = new ArrayList<>();
		
		
		if("전체".equals(state)) {
			logger.info("전체 선택됨");
			
			Paging paging = campService.getPaging(curPage);
			campList = campService.getCampList(paging);
			
			for(Campaign c : campList) {
				logger.info("{}", c);
			}
			
			model.addAttribute("campList", campList);
			
		} else {
			logger.info("마감 혹은 진행중이 선택됨");
			
			Paging paging = campService.getPagingByState(curPage, state);
					
			campList = campService.getListByState(paging, state);
			
			for(Campaign c : campList) {
				logger.info("{}", c);
			}
			
			
			model.addAttribute("campList", campList);
		}
		
		
		return "/campaign/campList";
		
	}
	

	

}
