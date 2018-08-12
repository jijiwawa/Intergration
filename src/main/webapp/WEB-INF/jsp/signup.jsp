<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册 - Campus</title>
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
<%@ include file="header.jsp"%>

<div class="panel panel-default" id="login" style="width: 30%;margin-left: 35%;margin-top: 5%;margin-bottom: 5%">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">注册</h3>
    </div>
    <div class="panel-body">
            <div class="form-group" >
                <label >用户名</label>
                    <input type="text" class="form-control" id="username" name="username" required="required">
            </div>

            <div class="form-group">
                <label >性别</label>
                    <select class="form-control" id="isMale" name="isMale">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
            </div>

            <div class="form-group">
                <label >密码</label>
                    <input type="password" class="form-control" id="password" name="password" required="required">
            </div>

            <div class="form-group">
                <label >手机号</label>
                    <input type="tel" class="form-control" id="tel" name="tel" required="required">
            </div>
            <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
            <button id="signUp" class="btn btn-success btn-block">注册</button>
    </div>
</div>
<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

<script>
    $("#signUp").click(function(){
        var yhm=$("#username").val();
        var xb=$("#isMale").val();
        var mm=$("#password").val();
        var sjh=$("#tel").val();
        if(yhm==''){
            $("#info").text("提示：用户名不能为空");
        }else if(mm==''){
            $("#info").text("提示：密码不能为空");
        }else if(sjh=''){
            $("#info").text("提示：手机号不能为空");
        }else {
            if($("#tel").val().length!=11){
                $("#info").text("提示：手机号应为11位");
            }else {
                $.ajax({
                    type: "POST",
                    url: "/intergration/user/add",
                    data: {
                        username: yhm,
                        isMale: xb,
                        password: mm,
                        tel: $("#tel").val()
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.stateCode.trim() == "0") {
                            $("#info").text("提示：用户名已存在");
                        } else if (data.stateCode.trim() == "1") {
                            window.location.href = "/intergration"
                        }
                    }
                });
            }
        }
    })
</script>
</body>
</html>