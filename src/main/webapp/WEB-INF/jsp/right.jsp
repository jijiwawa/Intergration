<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>发帖权限管理 - Campus</title>
    <link href="/intergration/css/bootstrap.min.css" rel="stylesheet">
    <script src="/intergration/js/jquery-3.2.1.js"></script>
    <script src="/intergration/js/bootstrap.min.js"></script>
    <script src="/intergration/js/js.cookie.js"></script>

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

<div class="panel panel-default" id="login" style="width: 20%;margin-left: 40%;margin-top: 5%;margin-bottom: 5%">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">发帖权限管理</h3>
    </div>
    <div class="panel-body">

        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" required="required">
        </div>
        <div class="form-group">
            <label >发帖权限</label>
            <select class="form-control" id="hasRight" name="hasRight">
                <option value="1">允许发帖</option>
                <option value="0">禁止发帖</option>
            </select>
        </div>

        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
            <button id="commitButton" class="btn btn-success btn-block">确定</button>
    </div>
</div>
<script>
    $("#commitButton").click(function () {
        var id =$("#username").val();
        var right=$("#hasRight").val();
        if( id=='' ){
            $("#info").text("提示:目标用户名不能为空");
        }
        else {
            $.ajax({
                type: "POST",
                url: "/intergration/user/manageright",
                data: {
                    username:id ,
                    hasRight: right
                },
                dataType: "json",
                success: function(data) {
                    if(data.stateCode.trim() == "0") {
                        $("#info").text("提示:目标用户名不存在!");
                    } else if(data.stateCode.trim() == "1") {
                        $("#info").text("提示:操作未成功，请重试");
                    } else if(data.stateCode.trim() == "2"){
                        $("#info").text("提示:操作成功");
                    }
                }
            });
        }
    })
</script>
<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>