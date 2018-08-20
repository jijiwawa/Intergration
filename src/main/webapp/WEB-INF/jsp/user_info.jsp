<%--
  Created by IntelliJ IDEA.
  User: suxik
  Date: 2018/8/12
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <link href="/intergration/css/bootstrap.min.css" rel="stylesheet">
    <script src="/intergration/js/jquery-3.2.1.js"></script>
    <script src="/intergration/js/bootstrap.min.js"></script>
    <title>Genesis › <c:if test="${!empty user}">${user.userName}</c:if><c:if test="${!empty errorInfo}">会员未找到</c:if></title>

</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <a href="/intergration">Campus</a> › ${user.userName}
        </div>

        <div class="panel-body">
            <c:if test="${!empty user}">
            <form class="form-horizontal" role="form">
                <div style="margin-left: 17%">
                    <img width="60px" height="60px" src="/intergration/${user.headSculpture}" class="img-rounded">
                </div><br/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${user.userName}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">电话号码</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${user.phoneNumber}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">性别</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">
                            <c:if test="${user.isMale == 0}">男
                            </c:if>
                            <c:if test="${user.isMale == 1}">女
                            </c:if>
                        </p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">积分</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${user.credit}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">余额</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${user.property}</p>
                    </div>
                </div>
            </form>
            </c:if>
            <c:if test="${!empty errorInfo}">
                会员未找到!
            </c:if>
        </div>
    </div>
</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>