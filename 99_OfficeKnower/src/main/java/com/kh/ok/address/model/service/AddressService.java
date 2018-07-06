package com.kh.ok.address.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.address.model.vo.Address;

public interface AddressService {

	
	int InsertAddress(Map<String, Object> map);

	int addressAdd(Address address);

	List<Address> addressView();

	List<Address> addressTrashList();

	int addressTrash(String addId);

	int addressReset(String addId);










	


}
