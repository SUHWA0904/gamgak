package com.gamgak.csk.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.gamgak.csk.member.model.entity.Member;


@Repository
public class MemberDao {
	//public interface MemberDao extends JpaRepository<Member, Long>{
	public Member selectMemberById(SqlSessionTemplate session,Member m){
		System.out.println("dao"+m);
		return session.selectOne("member.selectMemberById",m);
	}

}