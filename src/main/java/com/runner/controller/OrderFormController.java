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
    public ModelAndView updateOrderformShow(HttpSession session,HttpServletRequest request){
        int pageIndex = 1;//设置初始的当前页，页面显示的都是第一页
        int pageSize = 6;//设置每一页显示几条数据
        int shouldOrderByTime=0;
        int isPickOrderForm = 1;//判斷是接单还是发单信息
        PageUtil<Topic> pageUtil = new PageUtil<Topic>();//初始化工具类
        ModelAndView indexPage=new ModelAndView("runner/main_runner");
        if(request.getParameter("pageIndex")!=null){
            pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
        }
        if(request.getParameter("shouldOrderByTime")!=null){
            shouldOrderByTime=Integer.parseInt(request.getParameter("shouldOrderByTime"));
        }
        if(request.getParameter("isPickOrderForm")!=null){
            isPickOrderForm=Integer.parseInt(request.getParameter("isPickOrderForm"));
        }
        //获取用户信息
        String name=(String) session.getAttribute("username");
        User user=userService.getUserByUserName(name);
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
        List<OrderForm> orderForms_pick;
        List<OrderForm> orderForms_put;
        //接单信息
        orderForms_put=orderFormService.getDeputeOrderForm_info(user.getId());
        orderForms_pick=orderFormService.getPickOrderForm_info(user.getId());
        if(isPickOrderForm==1){
            isPickOrderForm=1;
        }else{
            isPickOrderForm=0;
        }
        indexPage.addObject("orderforms",orderforms);
        indexPage.addObject("user",user);
        indexPage.addObject("pageUtil",pageUtil);
        indexPage.addObject("pageIndex",pageIndex);
        indexPage.addObject("shouldOrderByTime",shouldOrderByTime);
        indexPage.addObject("orderForms_pick",orderForms_pick);
        indexPage.addObject("orderForms_put",orderForms_put);
        indexPage.addObject("isPickOrderForm",isPickOrderForm);
        return  indexPage;
    }
    @RequestMapping("/updateOrderformShow_1s")
    @ResponseBody
    public Object updateOrderformShow_1s(HttpSession session,HttpServletRequest request){
       HashMap<String,String> res = new HashMap<String, String>();
        res.put("refreshState","1");
       return res;
    }
    /**
     * 个人接单发单信息
     */
    @RequestMapping("/showOrderForm_info")
    public ModelAndView showOrderForm_info(HttpSession session,HttpServletRequest request){
        int isPickOrderForm = 1;
        ModelAndView mav = new ModelAndView("runner/side_runner");
        if(request.getParameter("isPickOrderForm")!=null){
            isPickOrderForm=Integer.parseInt(request.getParameter("isPickOrderForm"));
        }
        String name=(String) session.getAttribute("username");
        User user=userService.getUserByUserName(name);
        List<OrderForm> orderForms_pick = null;
        List<OrderForm> orderForms_put = null;
        //接单信息
//        if(isPickOrderForm==1){
//            orderForms_pick=orderFormService.getPickOrderForm_info(user.getId());
//            isPickOrderForm=1;
//        }else{
//            orderForms_put=orderFormService.getDeputeOrderForm_info(user.getId());
//            isPickOrderForm=0;
//        }
        mav.addObject("orderForms_pick",orderForms_pick);
        mav.addObject("orderForms_put",orderForms_put);
        mav.addObject("user",user);
        mav.addObject("isPickOrderForm",isPickOrderForm);
        return mav;
    }
    @RequestMapping("/showOrderForm_info_before")
    @ResponseBody
    public Object showOrderForm_info_before(HttpSession session,HttpServletRequest request){
        HashMap<String,String> res = new HashMap<String, String>();
        res.put("state_show","1");
        return res;
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
                if(orderFormService.getPutOrderNum(client_id)<3){
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
                }else{
                    res.put("orderState","3");
                }
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

    /**
     * 点击确认收获按钮
     */
    @RequestMapping("/afterComment")
    @ResponseBody
    public Object afterComment(HttpServletRequest request, HttpSession HttpSession){
        //3.确认后，发单者立刻评价接单者，通过公式计算接单着的信用度
        //首先进行评价，获取评价的分数grade和评语 comment
        //计算信用度

        //1.将钱打给接单者，*90%，updateUser
        Integer orderform_id = Integer.valueOf(request.getParameter("orderform_id"));
        Integer client_id = (Integer) HttpSession.getAttribute("userId");
        HashMap<String, String> res = new HashMap<String, String>();
        OrderForm orderForm = orderFormService.findOrderFormById(orderform_id);
        User user = userService.getUserByUserId(orderForm.getTrustee_id());
        user.setProperty(user.getProperty().add(orderForm.getPaymoney().multiply(new BigDecimal(0.9))));
        userService.updateUser(user);
        //2.更改订单状态为2
        orderForm.setOrder_state(2);
        orderFormService.updateOrderForm(orderForm);

        res.put("success_state","1");
        // 接单者在历史订单中评价发单者，评价后同样通过公式计算发单者的信用度
        return res;
    }
}
