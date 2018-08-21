<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<c:if test="${empty userId}">
    <!-- 未登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <blockquote>
                Campus
                <small>一个校园一体化平台</small>
            </blockquote>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item">
                <a  href="/intergration/signin" class="btn btn-primary btn-block">登录</a>
                <a  href="/intergration/signup" class="btn btn-default btn-block">注册</a>
            </li>
        </ul>
    </div>
</c:if>
<script>
    function side_init() {
        $.ajax({
            type:"post",
            url:"/intergration/showOrderForm_info_before",
            data:{"orderform_id":id},
            dataType: "json",
            success: function (data) {
                if(data.state_show==1){
                    window.location.href="/intergration/showOrderForm_info?isPickOrderForm=1"
                }else{
                    window.location.href="/intergration/showOrderForm_info?isPickOrderForm=1"
                }
            }
        });
    }
</script>
<c:if test="${!empty userId}">

    <div class="container-fluid" style="width: 20%;margin:1% 2% 1% 0%;height: 385px;float: right" >
        <!-- 检索 -->
        <div class="panel-heading" style="background-color: white">
            <a style="margin-right: 2%" class="btn <c:if test="${isPickOrderForm==1}">btn-success</c:if>  btn-small"
               href="/intergration/updateOrderformShow?pageIndex=${pageIndex}&shouldOrderByTime=${shouldOrderByTime}&isPickOrderForm=1">接单信息</a>
            <a style="margin-right: 2%" class="btn <c:if test="${isPickOrderForm==0}">btn-success</c:if>  btn-small"
               href="/intergration/updateOrderformShow?pageIndex=${pageIndex}&shouldOrderByTime=${shouldOrderByTime}&isPickOrderForm=0">发单信息</a>
        </div>
        <!-- 订单信息窗口 -->
        <ul class="list-group" style="width: 100%;height: 430px">
            <!-- 从订单表中遍历出未接单的信息显示出来 -->
            <c:if test="${isPickOrderForm==1}">
            <c:forEach items="${orderForms_pick}" var="orderfrom">
                <li class="list-group-item">
                    <div style="height: 50px;border:#fffa23 2px;">
                        <div style="float: left;width: 80%;margin-bottom: 5px;display:inline;border:solid 1px;" >
                            <!--第一行：时间点-->
                            <div style="height: 25px;width: 100%;background-color: yellow;">
                                <div style="margin-left: 0.5%;height:24px;width: 48%;display:inline;border:yellow 1px;">
                                    <small class="text-muted">发单时间：${orderfrom.localCreateTime}</small>
                                </div>
                                <div style="float:right;margin-left: 0.5%;height:24px;width: 50%;display:inline;border:black 1px;">
                                    <small class="text-muted">最晚取递时间：${orderfrom.latest_time}</small>
                                </div>
                            </div>
                            <!--第二行-->
                            <div style="height: 25px;width: 100%;border:black 1px;">
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">取递点：${orderfrom.pickup_ads}</small>
                                </div>
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">快递公司：${orderfrom.express_company}</small>
                                </div>
                                <div style="margin-left: 2px;float:left;margin-left: 1%;height: 24px;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">货物大小：${orderfrom.goods_size}</small>
                                </div>
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">跑腿费：${orderfrom.paymoney}</small>
                                </div>
                            </div>
                        </div>
                        <!--接单按钮-->
                        <div style="width: 6%;float: right;text-align: center;margin-right: 2px;margin-top: 8px;">
                            <button id="creat_order_${orderfrom.id}" class="btn btn-success btn-block" href="#" onclick="pickOrderForm(${orderfrom.id})" >接单</button>
                        </div>
                        <!--备注-->
                        <div style="width: 12%;float: right;text-align: center;margin-right: 1%;" >
                            <textarea class="text-muted" id="remark1" name="remark" readonly="readonly" style="resize:none;width: 141px;height: 53px;background-color: whitesmoke;border: 0px" >备注:${orderfrom.remark}</textarea>
                        </div>
                    </div>
                </li>
            </c:forEach>
            </c:if>
            <c:if test="${isPickOrderForm==0}">
                <c:forEach items="${orderForms_put}" var="orderfrom">
                    <li class="list-group-item">
                        <div style="height: 50px;border:#fffa23 2px;">
                            <div style="float: left;width: 86%;margin-bottom: 5px;display:inline;border:solid 1px;" >
                                <!--第一行：时间点-->
                                <div style="height: 25px;width: 100%;background-color: yellow;">
                                    <div style="margin-left: 0.5%;height:24px;width: 48%;display:inline;border:yellow 1px;">
                                        <small class="text-muted">发单时间：${orderfrom.localCreateTime}</small>
                                    </div>
                                    <div style="float:right;margin-left: 0.5%;height:24px;width: 50%;display:inline;border:black 1px;">
                                        <small class="text-muted">接单时间：${orderfrom.take_time}</small>
                                    </div>
                                </div>
                                <!--第二行-->
                                <div style="height: 25px;width: 100%;border:black 1px;">
                                    <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                        <small class="text-muted">单号：${orderfrom.order_num}</small>
                                    </div>
                                    <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                        <small class="text-muted">接单人：${orderfrom.user.userName}</small>
                                    </div>
                                    <div style="margin-left: 2px;float:left;margin-left: 1%;height: 24px;width: 24%;display:inline;border:1px red;">
                                        <small class="text-muted">接单人手机号码：${orderfrom.user.phoneNumber}</small>
                                    </div>
                                    <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                        <small class="text-muted">信用度：${orderfrom.user.credit}</small>
                                    </div>
                                </div>
                            </div>
                            <!--备注-->
                            <div style="width: 12%;float: right;text-align: center;margin-right: 1%;" >
                                <textarea class="text-muted" id="remark" name="remark" readonly="readonly" style="resize:none;width: 141px;height: 53px;background-color: whitesmoke;border: 0px" >备注:${orderfrom.remark}</textarea>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </div>
    <!--历史订单-->
    <!-- 发订单按钮 window.location.href='#'-->
    <div class="panel panel-default" id="sidebar1" style="width: 20%;margin:0% 2% 0% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <button id="history_orderform" class="btn btn-success btn-block" onclick="updateOrderForm_for_1s()">历史订单</button>
        </div>
        <div class="panel-heading" style="background-color: white;text-align: center">
            <button id="signUp" class="btn btn-success btn-block" onclick="window.location.href='/intergration/toSign_order'">申请发单</button>
        </div>
    </div>

</c:if>

