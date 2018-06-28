package com.kh.ok.address.model.dao;


import java.util.List;

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

	


	

}
