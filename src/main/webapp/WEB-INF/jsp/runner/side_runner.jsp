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

    <div class="container-fluid" style="width: 25%;margin:1% 2% 1% 0%;height: 385px;float: right" >
        <!-- 检索 -->
        <div class="panel-heading" style="background-color: white">
            <a style="margin-right: 2%" class="btn <c:if test="${isPickOrderForm==1}">btn-success</c:if>  btn-small"
               href="/intergration/updateOrderformShow?pageIndex=${pageIndex}&shouldOrderByTime=${shouldOrderByTime}&isPickOrderForm=1">接单信息</a>
            <a style="margin-right: 2%" class="btn <c:if test="${isPickOrderForm==0}">btn-success</c:if>  btn-small"
               href="/intergration/updateOrderformShow?pageIndex=${pageIndex}&shouldOrderByTime=${shouldOrderByTime}&isPickOrderForm=0">发单信息</a>
        </div>
        <!-- 订单信息窗口 -->
        <ul class="list-group" style="width: 100%;">
            <c:if test="${isPickOrderForm==1}">
            <c:forEach items="${orderForms_pick}" var="orderfrom">
                <li class="list-group-item">
                    <div style="margin-top: 1px;height: 95px;border:#fffa23 2px;">
                        <div style="float: left;width: 100%;margin-bottom: 5px;display:inline;border:solid 1px;" >
                            <!--第一行：时间点-->
                            <div style="height: 30px;width: 100%;background-color: yellow;">
                                <div style="margin-left: 0.5%;height:24px;width: 48%;display:inline;border:yellow 1px;">
                                    <small class="text-muted">接单于：${orderfrom.localCreateTime1}</small>
                                </div>
                                <div style="float:right;margin-left: 0.5%;height:24px;width: 50%;display:inline;border:black 1px;">
                                    <small class="text-muted">最晚取递时间：${orderfrom.latest_time}</small>
                                </div>
                            </div>
                            <!--第二行-->
                            <div style="margin-top:1px;height: 30px;width: 100%;border:black 1px;">
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">${orderfrom.pickup_ads}</small>
                                </div>
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">${orderfrom.express_company}</small>
                                </div>
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">${orderfrom.goods_size}</small>
                                </div>
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">￥${orderfrom.paymoney}</small>
                                </div>
                            </div>
                            <div style="margin-top:1px;height: 30px;width: 100%;border:black 1px;">
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">name:${orderfrom.user.userName}</small>
                                </div>
                                <div style="margin-left: 2px;float:left;margin-left: 0.5%;width: 24%;display:inline;border:1px red;">
                                    <small class="text-muted">tel:${orderfrom.user.phoneNumber}</small>
                                </div>
                                <div style="margin-left: 2px;float:right;margin-left: 1%;width: 24%;display:inline;border:1px red;">
                                    <button id="showInfo" class="btn btn-success btn-block" href="#" onclick="showInfo_form(${orderfrom.user.credit},${orderfrom.pick_code},${orderfrom.pick_phonenum},'${orderfrom.pick_name}','${orderfrom.remark}')" >取递信息</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </c:forEach>
            </c:if>

            <c:if test="${isPickOrderForm==0}">
                <c:forEach items="${orderForms_put}" var="orderfrom">
                    <li class="list-group-item">
                        <div style="margin-top: 1px;height: 95px;border:#fffa23 2px;">
                            <div style="float: left;width: 100%;margin-bottom: 5px;display:inline;border:solid 1px;" >
                                <!--第一行：时间点-->
                                <div style="height: 30px;width: 100%;background-color: yellow;">
                                    <div style="margin-left: 0.5%;height:24px;width: 48%;display:inline;border:yellow 1px;">
                                        <small class="text-muted">发单于：${orderfrom.localCreateTime}</small>
                                    </div>
                                    <div style="float:right;margin-left: 0.5%;height:24px;width: 50%;display:inline;border:black 1px;">
                                        <small class="text-muted">单号：${orderfrom.order_num}</small>
                                    </div>
                                </div>
                                <!--第二行-->
                                <c:if test="${orderfrom.user.userName==null}">
                                <div style="margin-top:1px;height: 30px;width: 100%;border:black 1px;">
                                    <small class="text-muted" style="color: red;font-family: 'YaHei Consolas Hybrid','Consolas','Microsoft YaHei','Malgun Gothic', 'Segoe UI', 'Helvetica, Arial'">等待接单中！！</small>
                                </div>
                                </c:if>
                                <c:if test="${orderfrom.user.userName!=null}">
                                    <div style="margin-top:1px;height: 30px;width: 100%;border:black 1px;">
                                        <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 48%;display:inline;border:1px red;">
                                            <small class="text-muted" style="width: auto">接单时间:${orderfrom.localCreateTime1}</small>
                                        </div>
                                        <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                            <small class="text-muted">接单人:${orderfrom.user.userName}</small>
                                        </div>
                                        <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 24%;display:inline;border:1px red;">
                                            <small class="text-muted">信用度:${orderfrom.user.credit}</small>
                                        </div>
                                    </div>
                            </c:if>
                            <div style="margin-top:1px;height: 30px;width: 100%;border:black 1px;">
                                <c:if test="${orderfrom.user.userName!=null}">
                                    <div style="margin-left: 2px;float:left;margin-left: 0.5%;width: 24%;display:inline;border:1px red;">
                                        <small class="text-muted">name:${orderfrom.user.userName}</small>
                                    </div>
                                    <div style="margin-left: 2px;float:left;margin-left: 0.5%;width: 24%;display:inline;border:1px red;">
                                        <small class="text-muted">tel:${orderfrom.user.phoneNumber}</small>
                                    </div>
                                    <div style="margin-left: 2px;float:left;margin-left: 0.5%;width: 24%;display:inline;border:1px red;">
                                        <small class="text-muted" style="color: green;font-family: 'YaHei Consolas Hybrid','Consolas','Microsoft YaHei','Malgun Gothic', 'Segoe UI', 'Helvetica, Arial'">派件中！！</small>
                                    </div>
                                </c:if>
                                <div style="margin-left: 2px;float:right;margin-left: 1%;width: 24%;display:inline;border:1px red;">
                                    <button  class="btn btn-success btn-block <c:if test="${orderfrom.order_state==0}" >disabled</c:if>" style="<c:if test="${orderfrom.order_state==0}">cursor:not-allowed;</c:if>" <c:if test="${orderfrom.order_state==1}">onclick="sureGetTheGood(${orderfrom.id})"</c:if>>确认收货</button>
                                </div>
                            </div>
                        </div>
                        </div>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </div>
    <!--历史订单-->
    <!-- 发订单按钮 window.location.href='#'-->
    <div class="panel panel-default" id="sidebar1" style="width: 25%;margin:0% 2% 0% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <button id="history_orderform" class="btn btn-success btn-block" onclick="window.location.href='/intergration/toHistoryOrderForm'">历史订单</button>
        </div>
        <div class="panel-heading" style="background-color: white;text-align: center">
            <button id="signUp" class="btn btn-success btn-block" onclick="window.location.href='/intergration/toSign_order'">申请发单</button>
        </div>
        <%--<div class="panel-heading" style="background-color: white;text-align: center">--%>
            <%--<button id="test" class="btn btn-success btn-block">test</button>--%>
        <%--</div>--%>
    </div>

</c:if>
<script>
    function showInfo_form(credit,code,phonenumber,name,remark){
        alert("委托人信用度:"+credit+"\n取货码："+code+"\n取货手机："+phonenumber+"\n取货姓名:"+name+"\n备注:"+remark);
    }
    function afterComment() {
        var orderform_id1=$("#orderformid").val();
        var grade1=$("input[name='radio']:checked").val();
        var comment1=$("#comment").val();
        // alert(" "+grade1+".."+comment1+" .."+orderform_id1);
        // console.log(orderform_id1+","+grade1+","+comment1);
        if(grade1==''){
            $("#info2").text("提示：评分不能为空！！");
        }else{
            $.ajax({
                type: "post",
                url: "/intergration/afterComment",
                data: {"orderform_id": orderform_id1,
                    "grade":grade1,
                    "comment":comment1},
                dataType: "json",
                success: function (data) {
                    if (data.success_state.trim() == "1") {
                        window.location.href = "/intergration/updateOrderformShow"
                    }
                    else{
                        window.location.href = "/intergration/updateOrderformShow"
                    }
                }
            });
        }
    }

    function sureGetTheGood(id){
        $('#orderformid').val(id);
        $('#myModal').modal('show');
    }

    $("#test").click(function () {
        alert("test");
    });
</script>
