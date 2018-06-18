package com.kh.ok.member.model.dao;

import com.kh.ok.member.model.vo.Member;

public interface MemberDAO {

	Member selectUserId(String userId);

	int memberOneUpdate(Member member);

}
