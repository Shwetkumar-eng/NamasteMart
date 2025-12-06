package com.namastemart.service;

import java.util.List;

import com.namastemart.beans.UserBean;


public interface UserService {
	
public String registerUser(String userName,Long mobileNo,String emailId,String address,int pinCode,
		String password,byte[] userImage);

public String registerUser(UserBean user);

public boolean isRegistered(String emailId);

public String isValidCredential(String emailId,String password);

public UserBean getUserDetails(String emailId,String password);

public boolean updateUserDetails(UserBean user);

public String getFName(String emailId);

public String getUserAddr(String userId);


public List<UserBean> getAllUsers();

public void activateUser(String userId);

public void deactivateUser(String userId);

public void deleteUser(String userId);
	
	
}
