package com.mainpage.controller;

import com.mainpage.domain.User;
import com.mainpage.service.impl.UserServiceImpl;
import com.mainpage.util.ProduceMD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

@Controller
public class UserController {
    @Autowired
    private UserServiceImpl userService;

    @RequestMapping("/user/add")
    @ResponseBody
    public Object addUser(HttpServletRequest request){

        HashMap<String, String> res = new HashMap<String, String>();
        if(userService.isUserNameExist(request.getParameter("username"))){
            //用户名已存在
            res.put("stateCode","0");
        }else {
            User user = new User();
            int isMale = request.getParameter("isMale").equals("男") ? 0 : 1;
            Random rand = new Random();
            int randomNum = rand.nextInt(10) + 1;
            String headSculptureUrl = "/img/avatar/avatar-default-" + randomNum + ".png";
            String password = ProduceMD5.getMD5(request.getParameter("password"));
            user.setUserName(request.getParameter("username"));
            user.setPhoneNumber(request.getParameter("tel"));
            user.setIsMale((byte) isMale);
            user.setPassword(password);
            user.setHeadSculpture(headSculptureUrl);
            userService.addUser(user);
            res.put("stateCode","1");
        }
        return res;
    }

    @RequestMapping("/user/loginCheck")
    @ResponseBody
    public Object signInCheck(HttpServletRequest request,HttpSession session){

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

    @RequestMapping("/user/signout")
    public String signOut(HttpSession session){
        session.removeAttribute("userId");
        session.removeAttribute("username");
        return "redirect:/";
    }

    @RequestMapping("/user/settings")
    public ModelAndView settings(HttpSession session){
        User user=userService.getUserByUserName((String)session.getAttribute("username"));
        ModelAndView modelAndView=new ModelAndView("settings");
        modelAndView.addObject("user",user);
        return modelAndView;
    }

    @RequestMapping(value = "/user/settings/headsculpture",method = RequestMethod.GET)
    public ModelAndView updateHeadSculpture(HttpServletRequest request, HttpSession session){

        User user=userService.getUserByUserName((String)session.getAttribute("username"));

        ModelAndView mv=new ModelAndView("update_headsculpture");
        mv.addObject("user",user);
        return mv;
    }

    @RequestMapping(value = "/user/settings/headsculpture/update",method = RequestMethod.POST)
    public ModelAndView updateHeadSculptureDo(@RequestPart("avatar")MultipartFile avatarFile, HttpServletRequest request, HttpSession session){
        Integer uid=(Integer) session.getAttribute("userId");

        String fileName=avatarFile.getOriginalFilename();
        String suffix=fileName.substring(fileName.lastIndexOf(".")+1, fileName.length());
        Long date=new Date().getTime();
        String newFileName=date+"-"+uid+"."+suffix;
        String absolutePath=session.getServletContext().getRealPath("/static/img/avatar")+"/"+newFileName;
        String relativePath="/img/avatar"+"/"+newFileName;
        User newUser=new User();
        newUser.setHeadSculpture(relativePath);
        newUser.setId(uid);
        File file=new File(absolutePath);

        if (!file.exists()){
            try {
                avatarFile.transferTo(file);
                userService.updateUser(newUser);
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        User user=userService.getUserByUserName((String)session.getAttribute("username"));
        ModelAndView mv=new ModelAndView("update_headsculpture");
        mv.addObject("user",user);
        return mv;
    }

    @RequestMapping(value = "/user/settings/password",method = RequestMethod.GET)
    public ModelAndView updatePassword(HttpServletRequest request, HttpSession session){

        User user=userService.getUserByUserName((String)session.getAttribute("username"));

        ModelAndView mv=new ModelAndView("update_password");
        mv.addObject("user",user);
        return mv;
    }

    @RequestMapping(value="/user/settings/password/update",method = RequestMethod.POST)
    @ResponseBody
    public Object updatePasswordDo(HttpSession session,HttpServletRequest request){
        Integer uid=(Integer) session.getAttribute("userId");
        String password=ProduceMD5.getMD5(request.getParameter("password"));
        HashMap<String, String> res = new HashMap<String, String>();
        User newUser=new User();
        newUser.setId(uid);
        newUser.setPassword(password);
        boolean hasUpdate=userService.updateUser(newUser);
        if(hasUpdate){
            session.removeAttribute("userId");
            session.removeAttribute("username");
            res.put("stateCode", "1");
        }else{
            res.put("stateCode", "0");
        }
        return res;
    }

    @RequestMapping("/member/{username}")
    public ModelAndView personalCenter(@PathVariable("username")String username, HttpSession session){
        boolean ifExistUser=userService.isUserNameExist(username);

        ModelAndView mv=new ModelAndView("user_info");
        if (ifExistUser){
            User resultUser=userService.getUserByUserName(username);
            mv.addObject("user",resultUser);
            return mv;
        }else {
            String errorInfo=new String("会员未找到");
            mv.addObject("errorInfo",errorInfo);
            return mv;
        }
    }

}
