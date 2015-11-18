<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="wh nav-new nav-new-list">
    <div class="hd">
        <div class="cate" id="cate">
            <div class="ld"><h2>非遗商品分类<i class="icon-new"></i></h2></div>
            <div class="allsort">
                <c:forEach items="${categoryList}" var="category">
                    <div class="item">
                        <h3><a href="<c:url value="/project/list/${category.id}"/>" title="">${category.name}</a><i class="icon-new icon-link"></i></h3>
                        <div class="i-mc" style="display: none;">
                            <div class="links">
                                <c:forEach items="${projectMap.get(category.id)}" var="project">
                                    <a href="<c:url value="/product/list/${project.id}"/>" title="">${project.name}</a>
                                </c:forEach>
                            </div>
                            <!-- //End--links-->
                            <div class="reco">
                                <c:forEach items="${projectMap.get(category.id)}" var="project">
                                    <c:if test="${not empty recommendedTenantList}">
                                        <c:forEach items="${recommendedTenantList}" var="tenant">
                                            <c:if test="${project.id==tenantMap.get(tenant.id)}">
                                                <a href="<c:url value="/tenant/${tenant.id}"/>" title=""> <img class="imgfilter" src="http://pro.efeiyi.com/${tenant.logoUrl}@!project-tenant-pc" alt=""></a>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </div>
                                <%--</c:forEach>--%>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="items">
            <a href="<c:url value="/"/>">首页</a>
            <a href="">品牌专区</a>
            <a href="">各地非遗</a>
            <a href="">大师</a>
            <a href="">工艺</a>
        </div>
    </div>
</div>
<!--//End--nav-new-->
