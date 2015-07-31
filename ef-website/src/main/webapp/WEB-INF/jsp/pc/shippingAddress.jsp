<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>product</title>
  <script>

    function find(o){
      var pid = $(o).next().val();
      window.location=("/product/getProduct.do?id="+pid);
    }
  </script>
</head>
<body>
<h1>商品列表</h1>
<form name="product"  method="post">
  <table width="95%" align="center" cellpadding="10" cellspacing="0" border="1">
    <tr>
      <td>商品名称</td>
      <td>查看详情</td>
    </tr>
    <c:forEach items="${productList}" var="product" >
      <tr>
        <td><input type="text" name="productName" value="${product.name}"/></td>
        <td><input type="button" value="浏览" onclick="find(this);"><input type="hidden" id="productId" value="${product.id}"></td>
      </tr>
    </c:forEach>
  </table>
</form>
</body>
</html>
