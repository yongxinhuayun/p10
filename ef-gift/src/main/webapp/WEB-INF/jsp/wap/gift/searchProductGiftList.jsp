<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<header id="header" class="am-header custom-header newheader">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1)" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">礼品筛选</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
</header>
<article>
  <div id="result" class="bd search-sort">
    <ul class="bd tnav">
      <li>
        <a href="javascript:void(0);"
           title="综 合">综 合</a>
      </li>
      <li>
        <a href="javascript:void(0);" title="新 品">新 品</a>
      </li>
      <li>
        <a href="javascript:void(0)">价  格
          <i class="icon-a1"></i>
        </a>
      </li>
      <li>
        <a href="<c:url value="/searchProductGift"/>" title="筛 选">筛 选</a>
      </li>
    </ul>
    <ul class="ul-list">
      <%
        if(request.getParameter("value")!=null && !request.getParameter("value").equals("")){
      %>
      <c:forEach items="${productGiftTagList}" var="productGiftTag">
        <li>
          <a href="http://www.efeiyi.com/product/productModel/${productGiftTag.productGift.productModel.id}" title="">
            <img src="http://pro.efeiyi.com/${productGiftTag.productGift.productModel.productModel_url}@!product-model-wap-view" alt="">
            <p class="name">${productGiftTag.productGift.productModel.name}</p>
            <p class="price"><em>￥</em>${productGiftTag.productGift.productModel.price}</p>
          </a>
        </li>
      </c:forEach>
      <%
      }else {
      %>
      <c:forEach items="${productGiftList}" var="productGift">
        <li>
          <a href="http://www.efeiyi.com/product/productModel/${productGift.productModel.id}" title="">
            <img src="http://pro.efeiyi.com/${productGift.productModel.productModel_url}@!product-model-wap-view" alt="">
            <p class="name">${productGift.productModel.name}</p>
            <p class="price"><em>￥</em>${productGift.productModel.price}</p>
          </a>
        </li>
      </c:forEach>
      <%
        }
      %>
    </ul>
  </div>
</article>
</body>
</html>
