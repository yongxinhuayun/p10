<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

<script type="text/javascript">
    function loginOrRegister(o){
       window.location.href="/pc/forward.do?result="+o;
    }
</script>
<h2>Hello World!</h2>
<input type="button" value="登录" onclick="loginOrRegister(1);"/>
<input type="button" value="注册" onclick="loginOrRegister(2);"/>
</body>
</html>
