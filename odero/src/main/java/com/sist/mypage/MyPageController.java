package com.sist.mypage;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.mypage.dao.*;


//��Ʈ�ѷ�
@Controller
public class MyPageController {
	@Autowired
	MyPageDAO dao;
	@RequestMapping("mypage.do")
	public String mypage(Model model) {

	/*	List<MyPagePlaceVO> list = dao.MyPlaceBest5();
		model.addAttribute("list",list);*/
		return "cart/mypage";
	}
	@RequestMapping("mypage_list.do")
	public String mypage_list() {
		return "cart/mypage_list";
	}
	@RequestMapping("mypage_cos.do")
	public String mypage_cos() {
		return "cart/mypage_cos";
	}
	@RequestMapping("mypage_place.do")
	public String mypage_place() {
		return "cart/mypage_place";
	}
}