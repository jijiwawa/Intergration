package com.runner.service;

import com.runner.po.OrderForm;

public interface OrderFormService {
    //根据id查询订单
    public OrderForm findOrderFormById(Integer id);
    //根据委托人id查询订单
    public OrderForm findOrderFormByClientId(Integer client_id);
    //根据接单/受托人id查询订单
    public OrderForm findOrderFormByTrusteeId(Integer trustee_id);

    //新增订单
    public boolean addOrderForm(OrderForm orderForm);
    //新增前检验订单号是否存在
    public boolean isOrderNumExist(String order_num);



    // 更新订单
    public void updateOrderForm(OrderForm orderForm);

}
