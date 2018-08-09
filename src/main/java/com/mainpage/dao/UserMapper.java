package com.mainpage.dao;

import com.mainpage.domain.User;

public interface UserMapper {

    int isUserNameExist(String username);

    int addUser(User user);

    User getUserByUserName(String username);

    int updateUserById(User user);
}
