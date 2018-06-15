package com.kh.ok.member.model.dao;

import com.kh.ok.member.model.vo.Member;

public interface MemberDAO {

	Member selectOne(String userId);

}
