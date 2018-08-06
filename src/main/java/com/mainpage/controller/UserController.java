package com.mainpage.controller;

import com.mainpage.domain.User;
import com.mainpage.service.impl.UserServiceImpl;
import com.mainpage.util.ProduceMD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class UserController {
    @Autowired
    private UserServiceImpl userService;

    @RequestMapping("/user/add")
    public String addUser(HttpServletRequest request){

        User user=new User();
        int isMale=request.getParameter("isMale").equals("男")? 0:1;
        String password=ProduceMD5.getMD5(request.getParameter("password"));
        user.setUserName(request.getParameter("username"));
        System.out.println(user.getUserName());
        user.setPhoneNumber(request.getParameter("tel"));
        user.setIsMale((byte)isMale);
        user.setPassword(password);
        userService.addUser(user);

        return "redirect:/";
    }

}
