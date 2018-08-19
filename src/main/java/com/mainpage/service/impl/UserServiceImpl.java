package com.mainpage.service.impl;

import com.mainpage.dao.UserMapper;
import com.mainpage.domain.User;
import com.mainpage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userDao;

    public boolean addUser(User user) {
        return userDao.addUser(user)>0;
    }

    public boolean isUserNameExist(String username) {
        return userDao.isUserNameExist(username)==1;
    }

    public User getUserByUserName(String username) {
        return userDao.getUserByUserName(username);
    }
    public User getUserByUserId(int id) {
        return userDao.getUserByUserId(id);
    }

    //登录验证 0:用户名不存在 1:密码错误 2:验证成功
    public int loginCheck(String username, String password) {
        if(isUserNameExist(username)){
            User user=userDao.getUserByUserName(username);
            if(user.getPassword().equals(password)){
                return 2;
            }
            return 1;
        }
        return 0;
    }

    public boolean updateUser(User user) {
        return userDao.updateUserById(user)>0;
    }

}
