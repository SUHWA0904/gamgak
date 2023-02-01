package com.gamgak.ldh.profile.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProfileDao {
	
	//저장한 맛집 카운트 가져오기
	public int selectMyResCount(SqlSessionTemplate session, int memberNo){
		return session.selectOne("profile.selectMyResCount",memberNo);
	}
	
	//친구 카운트 가져오기
	public int selectFriendCount(SqlSessionTemplate session, int memberNo){
		return session.selectOne("profile.selectFriendCount",memberNo);
	}
	
	//모임 카운트 가져오기
	public int selectMeetingCount(SqlSessionTemplate session, int memberNo){
		return session.selectOne("profile.selectMeetingCount",memberNo);
	}
	
	//식당 저장
	public int insertRestaurant(SqlSessionTemplate session, Map restaurant) {
		try{
			return session.insert("profile.insertRestaurant",restaurant);
		}catch (Exception e) {
			return 0;
		}
	}
	
//	//맛집 저장
//	public int insertMyRes(SqlSessionTemplate session, Map param) {
//		return session.insert("profile.insertMyRes",param);
//	}
	
}