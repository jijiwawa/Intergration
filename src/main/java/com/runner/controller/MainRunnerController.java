package com.runner.controller;

import com.mainpage.service.impl.UserServiceImpl;
import com.runner.po.OrderForm;
import com.runner.service.impl.OrderFormServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MainRunnerController {
    @Autowired
    private OrderFormServiceImpl orderFormService;
    @Autowired
    private UserServiceImpl userService;

    @RequestMapping("/toSign_order")
    public ModelAndView toSignOrder(){
        return new ModelAndView("runner/sign_order");
    }
}

