<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/29
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>【${product.name} ${productModel.name}】${product.subName} -e飞蚁</title>
    <c:if test="${product.master!=null}">
        <c:set var="master">
            ${product.master.fullName}
        </c:set>
    </c:if>
    <meta name="keywords"
          content="${product.name},${productModel.name},${product.subName},${product.project.name},${master},${productModel.name},${product.bigTenant.name}"/>
    <meta name="description"
          content="${product.name},${productModel.name},${product.subName},${product.project.description}"/>

</head>
<body>
<script>

</script>
<!-- //End--header-->
<div class="hd product-intro">
    <div class="wh">
        <ol class="am-breadcrumb">
            <li><a href="/">首页</a></li>
            <li><a href="/product/list/${project.id}">${project.name}</a></li>
            <li class="am-active">${product.name}</li>
        </ol>
    </div>
    <!-- //End--面包屑-->
    <%--<div class="wh itemInfo">--%>
    <%--<div class="preview">--%>
    <%--<div class="collect" id ="show" onclick="collect('${productModel.id}')">--%>
    <%--<i class="icon icon-hover"></i>--%>
    <%--<span class="hover">收藏</span>--%>
    <%--</div>--%>
    <div class="wh itemInfo">
        <div class="preview">
            <div class="collect" id="show" onclick="collect('${productModel.id}')">
                <div class="biao"><i class="icon"></i></div>
                <span class="txt hover">添加收藏</span>
            </div>
            <div class="collect" id="hidden" style="display: none;" onclick="deCollect('${productModel.id}')">
                <div class="biao"><i class="icon icon-active"></i></div>
                <span class="txt active">取消收藏</span>
            </div>
            <%--<div class="collect" id="hidden" style="visibility: hidden" onclick="deCollect('${productModel.id}')">--%>
            <%--<i class="icon icon-hover"></i>--%>
            <%--<span class="hover">已收藏</span>--%>
            <%--</div>--%>
            <%--<div class="collect" disabled =disable  onclick="getStatus('${productModel.id}')">  <i class="icon" > </i> <span class="hover" id="collection" >收藏</span><span class="active">已收藏</span>  </div>--%>
            <%--<div class="collect" > <a <a onclick="getStatus('${productModel.id}')"> method="post"/> <i class="icon"></i></a><span class="hover">收藏</span></div>--%>
            <div class="slider-img">
                <ul>
                    <%--<c:if test="${productPicture.status=='2'}">--%>
                    <li><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-detail-pc-view"
                             alt=""/></li>
                    <%--</c:if>--%>
                    <c:forEach items="${productPictures}" var="productPicture" varStatus="rec">
                        <c:if test="${productPicture.status=='1'&&productPicture.productModel.id==productModel.id}">
                            <li><img src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!product-detail-pc-view"
                                     alt=""/></li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <!-- //End--sliderimg-->
            <div class="slider-main">
                <ul>
                    <%--<c:if test="${productPicture.status=='2'}">--%>
                    <li>
                        <img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-details-picture"
                             alt=""/>
                    </li>
                    <%--</c:if>--%>
                    <c:forEach items="${productPictures}" var="productPicture" varStatus="rec">
                        <c:if test="${productPicture.status=='1'&&productPicture.productModel.id==productModel.id}">
                            <li>
                                <img src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!product-details-picture"
                                     alt=""/>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <!-- //End--slider-main-->
        </div>


        <div class="itme-ext">
            <div class="name">
                <p><strong>${product.name}</strong></p>

                <p>${product.subName}</p>
            </div>
            <!-- //End-->
            <c:if test="${product.master!=null}">
                <div class="master-name">
                    <p class="p1"><a href="http://${product.master.name}.efeiyi.com"
                                     target="_blank"><span>${product.master.fullName}</span></a>
                        <c:if test="${not empty artistry}">
                            <a href="http://minglu.efeiyi.com/project/${artistry.id}">[${product.master.getMainProjectName().getProject().getName()}]</a>
                        </c:if>
                        <c:if test="${empty artistry}">
                            [${product.master.getMainProjectName().getProject().getName()}]
                        </c:if>

                    </p>

                    <p class="p2"><ming800:status name="level" dataType="Project.level"
                                                  checkedValue="${productModel.product.master.getMainProjectName().getProject().getLevel()}"
                                                  type="normal"/>传承人</p>

                    <div class="master-img-pt"><a href="http://${product.master.name}.efeiyi.com" target="_blank"
                                                  title=""><img
                            src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!tanent-details-view"></a>
                    </div>
                </div>
            </c:if>
            <!-- //End-->
            <div class="master-cost">
                <c:if test="${productModel.price.intValue()!=0}">
                    <c:if test="${not empty productModel.marketPrice&&productModel.product.status==1}">
                        <p><font>市场价：</font><em>${productModel.marketPrice}</em></p>
                    </c:if>
                    <c:if test="${not empty productModel.price&&productModel.product.status==1}">
                        <p>飞蚁价</p>

                        <p><strong>￥</strong><span>${productModel.price}</span></p>
                    </c:if>
                </c:if>
            </div>
            <!-- //End-->
            <!-- //End-->
            <div class="des">
                <div class="colour">服务：</div>
                <div class="colour-page">
                    <span>由 <a target="_blank"
                               href="<c:url value="/tenant/${product.tenant.id}"/>">${product.bigTenant.name}</a>[${product.bigTenant.address}] 发货并提供售后服务</span>
                </div>
            </div>
            <div class="des">
                <c:if test="${fn:length(productModelList) >1}">
                    <div class="colour">规格：</div>
                    <div class="colour-page">
                        <ul class="ul-list">
                            <c:forEach items="${productModelList}" var="productModelTmp" varStatus="rec">
                                <c:if test="${productModel.id == productModelTmp.id}">
                                    <li class="active">
                                        <a href="/product/productModel/${productModelTmp.id}">
                                                <%--<c:forEach items="${productModelTmp.productPropertyValueList}"--%>
                                                <%--var="productPropertyValue" varStatus="rec">--%>
                                                <%--${productPropertyValue.projectPropertyValue.value}--%>
                                                <%--</c:forEach>--%>
                                                <%--${product.name}--%>
                                                ${productModelTmp.name}
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${productModel.id != productModelTmp.id}">
                                    <li class="">
                                        <a href="/product/productModel/${productModelTmp.id}">
                                                <%--<c:forEach items="${productModelTmp.productPropertyValueList}"--%>
                                                <%--var="productPropertyValue" varStatus="rec">--%>
                                                <%--${productPropertyValue.projectPropertyValue.value}--%>
                                                <%--</c:forEach>--%>
                                                <%--${product.name}--%>
                                                ${productModelTmp.name}
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </div>
            <c:if test="${productModel.product.status==1&&productModel.status!=0}">
                <div class="des">
                    <div class="colour">数量：</div>
                    <div class="colour-page">
                        <div class="amount">
                            <a onclick="subtractProduct()" class="btn-sub" title="减"><i class="icon icon-add"></i></a>
                            <input id="value" class="txt" type="text" value="1"/>
                            <a onclick="addProduct()" class="btn-add" title="加"><i class="icon icon-sub"></i></a>
                        </div>
                        <!-- //End-->
                    </div>
                </div>
            </c:if>
            <div class="choose-btns">
                <c:if test="${productModel.amount <= 0}">
                    <a id="modelId" class="btn btn-append" title="售罄">售罄</a>
                </c:if>
                <c:if test="${productModel.amount > 0&&productModel.product.status==1}">
                    <a id="modelId" class="btn btn-append"
                       onclick="addCart('${productModel.id}')" title="放入购物车" dis>放入购物车</a>
                    <a class="btn btn-buy" onclick="immediateBuy('${productModel.id}')"
                       title="立即购买">立即购买</a>
                    <a class="btn" id="btn-gift" title="购买送礼">购买送Ta</a>
                </c:if>
                <%--<a class="btn btn-append" href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" title="放入购物车">放入购物车</a>--%>
                <%--<a class="btn btn-buy" href="<c:url value="/order/easyBuy/${productModel.id}"/>" title="立即购买">立即购买</a>--%>
                <%--<!--JiaThis Button BEGIN-->--%>
                <!--  <div class="jiathis_style">
                      <span class="jiathis_txt">分享到</span>
                      <a class="jiathis_button_weixin"></a>
                      <a class="jiathis_button_tqq"></a>
                      <a class="jiathis_button_tsina"></a>
                      <a class="jiathis_button_cqq"></a>
                  </div>-->
                <!--  JiaThis Button END-->
            </div>
            <!-- //End-->


        </div>
    </div>
    <!-- //End--itemInfo-->
    <div class="wh destail-tab">
        <div class="tab-wrap">
            <!-- JiaThis Button BEGIN -->
            <div class="jiathis_style">
                <span class="jiathis_txt">分享到</span>
                <a class="jiathis_button_weixin"></a>
                <a class="jiathis_button_tqq"></a>
                <a class="jiathis_button_tsina"></a>
                <a class="jiathis_button_cqq"></a>
            </div>
            <!-- JiaThis Button END -->
            <div class="tab-items">
                <ul>
                    <c:if test="${empty productModel.product.tenant.id}">
                        <li><a href="#detail" title="商品详情">商 品 详 情<i class="icon"></i></a></li>
                        <li><a href="#title" title="商品评价">商 品 评 价</a></li>
                    </c:if>
                    <c:if test="${not empty productModel.product.tenant.id}">
                        <li><a href="#detail" title="商品详情">商 品 详 情<i class="icon"></i></a></li>
                        <%--<li><a href="#feeling" title="大师感悟">大 师 感 悟<i class="icon"></i></a></li>--%>
                        <li><a href="#title" title="商品评价">商 品 评 价<i class="icon"></i></a></li>
                        <%--<li><a href="#" title="服务保障">服 务 保 障<i class="icon"></i></a></li>--%>

                        <li><a href="<c:url value="/tenant/${product.tenant.id}"/>" title="同店精品">进 入 店 铺</a></li>
                    </c:if>
                </ul>
            </div>
            <!-- //End-->
            <div class="btns">
                <c:if test="${productModel.amount > 0&&productModel.product.status==1&&productModel.status!=0}">
                    <a class="buy" href="<c:url value="/order/easyBuy/${productModel.id}?amount=1"/>" title="立即购买">立 即 购
                        买</a>
                    <a class="append"
                       href="<c:url value="/cart/addProduct.do?id=${productModel.id}&amount=1&redirect=/product/productModel/${productModel.id}"/>"
                       title="放入购物车"><i
                            class="icon"></i>放 入 购 物 车</a>
                </c:if>
            </div>
        </div>
    </div>
    <div class="wh detail" id="detail">
        <div class="wh title"><h3>商品详情</h3></div>
        <div class="wh part">
            <%--<div class="wh part">--%>
            <c:if test="${not empty product.productDescription.content}">
                ${product.productDescription.content}
            </c:if>
        </div>
        <div class="wh part">
            <c:if test="${not empty productPictureList&&fn:length(productPictureList)>0&&empty product.productDescription.content}">
                <c:forEach items="${productPictureList}" var="productPicture">
                    <p>
                        <img src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!pc-detail-view"/>
                    </p>
                </c:forEach>

            </c:if>
            <c:if test="${not empty purchaseOrderProductList}">
                <div class="discuss">
                    <div class="title" id="title"><h3>商品评价</h3></div>
                    <div class="dis-con">
                        <div class="dis-title">用户印象：</div>
                        <div class="dis-ul">
                                <%--<c:if test="${not empty purchaseOrderProductList}">--%>
                            <c:forEach items="${purchaseOrderProductList}" var="purchaseOrderProduct"
                                       varStatus="rec">
                                <c:if test="${not empty purchaseOrderProduct.purchaseOrderComment&&purchaseOrderProduct.purchaseOrderComment.status!='0'&&not empty purchaseOrderProduct.purchaseOrder.user&&not empty purchaseOrderProduct.purchaseOrder}">
                                    <li>
                                        <div class="txt">
                                            <c:if test="${not empty purchaseOrderProduct.purchaseOrderComment}">
                                                ${purchaseOrderProduct.purchaseOrderComment.content}
                                                <%--<c:if test="${not empty purchaseOrderProduct.purchaseOrderComment.purchaseOrderBusinessReply}">--%>
                                                <%--<div class=" hotel ae">--%>
                                                <%--<p><strong>[店家回复]</strong>${purchaseOrderProduct.purchaseOrderComment.purchaseOrderBusinessReply.reply}</p>--%>
                                                <%--<div class="time ae" >--%>
                                                <%--<span>${fn:substring(purchaseOrderProduct.purchaseOrderComment.purchaseOrderBusinessReply.createDatetime,0 ,11 )}</span>--%>
                                                <%--<span>${fn:substring(purchaseOrderProduct.purchaseOrderComment.purchaseOrderBusinessReply.createDatetime,11 ,19 )}</span>--%>
                                                <%--</div>--%>
                                                <%--</div>--%>
                                                <%--</c:if>--%>
                                            </c:if>
                                        </div>
                                        <div class="star">
                                            <c:if test="${empty purchaseOrderProduct.purchaseOrderComment.starts||purchaseOrderProduct.purchaseOrderComment.starts=='5'}">
                                                <i class="star-icon star-5"></i>
                                            </c:if>
                                            <c:if test="${purchaseOrderProduct.purchaseOrderComment.starts=='4'}">
                                                <i class="star-icon star-4"></i>
                                            </c:if>
                                            <c:if test="${purchaseOrderProduct.purchaseOrderComment.starts=='3'}">
                                                <i class="star-icon star-3"></i>
                                            </c:if>
                                            <c:if test="${purchaseOrderProduct.purchaseOrderComment.starts=='2'}">
                                                <i class="star-icon star-2"></i>
                                            </c:if>
                                            <c:if test="${purchaseOrderProduct.purchaseOrderComment.starts=='1'}">
                                                <i class="star-icon star-1"></i>
                                            </c:if>
                                        </div>
                                        <c:set var="user">
                                            ${purchaseOrderProduct.purchaseOrder.user.getUsername()}
                                        </c:set>
                                        <div class="user"><i
                                                class="icon"></i>${fn:substring(user, 0,3 )}****${fn:substring(user,7,11)}
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                            </ul>
                        </div>
                    </div>

                </div>
            </c:if>
        </div>
    </div>
</div>
<!--Start-/*够阿米送礼弹出框*/-->
<div class="dialog-gift" style="display: none;">
    <div class="content">
        <div class="title">
            <c:if test="${fn:length(product.productModelList)==1}">
                ${productModel.name}
            </c:if>
            <c:if test="${fn:length(product.productModelList)>1}">
                ${product.name}[${productModel.name}]
            </c:if>
        </div>
        <div class="code">
            <p class="img">

            <div id="native" style="display: inline-block;"></div>
            </p>
            <p class="txt">扫码下单</p>

            <p class="info"><img src="<c:url value="/scripts/images/dialog-gift-img.png"/>" alt=""></p>
        </div>
        <div class="icon-close" title="关闭"></div>
    </div>
    <div class="overbg"></div>
</div>
<!--//End-/*够阿米送礼弹出框*/-->
<script src="<c:url value="/resources/jquery/jquery.qrcode.min.js"/>"></script>
<script type="text/javascript">
    $(function () {
        $('#btn-gift').bind('click', function () {
            var $div = $('.dialog-gift');
            var $close = $div.find('.icon-close');
            $div.show();
            $(".nav-new,.header-new,.topbar,.footernew").css("z-index", "-1")
            $close.bind('click', function () {
                $div.hide();
                $(".nav-new,.header-new,.topbar,.footernew").css("z-index", "")
            });
            return false;
        });
    })

    $().ready(function () {
        ajaxRequest("<c:url value="/product/favorite/productFavoriteStatus.do"/>", {"id": "${productModel.id}"}, function (data) {
            if (data) {
                $("#show").hide();
                $("#hidden").show();
            } else {
                $("#show").show();
                $("#hidden").hide();
            }
        }, function () {
        }, "get")
    })


    function collect(o) {
        style = "visibility: none;"
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/product/addProductFavorite.do?id="/>' + o,
            dataType: 'json',
            success: function (data) {
                if (data == false) {
                    window.location.href = "<c:url value="/sso.do"/>";
                } else {
                    $("#show").hide();
                    $("#hidden").show();
                }
            },
        });
    }
</script>

<script type="text/javascript">
    function deCollect(o) {
        style = "visibility: none;"
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/product/removeProductFavorite.do?id="/>' + o,
            dataType: 'json',
            success: function (data) {
                if (data == false) {
                    window.location.href = "<c:url value="/sso.do"/>";
                } else {
                    $("#show").show();
                    $("#hidden").hide();
                }
            },
        });
    }


    function subtractProduct() {
        var t = $("#value");
        if (t.val() <= 1) {
            document.getElementById("classid").value = 1;
        }
        t.val(parseInt(t.val()) - 1)
    }
    function addProduct() {
        var t = $("#value");
        var t1 = ${productModel.amount};
        t.val(parseInt(t.val()) + 1)
        if (t.val() >= t1) {
            document.getElementById("value").value = t1;
        }
    }
    function addCart(o) {
        var t = document.getElementById("value").value;
        window.location.href = "<c:url value="/cart/addProduct.do?id="/>"+o +"&amount="+ t+"&redirect=/product/productModel/"+o;
    }
    function immediateBuy(o) {
        var t = document.getElementById("value").value;
        window.location.href = "<c:url value=""/>"+"/order/easyBuy/"+o +"?amount="+ t;
    }
</script>
<script>
    //    var t = document.getElementById("value").value;
    //    $('#native').qrcode({
    //        render: "div",
    //        text: url,
    //        width: 172,
    //        height: 184
    //    });
    $('#btn-gift').bind('click', function () {
        var t = document.getElementById("value").value;
        ;
        var url = "http://mall.efeiyi.com/order/giftBuy/${productModel.id}/" + t;
        $("#native").html("");
        $('#native').qrcode({
            text: url,
//            width: 172,
//            height: 184
        });
        var $div = $('.dialog-gift');
        var $close = $div.find('.icon-close');
        $div.show();
        $close.bind('click', function () {
            $div.hide();
        });
        return false;
    });
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>

<script type="text/javascript">
    var _mvq = window._mvq || [];
    window._mvq = _mvq;
    _mvq.push(['$setAccount', 'm-197303-0']);
    _mvq.push(['$setGeneral', 'goodsdetail', '', /*用户名*/ '', /*用户id*/ '']);
    _mvq.push(['$logConversion']);

    _mvq.push(['$addGoods', /*分类id*/ '', /*品牌id*/ '', /*商品名称*/ '${productModel.name}', /*商品ID*/ '${productModel.id}', /*商品售价*/ '${productModel.price}',
        /*商品图片url*/ 'http://pro.efeiyi.com/${productModel.productModel_url}', /*分类名*/ '${productModel.product.project.name}', /*品牌名*/ '', /*商品库存状态1或是0*/ '${productModel.product.status}', /*网络价*/ '', /*收藏人数*/ '', /*商品下架时间*/ '']);
    _mvq.push(['$logData']);
</script>
</body>
</html>









