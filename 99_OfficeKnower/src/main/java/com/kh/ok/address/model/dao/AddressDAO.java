package com.kh.ok.address.model.dao;


import java.util.List;
import java.util.Map;

import com.kh.ok.address.model.vo.Address;

public interface AddressDAO {

	int addressAdd(Address address);

	List<Address> addressView();

	int InsertAddress(Map<String, Object> map);

	int addressTrash(String addId);

	List<Address> addressTrashList();

	int addressReset(String addId);

	






	

}
