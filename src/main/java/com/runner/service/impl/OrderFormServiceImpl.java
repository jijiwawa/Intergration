package com.runner.service.impl;

import com.runner.dao.OrderFormDao;
import com.runner.po.OrderForm;
import com.runner.service.OrderFormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
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
}
