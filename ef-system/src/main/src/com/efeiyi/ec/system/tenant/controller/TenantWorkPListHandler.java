package com.efeiyi.ec.system.tenant.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/22.
 */
public class TenantWorkPListHandler implements DoHandler {

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        modelMap.put("projectId",request.getParameter("projectId"));
        modelMap.put("tenantId",request.getParameter("tenantId"));

        return modelMap;
    }
}
