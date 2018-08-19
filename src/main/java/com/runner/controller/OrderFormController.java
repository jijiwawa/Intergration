package com.runner.controller;

import com.mainpage.domain.User;
import com.mainpage.service.impl.UserServiceImpl;
import com.runner.dao.OrderFormDao;
import com.runner.po.OrderForm;
import com.runner.service.OrderFormService;
import com.runner.service.impl.OrderFormServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.RequestWrapper;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;

@Controller
public class OrderFormController {
    @Autowired
    private OrderFormServiceImpl orderFormService;
    @Autowired
    private UserServiceImpl userService;
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

}
