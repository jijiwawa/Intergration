<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="Content-Type"  content="text/html;charset=utf-8">
    <meta name="keywords" content="Genesis,论坛,社区,程序员">
    <title>校园一体化服务平台</title>
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

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>
<div class="row">
    <div class="col-xs-6 col-md-2">
    </div>
    <div class="col-xs-6 col-md-3">
        <div class="thumbnail">
            <img src="https://www.baidu.com/img/bd_logo1.png" >
            <div class="caption">
                <h3>跑腿服务</h3>
                <p>todo</p>
                <a href="/intergration/todo" class="btn btn-primary" role="button">进入</a>
            </div>
        </div>
    </div>
    <div class="col-xs-6 col-md-3">
        <div class="thumbnail">
            <img src="https://www.baidu.com/img/bd_logo1.png" >
            <div class="caption">
                <h3>校园时事</h3>
                <p>一个传播校园信息的平台</p>
                <a href="/intergration/forum/main" class="btn btn-primary" role="button">进入</a>
            </div>
        </div>
    </div>
</div>
<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>