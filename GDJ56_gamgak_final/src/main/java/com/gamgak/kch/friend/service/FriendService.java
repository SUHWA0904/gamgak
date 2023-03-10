package com.gamgak.kch.friend.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gamgak.kch.friend.dao.FriendDao;

@Service
public class FriendService {

	private FriendDao dao;
	
	@Autowired
	public FriendService(FriendDao dao) {
		this.dao=dao;
	}
	
	//친구목록
	public List<Map> selectFriendList(Map param){
		return dao.selectFriendList(param);
	}
	
	//페이징
	public int selectFriendCount(int loginMemberNo) {
		return dao.selectFriendCount(loginMemberNo);
	}
	
	//친구검색
	public List<Map> friendSearch(String keyword, int loginMemberNo){
		return dao.friendSearch(keyword, loginMemberNo);
	}
	
	//친구신청
	@Transactional
	public int insertFriend(int loginMemberNo, int memberNo) {
		return dao.insertFriend(loginMemberNo, memberNo);
	}
	
	//친구신청취소
	@Transactional
	public int cancleFriend(int loginMemberNo, int memberNo) {
		return dao.cancleFriend(loginMemberNo, memberNo);
	}	 
	
	//친구수락
	@Transactional
	public int acceptFriend(int loginMemberNo, int memberNo) {
		return dao.acceptFriend(loginMemberNo, memberNo);
	}
	
	//친구신청수
	public int friendCount(int loginMemberNo) {
		return dao.friendCount(loginMemberNo);
	}
	
	//친구삭제
	@Transactional
	public int deleteFriend(int loginMemberNo, int friendMemberNO) {
		dao.deleteEnterchat(loginMemberNo, friendMemberNO);
		return dao.deleteFriend(loginMemberNo, friendMemberNO);
	}	
}
