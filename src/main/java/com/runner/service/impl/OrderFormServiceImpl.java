package com.runner.service.impl;

import com.runner.dao.OrderFormDao;
import com.runner.po.OrderForm;
import com.runner.service.OrderFormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class OrderFormServiceImpl implements OrderFormService {
    //注解注入OrderFormDao
    @Autowired
    private OrderFormDao orderFormDao;
    //根据id查询订单
    public OrderForm findOrderFormById(Integer id) {
        return this.orderFormDao.findOrderFormById(id);
    }
    //根据委托人id查询订单
    public OrderForm findOrderFormByClientId(Integer client_id) {
        return this.orderFormDao.findOrderFormByClientId(client_id);
    }
    //根据接单/受托人id查询订单
    public OrderForm findOrderFormByTrusteeId(Integer trustee_id) {
        return this.orderFormDao.findOrderFormByTrusteeId(trustee_id);
    }
    //查询订单状态为0且按时间最新顺序排列的结果，用于对所有用户显示
    public List<OrderForm> showOrderFormLatest(int index) {
        return orderFormDao.showOrderFormLatest(index);
    }

    //新增订单
    public boolean addOrderForm(OrderForm orderForm) {
        if(isOrderNumExist(orderForm.getOrder_num())){
            return false;
        }else{
            return  this.orderFormDao.addOrderForm(orderForm);
        }
    }
    //新增前检验订单号是否存在
    public boolean isOrderNumExist(String order_num) {
        return orderFormDao.isOrderNumExist(order_num)>0;
    }

    // 更新订单
    public void updateOrderForm(OrderForm orderForm) {
        orderFormDao.updateOrderForm(orderForm);
    }
}

