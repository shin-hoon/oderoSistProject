package com.sist.place;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.*;
import com.sist.place.dao.*;

@Controller
public class PlaceController {
	@Autowired
	private PlaceDAO dao;
	@Autowired
	private P_ReplyDAO p_dao;
	
	@RequestMapping("p_detail.do")
	public String place_detail(int p_no, Model model) {
		
		PlaceVO vo = dao.placeDetailData(p_no);
		List<P_ReplyVO> r_list = p_dao.p_replyListData(p_no);
		// keyword split
		String str_kw = vo.getP_keyword();
		String[] skeyword = str_kw.split(",");
		// img split
		String str_img = vo.getP_img();
		String[] simg = str_img.split(",");
		String p_addr = vo.getP_addr();
		
		model.addAttribute("p_addr", p_addr);
		model.addAttribute("backimg", simg[0]);
		model.addAttribute("r_list", r_list);
		model.addAttribute("skeyword", skeyword);
		model.addAttribute("simg", simg);
		model.addAttribute("vo", vo);
		return "place/p_detail";
	}
	
	// 댓글
	/*@RequestMapping("p_reply_insert.do")
	public String p_replyInsert() {
		return "place/p_reply";
	}
	@RequestMapping("p_reply_insert_ok.do")
	public String p_replyInsert_ok() {
		return "redirect:p_detail.do";
	}
	 */
	
	@RequestMapping("p_list.do")
	public String placeListData(String page, Model model) {
		
		if(page==null)
			page="1";
		int curpage= Integer.parseInt(page);
		int rowsize=8;
		int start=(rowsize*curpage)-(rowsize-1);
		int end= rowsize * curpage;
		
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		int totalpage = dao.placeTotalList();
		
		
		
		List<PlaceVO> list =dao.placeListData(map);
		model.addAttribute("list",list);
		model.addAttribute("curpage",curpage);
		model.addAttribute("totalpage",totalpage);
		
		
		return "place/p_list";
	}
	
	
	/*@RequestMapping("s_list.do")
	public String placeSelectData(String sn_1,String sn_3,String page, Model model){
		
		if(page==null)
			page="1";
		int curpage= Integer.parseInt(page);
		int rowsize=8;
		int start=(rowsize*curpage)-(rowsize-1);
		int end= rowsize * curpage;
		
		System.out.println("page: "+page);
		System.out.println("start: "+start);
		System.out.println("end: "+end);
		System.out.println("sn_1: "+sn_1);
		
		Map map=new HashMap();
		map.put("sn_3", sn_3);
		map.put("start", start);
		map.put("end", end);
		
		model.addAttribute("curpage",curpage);
		model.addAttribute("sn_1",sn_1);
		
		if(sn_1.equals("이색/체험"))
		{
			List<PlaceVO> sp_list = dao.placeSelectData_p(map);
			int sp_totalpage=dao.placeTotalpage_sp(sn_3);
			
			model.addAttribute("sp_list",sp_list);
			model.addAttribute("sp_totalpage",sp_totalpage);
			
		}
		else  
		{
			List<PlaceVO> cf_list=dao.placeSelectData_cf(map);
			int cf_totalpage=dao.placeTotalpage_cf(sn_3);
			
			model.addAttribute("cf_list",cf_list);
			model.addAttribute("cf_totalpage",cf_totalpage);
			
		}
		

		return "place/list_view/s_list";
	}
	*/
	
}