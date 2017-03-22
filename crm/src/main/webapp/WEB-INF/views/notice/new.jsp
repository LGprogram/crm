<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>凯盛CRM | 新增公告</title>
    <%@include file="../include/css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/simditor/styles/simditor.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp"%>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="notice"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">

            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">新增公告</h3>
                </div>
                <div class="box-body">
                    <form method="post" id="newForm">
                        <div class="form-group">
                            <label>标题</label>
                            <input type="text" name="title" class="form-control" id="title">
                        </div>
                        <div class="form-group">
                            <label>公告内容</label>
                            <textarea name="context" id="context" rows="10" class="form-control"></textarea>
                        </div>
                    </form>
                </div>
                <div class="box-footer">
                    <button id="saveBtn" class="btn btn-primary pull-right">发表</button>
                </div>
            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="../include/js.jsp"%>
<script src="/static/plugins/simditor/scripts/module.min.js"></script>
<script src="/static/plugins/simditor/scripts/hotkeys.min.js"></script>
<script src="/static/plugins/simditor/scripts/uploader.min.js"></script>
<script src="/static/plugins/simditor/scripts/simditor.js"></script>
<script>
    $(function(){

        var edit = new Simditor({
            textarea:$("#context"),
            placeholder: '请输入公告内容',
            upload:{
                url:"/notice/img/upload",
                fileKey:"file"
            }
        });


        $("#saveBtn").click(function(){
            /*表单值为空时不提交*/
            if(!$("#title").val()) {
                $("#title").focus();
                return;
            }
            if(!$("#context").val()) {
                $("#context").focus();
                return;
            }
            $("#newForm").submit();
        });

    });
</script>
</body>
</html>


