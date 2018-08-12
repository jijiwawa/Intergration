package com.runner.controller;

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
import java.util.HashMap;

@Controller
public class OrderFormController {
    @Autowired
    private OrderFormServiceImpl orderFormService;
    /**
     * 根据id查询订单详情
     */
    @RequestWrapper(className = "findOrderFormById")
    public String findOrderFormById(Integer id, Model model){
        OrderForm orderForm = orderFormService.findOrderFormById(id);
        model.addAttribute("orderForm",orderForm);
        return "orderForm";
    }
    /**
     * 新增订单
     */
    @RequestMapping("orderForm/add")
    @ResponseBody
    public Object addOrderForm(HttpServletRequest request, HttpSession HttpSession){
        HashMap<String, String> res = new HashMap<String, String>();
        if(orderFormService.isOrderNumExist(request.getParameter("order_num"))){
            //用户名已存在
            res.put("stateCode","0");
        }else {
            OrderForm orderForm = new OrderForm();
            Integer client_id = (Integer) HttpSession.getAttribute("userId");
            String order_num = (String) request.getAttribute("order_num");
            String express_company = (String) request.getAttribute("express_company");
            String pickup_ads = (String) request.getAttribute("pickup_ads");
            String latest_time = (String) request.getAttribute("latest_time");
            String goods_size = (String) request.getAttribute("goods_size");
            BigDecimal paymoney = (BigDecimal) request.getAttribute("paymoney");
            String remark = (String) request.getAttribute("remark");
            String pick_code = (String) request.getAttribute("pick_code");
            String pick_phonenum = (String) request.getAttribute("pick_phonenum");
            String pick_name = (String) request.getAttribute("pick_name");
            orderForm.setClient_id(client_id);
            orderForm.setOrder_num(order_num);
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
            res.put("stateCode","1");
        }
        return res;
    }

}