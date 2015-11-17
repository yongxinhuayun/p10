<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>我的团长我的团-e飞蚁</title>
    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="assets/i/favicon.png">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css"/>">
</head>
<body>
<header class="am-header custom-header">

    <!-- //End--chevron-left-->
    <h1 class="am-header-title" style="margin: 0 10%;">我的团长我的团</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav am-header-right1">
        <a href="<c:url value="/person/personInfoView.do"/>" class="chevron-right" id="menu">
            <i class="icon icon-user"></i>
        </a>
    </div>
</header>
<!--//End--header-->
<div class="all-bulk ae">
    <div class="one-bulk ae">
        <ul class="ae" id = "productListId">
            <%--<c:forEach items="${groupProductList}" var="groupProduct" varStatus="rec">--%>
                <%--<li class="ae">--%>
                    <%--<div class="colonel-pic ae"><a href="<c:url value="/product/groupProduct/${groupProduct.id}"/>"><img src="http://pro.efeiyi.com/${groupProduct.productModel.productModel_url}@!tg-efeiyi-view-list"></a>--%>
                        <%--<div class="c-page"><span><a href="javascript:void(0)">${groupProduct.productModel.name}${groupProduct.productModel.product.subName}</a></span>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<ul class="price ae">--%>
                        <%--<li><s>原价:${groupProduct.productModel.price}元</s></li>--%>
                        <%--<li>团购价:${groupProduct.groupPrice}元</li>--%>
                        <%--<li>${groupProduct.memberAmount}人成团</li>--%>
                    <%--</ul>--%>
                <%--</li>--%>
            <%--</c:forEach>--%>
        </ul>
    </div>
    <div class="more ae"><a onclick="moreGroupProduct()"><span>下拉了解更多商品...</span><div class="icon"></div></a></div>
</div>

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js"/>"></script>
<script src="<c:url value="/scripts/wap/js/myorder.js?v=20150831"/>"></script>
<!--自定义js--Start-->


<%--{{for(var i = 0 ; i<it.length ; i++) { }}--%>
<%--<li class="ae">--%>
    <%--<div class="colonel-pic ae"><a href="/product/groupProduct/{{=it[i].id}}"><img src="http://pro.efeiyi.com/{{=it[i].productModel.productModel_url}}@!tg-efeiyi-view-list"></a>--%>
        <%--<div class="c-page"><span><a href="javascript:void(0)">{{=it[i].productModel.name}}{{=it[i].productModel.product.subName}}</a></span>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<ul class="price ae">--%>
        <%--<li><s>原价:{{=it[i].productModel.price}}元</s></li>--%>
        <%--<li>团购价:{{=it[i].groupPrice}}元</li>--%>
        <%--<li>{{=it[i].memberAmount}}人成团</li>--%>
    <%--</ul>--%>
<%--</li>--%>
<%--{{ } }}--%>






<script>
    function htmlGenerater(it /**/) {
        var out = '';
        for (var i = 0; i < it.length; i++) {
            out += '<li class="ae"> <div class="colonel-pic ae"><a href="<c:url value="/product/groupProduct/"/>' + (it[i].id) + '"><img src="http://pro.efeiyi.com/' + (it[i].productModel.productModel_url) + '@!tg-efeiyi-view-list"></a> <div class="c-page"><span><a href="javascript:void(0)">' + (it[i].productName) + '['+ it[i].productModel.name +']' + '</a></span> </div> </div> <ul class="price ae"> <li><s>原价:' + (it[i].productModel.price) + '元</s></li> <li>团购价:' + (it[i].groupPrice) + '元</li> <li>' + (it[i].memberAmount) + '人成团</li> </ul></li>';
        }
        return out;
    }



    $(document).ready(function(){
        getProductList("<c:url value='/product/groupProduct.do/'/>");
    })
    var count = 1;
    function moreGroupProduct(){
        var url = "<c:url value='/product/groupProduct.do/'/>";
        getProductList(url);
    }
    function getProductList(url){
        $.ajax({
            type: "get",//设置get请求方式
            url: url+count,//设置请求的脚本地址
            data: "",//设置请求的数据
            async: true,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                console.log(data);
                count = count + 1;
                if(data != null && data.length > 0) {
                    var box = htmlGenerater(data);
                    $("#productListId").append(box);
                }
            }
        })
    }
</script>
<!--自定义js--End-->
</body>
</html>