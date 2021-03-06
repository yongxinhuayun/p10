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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
</head>
<body>

<div class="admin-content">
    <div style="margin-left: 15px;">
<security:authorize ifAnyGranted="admin,operational,c_operational">
        <input onclick="window.location.href='<c:url
                value="/basic/xm.do?qm=formTenantCategory&tenantId=${tenantId}"/>'"
               type="button" class="am-btn am-btn-default am-btn-xs"
               style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
               value="新建类别"/>
  </security:authorize>
    </div>
    <div class="am-g">



            <div class="am-u-sm-12">
                <table class="am-table am-table-bordered am-table-radius am-table-striped">
                    <tr>
                        <td>操作</td>
                        <td>类别名称</td>
                        <%--<td>类别编号</td>--%>
                        <%--<td>类别图片</td>--%>
                    </tr>

                    <c:forEach items="${requestScope.pageInfo.list}" var="tenantCategory">

                        <tr id="${tenantCategory.id}">
                            <td>
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <security:authorize ifAnyGranted="admin,operational,c_operational">
                                        <button onclick="window.location.href='<c:url
                                                value="/basic/xm.do?qm=formTenantCategory&id=${tenantCategory.id}&tenantId=${tenantId}"/>'"
                                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                                class="am-icon-edit"></span> 编辑
                                        </button>
                                        <button onclick="removeTenantCategory('${tenantCategory.id}')"
                                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                                class="am-icon-trash-o"></span> 删除
                                        </button>
                                        </security:authorize>
                                        <%--<c:if test="${empty projectCategory.projectCategoryRecommendeds}">--%>
                                            <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                               <%--onclick="recommended(this,1,'<c:url--%>
                                                       <%--value="/Recommended/deleteObjectRecommended.do"/>')"--%>
                                               <%--href="#" recommend="1" recommendedId="${projectCategory.id}" id="">--%>
                                                <%--<span class="am-icon-heart"> 推荐</span>--%>
                                            <%--</a>--%>


                                        <%--</c:if>--%>
                                        <%--<c:if test="${not empty projectCategory.projectCategoryRecommendeds}">--%>
                                            <%--<c:forEach var="recommended"--%>
                                                       <%--items="${projectCategory.projectCategoryRecommendeds}">--%>
                                                <%--<c:if test="${recommended.projectCategory.id == projectCategory.id}">--%>
                                                    <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                                       <%--href="#" onclick="recommended(this,1,'<c:url--%>
                                                            <%--value="/Recommended/deleteObjectRecommended.do"/>')"--%>
                                                       <%--recommendedId="${projectCategory.id}" id="${recommended.id}"--%>
                                                       <%--recommend="0">--%>
                                                        <%--<span class="am-icon-heart">取消推荐 </span>--%>
                                                    <%--</a>--%>
                                                <%--</c:if>--%>
                                            <%--</c:forEach>--%>

                                        <%--</c:if>--%>
                                    <%--<span style="display: none;float: left;padding-left: 10px;">--%>
                                                <%--<input type="text" name="sort" style="width: 35px;" value=""/>--%>
                                                <%--<a class=" am-btn-primary"--%>
                                                   <%--onclick="saveRecommended(this,'projectRecommended',1,'<c:url--%>
                                                           <%--value="/Recommended/saveObjectRecommended.do"/>')"--%>
                                                   <%--style="padding: 0px 10px 5px 10px"> 保存</a>--%>
                                       <%--</span>--%>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <a href="<c:url value="/basic/xm.do?qm=viewTenantCategory&id=${tenantCategory.id}&tenantId=${tenantId}" />">
                                        ${tenantCategory.value}
                                </a>
                                <%--<c:forEach var="recommended" items="${projectCategory.projectCategoryRecommendeds}">--%>
                                    <%--<c:if test="${recommended.projectCategory.id == projectCategory.id}">--%>
                                        <%--<span id="${recommended.id}" style="margin-left: 5px;color: red;"> 推荐</span>--%>
                                    <%--</c:if>--%>
                                <%--</c:forEach>--%>
                            </td>
                            <%--<td>--%>
                                    <%--${projectCategory.serial}--%>
                            <%--</td>--%>
                            <%--<td>--%>
                                <%--<img width="8%" src="http://pro.efeiyi.com/${projectCategory.pictureUrl}@!product-model">--%>
                            <%--</td>--%>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div style="clear: both">
                <c:url value="/basic/xm.do" var="url"/>
                <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
                    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
                    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
                </ming800:pcPageList>
            </div>

        </div>
    </div>

<script>
    function removeTenantCategory(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTenantCategory"/>',
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
