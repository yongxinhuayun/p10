package com.efeiyi.ec.system.product.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.hibernate.envers.Audited;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/7/20.
 */
public class productHandler implements MultipartHandler{
    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    //private  MyUser userDetails = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "product/"+identify+".jpg";
        boolean result = aliOssUploadManager.uploadFile(multipartRequest.getFile("picture_url"), "tenant", url);

        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(),request);
        HashMap<String,Object> paramMap = xSaveOrUpdate.getParamMap();
        paramMap.put("picture_url",url);
        paramMap.put("createDateTime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        paramMap.put("status","1");

//        Master tenant = new Master();
//        tenant.setId(request.getParameter("tenant_id"));
//        paramMap.put("tenant",request.getParameter(userDetails);

        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);


        modelMap.put("object",object);

        return modelMap;
    }
}
