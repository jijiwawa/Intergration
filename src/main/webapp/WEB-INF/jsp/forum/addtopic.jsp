<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/intergration/css/editormd.min.css" />
    <link href="/intergration/css/bootstrap.min.css" rel="stylesheet">
    <script src="/intergration/js/jquery.min.js"></script>
    <script src="/intergration/js/editormd.min.js"></script>
    <script src="/intergration/js/bootstrap.min.js"></script>
    <title>Campus › 发布新帖子 </title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="../header.jsp"%>

<div style="width: 90%;margin:1% 2% 1% 5%;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <a href="/intergration">Genesis</a> › 发布新帖子
        </div>

        <div class="panel-body">
                <div class="form-group">
                    <label for="title">主题标题</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="请输入主题标题" required="required">
                </div>
                <div id="test-editormd">
                    <textarea style="display:none;">#Hello</textarea>
                </div>
                <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
                <button id="post" class="btn btn-success btn-small">发布</button>
        </div>

    </div>

</div>


<!-- 引入footer文件 -->
<%@ include file="../footer.jsp"%>

<script>
    var editor;
    $(function() {
        editor = editormd("test-editormd", {
            width   : "100%",
            height  : 640,
            path : "/intergration/js/lib/"
        });
    });
    $("#post").click(function () {
        var ptitle=$("#title").val();
        var pcontent=editor.getMarkdown();
        if(ptitle==''){
            $("#info").text("提示：请输入标题");
        }else if(pcontent==''){
            $("#info").text("提示：请输入内容");
        }else{
            $.ajax({type: "POST",
                url: "/intergration/forum/post",
                data: {
                    title: ptitle,
                    content: pcontent,
                },
                dataType: "json",
                success: function(data){
                    if(data.stateCode.trim() == "0") {
                        $("#info").text("提示:请先登录");
                    } else if(data.stateCode.trim() == "1") {
                        $("#info").text("提示:无发帖权限!");
                    } else if(data.stateCode.trim() == "2"){
                        window.location.href="/intergration/forum/main";
                    }
                }
            })
        }
    })
</script>
</body>
</html>
