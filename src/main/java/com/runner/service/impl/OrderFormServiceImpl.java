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

    /**
     *查
     */
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

    public List<OrderForm> showOrderFormAds(int index) {
        return orderFormDao.showOrderFormAds(index);
    }

    public List<OrderForm> showOrderFormMoney(int index) {
        return orderFormDao.showOrderFormMoney(index);
    }

    public List<OrderForm> showOrderFormSize(int index) {
        return orderFormDao.showOrderFormSize(index);
    }

    //查询订单状态为0的订单数量
    public int getOrderFormNum() {
        return orderFormDao.getOrderFormNum();
    }

    public boolean isMyOrderForm(int order_id,int user_id) {
        return orderFormDao.isMyOrderForm(user_id,order_id)>0;
    }

    //获取某用户接单数state=1
    public int getUserPickNum(int user_id){
        return orderFormDao.getUserPickNum(user_id);
    }

    public List<OrderForm> getPickOrderForm_info(int trustee_id) {
        return orderFormDao.getPickOrderForm_info(trustee_id);
    }

    public List<OrderForm> getDeputeOrderForm_info(int client_id) {
        return orderFormDao.getDeputeOrderForm_info(client_id);
    }

    /**
     *增
     */
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

    /**
     *改
     */
    // 更新订单
    public void updateOrderForm(OrderForm orderForm) {
        orderFormDao.updateOrderForm(orderForm);
    }
    /**
     *删
     */
}

