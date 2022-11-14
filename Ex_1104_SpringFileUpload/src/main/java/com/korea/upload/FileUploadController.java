package com.korea.upload;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import vo.PhotoVO;

@Controller
public class FileUploadController {
	
	//@Autowired : 자동 주입 어노테이션
	//servlet-context, session, request와 같은 jsp,servlet에서 제공해주는 객체이기 때문에
	//스프링에서도 지원을 한다. jsp에서 servlet에서 지원해주는 객체를 따로 생성하는 과정 없이
	//자동으로 만들어 둘 수 있게 하는 어노테이션
	//무조건은 아니지만 코드를 손 보면 원하는 객체를 다 만들 수 있다.
	@Autowired
	ServletContext application;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	static final String VIEW_PATH = "/WEB-INF/views/";
	
	@RequestMapping(value = {"/","/insert_form.do"})
	public String insert_form() {
		return VIEW_PATH + "insert_form.jsp";
	}
	
	//파일 업로드
	@RequestMapping("/upload.do")
	public String upload(PhotoVO vo) {
		
		String webPath = "/resources/upload/";  //우리가 실제로 접근해야 하는 폴더
		
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);
		
		//업로드된 파일 정보
		MultipartFile photo = vo.getPhoto();
		String filename = "no_file";
		
		if(!photo.isEmpty()) {
			
			//업로드 될 실제 파일명
			filename = photo.getOriginalFilename();
			
			//파일을 저장할 경로
			File saveFile = new File(savePath,filename);
			//savepath 경로까지 가서 filename이 있나 확인
			//없으면 만들어
			
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				//동일한 이름의 파일일 경우 폴더형태로 변환이 불가하므로
				//업로드 시간을 붙여서 이름이 중복되는걸 방지
				//currentTimeMills() 자바가 만들어진 1970년부터 2022년 현재까지의 시간을
				//100분의 1초로 저장하고 있다.
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath,filename);
			}
			
			try {
				photo.transferTo(saveFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		vo.setFilename(filename);
		
		request.setAttribute("vo", vo);
		
		return VIEW_PATH + "input_result.jsp";
	}
}
