package com.ming800.core.base.controller;


import com.ming800.core.base.service.impl.BaseManagerImpl;
import com.ming800.core.p.controller.BannerController;
import com.ming800.core.p.controller.DocumentController;
import com.ming800.core.p.model.Banner;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.junit.AfterClass;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import javax.annotation.Resource;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;

import java.util.List;


/**
 * Created by kayson on 2015/7/14.
 *
 *
 */

@SuppressWarnings("unchecked")
//@Transactional
//@TransactionConfiguration(transactionManager ="transactionManager", defaultRollback = true)
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={"file:src/main/webapp//WEB-INF/applicationContext-*.xml","file:src/main/webapp//WEB-INF/spring-servlet.xml"})
@Controller
public class BannerControllerTest {
    private static Logger logger = Logger.getLogger(BannerControllerTest.class);

    // 加载顺序 @BeforeClass –> @Before –> @Test –> @After –> @AfterClass

   //HttpServletRequest request;
     MockHttpServletRequest request;
     MockHttpServletResponse response;
    // ModelAndView mv ;
     @Resource
     BannerController bannerController;
     @Resource
     DocumentController documentController;
     ModelMap  map ;
     @Autowired
     private BaseManager baseManager;

     @BeforeClass
     public static void setUpBeforeClass() throws Exception {

     }
    @SuppressWarnings("SuppressWarnings")
    @Before
    public void init() {
          logger.info("加载spring配置开始 ............");
	      /* ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml"); */
        /*ApplicationContext applicationContext = new FileSystemXmlApplicationContext(new String[]{
                "src/main/webapp//WEB-INF/applicationContext-*.xml",
                "src/main/webapp//WEB-INF/spring-servlet.xml"});*/
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext(new String[]{
                "classpath*:applicationContext-*.xml",
                "classpath*:spring-servlet.xml"});
         logger.info("加载spring配置结束.............");
        map = new ModelMap();
        request = new MockHttpServletRequest();
        response = new MockHttpServletResponse();
        request.setCharacterEncoding("UTF-8");
        //bannerController = new BannerController();
       //baseManager=(BaseManagerImpl)applicationContext.getBean("baseManagerImpl");
        //bannerController = (BannerController)applicationContext.getBean("bannerController");
        //documentController = (DocumentController)applicationContext.getBean("documentController");
    }
    @Test
    public void demo1() {

        List<Banner> banners;
        XQuery xQuery = null;
        try {
            xQuery = new XQuery("listPCBanner_default",request);
        } catch (Exception e) {
            logger.error("create xQuery error in BannerController.getBannerByModlueId()...");
            e.printStackTrace();
        }
        banners = baseManager.listObject(xQuery);
        if (banners==null || banners.size()<=0){
            logger.info("no banners be found,plase confirm again!");

        }else{
           /* banners.parallelStream()
                    .sorted((a, b) -> a.getBannerOrder() > b.getBannerOrder())
                    .forEach(e -> System.out::println);*/
            for(Banner banner:banners){
                System.out.println(banner.getImageUrl());
            }
        }
    }

    @Test
    public void demo2()throws  Exception{

        bannerController.getBannerByGroupId(request);
       /* Assert.assertNotNull(mv);
        Assert.assertEquals(response.getStatus(), 200);*/
    }
    @Test
    public void demo3()throws  Exception{

        documentController.getDocByGroupId(request);

    }
    @Test
    public void demo4()throws  Exception{

     String url ="/base_resource/p/assets/i/favicon.png";

        System.out.println(url.substring(url.indexOf("base_resource/p/")).substring("base_resource/p/".length()));
        System.out.println(url.lastIndexOf("base_resource/p/"));
        System.out.println(url.substring((url.indexOf("base_resource/p/"))).substring("base_resource/p/".length())) ;
        String fileType=url.substring("admin.css".indexOf("."));
        System.out.println("admin.css".indexOf("."));

        String fileName = url.substring(url.lastIndexOf(".")+1);
        System.out.print(fileName);
    }
    @After
    public  void setUpAfter() throws Exception {

    }

    @AfterClass
    public static void setUpAfterClass() throws Exception {

    }


}
