package com.runner.po;

import com.mainpage.domain.User;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 订单持久化类
 */
public class OrderForm {
    private Integer id;                      //主键id
    private String order_num;                //订单号
    private String express_company;           //快递公司
    private String pickup_ads;               //取货地点
    private String latest_time;             //最晚取货时间
    private String goods_size;               //货物大小
    private BigDecimal paymoney;             //支付金额
    private Integer client_id;               //委托人id
    private String remark;                   //备注（货物描述）
    private Timestamp depute_time;           //委托时间
    private Integer trustee_id;              //受托人id
    private Timestamp take_time;             //接单时间
    private String pick_code;                //取货码
    private String pick_phonenum;            //取货手机号码
    private String pick_name;                //取货所需姓名
    private Integer order_state ;            // 订单状态0待接单，1被接单，运送中，2已收货，3废弃或者暂时不用
    private User user;               //若本人是接单人，则该User是发单人，反之

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrder_num() {
        return order_num;
    }

    public void setOrder_num(String order_num) {
        this.order_num = order_num;
    }

    public String getExpress_company() {
        return express_company;
    }

    public void setExpress_company(String express_company) {
        this.express_company = express_company;
    }

    public String getPickup_ads() {
        return pickup_ads;
    }

    public void setPickup_ads(String pickup_ads) {
        this.pickup_ads = pickup_ads;
    }

    public String getLatest_time() {
        return latest_time;
    }

    public void setLatest_time(String  latest_time) {
        this.latest_time = latest_time;
    }

    public String getGoods_size() {
        return goods_size;
    }

    public void setGoods_size(String goods_size) {
        this.goods_size = goods_size;
    }

    public BigDecimal getPaymoney() {
        return paymoney;
    }

    public void setPaymoney(BigDecimal paymoney) {
        this.paymoney = paymoney;
    }

    public Integer getClient_id() {
        return client_id;
    }

    public void setClient_id(Integer client_id) {
        this.client_id = client_id;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Timestamp getDepute_time() {
        return depute_time;
    }

    public void setDepute_time(Timestamp depute_time) {
        this.depute_time = depute_time;
    }

    public Integer getTrustee_id() {
        return trustee_id;
    }

    public void setTrustee_id(Integer trustee_id) {
        this.trustee_id = trustee_id;
    }

    public Date getTake_time() {
        return take_time;
    }

    public void setTake_time(Timestamp take_time) {
        this.take_time = take_time;
    }

    public String getPick_code() {
        return pick_code;
    }

    public void setPick_code(String pick_code) {
        this.pick_code = pick_code;
    }

    public String getPick_phonenum() {
        return pick_phonenum;
    }

    public void setPick_phonenum(String pick_phonenum) {
        this.pick_phonenum = pick_phonenum;
    }

    public String getPick_name() {
        return pick_name;
    }

    public void setPick_name(String pick_name) {
        this.pick_name = pick_name;
    }

    public Integer getOrder_state() {
        return order_state;
    }

    public void setOrder_state(Integer order_state) {
        this.order_state = order_state;
    }

    public String getLocalCreateTime() {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");//设置日期格式
        String date = df.format(this.depute_time);
        return date;
    }
}
