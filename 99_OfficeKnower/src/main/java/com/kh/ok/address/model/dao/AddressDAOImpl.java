package com.kh.ok.address.model.dao;


import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.address.model.vo.Address;


@Repository
public class AddressDAOImpl implements AddressDAO {
	@Autowired
	SqlSessionTemplate sqlSession;
	

	@Override
	public int addressAdd(Address address) {
		return sqlSession.insert("address.addressAdd", address);
	}

	@Override
	public List<Address> addressView() {
		return sqlSession.selectList("address.addressView");
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
	public List<Address> addressTrashList() {
		return sqlSession.selectList("address.addressTrashList");
	}

	

	
/*	@Override
	public int addressTrash(String addId) {
		return sqlSession.update("address.addressTrash",addId);
	}
*/

	


	

}
