<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<c:if test="${empty userId}">
    <!-- 未登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <blockquote>
                Campus
                <small>一个校园一体化平台</small>
            </blockquote>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item">
                <a  href="/Intergration/signin" class="btn btn-primary btn-block">登录</a>
                <a  href="/Intergration/signup" class="btn btn-default btn-block">注册</a>
            </li>
        </ul>
    </div>
</c:if>

<c:if test="${!empty userId}">
    <!-- 已登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <!-- 个人订单信息，发单与接单信息 -->
        <div class="panel-heading" style="background-color: white;text-align: center">
            <a href="/member/${user.userName}">${user.userName}</a>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item"><a href="/new">创作新主题</a></li>
            <li class="list-group-item"><a href="">0条未读提醒</a></li>
            <li class="list-group-item"><a href="">积分:${user.credit}</a></li>
        </ul>
    </div>
</c:if>
<!-- 发订单按钮 -->
<div class="panel panel-default" id="sidebar1" style="width: 20%;margin:1% 2% 1% 0%;float: right">
    <div class="panel-heading" style="background-color: white;text-align: center">
        <button id="signUp" class="btn btn-success btn-block" onclick="window.location.href='/Intergration/toSign_order'">申请发单</button>
    </div>
</div>
