package com.efeiyi.ec.system.product.controller;

import com.efeiyi.ec.product.model.SubjectProduct;
import com.efeiyi.ec.product.model.SubjectProductModel;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/21.
 */
public class PListTProductModelHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        if(request.getParameter("subjectId")!=null&&request.getParameter("subjectId")!=""){
            XQuery xQuery = new XQuery("listSubjectProductModel_default2",request);
            xQuery.put("subject_id",request.getParameter("subjectId"));
            List<SubjectProductModel> subjectProductModelList = baseManager.listObject(xQuery);
            modelMap.put("subjectProductModelList",subjectProductModelList);
        }

       modelMap.put("subjectId",request.getParameter("subjectId"));
//        XQuery xQuery = new XQuery();
//        List list =  baseManager.listObject(xQuery);

        return modelMap;
    }
}
