<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/15
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>工艺-分类</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/cyclopedia.css?v=20150831'/>">
  <script src="<c:url value='/resources/jquery/jquery-2.1.3.min.js'/>"></script>
</head>
<body>
<header class="am-header custom-header">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
      <a href="javascript:window.history.go(-1);" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">传统技艺</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav">
      <a href="#chevron-right" class="chevron-right" id="menu">
        <i class="line"></i>
      </a>
    </div>
    <!-- //End--chevron-left-->
    <div class="menu-list">
      <div class="menu-page">
        <ul class="bd">
          <li><a href="" title="首页">首页</a></li>
          <li><a href="" title="分类">消&nbsp;息</a></li>
          <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
        </ul>
      </div>
    </div>
  </header>
</header>
<input type="hidden" name="addType" id="addType" value="<%=request.getAttribute("addType")%>">
<!--//End--header-->
<!--传统技艺-->
<div class="classify" id="pubu">
  <c:if test="${!empty  pageInfo.list}">
    <c:forEach var="ppj" items="${pageInfo.list}">
      <ul class="hot" id="box">
        <li>
          <a href="<c:url value='/base/brifProject.do?projectId=${ppj.id}'/>"><img src="${ppj.picture_url}"></a>
          <div class="hot-poge">
            <span style="margin-right: 1rem">人气</span>
              <%-- <span>${fn:length(ppj.project.projectFolloweds)}</span>--%>
            <span><c:if test="${ppj.fsAmount == null}">0</c:if><c:if test="${ppj.fsAmount != null}">${ppj.fsAmount}</c:if></span>
          </div>
        </li>
      </ul>
    </c:forEach>
  </c:if>
<c:if test="${empty  pageInfo.list}">
  暂时未上架，敬请期待！！！
</c:if>
</div>
<!--传统技艺-->
<script>

  var startNumber =2;
  var ajaxkey1 = true;
  $(window).load(function(){
    PBL("#pubu","#box",2);
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document.body).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){
       var addType = $("#addType").val();
       if(addType=="allCategory" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_allCategory&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="Category" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_Category&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="all" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_all&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="level" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_level&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="allDirt" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_allDirt&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="Dirt" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_Dirt&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else{

       }

      }
    });
  });


  /************************************************* ↓ 函数 ↓ */
//瀑布流主函数
  function PBL(outer,boxs,style){//outer父级元素、boxs子级元素，style加载样式（ 1或者2 ）
    var pubu = $(outer);
    var box = $(boxs);
    var num = Math.floor($(document.body).width()/box.outerWidth());//根据浏览器宽度获得显示的列的数量
    pubu.width(num*(box.outerWidth()));//给pubu的宽度赋值
    var allHeight = [];//定义一个数组存储所有列的高度
    for(var i=0;i<box.length;i++){
      if (i<num) {
        allHeight[i]=box.eq(i).outerHeight();
      }else{
        var minHeight = Math.min.apply({},allHeight);//获得所有的列中高度最小的列的高度
        var sy = getSy(minHeight,allHeight);//获取高度最小的列的索引
        getStyle(box.eq(i),minHeight,sy*box.eq(i).outerWidth(),i,style);
        allHeight[sy] += box.eq(i).outerHeight();
      }
    }
  }
  //获取高度最小的列的索引
  function getSy(minH,allH){
    for(sy in allH){
      if(allH[sy]==minH) return sy;
    }
  }







  //请求数据的方法
  function getData1(url){
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+startNumber,//设置请求的脚本地址
      data:"",//设置请求的数据
      dataType:"json",//设置请求返回的数据格式
      success:function(data){
        var pubu = $("#pubu");
        if(data.list && data.list != null){
          for(i in data.list){

            var moods = data.list[i].project.fsAmount;
            if(moods==null) moods=0;
            var box = $("<ul class='hot' id='box'>" +
                    "<li><a href='#'><img src='"+data.list[i].project.picture_url+"'></a> " +
                    "<div class='hot-poge'> <span style='margin-right: 1rem'>人气</span> " +
                    "<span>"+moods+"</span> " +
                    "</div></li> </ul>");
            pubu.append(box);
          }

        }else{
          flag = true;
        }
        PBL("#pubu","#box",2);
        startNumber=startNumber+1;
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if(flag==true) {
          ajaxkey1 = false;
        }
      }
    })
  }

  //判断请求数据的开关
  function getDataCheck(){
    var pubu = $("#pubu");
    var box = $("#box");
    var lastboxHeight = $(box[box.length-1]).offset().top+Math.floor($(box[box.length-1]).outerHeight()/2);
    var documentHeight = $(window).height();
    var scrollTop = $(document).scrollTop();
    return lastboxHeight<documentHeight+scrollTop?true:false;
  }
  //存储开始请求数据条数的位置
  var getStartNum = 0;
  var StartNum = 1;
  var StartNum2 = 1;
  var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
  var ajaxkey1 = true;
  var  isAttention = false;
  //设置请求数据加载的样式
  function getStyle(boxs,top,left,index,style){
    if (getStartNum>=index) {
      return;
    }
    boxs.css("position","absolute");
    switch(style){
      case 1:
        boxs.css({
          "top":top+$(window).height(),
          "left":left
        });
        boxs.stop().animate({
          "top":top,
          "left":left
        },999);
        break;
      case 2:
        boxs.css({
          "top":top,
          "left":left,
          "opacity":"0"
        });
        boxs.stop().animate({
          "opacity":"1"
        },999);
    }
    getStartNum = index;//更新请求数据的条数位置





  }


</script>

<script src="<c:url value='/resources/jquery/jquery.min.js?v=20150831'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>

<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--自定义js--Start-->
<script src="<c:url value='/resources/assets/js/amazeui.min.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/wap/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/wap/js/cyclopedia.js?v=20150831'/>"></script>
<!--自定义js--End-->
</body>
</html>