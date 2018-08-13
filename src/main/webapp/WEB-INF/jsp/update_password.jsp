<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="/intergration/css/bootstrap.min.css" rel="stylesheet">
    <script src="/intergration/js/jquery-3.2.1.js"></script>
    <script src="/intergration/js/bootstrap.min.js"></script>
    <title>Campus ›修改密码</title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 20%;margin-left: 40%;margin-top: 5%;margin-bottom: 5%">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <a href="/intergration">Campus</a> › 设置 ›修改密码
        </div>

        <div class="panel-body">

            <div class="form-group">
                <label for="oldPassword">旧密码</label>
                <input type="password" class="form-control" id="oldPassword" name="ousername" placeholder="请输入旧密码" required="required">
            </div>
            <div class="form-group">
                <label for="newPassword">新密码</label>
                <input type="password" class="form-control" id="newPassword" name="username" placeholder="请输入新密码" required="required">
            </div>
            <div class="form-group">
                <label for="checkPasswd">密码</label>
                <input type="password" class="form-control" id="checkPasswd" name="password" placeholder="请再次输入新密码" required="required">
            </div>

            <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
            <button id="changePasswordButton" class="btn btn-success btn-block">确定</button>
            </input>
        </div>

    </div>
</div>
<script>
    $("#changePasswordButton").click(function(){
        if($("#newPassword").val()==''){
            $("#info").text("新密码不能为空");
        }else if($("#oldPassword").val()==''){
            $("#info").text("请输入旧密码");
        }
        else if($("#checkPasswd").val()==''){
            $("#info").text("请输入确认密码");
        }
        else if($("#newPassword").val()!=$("#checkPasswd").val()){
            $("#info").text("两次密码不匹配，请重输");
        }else {
            $.ajax({
                type: "POST",
                url: "/intergration/user/settings/password/update",
                data:{
                    newPassword:$("#newPassword").val(),
                    oldPassword:$("#oldPassword").val()
                },
                dataType: "json",
                success: function (data) {
                    if (data.stateCode.trim() == "0") {
                        $("#info").text("操作未成功，请重试");
                    } else if (data.stateCode.trim() == "1") {
                        $("#info").text("旧密码错误");
                    }else if (data.stateCode.trim() == "2") {
                        window.location.href = "/intergration";
                    }
                }
            });
        }
    });
</script>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>