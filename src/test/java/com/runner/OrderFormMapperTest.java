package com.runner;

import com.mainpage.domain.User;
import com.mainpage.service.UserService;
import com.mainpage.service.impl.UserServiceImpl;
import com.runner.po.OrderForm;
import com.runner.service.OrderFormService;
import com.runner.service.impl.OrderFormServiceImpl;
import org.apache.ibatis.session.SqlSession;
import org.aspectj.weaver.ast.Or;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class OrderFormMapperTest extends BaseTest{
    @Autowired
    OrderFormServiceImpl orderFormService ;
    @Autowired
    UserServiceImpl userService;

    @Test
    public void addOrderFormTest(){
        // 获取 Sqlsession
        OrderForm orderForm = new OrderForm();
        orderForm.setClient_id(28);
        orderForm.setOrder_num("1234555555");
        orderForm.setExpress_company("顺丰");
        orderForm.setPickup_ads("上大浴室");
        orderForm.setLatest_time("17:50");
        orderForm.setGoods_size("大");
        orderForm.setPaymoney(new BigDecimal("123"));
        orderForm.setDepute_time(new Timestamp(System.currentTimeMillis()));
        orderForm.setRemark("hello");
        orderForm.setPick_code("120");
        orderForm.setPick_phonenum("18800201151");
        orderForm.setPick_name("苏工");
        orderFormService.addOrderForm(orderForm);
    }
    @Test
    public void addOrderFormTest1() {
        //System.out.println(orderFormService.isOrderNumExist("123"));
        User user=userService.getUserByUserId(31);
        System.out.println(user);
        user.setProperty(new BigDecimal(15.0));
        System.out.println(user.getProperty());
        System.out.println(userService.updateUser(user));
    }

    //测试输出主界面结果
    @Test
    public void addOrderFormTest2() {
        List<OrderForm> showtoall =
                orderFormService.showOrderFormLatest(0);
        for (OrderForm a:showtoall) {
            System.out.println(a.getOrder_num()+","+a.getLatest_time()+","+a.getPick_code()+","+a.getRemark());
        }
    }

    @Test
    public void addOrderFormTest3() {
        OrderForm orderForm = orderFormService.findOrderFormById(13);
        orderForm.setOrder_state(1);
        orderForm.setTrustee_id(31);
        orderForm.setTake_time(new Timestamp(System.currentTimeMillis()));
        orderFormService.updateOrderForm(orderForm);
        System.out.println(orderFormService.getUserPickNum(31));
    }
    @Test
    public void addOrderFormTest4() {
        List<OrderForm> list = orderFormService.getHistoryOrderForm(40);
        for (OrderForm a:list) {
            System.out.println(a);
        }
    }
}
