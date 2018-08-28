<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="Content-Type"  content="text/html;charset=utf-8">
    <meta name="keywords" content="intergration,论坛,社区,程序员">
    <title>跑腿</title>
    <link href="/intergration/css/bootstrap.min.css" rel="stylesheet">
    <script src="/intergration/js/jquery-3.2.1.js"></script>
    <script src="/intergration/js/bootstrap.min.js"></script>
    <style>
        li {list-style-type:none;}
        html, body {
            height: 100%;
            font-size: 14px;
            color: #525252;
            font-family: NotoSansHans-Regular,AvenirNext-Regular,arial,Hiragino Sans GB,"Microsoft Yahei","Hiragino Sans GB","WenQuanYi Micro Hei",sans-serif;
            background: #f0f2f5;
        }
        .footer {
            background-color: #fff;
            margin-top: 22px;
            margin-bottom: 22px;
            width: 100%;
            padding-top: 22px;
            color: #8A8A8A;
            display: block;
            height: 200px;
            border: 1px ;
            clear:both
        }

        .container {
            margin-right: 5%;
            margin-left: 5%;
            padding-left: 15px;
            padding-right: 15px;
            width: 40%;
            float: left;
        }
        .info {
            margin-right: 5%;
            width: 10%;
            float: left;
        }
        a{
            color: #8A8A8A;
            cursor: pointer;
        }
    </style>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="../header.jsp"%>

<div class="panel panel-default" style="width: 65%;margin:1% 2% 5% 5%;float: left;" id="updateOrderForm_div">
    <!-- 检索 -->
    <div class="panel-heading" style="background-color: white">
        <a style="margin-right: 2%" class="btn <c:if test="${shouldOrderByTime==0}">btn-success</c:if>  btn-small"
           href="/intergration/updateOrderformShow?pageIndex=1&shouldOrderByTime=0">最新</a>
        <a style="margin-right: 2%" class="btn <c:if test="${shouldOrderByTime==1}">btn-success</c:if>  btn-small"
           href="/intergration/updateOrderformShow?pageIndex=1&shouldOrderByTime=1">取货点</a>
        <a style="margin-right: 2%" class="btn <c:if test="${shouldOrderByTime==2}">btn-success</c:if>  btn-small"
           href="/intergration/updateOrderformShow?pageIndex=1&shouldOrderByTime=2">收益</a>
        <a style="margin-right: 2%" class="btn <c:if test="${shouldOrderByTime==3}">btn-success</c:if>  btn-small"
           href="/intergration/updateOrderformShow?pageIndex=1&shouldOrderByTime=3">货物大小</a>
    </div>
    <!-- 订单信息窗口 -->
    <ul class="list-group" style="width: 100%;height: 430px">
        <!-- 从订单表中遍历出未接单的信息显示出来 -->
        <c:forEach items="${orderforms}" var="orderfrom">
            <li class="list-group-item">
                <div style="height: 50px;border:#fffa23 2px;">
                    <div style="float: left;width: 80%;margin-bottom: 5px;display:inline;border:solid 1px;" >
                        <!--第一行：时间点-->
                        <div style="height: 25px;width: 100%;background-color: yellow;">
                            <div style="float:left;margin-left: 0.5%;height:24px;width: 32%;display:inline;border:yellow 1px;">
                                <small class="text-muted">发单时间：${orderfrom.localCreateTime}</small>
                            </div>
                            <div style="margin-left: 0.5%;height:24px;width: 32%;display:inline;border:yellow 1px;">
                                <small class="text-muted">单号：${orderfrom.order_num}</small>
                            </div>
                            <div style="float:right;margin-left: 0.5%;height:24px;width: 32%;display:inline;border:black 1px;">
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
                    <div style="width: 6%;float: right;text-align: center;margin-right: 1%;margin-top: 8px;">
                        <button id="creat_order_${orderfrom.id}" class="btn btn-success btn-block" href="#" onclick="pickOrderForm(${orderfrom.id})" >接单</button>
                    </div>
                    <!--备注-->
                    <div style="width: 12%;float: right;text-align: center;margin-right: 1%;" >
                        <textarea class="text-muted" id="remark" name="remark" readonly="readonly" style="resize:none;width: 141px;height: 53px;background-color: whitesmoke;border: 0px" >备注:${orderfrom.remark}</textarea>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
    <!--分页功能-->
    共<b>${pageUtil.pageNumber}</b>条
    <a class="btn  btn-small" href="/intergration/updateOrderformShow?pageIndex=1&shouldOrderByTime=${shouldOrderByTime}" >首页</a>
    <a class="btn  btn-small" href="/intergration/updateOrderformShow?pageIndex=
<c:if test="${pageUtil.pageIndex>1}">${pageUtil.pageIndex-1}</c:if>
<c:if test="${pageUtil.pageIndex==1}">1</c:if>&shouldOrderByTime=${shouldOrderByTime}" >上一页</a>
    <c:forEach begin="1" end="${pageUtil.pageCount}" var="i">
        <a class="btn <c:if test="${pageUtil.pageIndex==i}">btn-success</c:if> btn-small"
           href="/intergration/updateOrderformShow?pageIndex=${i}&shouldOrderByTime=${shouldOrderByTime}" >${i}</a>
    </c:forEach>
    <a class="btn  btn-small" href="/intergration/updateOrderformShow?pageIndex=
<c:if test="${pageUtil.pageIndex<pageUtil.pageCount}">${pageUtil.pageIndex+1}</c:if>
<c:if test="${pageUtil.pageIndex==pageUtil.pageCount}">${pageUtil.pageCount}</c:if>&shouldOrderByTime=${shouldOrderByTime}">下一页</a>
    <a class="btn  btn-small" href="/intergration/updateOrderformShow?pageIndex=${pageUtil.pageCount}&shouldOrderByTime=${shouldOrderByTime}" >末页</a>
</div>
<%@ include file="../text.jsp"%>
<!-- 引入侧边栏文件 -->
<%@ include file="side_runner.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="../footer.jsp"%>
</body>
<script>
    function pickOrderForm(id){
        $.ajax({
            type:"post",
            url:"/intergration/pickOrderForm",
            data:{"orderform_id":id},
            dataType: "json",
            success: function (data) {
                if (data.pick_state.trim() == "0") {
                    alert("提示：这是您发出的订单，不能接！！");
                } else if (data.pick_state.trim() == "1") {
                    alert("提示：信用度不足，不能接！！");
                } else if(data.pick_state.trim()=="2"){
                    alert("提示：已接单数为3，不能接！！！");
                } else if(data.pick_state.trim()=="3"){
                    alert("提示：存在未评价的订单，不能接！！！");
                }else if(data.pick_state.trim()=="4"){
                    alert("提示：接单成功！！！");
                    window.location.href = "/intergration/updateOrderformShow"
                }else if(data.pick_state.trim()=="5"){
                    alert("提示：若想接单，请先登录！");
                }
            }
        });
    }
    function updateOrderForm_for_1s(){
        var count=0;
        $.ajax({
            type:"post",
            url:"/intergration/updateOrderformShow_1s",
            async : false,  //同步请求
            dataType: "json",
            success:function(data){
                //alert(dates);
                //alert("#count");$("#updateOrderForm_div").html(data.orderforms,data.pageUtil,data.shouldOrderByTime); //要刷新的div
                //count=count+1;
               // alert("1");
                if(data.refreshState.trim() == "1"){
                    //alert("2");
                    window.location.href = "/intergration/updateOrderformShow"

                   // alert("3");
                    setTimeout(updateOrderForm_for_1s(),3000);
                }else{
                    alert("it is too lazy!!")
                }
            },
            error: function() {
                alert("失败，请稍后再试！");
            }
        });

    }

    $("#waitWork").click(function(){
        var url = "请求地址";
        var data = {type:1};
        $.ajax({
            type : "get",
            async : false,  //同步请求
            url : url,
            data : data,
            timeout:1000,
            success:function(dates){
                //alert(dates);
                $("#mainContent").html(dates);//要刷新的div
            },
            error: function() {
                // alert("失败，请稍后再试！");
            }
        });
    });

</script>
</html>
