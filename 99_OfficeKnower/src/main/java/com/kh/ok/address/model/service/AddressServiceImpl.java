package com.kh.ok.address.model.service;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.address.model.dao.AddressDAO;
import com.kh.ok.address.model.vo.Address;
import com.kh.ok.member.model.vo.Member;


@Service
public class AddressServiceImpl implements AddressService {
	
	@Autowired
	AddressDAO addressDAO;
	
	@Override
	public int addressAdd(Address address) {
		return addressDAO.addressAdd(address);
	}

	@Override
	public List<Address> addressView() {
		return addressDAO.addressView();
	}

	@Override
	public int InsertAddress(Map<String, Object> map) {
		return addressDAO.InsertAddress(map);
	}

	@Override
	public List<Address> addressTrashList() {
		return addressDAO.addressTrashList();
	}

	@Override
	public int addressTrash(String addId) {
		return addressDAO.addressTrash(addId);
	}

	@Override
	public Address AddressSelectName(Map<String, String> map) {
		return addressDAO.AddressSelectName(map);
	}

	@Override
	public int addressUpdateInfo(Address address) {
		return addressDAO.addressUpdateInfo(address);
	}

	public int addressReset(String addId) {
		return addressDAO.addressReset(addId);
	}









	

}
