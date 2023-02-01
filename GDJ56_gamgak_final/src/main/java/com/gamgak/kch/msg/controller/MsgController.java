package com.gamgak.kch.msg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gamgak.kch.msg.common.PageFactory;
import com.gamgak.kch.msg.service.MsgService;
import com.gamgak.psh.admin.vo.Member;

@Controller
@RequestMapping("/msg")
public class MsgController {
	
	private MsgService service;
	
	
	@Autowired
	public MsgController(MsgService service) {
		this.service=service;
	}
	
	//페이지전환
	@RequestMapping("/msgList.do")
	public String msgList() {
		return "kch_msg/msgList";
	}
	
	//채팅방 목록
	@RequestMapping("/selectMsgList.do")
	@ResponseBody
	public Map<String,Object> selectMsgList(int loginMemberNo, int cPage) {
		Map<String,Object> list=new HashMap<String, Object>();
		int numPerpage=5;
		System.out.println(loginMemberNo+cPage+numPerpage);
		int total=service.selectMsgCount(loginMemberNo);
		System.out.println(total);
		list.put("list",service.selectMsgList(Map.of("loginMemberNo",loginMemberNo,"cPage",cPage,"numPerpage",numPerpage)));
		list.put("pageBar",PageFactory.getPage(loginMemberNo,cPage, numPerpage, total,"selectMsgList.do"));
		System.out.println(list);

		return list;
	}
	
	//채팅 대화내용
	@RequestMapping("/selectChatList.do")
	@ResponseBody
	public List<Map> selectChatList(int personalChatroomNo, int loginMemberNo){
		List<Map> list=service.selectChatList(personalChatroomNo, loginMemberNo);
		return list;
	}
	
	//메세지 저장
	@RequestMapping("/insertMsg.do")
	@ResponseBody
	public int insertMsg(int personalChatroomNo,int receiverNo, int senderNo, String content) {
		int result=service.insertMsg(personalChatroomNo,receiverNo,senderNo,content);
		return result;
	}
	
	//같은방 회원 정보 가져오기
	@RequestMapping("/chatroomMember.do")
	@ResponseBody
	public Map chatroomMember(int personalChatroomNo, int loginMemberNo) {
		Map m=new HashMap();
		m.put("data",service.chatroomMember(personalChatroomNo,loginMemberNo));
		return m;
	}

}
