<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>凯盛CRM | 公告列表</title>
    <%@include file="../include/css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/datatables/css/dataTables.bootstrap.min.css">
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
                    <h3 class="box-title">公告列表</h3>
                    <shiro:hasRole name="经理">
                        <div class="box-tools pull-right">
                            <a href="/notice/new" class="btn btn-xs btn-success"><i class="fa fa-pencil"></i> 发表公告</a>
                        </div>
                    </shiro:hasRole>
                </div>
                <div class="box-body">
                    <table class="table" id="noticeTable">
                        <thead>
                        <tr>
                            <th>标题</th>
                            <th>发布时间</th>
                            <th>发布人</th>
                        </tr>
                        </thead>
                    </table>
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
<script src="/static/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/moment/moment.min.js"></script>
<script>
    $(function () {
        var table = $("#noticeTable").DataTable({
            "lengthChange":false,//单页显示长度不变
            /*"lengthMenu":[10,50,100],*/
            "pageLength":25,//单页显示长度
            "serverSide":true,//表示所有操作都在服务端进行
            "ordering":false,//不排序
            "autoWidth":false,
            "ajax":{
                "url":"/notice/load",
                "type":"post",
            },
            "searching":false,//不使用自带的搜索
            "order":[[0,'desc']],//默认排序顺序
            "columns":[
                {"data":"id","name":"id"},
                {"data":function (row) {
                    return"<a href='/notice/detail/"+row.id+"'>"+row.title+"</a>";
                }},
                {"data":"createtime"},
                {"data":"realname"},
            ],
            "columnDefs":[
                {targets:[0],visible:false},
            ],
            "language":{//定义中文
                "search":"请输入员工姓名或登录账号",
                "zeroRecords":"没有匹配的数据",
                "lengthMenu":"显示_MENU_条数据",
                "info":"显示从_START_到_END_条数据共_TOTAL_条数据",
                "infoFiltered":"(从_MAX_条数据中过滤得来)",
                "loadingRecords":"加载中...",
                "processing":"处理中...",
                "paginate":{
                    "first":"首页",
                    "last":"末页",
                    "next":"下一页",
                    "previous":"上一页"
                }
            }
        });
    });
</script>
</body>
</html>