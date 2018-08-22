<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="Content-Type"  content="text/html;charset=utf-8">

    <meta name="keywords" content="校园一体化服务平台">

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
<%@ include file="../header.jsp"%>

<div class="panel panel-default" id="main" style="width: 70%;margin:1% 2% 5% 5%;float: left;">
    <div class="panel-heading" style="background-color: white">
        <a class="btn <c:if test="${shouldOrderByTime==0}">btn-success</c:if>  btn-small"
        href="/intergration/forum/main?pageIndex=1&shouldOrderByTime=0">最新</a>&nbsp;&nbsp;
        <a class="btn <c:if test="${shouldOrderByTime==1}">btn-success</c:if> btn-small"
           href="/intergration/forum/main?pageIndex=1&shouldOrderByTime=1">热评</a>
    </div>
    <div style="height: 580px;">
        <ul class="list-group" style="width: 100%;">
        <c:forEach items="${topics}" var="topic">
            <li class="list-group-item">
                <div style="height: 50px">
                    <div style="float: left;width: 6%;margin-bottom: 5px">
                        <img width="50px" height="50px" src="/intergration/${topic.user.headSculpture}" class="img-rounded">
                    </div>
                    <div style="width: 89%;float: left">
                        <a href="/intergration/forum/t/${topic.id}">${topic.title}</a><br/>
                        <div>
                            <a href="/intergration/member/${topic.user.userName}"><span ><strong>${topic.user.userName}</strong></span></a>&nbsp;&nbsp;&nbsp;
                            <small class="text-muted">${topic.localCreateTime}</small>
                        </div>
                    </div>
                    <div style="width: 5%;float: right;text-align: center">
                        <span class="badge">${topic.countReplies}</span>
                    </div>
                </div>
            </li>
        </c:forEach>
        </ul>
    </div>
    <div>
        共<b>${pageUtil.pageNumber}</b>条
        <a class="btn  btn-small" href="/intergration/forum/main?pageIndex=1&shouldOrderByTime=${shouldOrderByTime}" >首页</a>
        <a class="btn  btn-small" href="/intergration/forum/main?pageIndex=
<c:if test="${pageUtil.pageIndex>1}">${pageUtil.pageIndex-1}</c:if>
<c:if test="${pageUtil.pageIndex==1}">1</c:if>&shouldOrderByTime=${shouldOrderByTime}" >上一页</a>
        <c:forEach begin="1" end="${pageUtil.pageCount}" var="i">
            <a class="btn <c:if test="${pageUtil.pageIndex==i}">btn-success</c:if> btn-small"
               href="/intergration/forum/main?pageIndex=${i}&shouldOrderByTime=${shouldOrderByTime}" >${i}</a>
        </c:forEach>
        <a class="btn  btn-small" href="/intergration/forum/main?pageIndex=
<c:if test="${pageUtil.pageIndex<pageUtil.pageCount}">${pageUtil.pageIndex+1}</c:if>
<c:if test="${pageUtil.pageIndex==pageUtil.pageCount}">${pageUtil.pageCount}</c:if>&shouldOrderByTime=${shouldOrderByTime}">下一页</a>
        <a class="btn  btn-small" href="/intergration/forum/main?pageIndex=${pageUtil.pageCount}&shouldOrderByTime=${shouldOrderByTime}" >末页</a>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="../side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="../footer.jsp"%>
</body>
</html>