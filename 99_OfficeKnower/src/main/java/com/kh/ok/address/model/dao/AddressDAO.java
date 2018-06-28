package com.kh.ok.address.model.dao;


import java.util.List;

import com.kh.ok.address.model.vo.Address;

public interface AddressDAO {

	int addressAdd(Address address);

	List<Address> addressView();

	

}
