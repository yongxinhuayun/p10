package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantWork;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/6/29.
 */
@Controller
@RequestMapping("/tenant")
public class TenantController extends BaseController {

    @Autowired
    BaseManager baseManager;

    /**
     * 获取某传承人的详情页
     * @param model
     * @return
     */
    @RequestMapping({"/{tenantId}"})
    public ModelAndView getTenant(HttpServletRequest request ,  @PathVariable String tenantId , Model model)throws Exception{
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        String queryHql = "from TenantWork t where t.tenant.id = :tenantId";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId",tenantId);
        List list = baseManager.listObject(queryHql,queryParamMap);
        model.addAttribute("tenantWorkList",list);
        model.addAttribute("entity", tenant);
        return new ModelAndView("/tenant/tenantView");
    }

    /**
     * 获取所有传承人
     * @param modelMap
     * @return
     */
    @RequestMapping("/tenantList")
    public ModelAndView listTenant(HttpServletRequest request , ModelMap modelMap)throws Exception{
        XQuery xQuery = new XQuery("listTenantRecommended_default",request);
        List list = baseManager.listObject(xQuery);
        modelMap.addAttribute("list",list);
        return new ModelAndView("/tenant/tenantList",modelMap);
    }



}
