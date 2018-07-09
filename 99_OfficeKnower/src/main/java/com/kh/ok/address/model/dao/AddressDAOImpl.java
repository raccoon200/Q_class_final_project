package com.kh.ok.address.model.dao;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.address.model.vo.Address;
import com.kh.ok.member.model.vo.Member;


@Repository
public class AddressDAOImpl implements AddressDAO {
	@Autowired
	SqlSessionTemplate sqlSession;
	

	@Override
	public int addressAdd(Address address) {
		return sqlSession.insert("address.addressAdd", address);
	}

	@Override
	public List<Address> addressView(String com_no) {
		return sqlSession.selectList("address.addressView", com_no);
	}

	@Override
	public int InsertAddress(Map<String, Object> map) {
		return sqlSession.insert("address.InsertAddress",map);
	}

	@Override
	public int addressTrash(String addId) {
		return sqlSession.insert("address.addressTrash", addId);
	}

	@Override
	public List<Address> addressTrashList(String com_no) {
		return sqlSession.selectList("address.addressTrashList", com_no);
	}

	@Override
	public Address AddressSelectName(Map<String, String> map) {
		return sqlSession.selectOne("address.AddressSelectName", map);
	}

	@Override
	public int addressUpdateInfo(Address address) {
		return sqlSession.update("address.addressUpdateInfo",address);
	}
	public int addressReset(String addId) {
		return sqlSession.insert("address.addressReset", addId);

	}

	@Override
	public List<Address> addressSearch(Map<String, String> map) {
		return sqlSession.selectList("address.addressSearch", map);
	}

	

	
/*	@Override
	public int addressTrash(String addId) {
		return sqlSession.update("address.addressTrash",addId);
	}
*/

	


	

}
