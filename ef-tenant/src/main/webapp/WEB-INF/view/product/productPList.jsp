<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
     <div style="text-align: left" >
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProduct"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建商品" />
     </div>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align: center">
                <td width="25%">操作</td>
                <td width="20%">作品号</td>
                <td width="20%">作品名称</td>
                <td width="20%">价格</td>
            </tr>

          <c:forEach items="${requestScope.pageInfo.list}" var="product">
                <tr style="text-align: center" id="${product.id}">
                    <td width="20%">
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs" style="width: 100%;text-align: center;" >
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct&id=${product.id}"/>">
                                        修改基本信息
                                </a>
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_Description&id=${product.id}"/>">
                                        修改描述
                                </a>
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_ProductModel&id=${product.id}"/>">
                                        修改属性
                                </a>
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_Picture&id=${product.id}"/>">
                                        修改图片
                                </a>
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="#" onclick="removeProduct('${product.id}')">
                                         删除
                                </a>
                            </div>
                        </div>
                    </td>
                    <td width="20%">${product.serial}</td>
                    <td width="20%"><a href="<c:url value="/basic/xm.do?qm=viewProduct&view=${view}&id=${product.id}"/>"> ${product.name}</a></td>
                    <td width="20%">${product.price}</td>
                </tr>
            </c:forEach>
        </table>
        <div style="clear: both">
            <c:url value="/basic/xm.do" var="url"/>
            <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
                <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
                <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
                <ming800:pcPageParam name="menuId" value="${requestScope.menuId}"/>
            </ming800:pcPageList>
        </div>

<script>
    function removeProduct(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeProduct"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }
</script>
</body>
</html>
