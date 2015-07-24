<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div align="center" am-panel am-panel-default admin-sidebar-panel>
    <h1>大师${object.name}详细信息</h1>
</div>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>大师姓名：</td>
            <td>${object.name}</td>
        </tr>
        <tr>
            <td>级别：</td>
            <td>${object.type}</td>
        </tr>
        <tr>
            <td>状态：</td>
            <td>${object.status}</td>
        </tr>
        <tr>
            <td>地址：</td>
            <td>${object.province.name}&nbsp;${object.address.addressCity.name}&nbsp;${object.address.name}</td>
        </tr>
    </table>
</div>
</body>
</html>
