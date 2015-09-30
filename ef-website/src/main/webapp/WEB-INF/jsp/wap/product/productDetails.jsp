<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>商品详情</title>
</head>
<body>

<article class="custom">
    <div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}'>
        <ul class="am-slides">
            <li><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!wap-product-pic"></li>
            <c:forEach items="${productModel.product.productPictureList}" var="picture">
                <c:if test="${picture.status=='1'}">
                <li><img src="http://pro.efeiyi.com/${picture.pictureUrl}@!wap-product-pic"></li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
    <!--//End--am-slider-->
    <div class="bd details">
        <div class="bd des-title">
            <strong class="bd txt">${productModel.product.name}
                <c:forEach
                    items="${productModel.productPropertyValueList}" var="pv">
                ${pv.projectPropertyValue.value}
            </c:forEach> </strong>
            <a href="#分享" class="share">
                <i class="icon icon-share"></i>

                <p>分享</p>
            </a>
            <a onclick="getStatus(${productModel.product.id})" class="addfav">
                <i class="icon icon-addfav"></i>

                <p>收藏</p>
            </a>
        </div>
        <!-- //End--des-title-->
        <div class="bd des-price">
            <p class="bd p-price"><span>价格：</span><em>￥</em><strong>${productModel.price.intValue()}</strong></p>

            <p class="bd express">快递：0（飞蚁包邮）</p>
        </div>
        <!-- //End--des-price-->
        <c:if test="${fn:length(productModelList)>1}">
        <div class="bd des-format">
            <a data-am-modal="{target: '#my-actions'}" class="bd btn-format" title="选择规格">选择规格<i
                    class="arrow-right"></i></a>
        </div>
        </c:if>
        <!-- //End--des-format-->
        <div class="des-content">
            <div class="bd title">详情</div>
            <div class="bd" style="padding: 10px">
                <c:if test="${!empty product.productDescription}">
                    ${product.productDescription.content}
                </c:if>
            </div>
            <!-- //End--box-des-->
        </div>
        <!-- //End--des-format-->
    </div>
    <!-- //End---->
    <div class="bd details-total-bar">
        <a class="btn-default" href="/tenantOfMobile/${productModel.product.tenant.id}" title="进店">进店</a>
        <a class="btn-default" href="#咨询" title="咨询">咨询</a>
        <c:if test="${productModel.amount<=0}">
            <a class="btn-cart"  href=""  title="放入购物车"><i class="icon"></i>放入购物车</a>
            <a class="btn-buy"   href=""  title="立即购买">立即购买</a>
        </c:if>
        <c:if test="${productModel.amount>0}">
            <a class="btn-cart"  href="/cart/addProduct.do?id=${productModel.id}" title="放入购物车"><i class="icon"></i>放入购物车</a>
            <a class="btn-buy"   href="/order/easyBuy/${productModel.id}" title="立即购买">立即购买</a>
        </c:if>
    </div>
</article>
<div class="am-modal-actions dialog-des-format" id="my-actions">
    <div class="bd ">
        <ul class="bd ul-nav">
            <c:if test="${fn:length(productModelList) >1}">
                <c:forEach items="${productModel.product.productModelList}" var="pm">
                    <li> <a href="<c:url value="/product/productModel/${pm.id}"/> ">
                            ${pm.product.name} <c:forEach
                            items="${pm.productPropertyValueList}" var="pv">
                        ${pv.projectPropertyValue.value}
                    </c:forEach>
                    </a></li>
                </c:forEach>
            </c:if>
            <%--<li><a href="#规格2">规格2</a></li>--%>
            <%--<li><a href="#规格1">规格1</a></li>--%>
            <%--<li><a href="#规格2">规格2</a></li>--%>
        </ul>
        <%--<ul class="bd ul-amount">--%>
        <%--<li>购买数量</li>--%>
        <%--<li>--%>
        <%--<a class="sub btn-cart-no" href="#减"></a>--%>
        <%--<input class="ipt-txt" type="text" value="1"/>--%>
        <%--<a class="add" href="#加"></a>--%>
        <%--</li>--%>
        <%--</ul>--%>
        <%--<c:if test="${productModel.amount <= 0}">--%>
            <%--<a  class="bd btn-cart">缺货</a>--%>
        <%--</c:if>--%>
        <%--<c:if test="${productModel.amount > 0}">--%>
            <%--<a class="bd btn-cart" href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" >加 入 购 物 车</a>--%>
        <%--</c:if>--%>
    </div>
</div>
<div class="am-dimmer am-active" data-am-dimmer="" style="display: none;"></div>
<script type="text/javascript">
    function getStatus(o) {
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/product/addProductFavorite.do?id="/>' + o,
            dataType: 'json',
            success: function (data) {
                if(data==false){
                    window.location.href = "<c:url value="http://passport.efeiyi.com/login"/>";
                }
            },
        });
    }

    $().ready(function(){

        $("img").each(function(){
            $(this).css("width","100%");
        })

    })
</script>
<%--<script>--%>
    <%--$(function(){--%>
        <%--$('.btn-cart,.btn-format,.btn-buy').click(function(){--%>
            <%--$('.dialog-des-format').css({'-webkit-transform':'translateY(0)'});--%>
            <%--$('.am-dimmer').show();--%>
            <%--$('.am-active').click(function(){--%>
                <%--$('.dialog-des-format').css({'-webkit-transform':'translateY(110%)'});--%>
                <%--$('.am-dimmer').hide();--%>
            <%--})--%>
            <%--return false;--%>
        <%--})--%>
    <%--})--%>
<%--</script>--%>
</body>


</html>
