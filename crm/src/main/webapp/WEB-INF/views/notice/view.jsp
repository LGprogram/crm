<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>凯盛CRM | ${notice.title}</title>
    <%@include file="../include/css.jsp"%>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp"%>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="notice"/>
    </jsp:include>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <section class="content-header">
            <h1>　　</h1>
            <ol class="breadcrumb">
                <li><a href="/notice"><i class="fa fa-list"></i> 公告列表</a></li>
                <li class="active">${notice.title}</li>
            </ol>
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">${notice.title} <small>${notice.realname} ${notice.createtime}</small></h3>
                </div>
                <div class="box-body">
                    ${notice.context}
                </div>
                <div class="box-footer">
                    <h5>已查看：</h5>
                    <c:forEach items="${noticeViewList}" var="noticeView">
                        |${noticeView.viewname}
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>
<!-- ./wrapper -->

<%@include file="../include/js.jsp"%>
<script>
    $(function(){





    });
</script>
</body>
</html>
