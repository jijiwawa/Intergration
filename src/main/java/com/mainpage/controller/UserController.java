package com.mainpage.controller;

import com.mainpage.domain.User;
import com.mainpage.service.impl.UserServiceImpl;
import com.mainpage.util.ProduceMD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;

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

    @RequestMapping("/user/loginCheck")
    @ResponseBody
    public Object sigInCheck(HttpServletRequest request,HttpSession session){

        //处理参数
        String password=ProduceMD5.getMD5(request.getParameter("password"));
        String username=request.getParameter("username");
        //验证用户名密码
        int loginVerify=userService.loginCheck(username,password);

        HashMap<String, String> res = new HashMap<String, String>();

        //登录成功
        if(loginVerify == 2){
            User user =userService.getUserByUserName(username);
            Integer userId=user.getId();
            //用户信息写入session
            session.setAttribute("userId",userId);
            session.setAttribute("username",username);
            res.put("stateCode", "2");
        }
        //密码错误
        else if (loginVerify == 1){
            res.put("stateCode", "1");
        }
        //用户名不存在
        else {
            res.put("stateCode", "0");
        }
        return res;
    }

}
