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
    <title>凯盛CRM-员工管理</title>
    <%@include file="../include/css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/webuploader/webuploader.css">
    <link rel="stylesheet" href="/static/plugins/datatables/css/dataTables.bootstrap.min.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp"%>
    <jsp:include page="../include/leftSide.jsp">
            <jsp:param name="menu" value="doc"/>
    </jsp:include>
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">文档列表</h3>
                    <div class="box-tools">
                        <span id="uploadBtn"><span class="text"><i class="fa fa-upload"></i> 上传文件</span></span>
                        <button class="btn btn-bitbucket btn-xs" id="newDir"><i class="fa fa-folder"></i> 新建文件夹</button>
                    </div>
                </div>
                <div class="box-body">

                    <table class="table">
                        <thead>
                        <tr>
                            <th></th>
                            <th>名称</th>
                            <th>大小</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty documentList}">
                                <tr>
                                    <td colspan="5">暂时没有任何数据</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${documentList}" var="document">
                                    <tr>
                                        <c:choose>
                                            <c:when test="${document.type == 'directory'}">
                                                <td><i class="fa fa-folder-o"></i></td>
                                                <td><a href="/doc?fid=${document.id}">${document.name}</a></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><i class="fa fa-file-o"></i></td>
                                                <td><a href="/doc/download/${document.id}">${document.name}</a></td>

                                            </c:otherwise>
                                        </c:choose>
                                        <td>${document.size}</td>
                                        <td>${document.createuser}</td>
                                        <td>${document.createtime}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </div>
</div>
</div>
<div id="newModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">x</button>
                <h3>新建文件夹</h3>
            </div>
            <div class="modal-body">
                <form id="docForm" action="/doc/newDir" method="post" >
                    <input type="hidden" name="fid" value="${fid}">
                    <div class="form-group">
                        <label>请输入文件夹名称</label>
                        <input type="text" name="name" id="name" class="form-control">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>
<%@include file="../include/js.jsp"%>
<script src="/static/plugins/webuploader/webuploader.min.js"></script>
<script>
    $(function () {
        var fid = ${fid};
        //新建文件夹
        $("#newDir").click(function () {
            $("#docForm")[0].reset();
            $("#newModal").modal({
                show:true,
                keyboard:false,
                backdrop:'static'
            });
        });
        $("#saveBtn").click(function () {
            if(!$("#name").val()) {
                $("#name").focus();
                return;
            }
            $("#docForm").submit();
        });
        //上传文件
        var uploader = WebUploader.create({
            swf:"/static/plugins/webuploader/Uploader.swf",
            pick:"#uploadBtn",
            server:"/doc/file/upload",
            fileValL:"file",
            formData:{"fid":fid},
            auto:true //选择文件后直接上传
        });

        //上传文件成功
        uploader.on("startUpload",function(){
            $("#uploadBtn .text").html('<i class="fa fa-spinner fa-spin"></i> 上传中...');
        });
        uploader.on( 'uploadSuccess', function( file,data ) {
            if(data._raw== "success") {
                window.history.go(0);
            }
        });

        uploader.on( 'uploadError', function( file ) {
            alert("文件上传失败");
        });

        uploader.on( 'uploadComplete', function( file ) {
            $("#uploadBtn .text").html('<i class="fa fa-upload"></i> 上传文件').removeAttr("disabled");;
        });


    });


</script>
</body>
</html>




