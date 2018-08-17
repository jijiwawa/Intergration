package com.runner;

import com.runner.po.OrderForm;
import com.runner.service.OrderFormService;
import com.runner.service.impl.OrderFormServiceImpl;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderFormMapperTest extends BaseTest{
    @Autowired
    OrderFormServiceImpl orderFormService ;

    @Test
    public void addOrderFormTest(){
        // 获取 Sqlsession
        OrderForm orderForm = new OrderForm();
        orderForm.setClient_id(28);
        orderForm.setOrder_num("123");
        orderForm.setExpress_company("顺丰");
        orderForm.setPickup_ads("上大浴室");
        orderForm.setLatest_time("17:50");
        orderForm.setGoods_size("大");
        orderForm.setPaymoney(BigDecimal.valueOf(12));
        orderForm.setDepute_time(new Timestamp(System.currentTimeMillis()));
        orderForm.setRemark("hello");
        orderForm.setPick_code("120");
        orderForm.setPick_phonenum("18800201151");
        orderForm.setPick_name("苏工");
        orderFormService.addOrderForm(orderForm);
    }

}
