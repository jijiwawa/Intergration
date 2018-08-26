package com.mainpage;

import com.mainpage.domain.User;
import com.mainpage.service.impl.UserServiceImpl;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class UserMapperTest extends BaseTest {

    @Autowired
    private UserServiceImpl userService;

    @Test
    public void isUserNameExistTest(){
        boolean res=userService.isUserNameExist("算法导论");
        System.out.println("1"+res);
        res=userService.isUserNameExist("啦啦啦");
        System.out.println("2"+res);
    }

    @Test
    public void addUserTest(){
        User user=new User();
        user.setPhoneNumber("18812341234");
        user.setUserName("嘿嘿");
        user.setIsMale((byte)1);
        user.setPassword("012");
        if(!userService.isUserNameExist(user.getUserName())) {
            userService.addUser(user);
        }
    }

    @Test
    public void findUser(){
        User user = userService.getUserByUserId(28);
        System.out.println(user);
    }

}
