
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>客户信息 | ${customer.name}</title>
    <%@include file="../include/css.jsp"%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <%@include file="../include/mainHeader.jsp"%>
    <jsp:include page="../include/leftSide.jsp">
        <jsp:param name="menu" value="customer"/>
    </jsp:include>
    <div class="content-wrapper">
        <section class="content-header">
            <h3 class="box-title"></h3>
            <ol class="breadcrumb">
                <li><a href="/customer"><i class="fa fa-dashboard"></i> 客户列表</a></li>
                <li class="active">${customer.name}</li>
            </ol>
        </section>
        <section class="content">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">
                        <c:choose>
                            <c:when test="${customer.type=='person'}">
                                <i class="fa fa-user"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-bank"></i>
                            </c:otherwise>
                        </c:choose>
                        ${customer.name}
                    </h3>
                    <div class="box-tools">
                        <c:if test="${not empty customer.userid}">
                            <button class="btn btn-danger btn-xs" id="openCust">公开客户</button>
                            <button class="btn btn-info btn-xs" id="moveCust">转移客户</button>
                        </c:if>
                    </div>
                </div>
                <div class="box-body">
                    <table class="table">
                        <tr>
                            <td style="width: 100px">联系电话</td>
                            <td style="width: 200px">${customer.tel}</td>
                            <td style="width: 100px">微信</td>
                            <td style="width: 200px">${customer.weixin}</td>
                            <td style="width: 100px">电子邮件</td>
                            <td style="width: 200px">${custoemr.email}</td>
                        </tr>
                        <tr>
                            <td>等级</td>
                            <td style="color: #ff7400">${customer.level}</td>
                            <td>地址</td>
                            <td colspan="3">${customer.address}</td>
                        </tr>
                        <c:if test="${not empty customer.companyid}">
                            <tr>
                                <td>所属公司</td>
                                <td colspan="5"><a href="/customer/${customer.companyid}">${customer.companyname}</a></td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty customerList}">
                            <tr>
                                <td>关联客户</td>
                                <td colspan="5">
                                    <c:forEach items="${customerList}" var="cust">
                                        <a href="/customer/${cust.id}">${cust.name}</a>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:if>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-list"></i> 销售机会</h3>
                        </div>
                        <div class="box-body">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>机会名称</th>
                                    <th>价值</th>
                                    <th>当前进度</th>
                                    <th>最后跟进时间</th>
                                </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <%--col-md-8 end--%>
                <div class="col-md-4">
                    <div class="box box-default collapsed-box">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-qrcode"></i> 电子名片</h3>
                            <div class="box-tools">
                                <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"><i class="fa fa-plus"></i></button>
                            </div>
                        </div>
                        <div class="box-body" style="text-align: center">
                            <img src="/customer/qrcode/${customer.id}.png" alt="">
                        </div>
                    </div>

                    <div class="box box-default">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-calendar-check-o"></i> 代办事项</h3>
                            <div class="box-tools">
                                <button class="btn btn-default btn-xs" id="newTask"><i class="fa fa-plus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <h5>暂无代办事项</h5>
                        </div>
                    </div>
                </div>
                <%--col-md-4 end--%>
            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>
<!-- ./wrapper -->
<div class="modal fade" id="moveModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">转移客户</h4>
            </div>
            <div class="modal-body">
                <form action="/customer/move" id="moveForm" method="post">
                    <input type="hidden" name="id" value="${customer.id}">
                    <div class="form-gourp">
                        <label>请输入转入员工姓名</label>
                        <select name="userid" class="form-control">
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.realname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="moveBtn">保存</button>
            </div>
        </div>
    </div>
</div>
<%@include file="../include/js.jsp"%>
<script src="/static/plugins/layer/layer.js"></script>
<script>
    $(function(){
       $("#moveCust").click(function(){
            $("#moveModal").modal({
                show:true,
                backdrop:'static',
                keyboard:false
            });
       });

        $("#moveBtn").click(function(){
            $("#moveForm").submit();
        });
       $("#openCust") .click(function(){
           layer.confirm("你确定公开客户信息吗？",{btn:['确定','取消']},function(){
               var id=${customer.id};
               window.location.href = "/customer/open/"+id;
           });
       });


    });
</script>

</body>
</html>
