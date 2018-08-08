package com.runner.controller;

import com.runner.dao.OrderFormDao;
import com.runner.po.OrderForm;
import com.runner.service.OrderFormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import javax.xml.ws.RequestWrapper;

@Controller
public class OrderFormController {
    @Autowired
    private OrderFormService orderFormService;
    /**
     * 根据id查询订单详情
     */
    //@RequestWrapper("/findOrderFormById")
    public String findOrderFormById(Integer id, Model model){
        OrderForm orderForm = orderFormService.findOrderFormById(id);
        model.addAttribute("orderForm",orderForm);
        return "orderForm";
    }
}
