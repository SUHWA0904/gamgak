package com.gamgak.csk.member.model.entity;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
//@Entity
public class Member implements UserDetails{
	//@Id
	private int memberNo;
	private String memberEmail;
	private String memberPassword;
	private String memberName;
	private String memberGender;
	private String memberNickName;
	private String introduce;
	@Temporal(TemporalType.DATE)
	private Date memberEnrollDate;
	private String profileOriName;
	private String profileReName;
	private String authorityYN;
	private int memberAge;
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		List<GrantedAuthority> auth=new ArrayList();
		if(!authorityYN.equals("Y")) auth.add(new SimpleGrantedAuthority("USER"));
		if(memberEmail.equals("admin@admin.com")) auth.add(new SimpleGrantedAuthority("ADMIN"));
		return auth;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.memberEmail;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.memberPassword;
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
}
