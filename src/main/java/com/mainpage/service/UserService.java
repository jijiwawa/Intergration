package com.mainpage.service;

import com.mainpage.domain.User;

public interface UserService {
    public boolean addUser(User user);
    public boolean isUserNameExist(String username);
    public User getUserByUserName(String username);

    public int loginCheck(String username,String password);

    public boolean updateUser(User user);
    public boolean isPhoneNumExist(String phone);
}
