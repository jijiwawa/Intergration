<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册 - Campus</title>
    <link href="/Intergration/css/bootstrap.min.css" rel="stylesheet">
    <script src="/Intergration/js/jquery-3.2.1.js"></script>
    <script src="/Intergration/js/bootstrap.min.js"></script>
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
<%@ include file="header.jsp"%>

<div class="panel panel-default" id="login" style="width: 30%;margin-left: 35%;margin-top: 5%;margin-bottom: 5%">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title" align="center">发布订单请求</h3>
    </div>
    <div class="panel-body">
            <div class="form-group" >
                <label >快递公司</label>
                <select class="form-control" id="express_company" name="express_company">
                    <option value="default">---请选择---</option>
                    <option value="顺丰">顺丰</option>
                    <option value="申通">申通</option>
                    <option value="顺风">圆通</option>
                    <option value="顺风">天天</option>
                    <option value="顺风">EMS</option>
                    <option value="顺风">中通</option>
                    <option value="顺风">韵达</option>
                    <option value="顺风">万象物流</option>
                    <option value="顺风">菜鸟驿站</option>
                </select>
                <label >快递单号</label>
                <input type="text" class="form-control" id="order_num" name="order_num">
            </div>

            <div class="form-group">
                <label >取货地点</label>
                    <select class="form-control" id="pickup_ads" name="pickup_ads">
                        <option value="default">---请选择---</option>
                        <option value="上大浴室对面">上大浴室对面</option>
                        <option value="E楼车库">E楼车库</option>
                        <option value="新世纪">新世纪</option>
                        <option value="其他">其他</option>
                    </select>
            </div>

            <div class="form-group">
                <label >最晚取货时间</label>
                    <input type="time" class="form-control" id="latest_time" name="latest_time"/>
            </div>

            <div class="form-group">
                <label >货物大小</label>
                <select class="form-control" id="goods_size" name="goods_size">
                    <option value="大">大</option>
                    <option value="中">中</option>
                    <option value="小">小</option>
                </select>
            </div>

            <div class="form-group">
                <label >支付金额</label>
                <input type="text" class="form-control" id="paymoney" name="paymoney">
            </div>

            <div class="form-group">
                <label >取货码</label>
                <input type="text" class="form-control" id="pick_code" name="pick_code"  >
            </div>

            <div class="form-group">
                <label >取货手机号码</label>
                <input type="tel" class="form-control" id="pick_phonenum" name="pick_phonenum" maxlength="11" >
             </div>

            <div class="form-group">
                <label >取货姓名</label>
                <input type="text" class="form-control" id="pick_name" name="pick_name"  >
            </div>

            <div class="form-group">
                <label >备注</label>
                <textarea class="form-control" id="remark" name="remark"  cols="30" rows="10"></textarea>
            </div>
            <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
            <button id="refresh" class="btn btn-success btn-block">重置</button>
            <button id="creat_order" class="btn btn-success btn-block">发单</button>
    </div>
</div>
<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

<script>
    $("#creat_order").click(function(){
        var express_company1=$("#express_company").val();  //快递公司
        var order_num1=$("#order_num").val();            //快递单号
        var pickup_ads1=$("#pickup_ads").val();          //快递地址
        var latest_time1=$("latest_time").val();         //最晚取货时间
        var goods_size1=$("#goods_size").val();          //货物大小
        var paymoney1=$("#paymoney").val();              //支付金额
        var pick_code1=$("#pick_code").val();            //取货码
        var pick_phonenum1=$("#pick_phonenum").val();    //取货电话号码
        var pick_name1=$("#pick_name").val();            //取货姓名
        var remark1=$("remark").val();

        if(express_company1==''||order_num1==''||pickup_ads1==''||latest_time1==''||goods_size1==''||paymoney1==''||pick_code1==''||pick_phonenum1==''||pick_name1==''){
            $("#info").text("提示：发单信息除备注外不能为空");
        }else {
            if($("#pick_phonenum").val().length!=11){
                $("#info").text("提示：手机号应为11位");
            }else {
                $.ajax({
                    type: "POST",
                    url: "/Intergration/order_form/add",
                    data: {
                        order_num: order_num1,
                        express_company: express_company1,
                        pickup_ads: pickup_ads1,
                        latest_time: latest_time1,
                        goods_size: goods_size1,
                        paymoney:  paymoney1,
                        remark: remark1,
                        pick_code: pick_code1,
                        pick_phonenum: pick_phonenum1,
                        pick_name:pick_name1
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.orderState.trim() == "0") {
                            $("#info").text("提示：订单号已存在");
                        } else if (data.orderState.trim() == "2") {
                            window.location.href = "/Intergration/tab/runner"
                        } else if(data.orderState.trim()=="1"){
                            $("#info").text("提示：余额不足");
                        }
                    }
                });
            }
        }
    })
</script>
</body>
</html>