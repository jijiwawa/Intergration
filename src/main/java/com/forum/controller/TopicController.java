package com.forum.controller;

import com.forum.domain.Topic;
import com.forum.service.impl.TopicServiceImpl;
import com.mainpage.domain.User;
import com.mainpage.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/forum")
public class TopicController {
    @Autowired
    public TopicServiceImpl topicService;
    @Autowired
    public UserServiceImpl userService;

    @RequestMapping("/main")
    public ModelAndView toMain(HttpSession session){
        ModelAndView indexPage=new ModelAndView("forum/main");
        //全部主题
        List<Topic> topics=topicService.listTopicsAndUsers();
        //获取用户信息
        String name=(String) session.getAttribute("username");
        User user=userService.getUserByUserName(name);
        indexPage.addObject("topics",topics);
        indexPage.addObject("user",user);
        return  indexPage;
    }
    @RequestMapping("/addpage")
    public ModelAndView addTopic(){
        ModelAndView newTopicPage=new ModelAndView("forum/addtopic");

        //获取统计信息
        int topicsNum=topicService.getTopicsNum();

        newTopicPage.addObject("topicsNum",topicsNum);
        return  newTopicPage;
    }
    @RequestMapping("/post")
    public ModelAndView postTopic(HttpSession session, HttpServletRequest request){
        ModelAndView indexPage;
        //未登陆
        if(session.getAttribute("userId")==null){
            indexPage=new ModelAndView("redirect:/signin");
            return  indexPage;
        }
        //处理参数
        int userId=(Integer) session.getAttribute("userId");
        String title=request.getParameter("title");
        String content=request.getParameter("content");
        //新建Topic
        Topic topic=new Topic();
        topic.setUserId(userId);
        topic.setTitle(title);
        topic.setContent(content);
        topic.setCreateTime(new Date());
        topic.setUpdateTime(new Date());
        //添加topic
        topicService.addTopic(topic);
        indexPage=new ModelAndView("redirect:/");

        return  indexPage;
    }
}
