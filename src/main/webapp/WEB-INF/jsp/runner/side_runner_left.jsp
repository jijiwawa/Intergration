<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<c:if test="${!empty userId}">
    <!-- 已登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: left">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <a href="/user_info.jsp">${user.userName}</a>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item"><a href="">余额:${user.property}</a></li>
            <li class="list-group-item"><a href="">信誉度:${user.credit}</a></li>
            <li class="list-group-item"><a href="">接单数:${user.trade_num}</a></li>
            <li class="list-group-item"><a href="">好评数:${user.trade_num}</a></li>
            <button style="float:right;" onclick="window.location.href='/intergration/updateOrderformShow'">返回</button>
        </ul>
    </div>
</c:if>


