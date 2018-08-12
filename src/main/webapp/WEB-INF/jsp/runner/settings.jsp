<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="/Intergration/css/bootstrap.min.css" rel="stylesheet">
    <script src="/Intergration/js/jquery-3.2.1.js"></script>
    <script src="/Intergration/js/bootstrap.min.js"></script>
    <title>Genesis ›设置</title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <a href="/">Genesis</a> › 设置
        </div>

        <div class="panel-body">

                <form class="form-horizontal" role="form" >
                    <div style="margin-left: 17%">
                        <img width="60px" height="60px" src="/Intergration/${user.headSculpture}" class="img-rounded">
                        <a class="btn btn-default" href="/settings/avatar" role="button">更换头像</a>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">uid</label>
                        <div class="col-sm-10">
                            <p class="form-control-static">${user.id}</p>
                        </div>
                    </div>
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
                                <c:if test="${user.isMale == 1}">男
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

                </form>

        </div>

    </div>



</div>

<!-- 引入侧边栏文件 -->
<%@ include file="order_info.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>

</body>
</html>