<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header>
    <nav class="navbar navbar-default" role="navigation" style="background-color: white">
        <div class="container-fluid" style="margin-left: 10%">
            <div class="navbar-header">
                <a class="navbar-brand" href="/intergration">Campus</a>
            </div>
            <div>

                <!--向左对齐-->
                <ul class="nav navbar-nav navbar-left">
                    <li><a href="/intergration/updateOrderformShow">跑腿</a>
                    </li>
                    <li <c:if test="${tab.tabNameEn == 'play'}">class="active"
                        </c:if>><a href="/intergration/forum/main">时事</a></li>
                    <li <c:if test="${tab.tabNameEn == 'creative'}">class="active"
                    </c:if>><a onclick="myFunction()" >课程评价</a></li>
                </ul>

                <c:if test="${empty userId}">
                <!--未登陆-->
                 <ul class="nav navbar-nav navbar-right">
                       <li>
                           <p class="navbar-text"><a href="/intergration/signin">登录</a></p>
                       </li>
                       <li>
                               <p class="navbar-text"><a href="/intergration/signup">注册</a></p>
                       </li>
                 </ul>
                </c:if>
            <c:if test="${!empty userId}">
                   <!--已登陆-->
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <p class="navbar-text"><a href="/intergration">首页</a></p>
                    </li>
                    <li>
                        <p class="navbar-text"><a href="/intergration/member/${sessionScope.username}">${sessionScope.username}</a></p>
                    </li>
                    <li>
                        <p class="navbar-text"><a href="/intergration/user/settings">设置</a></p>
                    </li>
                    <li>
                        <p class="navbar-text"><a onclick="signout_confirm()">登出</a></p>
                    </li>
                </ul>
            </c:if>
            </div>
        </div>
    </nav>


</header>

<script>
    function signout_confirm()
    {
        var r=confirm("确定退出?")
            if (r==true)
            {
                window.location.href="/intergration/user/signout";
            }
            else
            {
            }
    }

    function myFunction()
    {
        alert("待拓展！！")
    }
</script>
</script>

