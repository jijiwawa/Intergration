package com.runner.dao;
import com.runner.po.OrderForm;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * OrderForm接口文件
 */
public interface OrderFormDao {
    /**
     * 增
     */
    //新增订单，添加成功返回1
    public boolean addOrderForm(OrderForm orderForm);
    //新增前检验订单号是否存在
    public int isOrderNumExist(String order_num);
    /**
     * 删
     */
    public void deleteOrderForm(OrderForm orderForm);
    /**
     * 查
     */
    //根据id查询订单
    public OrderForm findOrderFormById(Integer id);
    //根据委托人id查询订单
    public OrderForm findOrderFormByClientId(Integer client_id);
    //根据接单/受托人id查询订单
    public OrderForm findOrderFormByTrusteeId(Integer trustee_id);
    //查询订单状态为0且按时间最新顺序排列的结果，用于对所有用户显示
    public List<OrderForm> showOrderFormLatest(int index);
    //取货地点排序
    public List<OrderForm> showOrderFormAds(int index);
    //查收益排序
    public List<OrderForm> showOrderFormMoney(int index);
    //货物大小顺序排序
    public List<OrderForm> showOrderFormSize(int index);
    //查询订单状态为0的订单数量
    public int getOrderFormNum();
    //判断订单号是否自己发出的
    public int isMyOrderForm(@Param("order_id")int order_id,@Param("user_id")int user_id);
    //获取某用户接单数state=08
    public int getUserPickNum(int user_id);
    //获取接单信息
    public List<OrderForm> getPickOrderForm_info(int trustee_id);
    //获取接单信息
    public List<OrderForm> getDeputeOrderForm_info(int client_id);
    //获取该用户发单次数
    public int getPutOrderNum(int client_id);
     /**
     * 改
     */
    public void updateOrderForm(OrderForm orderForm);
}
