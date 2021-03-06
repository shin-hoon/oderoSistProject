package com.sist.review;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.sist.review.dao.ReviewDao;
import com.sist.review.dao.ReviewVo;
import com.sist.review.dao.Review_ReplyVo;

@Controller
public class ReviewController {
	@Autowired
	private ReviewDao dao;
	
	String path = "/home/sist/bigdataDev/bigdataStudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/odero/review/data/";
	
	@RequestMapping("review_list.do")
	public String reviewList(String page, Model model) {
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		int rowSize = 9;
		int start = (rowSize * curpage) - (rowSize - 1);
		int end = rowSize * curpage;		
		
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);

		List<ReviewVo> list = dao.reviewList(map);
		for (ReviewVo vo : list) {
			String img = vo.getR_imgname();
			
			if (img.equals("-")) {
				img = "no_image.jpg";
				vo.setR_imgname(img);
			} else {
				img = img.split(",")[0];
				vo.setR_imgname(img);
			}
		}
		model.addAttribute("list", list);

		int totalpage = dao.reviewTotalList();
		model.addAttribute("curpage", curpage);
		model.addAttribute("totalpage", totalpage);

		return "review/list";
	}

	@RequestMapping("review_insert")
	public String reviewInsertPage() {
		return "review/insert";
	}

	@RequestMapping("review_insert_ok")
	public String reviewInsert(ReviewVo uploadForm) {
		List<MultipartFile> list = uploadForm.getImages();
		File f = new File(path);
		if (!f.exists())
			f.mkdir();
		if (list != null && list.size() > 0) {
			String fname = "";
			for (MultipartFile mf : list) {
				String name = mf.getOriginalFilename();
				if (!name.equals("")) {
					File file = new File(path+name);
					
					try {
						mf.transferTo(file);
					} catch (Exception e) {
						System.out.println(e.getMessage());
					}
					fname += name + ",";
				}
			}
			if (!fname.equals("")) {
				uploadForm.setR_imgname(fname.substring(0, fname.lastIndexOf(",")));
				uploadForm.setR_imgcount(list.size());
			} else {
				uploadForm.setR_imgname("-");
				uploadForm.setR_imgcount(0);
			}
		} else {
			uploadForm.setR_imgname("-");
			uploadForm.setR_imgcount(0);
		}
		dao.reviewInsert(uploadForm);
		return "redirect:review_list.do";
	}
	
	@RequestMapping("review_detail.do")
	public String reviewDetail(int no,Model model,String page) {
		if (page == null)
			page="1";
		
		int curpage = Integer.parseInt(page);
		int rowSize = 10;
		int start = (rowSize * curpage) - (rowSize - 1);
		int end = rowSize * curpage;		
		
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("no", no);
		
		List<Review_ReplyVo> list = dao.replyList(map);
		int totalpage = dao.replyTotalList(no);
		
		dao.reviewHitIncrement(no);
		ReviewVo vo = dao.reviewDetail(no);
		
		if (vo.getR_imgcount()>0) {
			String[] images = vo.getR_imgname().split(",");
			vo.setR_imgname(images[0]);
			model.addAttribute("images",images);
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String today = sdf.format(new Date());
		for (Review_ReplyVo rvo : list) {
			rvo.setDbday(sdf.format(rvo.getRr_regdate()));
		}
				
		model.addAttribute("today",today);
		model.addAttribute("vo", vo);
		model.addAttribute("list", list);
		model.addAttribute("curpage", curpage);
		model.addAttribute("totalpage", totalpage);
		return "review/detail";
	}
	
	@RequestMapping("review_update.do")
	public String reviewUpdatePage(int no,Model model) {
		ReviewVo vo = dao.reviewDetail(no);
		model.addAttribute("vo",vo);
		return "review/update";
	}
	
	@RequestMapping("review_update_ok.do")
	public String reviewUpdateData(ReviewVo uploadForm) {
		dao.reviewUpdateData(uploadForm);
		return "redirect:review_detail.do?no="+uploadForm.getR_no();
	}
	@RequestMapping("review_delete.do")
	public String reviewDelete(int no, HttpSession session) {
		ReviewVo vo = dao.reviewDeleteData(no);
		String id = (String)session.getAttribute("m_id");		
		if (id.equals(vo.getM_id())) {
			if (vo.getR_imgcount()>0) {
				String[] img = vo.getR_imgname().split(",");
				for (String i : img) {
					File f = new File(path+i);
					f.delete();
				}
			}
			dao.reviewDelete(no);
		}
		return "redirect:review_list.do";
	}
	
	
	// 댓글
	
	@RequestMapping("reply_insert.do")
	public String replyInsert(Review_ReplyVo vo){
		dao.replyInsert(vo);
		return "redirect:review_detail.do?no="+vo.getR_no();
	}
	
	@RequestMapping("re_reply_insert.do")
	public String re_replyInsert(Review_ReplyVo vo){		
		Review_ReplyVo rvo = dao.re_replyParent(vo.getRr_no());

		vo.setRr_gid(rvo.getRr_gid());
		vo.setRr_gstep(rvo.getRr_gstep()+1);
		vo.setRr_gtab(rvo.getRr_gtab()+1);
		
		System.out.println(vo.getM_id());
		System.out.println(vo.getRr_no());
		System.out.println(vo.getR_no());
		System.out.println(vo.getRr_msg());
		System.out.println(vo.getRr_gid());
		System.out.println(vo.getRr_gstep());
		System.out.println(vo.getRr_gtab());
		
		dao.re_replySort(vo);
		dao.re_replyInsert(vo);
		return "redirect:review_detail.do?no="+vo.getR_no();
	}
	
	
	
	
	
	
	
	
}
