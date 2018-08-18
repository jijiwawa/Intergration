package com.forum.controller;

import com.forum.domain.Reply;
import com.forum.domain.Topic;
import com.forum.service.ReplyService;
import com.forum.service.impl.TopicServiceImpl;
import com.forum.util.PageUtil;
import com.mainpage.domain.User;
import com.mainpage.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/forum")
public class TopicController {
    @Autowired
    public TopicServiceImpl topicService;
    @Autowired
    public UserServiceImpl userService;
    @Autowired
    public ReplyService replyService;

    @RequestMapping("/main")
    public ModelAndView toMain(HttpSession session,HttpServletRequest request){
        int pageIndex = 1;//设置初始的当前页，页面显示的都是第一页
        int pageSize = 4;//设置每一页显示几条数据
        int shouldOrderByTime=0;
        PageUtil<Topic> pageUtil = new PageUtil<Topic>();//初始化工具类
        ModelAndView indexPage=new ModelAndView("forum/main");
        if(request.getParameter("pageIndex")!=null){
            pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
        }
        if(request.getParameter("shouldOrderByTime")!=null){
            shouldOrderByTime=Integer.parseInt(request.getParameter("shouldOrderByTime"));
        }
        pageUtil.setPageIndex(pageIndex);
        int topicsNum=topicService.getTopicsNum();
        pageUtil.setPageNumber(topicsNum);
        pageUtil.setPageSize(pageSize);
//        pageUtil.setPageCount((int) Math.ceil((double) (pageUtil
//                .getPageNumber() / pageUtil.getPageSize())));
        pageUtil.setPageCount((pageUtil.getPageNumber()%pageSize)==0
        ?(pageUtil.getPageNumber()/pageSize):(pageUtil.getPageNumber()/pageSize+1));
        int index=(pageIndex-1)*pageSize;
        List<Topic> topics;
        if(shouldOrderByTime==0){
            topics=topicService.listTopicsAndUsers(index);
        }else{
            topics=topicService.listMostCommentsTopics(index);
        }
        //获取用户信息
        String name=(String) session.getAttribute("username");
        User user=userService.getUserByUserName(name);
        indexPage.addObject("topics",topics);
        indexPage.addObject("user",user);
        indexPage.addObject("pageUtil",pageUtil);
        indexPage.addObject("shouldOrderByTime",shouldOrderByTime);
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
    @ResponseBody
    public Object postTopic(HttpSession session, HttpServletRequest request){
        HashMap<String, String> res = new HashMap<String, String>();
        //未登陆
        if(session.getAttribute("userId")==null){
            res.put("stateCode", "0");
            return res;
        }
        //处理参数
        int userId=(Integer) session.getAttribute("userId");
        int userType=(Integer)session.getAttribute("userType");
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
        if(userType!=0) {
            topicService.addTopic(topic);
            res.put("stateCode", "2");
        }else {
            res.put("stateCode", "1");
        }
        return res;
    }

    @RequestMapping("/t/{id}")
    public ModelAndView toTopic(@PathVariable("id")Integer id, HttpSession session){
        //点击量加一
        boolean ifSucc=topicService.clickAddOne(id);
        //获取主题信息
        Topic topic=topicService.selectById(id);
        //获取主题全部评论
        List<Reply> replies=replyService.getRepliesOfTopic(id);
        //获取评论数
        int repliesNum=replyService.repliesNum(id);
        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        //获取用户信息
        int uid=(Integer) session.getAttribute("userId");
        String name=(String) session.getAttribute("username");
        User user=userService.getUserByUserName(name);
        //最热主题

        int allowUpdate=0;
        //渲染视图
        ModelAndView topicPage=new ModelAndView("forum/detail");
        topicPage.addObject("topic",topic);
        topicPage.addObject("replies",replies);
        topicPage.addObject("repliesNum",repliesNum);
        topicPage.addObject("topicsNum",topicsNum);
        topicPage.addObject("user",user);
        if(topic.getUserId()==uid){
            allowUpdate=1;
        }
        topicPage.addObject("allowUpdate",allowUpdate);
        return topicPage;
    }

    @RequestMapping(value = "/addreply",method = RequestMethod.POST)
    public ModelAndView addReply(HttpServletRequest request, HttpSession session){
        //处理参数
        int topicId=Integer.parseInt(request.getParameter("topicId"));
        Integer replyUserId=Integer.parseInt(request.getParameter("replyUserId"));
        String content=request.getParameter("content");
        //创建reply
        Reply reply=new Reply();
        reply.setTopicId(topicId);
        reply.setReplyUserId(replyUserId);
        reply.setContent(content);
        reply.setCreateTime(new Date());
        //执行添加
        boolean ifSucc=replyService.addReply(reply);

        //新建视图
        ModelAndView view=new ModelAndView("redirect:/forum/t/"+topicId);
        return view;
    }

    @RequestMapping("/topic/updatepage")
    public ModelAndView updatePage(HttpSession session,HttpServletRequest request){
        int id=Integer.parseInt(request.getParameter("id").trim());
        int uid=(Integer) session.getAttribute("userId");
        Topic topic=topicService.selectById(id);
        ModelAndView res=new ModelAndView("main");
        if(uid==topic.getUserId()){
        res=new ModelAndView("forum/update_topic");
        res.addObject("topic",topic);
        }
        return res;
    }
    @RequestMapping("/topic/updatedo")
    @ResponseBody
    public Object updateTopic(HttpSession session, HttpServletRequest request) {
        HashMap<String, String> res = new HashMap<String, String>();
        //未登陆
        if(session.getAttribute("userId")==null){
            res.put("stateCode", "0");
            return res;
        }
        //处理参数
        int userId=(Integer) session.getAttribute("userId");
        int userType=(Integer)session.getAttribute("userType");
        String title=request.getParameter("title");
        String content=request.getParameter("content");
        int id=Integer.parseInt((String)request.getParameter("id").trim());
        //新建Topic
        Topic topic=new Topic();
        topic.setId(id);
        topic.setTitle(title);
        topic.setContent(content);
        //添加topic
        if(userType!=0) {
            topicService.updateTopic(topic);
            res.put("stateCode", "2");
        }else {
            res.put("stateCode", "1");
        }
        return res;
    }
}
