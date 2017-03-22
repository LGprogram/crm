<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <%@include file="include/css.jsp"%>
</head>
<body>
    <div class="container">
        <form action="/" method="post">
            <div class="form-group">
                <label>账号</label>
                <input type="text" name="username" class="form-control">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control">
            </div>
            <button type="submit" class="btn btn-default">登录</button>
        </form>
    </div>
</body>
</html>
