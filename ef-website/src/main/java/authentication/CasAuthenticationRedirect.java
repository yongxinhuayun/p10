package authentication;

import com.ming800.core.util.HttpUtil;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2015/11/4.
 */
public class CasAuthenticationRedirect extends org.springframework.security.cas.web.CasAuthenticationEntryPoint {
    private String serviceUrlBak = null;


    @Override

    protected String createServiceUrl(final HttpServletRequest request, final HttpServletResponse response) {
        String unionid = request.getParameter("unionid");

        if (serviceUrlBak == null)


            serviceUrlBak = getServiceProperties().getService();


        if (serviceUrlBak != null) {
            String ctx = request.getContextPath();
            String queryString = request.getQueryString();
            String requestURI = request.getRequestURI();
            requestURI = requestURI.substring(requestURI.indexOf(ctx) + ctx.length(), requestURI.length());
            String serviceUrl = "";
            if (!requestURI.equals("/") && requestURI.length() > 0) {
                //serviceUrl="?"+ new SimpleUrlAuthenticationSuccessHandler().getTargetUrlParameter();
                serviceUrl = "?callUrl";
                serviceUrl += "=" + requestURI;
                if (StringUtils.isNotBlank(queryString)) {
                    serviceUrl += "?" + queryString;
                }

            }
            //出发登陆的时候去取得uuid
            if (HttpUtil.isWeixin(request) && unionid != null) {
                try {
                    String callback = URLEncoder.encode(serviceUrl, "utf-8");
                    String dataKey = "unionid";
                    response.sendRedirect(request.getContextPath() + "/wx/getInfo.do?callback=" + callback + "&dataKey=" + dataKey);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            getServiceProperties().setService(serviceUrlBak + serviceUrl);
        }


        return super.createServiceUrl(request, response);
    }

}
