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
    <link rel="stylesheet" href="/static/plugins/datatables/css/dataTables.bootstrap.min.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="../include/mainHeader.jsp"%>
    <%@include file="../include/leftSide.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                员工管理
            </h1>
        </section>
        <!-- Main content -->
        <section class="content">

            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">员工列表</h3>
                    <div class="box-tools pull-right">
                        <a href="javascript:;" id="newBtn" class="btn btn-xs btn-success"><i class="fa fa-plus"></i> 新增</a>
                    </div>
                </div>
                <div class="box-body">
                    <table class="table" id="userTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>账号</th>
                            <th>员工姓名</th>
                            <th>微信号</th>
                            <th>角色</th>
                            <th>状态</th>
                            <th>创建时间</th>
                            <th>#</th>
                        </tr>
                        </thead>
                        <tbody> </tbody>
                    </table>
                </div>
            </div>
        </section>
    </div>
</div>
<div id="newModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">x</button>
                <h3>新增用户</h3>
            </div>
            <div class="modal-body">
                <form id="newForm">
                    <div class="form-group">
                        <label>账号(登录使用)</label>
                        <input type="text" class="form-control" name="username" >
                    </div>
                    <div class="form-group">
                        <label>密码(默认000000)</label>
                        <input type="text"  name="password" class="form-control" value="000000" >
                    </div>
                    <div class="form-group">
                        <label>真实姓名</label>
                        <input type="text" class="form-control" name="realname" >
                    </div>
                    <div class="form-group">
                        <label>微信号</label>
                        <input type="text" class="form-control" name="weixin" >
                    </div>
                    <div class="form-group">
                        <label>角色</label>
                        <select class="form-control" name="roleid">
                            <c:forEach items="${roleList}" var="role">
                                <option value="${role.id}">${role.rolename}</option>
                            </c:forEach>
                        </select>
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
<div id="editModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">x</button>
                <h3>编辑用户</h3>
            </div>
            <div class="modal-body">
                <form id="editForm">
                    <input type="hidden" id="edit_id" name="id">
                    <div class="form-group">
                        <label>账号(登录使用)</label>
                        <input type="text" class="form-control" name="username" id="edit_username" >
                    </div>
                    <div class="form-group">
                        <label>密码(默认000000)</label>
                        <input type="text"  name="password" class="form-control" value="000000" id="edit_password" >
                    </div>
                    <div class="form-group">
                        <label>真实姓名</label>
                        <input type="text" class="form-control" name="realname" id="edit_realname" >
                    </div>
                    <div class="form-group">
                        <label>微信号</label>
                        <input type="text" class="form-control" name="weixin" id="edit_weixin" >
                    </div>
                    <div class="form-group">
                        <label>角色</label>
                        <select class="form-control" name="roleid" id="edit_roleid">
                            <c:forEach items="${roleList}" var="role">
                                <option value="${role.id}">${role.rolename}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select class="form-control" name="enable" id="edit_enable">
                            <option value="true">正常</option>
                            <option value="false">禁用</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="editBtn">保存</button>
            </div>
        </div>
    </div>
</div>
<%@include file="../include/js.jsp"%>
<script src="/static/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/moment/moment.min.js"></script>
<script src="/static/plugins/validate/jquery.validate.min.js"></script>
<script>
    $(function () {
        var table = $("#userTable").DataTable({
            "lengthChange":false,//单页显示长度不变
            /*"lengthMenu":[10,50,100],*/
            "pageLength":25,//单页显示长度
            "serverSide":true,//表示所有操作都在服务端进行
            "ordering":false,//不排序
            "autoWidth":false,
            "ajax":{
                "url":"/admin/users/load",
                "type":"post",

            },
            "searching":false,//不使用自带的搜索
            "order":[[0,'desc']],//默认排序顺序
            "columns":[
                {"data":"id","name":"id"},
                {"data":"username"},
                {"data":"realname"},
                {"data":"weixin"},
                {"data":"role.rolename"},
                {"data":function(row){
                    if(row.enable) {
                        return "<span class='label label-success'>正常</span>";
                    } else {
                        return "<span class='label label-danger'>禁用</span>";
                    }
                }},
                {"data":"createtime"},
                {"data":function(row){
                    return"<a href='javascript:;' rel='"+row.id+"' class='resetPassword'>重置密码</a> | <a href='javascript:;' rel='"+row.id+"' class='edit'>编辑</a> ";
                }}
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
        /*新增员工*/
        $("#newBtn").click(function () {
            $("#newForm")[0].reset();
            $("#newModal").modal({
                show:true,
                backdrop:'static',
                keyboard:false
            });


        });
        $("#newForm").validate({
            errorClass:"text-danger",
            errorElement:"span",
            rules:{
                username:{
                    required:true,
                    rangelength:[3,20],
                    remote:"/admin/users/checkusername"
                },

                password:{
                    required:true,
                    rangelength:[6,20]
                },
                realname:{
                    required:true,
                    rangelength:[3,20],
                },
                weixin:{
                    required:true
                }
            },
            messages:{
                username:{
                    required:"请输入用户名",
                    rangelength:"用户名的长度3~20位",
                    remote:"该用户名已被占用"
                },
                realname:{
                    required:"请输入真实姓名",
                    rangelength:"真实姓名长度2~20位"
                },
                password:{
                    required:"请输入密码",
                    rangelength:"密码长度6~18位"
                },
                weixin:{
                    required:"请输入微信号码"
                }
            },
            submitHandler:function (form) {
                $.post("/admin/users/new",$(form).serialize()).done(function (data) {
                    if(data=="success"){
                        $("#newModal").modal('hide');
                        table.ajax.reload();
                    }
                }).error(function () {
                    alert("服务器异常")
                });
            }
        });

        $("#saveBtn").click(function () {
            //触发submitHandler
            $("#newForm").submit();
        });

        //编辑
        $(document).delegate(".edit","click",function () {
            var id = $(this).attr("rel");
            $.post("/admin/users/edit",{"id":id}).done(function (result) {
                if(result.state=="success"){
                    /*$("#editForm")[0].reset();*/

                    $("#edit_id").val(result.data.id);
                    $("#edit_username").val(result.data.username);
                    $("#edit_password").val(result.data.password);
                    $("#edit_realname").val(result.data.realname);
                    $("#edit_weixin").val(result.data.weixin);
                    $("#edit_roleid").val(result.data.roleid);
                    $("#edit_enable").val(result.data.enable.toString());

                    $("#editModal").modal({
                        show:true,
                        backdrop:'static',
                        keyboard:false
                    });
                }else{
                    alert(result.message);
                }
            }).error(function () {
                alert("服务器错误，请稍候")
            });
        });
        $("#editForm").validate({
            errorClass:"text-danger",
            errorElement:"span",
            rules:{
                username:{
                    required:true,
                    rangelength:[3,20],
                    remote: {
                        url: "/admin/users/checkeditusername",
                        type: "get",
                        dataType: "json",
                        data: {
                            username: $("#edit_username").val(),
                            id: $("#edit_id").val()
                        }
                    }
                },

                password:{
                    required:true,
                    rangelength:[6,20]
                },
                realname:{
                    required:true,
                    rangelength:[3,20],
                },
                weixin:{
                    required:true
                }
            },
            messages:{
                username:{
                    required:"请输入用户名",
                    rangelength:"用户名的长度3~20位",
                    remote:"该用户名已被占用"
                },
                realname:{
                    required:"请输入真实姓名",
                    rangelength:"真实姓名长度2~20位"
                },
                password:{
                    required:"请输入密码",
                    rangelength:"密码长度6~18位"
                },
                weixin:{
                    required:"请输入微信号码"
                }
            },
            submitHandler:function (form) {
                $.post("/admin/users/update",$(form).serialize()).done(function (data) {
                    if(data=="success"){
                        $("#editModal").modal('hide');
                        table.ajax.reload();
                    }
                }).error(function () {
                    alert("服务器异常")
                });
            }
        });

        $("#editBtn").click(function () {
            $("#editForm").submit();
        });
        //重置密码
        $(document).delegate(".resetPassword","click",function () {
            var id = $(this).attr("rel");
            if(confirm("确认将密码重置为：000000？")) {
                $.post("/admin/users/resetpassword",{"id":id}).done(function(data){
                    if(data == 'success') {
                        alert("密码重置成功");
                    }
                }).fail(function(){
                    alert("服务器异常");
                });
            }
        })

    });
</script>
</body>
</html>