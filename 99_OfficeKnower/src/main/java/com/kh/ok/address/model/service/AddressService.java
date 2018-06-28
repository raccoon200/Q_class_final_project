package com.kh.ok.address.model.service;

import java.util.List;

import com.kh.ok.address.model.vo.Address;

public interface AddressService {

	int addressAdd(Address address);

	List<Address> addressView();


	


}
