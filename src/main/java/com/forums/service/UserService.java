package com.forums.service;

import com.forums.domain.User;

public interface UserService {
    public boolean addUser(User user);
    public boolean isUserNameExist(String username);
    public User getUserByUserName(String username);
    public int loginCheck(String username,String password);
}
