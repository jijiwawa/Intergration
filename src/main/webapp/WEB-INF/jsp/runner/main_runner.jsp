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
<%@ include file="header.jsp"%>

<div class="panel panel-default" id="main" style="width: 70%;margin:1% 2% 5% 5%;float: left;">
    <!-- 检索 -->
    <div class="panel-heading" style="background-color: white">
        <a style="margin-right: 2%">最新</a><a style="margin-right: 2%">取货点</a><a style="margin-right: 2%">收益</a><a style="margin-right: 2%">货物大小</a><a style="margin-right: 2%">收益</a>
    </div>
    <!-- 订单信息窗口 -->
    <ul class="list-group" style="width: 100%">
        <!-- 从订单表中遍历出未接单的信息显示出来 -->
        <c:forEach items="${orderforms}" var="orderfrom">
            <li class="list-group-item">
                <div style="height: 50px">
                    <div style="float: left;width: 6%;margin-bottom: 5px">
                        <img width="50px" height="50px" src="${orderform.user.avatar}" class="img-rounded">
                    </div>
                    <div style="width: 89%;float: left">
                        <a href="/t/${orderform.id}">${orderform.title}</a><br/>
                        <div>
                            <a><span class="label label-default" >${orderform.tab.tabName}</span></a>&nbsp;&nbsp;&nbsp;
                            <a href="/member/${orderform.user.username}"><span ><strong>${orderform.user.username}</strong></span></a>&nbsp;&nbsp;&nbsp;
                            <small class="text-muted">${orderform.localCreateTime}</small>
                        </div>
                    </div>
                    <div style="width: 5%;float: right;text-align: center">
                        <span class="badge">${orderform.countReplies}</span>
                    </div>
                </div>
            </li>
        </c:forEach>

    </ul>

</div>

<!-- 引入侧边栏文件 -->
<%@ include file="order_info.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>