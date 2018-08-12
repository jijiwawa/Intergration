package com.runner.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainRunnerController {

    @RequestMapping("/tab/runner")
    public ModelAndView toRunnerMain(){
        return new ModelAndView("runner/main_runner");
    }

    @RequestMapping("/toSign_order")
    public ModelAndView toSignOrder(){
        return new ModelAndView("runner/sign_order");
    }
}

