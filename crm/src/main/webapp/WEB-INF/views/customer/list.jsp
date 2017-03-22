<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>客户管理</title>
    <%@include file="../include/css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/datatables/css/dataTables.bootstrap.min.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp"%>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="customer"/>
    </jsp:include>

    <div class="content-wrapper">
        <section class="content">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">客户列表</h3>
                    <div class="box-tools pull-right">
                        <a href="javascript:;" id="newBtn" class="btn btn-xs btn-success"><i class="fa fa-plus"></i> 新增客户</a>
                    </div>
                </div>
                <div class="box-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th></th>
                                <th>客户名称</th>
                                <th>联系电话</th>
                                <th>电子邮件</th>
                                <th>等级</th>
                                <th>#</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </section>
    </div>
</div>
<div class="modal fade" id="newCus">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增客户</h4>
            </div>
            <div class="modal-body">
                <form id="cusForm">
                    <div class="form-group">
                        <label>类型</label>
                        <label class="radio-inline">
                            <input type="radio" name="type" id="personType"  value="person" checked> 个人
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="type" id="companyType" value="company">公司
                        </label>
                    </div>
                    <div class="form-group">
                        <label>客户名称</label>
                        <input type="text" class="form-control" name="name">
                    </div>
                    <div class="form-group">
                        <label>联系电话</label>
                        <input type="text" name="tel" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>客户等级</label>
                        <select class="form-control" name="level">
                            <option></option>
                            <option value="★">★</option>
                            <option value="★★">★★</option>
                            <option value="★★★">★★★</option>
                            <option value="★★★★">★★★★</option>
                            <option value="★★★★★">★★★★★</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>微信号</label>
                        <input type="text" name="weixin" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>电子邮件</label>
                        <input type="text" name="email" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>地址</label>
                        <input type="text" name="address" class="form-control">
                    </div>
                    <div class="from-group" id="company2" >
                        <label>所属公司</label>
                        <select class="form-control" name="companyid">
                            <option></option>
                            <c:forEach items="${companyList}" var="customer">
                                <option value="${customer.id}">${customer.name}</option>
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
<div class="modal fade" id="editCus">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑客户</h4>
            </div>
            <div class="modal-body">
                <form action="" id="editCusForm">
                    <input type="hidden" id="id" name="id">
                    <div class="form-group">
                        <label>客户名称</label>
                        <input type="text" name="name" class="form-control" id="name">
                    </div>
                    <div class="form-group">
                        <label>联系电话</label>
                        <input type="text" name="tel" class="form-control" id="tel">
                    </div>
                    <div class="form-group">
                        <label>客户等级</label>
                        <select class="form-control" id="level" name="level">
                            <option></option>
                            <option value="★">★</option>
                            <option value="★★">★★</option>
                            <option value="★★★">★★★</option>
                            <option value="★★★★">★★★★</option>
                            <option value="★★★★★">★★★★★</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>微信号</label>
                        <input type="text" name="weixin" class="form-control" id="weixin">
                    </div>
                    <div class="form-group">
                        <label>电子邮件</label>
                        <input type="text" name="email" class="form-control" id="email">
                    </div>
                    <div class="form-group">
                        <label>地址</label>
                        <input type="text" name="address" class="form-control" id="address">
                    </div>

                    <div class="form-group" id="company1">
                        <label>所属公司</label>
                        <select class="form-control" name="companyname">
                            <option></option>
                            <c:forEach items="${companyList}" var="customer">
                                <option value="${customer.name}">${customer.name}</option>
                            </c:forEach>
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
<script src="/static/plugins/layer/layer.js"></script>
<script src="/static/plugins/validate/jquery.validate.min.js"></script>
<script>
    $(function(){
       var table = $(".table").DataTable({
          /* "lengthChange":false,//单页显示长度不变*/
           "lengthMenu":[10,25,50],
           "pageLength":10,//单页显示长度
           "serverSide":true,//表示所有操作都在服务端进行
           "ordering":false,//不排序
           "autoWidth":false,
           "ajax":{
               "url":"/customer/list",
               "type":"post",

           },
           "searching":true,//使用自带的搜索
           "order":[[0,'desc']],//默认排序顺序
           "columns":[
               {"data":"id","name":"id"},
               {"data":function(row){
                if(row.type=="company"){
                    return '<i class="fa fa-university" aria-hidden="true"></i>';
                }else{
                    return '<i class="fa fa-user" aria-hidden="true"></i>';
                }

               }},
               {"data":function(row){
                if(row.companyname){
                    return "<a href='/customer/"+row.id+"'>"+row.name+"-"+"</a><a href='/customer/"+row.companyid+"'>"+row.companyname+"</a>";
                    //return row.name+"-"+row.companyname;
                }else{
                    return "<a href='/customer/"+row.id+"'>"+ row.name+"</a>";
                }

               }},
               {"data":"tel"},
               {"data":"email"},
               {"data":"level"},//客户等级
               {"data":function(row){
                   return"<a href='javascript:;' rel='"+row.id+"' class='edit'>编辑</a>  <a href='javascript:;' rel='"+row.id+"' class='delete'>删除</a> ";
               }}
           ],
           "columnDefs":[
               {targets:[0],visible:false},
           ],
           "language": {//定义中文
               "search": "请输入客户名称或电话",
               "zeroRecords": "没有匹配的数据",
               "lengthMenu": "显示_MENU_条数据",
               "info": "显示从_START_到_END_条数据共_TOTAL_条数据",
               "infoFiltered": "(从_MAX_条数据中过滤得来)",
               "loadingRecords": "加载中...",
               "processing": "处理中...",
               "paginate": {
                   "first": "首页",
                   "last": "末页",
                   "next": "下一页",
                   "previous": "上一页"
               }
           }
       }) ;

       $("#newBtn").click(function(){
            $("#cusForm")[0].reset();
            $("#newCus").modal({
                show:true,
                backdrop:'static',
                keyboard:false
            });
       });

       $("#companyType").click(function(){
          $("#company2").attr("hidden","hidden");
       });
       $("#personType").click(function(){
           $("#company2").removeAttr("hidden")
       });
        /*保存客户*/
        $("#saveBtn").click(function(){
            $("#cusForm").submit();
        });

        $("#cusForm").validate({
            errorElement:"span",
            errorClass:"text-danger",
            rules:{
                name:{
                    required:true,
                },
                tel:{
                    required:true,
                }
            },
            messages:{
                name:{
                    required:"请输入客户名称",
                },
                tel:{
                    required:"请输入电话",
                }
            },
            submitHandler:function(){
                $.ajax({
                    url:"/customer/new",
                    type:"post",
                    data:$("#cusForm").serialize(),
                    beforeSend:function(){
                        $("#saveBtn").text("保存中").attr("disabled","disabled");
                    },
                    success:function(json){
                        if(json.state=="success"){
                            layer.msg("保存成功");
                            $("#newCus").modal("hide");
                            table.ajax.reload()
                        }else{
                            layer.msg(json.message);
                        }
                    },
                    error:function(){
                        layer.msg("服务器异常");
                    },
                    complete:function(){
                        $("#saveBtn").text("保存").removeAttr("disabled");
                    }
                });
            }

        });

       //编辑客户
        $(document).delegate(".edit","click",function(){
            var id = $(this).attr("rel");
            $.post("/customer/edit",{"id":id}).done(function(json){
                if(json.state=="success"){
                    $("#editCusForm")[0].reset();
                    $("#editCus").modal({
                        show:true,
                        backdrop:'static',
                        keyboard:false
                    });
                    if(json.data.type=='company'){
                        $("#company1").attr("hidden","hidden");

                    }else{
                        $("#company1").removeAttr("hidden");
                       $("#company1").find("select").val(json.data.companyname);
                       /* $("#company1 select").val(json.data.companyname);*/

                    }
                    $("#id").val(json.data.id);
                    $("#name").val(json.data.name);
                    $("#tel").val(json.data.tel);
                    $("#level").val(json.data.level);
                    $("#weixin").val(json.data.weixin);
                    $("#email").val(json.data.email);
                    $("#address").val(json.data.address);

                }else{
                    layer.msg(json.message)
                }
            }).error(function(){
                layer.msg("服务器异常，请稍后再试");
            });
        });
        $("#editBtn").click(function(){
            $("#editCusForm").submit();
        });
        $("#editCusForm").validate({
            errorElement:"span",
            errorClass:"text-danger",
            rules:{
                name:{
                    required:true,
                },
                tel:{
                    required:true,
                }
            },
            messages:{
                name:{
                    required:"请输入客户名称",
                },
                tel:{
                    required:"请输入客户电话",
                }
            },
            submitHandler:function(form){
                $.post("/customer/update",$(form).serialize())
                    .done(function(json){
                    if(json.state =='success'){
                        $("#editCus").modal('hide');
                        table.ajax.reload();
                    }
                }).error(function(){
                   layer.msg("服务器异常");
                });
            }
        });
        //删除客户
        $(document).delegate(".delete","click",function(){
            var id = $(this).attr("rel");
            layer.confirm("你确定删除吗",{btn:['确定','取消']},function(data){

                $.get("/customer/del/"+id).done(function(json){
                if(json.state=='success'){
                    layer.msg("删除成功");
                    table.ajax.reload();
                }
                }).error(function(){
                    layer.msg("服务器异常，请稍后再试");
                });
                layer.close(data)
            });



        });




    });

</script>
</body>
</html>
