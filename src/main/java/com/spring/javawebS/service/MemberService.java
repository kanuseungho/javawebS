package com.spring.javawebS.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MultipartFile fName, MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, String mid);

	public void setMemberPwdUpdate(String mid, String pwd);

	public int setMemberUpdateOk(MultipartFile fName, MemberVO vo);

	public void setMemberDeleteOk(String mid);

	public MemberVO getMemberNickNameEmailCheck(String nickName, String email);

	public void setKakaoMemberInputOk(String mid, String pwd, String nickName, String email);

	public void setMemberUserDelCheck(String mid);

}
