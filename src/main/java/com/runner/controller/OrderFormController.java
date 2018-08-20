package com.runner.controller;

import com.forum.domain.Topic;
import com.forum.util.PageUtil;
import com.mainpage.domain.User;
import com.mainpage.service.impl.UserServiceImpl;
import com.runner.po.OrderForm;
import com.runner.service.OrderFormService;
import com.runner.service.impl.OrderFormServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.RequestWrapper;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

@Controller
public class OrderFormController {
    @Autowired
    private OrderFormServiceImpl orderFormService;
    @Autowired
    private UserServiceImpl userService;

    /**
     * 实时更新订单信息
     */
    @RequestMapping("/updateOrderformShow")
    @ResponseBody
    public ModelAndView updateOrderformShow(HttpSession session,HttpServletRequest request){
        int pageIndex = 1;//设置初始的当前页，页面显示的都是第一页
        int pageSize = 6;//设置每一页显示几条数据
        int shouldOrderByTime=0;
        PageUtil<Topic> pageUtil = new PageUtil<Topic>();//初始化工具类
        ModelAndView indexPage=new ModelAndView("runner/main_runner");
        if(request.getParameter("pageIndex")!=null){
            pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
        }
        if(request.getParameter("shouldOrderByTime")!=null){
            shouldOrderByTime=Integer.parseInt(request.getParameter("shouldOrderByTime"));
        }
        pageUtil.setPageIndex(pageIndex);
        int orderFormNum=orderFormService.getOrderFormNum();
        pageUtil.setPageNumber(orderFormNum);
        pageUtil.setPageSize(pageSize);
//        pageUtil.setPageCount((int) Math.ceil((double) (pageUtil
//                .getPageNumber() / pageUtil.getPageSize())));
        pageUtil.setPageCount((pageUtil.getPageNumber()%pageSize)==0
                ?(pageUtil.getPageNumber()/pageSize):(pageUtil.getPageNumber()/pageSize+1));
        int index=(pageIndex-1)*pageSize;
        List<OrderForm> orderforms;
        if(shouldOrderByTime==0){//默认照时间先后
            orderforms=orderFormService.showOrderFormLatest(index);
            System.out.println(orderforms.get(0).getDepute_time());
        }else if(shouldOrderByTime==1){
            orderforms=orderFormService.showOrderFormAds(index);
        }
        else if(shouldOrderByTime==2){
            orderforms=orderFormService.showOrderFormMoney(index);
        }
        else if(shouldOrderByTime==3){
            orderforms=orderFormService.showOrderFormSize(index);
        }else{
            orderforms=orderFormService.showOrderFormLatest(index);
        }
        //获取用户信息
        String name=(String) session.getAttribute("username");
        User user=userService.getUserByUserName(name);
        indexPage.addObject("orderforms",orderforms);
        indexPage.addObject("user",user);
        indexPage.addObject("pageUtil",pageUtil);
        indexPage.addObject("shouldOrderByTime",shouldOrderByTime);
        return  indexPage;
    }
    /**
     * 根据id查询订单详情
     */
    @RequestWrapper(className = "/findOrderFormById")
    public String findOrderFormById(Integer id, Model model){
        OrderForm orderForm = orderFormService.findOrderFormById(id);
        model.addAttribute("orderForm",orderForm);
        return "orderForm";
    }
    /**
     * 查询可接的订单
     */
    @RequestWrapper(className = "/show_allorderform")
    public void showAllOrderform(HttpServletRequest request,Model model){
        List<OrderForm> orderForms = orderFormService.showOrderFormLatest(0);
        model.addAttribute("orderForms",orderForms);
    }
    /**
     * 新增订单
     */
    @RequestMapping("/order_form/add")
    @ResponseBody
    public Object addOrderForm(HttpServletRequest request, HttpSession HttpSession){
        HashMap<String, String> res = new HashMap<String, String>();
        if(orderFormService.isOrderNumExist(request.getParameter("order_num"))){
            //订单已存在
            res.put("orderState","0");
        }else {
            //用户余额是否足够
            Integer client_id = (Integer) HttpSession.getAttribute("userId");
            System.out.println((String)request.getParameter("paymoney"));
            BigDecimal paymoney = new BigDecimal((String) request.getParameter("paymoney"));
            User user = userService.getUserByUserId(client_id);
            BigDecimal havemoney = user.getProperty();
            if(havemoney.compareTo(paymoney)>=0){
                OrderForm orderForm = new OrderForm();
                String order_num = (String) request.getParameter("order_num");
                String express_company = (String) request.getParameter("express_company");
                String pickup_ads = (String) request.getParameter("pickup_ads");
                String latest_time = (String) request.getParameter("latest_time");
                String goods_size = (String) request.getParameter("goods_size");
                String remark = (String) request.getParameter("remark");
                Timestamp depute_time= new Timestamp(System.currentTimeMillis());
                String pick_code = (String) request.getParameter("pick_code");
                String pick_phonenum = (String) request.getParameter("pick_phonenum");
                String pick_name = (String) request.getParameter("pick_name");
                orderForm.setClient_id(client_id);
                orderForm.setOrder_num(order_num);
                orderForm.setDepute_time(depute_time);
                orderForm.setExpress_company(express_company);
                orderForm.setPickup_ads(pickup_ads);
                orderForm.setLatest_time(latest_time);
                orderForm.setGoods_size(goods_size);
                orderForm.setPaymoney(paymoney);
                orderForm.setRemark(remark);
                orderForm.setPick_code(pick_code);
                orderForm.setPick_phonenum(pick_phonenum);
                orderForm.setPick_name(pick_name);
                orderFormService.addOrderForm(orderForm);
                // 发单用户扣钱
                user.setProperty(havemoney.subtract(paymoney));
                userService.updateUser(user);
                res.put("orderState","1");
            }
            else{
                //余额不足
                res.put("orderState","2");
            }
        }
        return res;
    }
    /**
     * 点击接单按钮
     */
    @RequestMapping("/pickOrderForm")
    @ResponseBody
    public Object pickOrderForm(HttpServletRequest request, HttpSession HttpSession){
        //获取订单id
        Integer orderform_id = Integer.valueOf(request.getParameter("orderform_id"));
        Integer client_id = (Integer) HttpSession.getAttribute("userId");
        HashMap<String, String> res = new HashMap<String, String>();
        //是否登录
        if(client_id!=null){
            //判断是否自己发出的订单
            if(orderFormService.isMyOrderForm(orderform_id,client_id)){
                res.put("pick_state","0");
                // 是自己发的单，不能接单
            }else {
                //判断信用度是否超过80分
                if(userService.getUserByUserId(client_id).getCredit()<80){
                    res.put("pick_state","1");
                    // 信用不足，不能接单
                }else{
                    // 接单数是否小于等于3
                    if(orderFormService.getUserPickNum(client_id)<3){
                        //是否有未评价的订单
                        if(3<1){
                            //存在未评价订单，不能接单
                            res.put("pick_state","3");
                        }else{
                            //可以接单,将接单人信息接单时间写入，并将订单状态改为1，接单中............
                            OrderForm orderForm = orderFormService.findOrderFormById(orderform_id);
                            orderForm.setTrustee_id(client_id);
                            orderForm.setTake_time(new Timestamp(System.currentTimeMillis()));
                            orderForm.setOrder_state(1);
                            orderFormService.updateOrderForm(orderForm);
                            res.put("pick_state","4");
                        }
                    }else{
                        // 接单数大于3，不能接单
                        res.put("pick_state","2");
                    }
                }
            }
        }else{
            // 未登录
            res.put("pick_state","5");
        }
        return res;
    }

}
