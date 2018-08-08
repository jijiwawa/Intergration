package com.mainpage.controller;

import com.mainpage.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class MainController {

    @Autowired
    private UserServiceImpl userService;

    @RequestMapping("/")
    public ModelAndView toMain(HttpSession session){
        return new ModelAndView("main");
    }

    @RequestMapping("/signup")
    public ModelAndView signUp(){
        return new ModelAndView("signup");
    }

    @RequestMapping("/signin")
    public ModelAndView signIn(){return new ModelAndView("signin");}

}
