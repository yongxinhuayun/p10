<%@ page import="com.efeiyi.ec.system.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar">
        <ul class="am-list admin-sidebar-list">
            <c:forEach items="${jnode.children}" var="childJnode">
                <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">
                    <security:authorize ifAnyGranted="${childJnode.access}">
                        <li class="admin-parent">
                            <a class="am-cf am-collapsed" data-am-collapse="{target: '#${childJnode.id}'}"
                               style="color: #333;"><span
                                    class="am-icon-file"></span> ${childJnode.text_zh_CN}</a>
                            <ul class="am-list am-collapse admin-sidebar-sub ${currentJnode!=null && currentJnode.father.id==childJnode.id? "am-in" : ""}"
                                id="${childJnode.id}">
                                <c:forEach items="${childJnode.children}" var="childchildJnode">
                                    <security:authorize ifAnyGranted="${childchildJnode.access}">
                                        <li>
                                            <a href="<c:url value="${childchildJnode.url}"/>" style="color: #333;"
                                               class="am-cf ${childchildJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}">${childchildJnode.text_zh_CN}</a>
                                        </li>
                                    </security:authorize>
                                </c:forEach>
                            </ul>
                        </li>
                    </security:authorize>
                </c:if>
                <c:if test="${empty childJnode.children}">
                    <li><a class="${childJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}"
                           href="<c:url value="${childJnode.url}"/>"></span> ${childJnode.text_zh_CN}</a></li>
                </c:if>

            </c:forEach>

        </ul>
        <div class="am-panel am-panel-default admin-sidebar-panel">
            <div class="am-panel-bd">
                <p><span class="am-icon-bookmark"></span> 公告</p>
                <p>手机：<%=AuthorizationUtil.getMyUser().getUsername()%>
                </p>
                <div style="width: 100%;table-layout:fixed; word-break: break-all; overflow:hidden; ">
                    <p>
                        链接：http://www.efeiyi.com/subject/iibegant1zwnlnby?source=user_<%=AuthorizationUtil.getMyUser().getId()%>
                    </p>
                </div>

                <p>
                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                       href='<c:url value="/userGift/createQRCode.do">
                               <c:param name="userID" value="<%=AuthorizationUtil.getMyUser().getId()%>"></c:param>
                                </c:url>'><span class="am-icon-trash-o">生成二维码并下载</span>
                    </a>
                </p>
            </div>
        </div>

    </div>
</div>
