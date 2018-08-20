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
                <a  href="/intergration/signin" class="btn btn-primary btn-block">登录</a>
                <a  href="/intergration/signup" class="btn btn-default btn-block">注册</a>
            </li>
        </ul>
    </div>
</c:if>

<c:if test="${!empty userId}">

    <div class="container-fluid" style="width: 20%;margin:1% 2% 1% 0%;float: right" >
        <div class="row-fluid">
            <div class="span2" style="align-self: center;">
                <div class="tabbable" id="tabs-212426" style="width: 100%;align-self: center;">
                    <ul class="nav nav-tabs" >
                        <li>
                            <a href="#info_pickform" data-toggle="tab">接单信息</a>
                        </li>
                        <li class="active">
                            <a href="#info_recvice" data-toggle="tab">发单信息</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane" id="info_pickform" style="width: 100%;height: 348px;">
                            <p>
                                第1部分内容.
                            </p>
                        </div>
                        <div class="tab-pane active" id="info_recvice" style="width: 100%;height: 348px;">
                            <p>
                                第二部分内容.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--历史订单-->
    <!-- 发订单按钮 -->
    <div class="panel panel-default" id="sidebar1" style="width: 20%;margin:0% 2% 0% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <button id="history_orderform" class="btn btn-success btn-block" onclick="window.location.href='#'">历史订单</button>
        </div>
        <div class="panel-heading" style="background-color: white;text-align: center">
            <button id="signUp" class="btn btn-success btn-block" onclick="window.location.href='/intergration/toSign_order'">申请发单</button>
        </div>
    </div>

</c:if>

