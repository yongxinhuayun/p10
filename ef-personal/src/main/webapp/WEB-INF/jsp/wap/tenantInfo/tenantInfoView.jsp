<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body style="background-color:#F1F5F8">
<header class="work-details">
    <div class="work-details-i"><a href="#"><img src="<c:url value="/scripts/assets/wap/images/logo10.gif"/>"></a></div>
</header>
<section class="work-text-h2">
    <div class="message-text2">
        <h1><c:forEach items="${tenantNews.tenantNewsTagList}" var="tenantNewsTag">
            [${tenantNewsTag.wordValue.value}]
        </c:forEach>
            ${tenantNews.title} </h1>
        <p class="message-text-p2"><fmt:formatDate value="${tenantNews.createDateTime}" pattern="yyyy-MM-dd" /></p>
        <hr data-am-widget="divider" style="margin-top:0;" class="am-divider am-divider-dashed" />
    </div>
    <p class="am-p-p">
        <img src="http://s.amazeui.org/media/i/demos/bw-2014-06-19.jpg" class="am-img-responsive"  style="height:201px; margin-bottom:16px;" alt=""/>
    <span>
        ${tenantNews.content}
    </span>
    </p>
</section>
</body>
</html>