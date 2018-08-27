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
<%@ include file="side_runner_left.jsp"%>
<div class="pre-scrollable" style="width: 73%;margin:1% 2% 5% 5%;align-self: center;" >
    <!-- 历史订单信息窗口 -->
    <ul class="list-group" style="width: 100%;height: 430px">
        <!-- 从订单表中遍历出未接单的信息显示出来 -->
        <c:if test="${history_orderform==null}">！！！您还未有任何交易完成记录！！！</c:if>
        <c:forEach items="${history_orderform}" var="orderfrom">
            <li class="list-group-item">
                <div style="height: 140px;border:#fffa23 2px;">
                    <div style="float: left;width: 100%;margin-bottom: 0.02%;margin-top: 0.02%;display:inline;border:solid 1px;" >
                        <!--第一行：时间点-->
                        <div style="height: 24px;width: 100%;">
                            <div style="margin-left: 0.3%;height:24px;width: 33%;display:inline;border:yellow 1px;">
                                <small class="text-muted" style="<c:if test="${orderfrom.trustee_id==userId}">background-color: yellow;</c:if>"><c:if test="${orderfrom.client_id==userId}">发单</c:if>
                                    <c:if test="${orderfrom.trustee_id==userId}">接单</c:if></small>
                            </div>
                            <div style="float:right;margin-left: 0.3%;height:24px;width: 33%;display:inline;border:black 1px;">
                                <small class="text-muted">接单时间：${orderfrom.localCreateTime1}</small>
                            </div>
                            <div style="margin-left: 0.3%;height:24px;width: 33%;display:inline;border:yellow 1px;float: right;">
                                <small class="text-muted">发单时间：${orderfrom.localCreateTime}</small>
                            </div>

                        </div>
                        <!--第二行-->
                        <div style="height: 32px;width: 100%;border:black 1px;">
                            <div style="margin-left: 2px;float:left;margin-left: 0.5%;height: 24px;width: 48%;display:inline;border:1px red;background-color: #00a8c6">
                                <small class="text-muted">单号：${orderfrom.order_num}</small>
                            </div>
                            <div style="margin-left: 2px;float:right;margin-left: 0.5%;height: 30px;width: 48%;display:inline;">
                                <button id="creat_order_${orderfrom.id}" class="btn btn-success btn-block" onclick="showHistoryFormInfo('${orderfrom.express_company}','${orderfrom.goods_size}','${orderfrom.paymoney}')"  style="height: auto;">详细信息</button>
                            </div>
                        </div>
                        <!--用户是发单人-->
                        <c:if test="${orderfrom.client_id==userId}">
                            <!--第三行-->
                            <div style="width: 100%;text-align: center;margin-right: 1%;height: 24px">
                                <label for="txt_${orderfrom.id}_1" style="float: left;width: 20%;">您对跑腿者的评价：</label>
                                <input id="txt_${orderfrom.id}_1" style="width: 78%;float: right;resize:none;" readonly="readonly" value="${orderfrom.trustee_comment}" >
                            </div>
                            <c:if test="${orderfrom.client_comment!=null}">
                                <div style="width: 100%;margin-top: 5px;text-align: center;margin-right: 1%;height: 24px;">
                                    <label for="txt1_${trustee.id}" style="float: left;width: 20%;">接单人对你的评价：</label>
                                    <input id="txt1_${trustee.id}" style="width: 78%;float: right;resize:none" readonly="readonly" value="${orderfrom.client_comment}">
                                </div>
                            </c:if>
                             <c:if test="${orderfrom.client_comment==null}">
                                 <div style="width: 100%;margin-top: 5px;text-align: center;margin-right: 1%;height: 24px;">
                                     <small class="text-muted" style="color: red;font-family: 'YaHei Consolas Hybrid','Consolas','Microsoft YaHei','Malgun Gothic', 'Segoe UI', 'Helvetica, Arial'">接单人未对你进行评价！！</small>
                                 </div>
                             </c:if>
                        </c:if>
                        <!--用户是接单人-->
                        <c:if test="${orderfrom.trustee_id==userId}">
                            <div style="width: 100%;text-align: center;margin-right: 1%;height: 24px">
                                <label for="txt_${orderfrom.id}_1" style="float: left;width: 20%;">发单人对你的评价：</label>
                                <input id="txt_${orderfrom.id}_1" style="width: 78%;float: right;resize:none;" readonly="readonly" value="${orderfrom.trustee_comment}">
                            </div>
                            <div style="width: 100%;margin-top: 5px;text-align: center;margin-right: 1%;height: 24px;">
                                <c:if test="${orderfrom.client_comment==null}">
                                    <small class="text-muted" style="color: red;font-family: 'YaHei Consolas Hybrid','Consolas','Microsoft YaHei','Malgun Gothic', 'Segoe UI', 'Helvetica, Arial'">您还为评价发单者，请<a onclick="commentClient('${orderfrom.id}')">评价发单者</a></small>
                                </c:if>
                                <c:if test="${orderfrom.client_comment!=null}">
                                    <label for="txt1_${trustee.id}" style="float: left;width: 20%;">你对发单者的评价：</label>
                                    <input id="txt1_${trustee.id}" style="width: 78%;float: right;resize:none" readonly="readonly" value="${orderfrom.client_comment}" >
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
<%@ include file="commentClient.jsp"%>


<!-- 引入footer文件 -->
<%@ include file="../footer.jsp"%>
</body>
<script>
    function showHistoryFormInfo(express_company,goods_size,paymoney){
        alert("快递公司："+express_company+"\n货物大小："+goods_size+"\n该单金额："+paymoney)
    }
    function commentClient(id){
        $('#orderformid1').val(id);
        $('#myModal1').modal('show');
    }

    function afterCommentClient1() {
        var orderform_id1 = $("#orderformid1").val();
        var grade1 = $("input[name='radio1']:checked").val();
        var comment1 = $("#comment1").val();
        alert(" "+grade1+".."+comment1+" .."+orderform_id1);
        //console.log(orderform_id1 + "," + grade1 + "," + comment1);
        if(grade1==''){
            $("#info1").text("提示：评分不能为空！！");
        }else{
            $.ajax({
                type: "post",
                url: "/intergration/afterCommentClient",
                data: {
                    "orderform_id": orderform_id1,
                    "grade": grade1,
                    "comment": comment1
                },
                dataType: "json",
                success: function (data) {
                    if (data.success_state.trim() == "1") {
                        window.location.href = "/intergration/toHistoryOrderForm"
                    }
                    else {
                        window.location.href = "/intergration/toHistoryOrderForm"
                    }
                }
            });
        }
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
