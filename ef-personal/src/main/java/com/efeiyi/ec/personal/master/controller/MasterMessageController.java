package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/9/21.
 */

@Controller
@RequestMapping("/masterMessage")
public class MasterMessageController {

	@Autowired
	private BaseManager baseManager;

	@RequestMapping("/index.do")
	public String mainPage(){
		return "/masterMessage/index";
	}

	@RequestMapping("/forwardIndex.do")
	public String indexPage(){
		return "/masterMessage/masterMessageList";
	}

	@ResponseBody
	@RequestMapping("/masterMessageList.do")
	public List MasterMessageList(HttpServletRequest request) throws Exception {
		XQuery xQuery = new XQuery("plistMasterMessage_default",request);
		MyUser user = AuthorizationUtil.getMyUser();
		List<MasterMessage> messageList = baseManager.listObject(xQuery);
		for (MasterMessage message : messageList){
			getPraiseStatus(message,user);
			message.setMasterId(message.getMaster().getId());
			message.setMasterName(message.getMaster().getFullName());
			message.setAmount(message.getAmount() == null ? 0 : message.getAmount());
			message.setFsAmount(message.getFsAmount() == null ? 0 : message.getFsAmount());
		}
		return messageList;
	}

	@RequestMapping("/getOnlyMasterMessageList.do")
	public String getMaster(HttpServletRequest request,Model model){
		String masterId = request.getParameter("masterId");
		String queryHql = "from MasterMessage m where m.master.id=:masterId";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",masterId);
		List<MasterMessage> list = baseManager.listObject(queryHql,queryMap);
		Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
		model.addAttribute("objectList",list);
		model.addAttribute("object",master);
		return "/masterMessage/masterMessageListView";
	}

	@RequestMapping("/getMasterMessage.do")
	public String getMasterMessage(HttpServletRequest request,Model model){
		String messageId = request.getParameter("messageId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (!StringTools.isEmpty(messageId)){
			MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),messageId);
			getMasterFollowedStatus(message.getMaster());
			model.addAttribute("object",message);
			model.addAttribute("myUser",user);
		}
		return "/masterMessage/masterMessageView";
	}

	public String getMasterFollowedStatus(Master master){
		String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.status=1";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",master.getId());
		List<MasterFollowed> list = baseManager.listObject(queryHql,queryMap);
		if (list != null && list.size() > 0){
			master.setFollowStatus("已关注");
		}else{
			master.setFollowStatus("关注");
		}
		return master.getFollowStatus();
	}


	public String getPraiseStatus(MasterMessage message , MyUser user){
		String queryHql = "from MasterMessagePraise p where p.message.id=:messageId and p.user.id=:userId";
		LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
		queryMap.put("messageId",message.getId());
		queryMap.put("userId",user.getId());
		List<MasterMessagePraise> list = baseManager.listObject(queryHql,queryMap);
		if (list != null && list.size() > 0){
			message.setPraiseStatus("取消赞");
		}else{
			message.setPraiseStatus("赞");
		}
		return message.getPraiseStatus();
	}

	@ResponseBody
	@RequestMapping("/collected.do")
	public boolean collected(HttpServletRequest request){
		String messageId = request.getParameter("messageId");
		MyUser user = AuthorizationUtil.getMyUser();
		String queryHql = "from MasterMessageStore s where s.masterMessage.id=:messageId and s.user.id=:userId";
		LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
		queryMap.put("messageId",messageId);
		queryMap.put("userId",user.getId());
		List<MasterMessageStore> list = baseManager.listObject(queryHql,queryMap);
		if (list == null || list.size() <= 0){
			MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),messageId);
			MasterMessageStore store = new MasterMessageStore();
			store.setUser(user);
			store.setMasterMessage(message);
			baseManager.saveOrUpdate(MasterMessageStore.class.getName(),store);
			return true;
		}else {
			MasterMessageStore store = list.get(0);
			baseManager.delete(MasterMessageStore.class.getName(),store.getId());
			return false;
		}
	}


	@RequestMapping("/forwardMasterDetails.do")
	public String forwardDetails(HttpServletRequest request, Model model) {
		String masterId = request.getParameter("masterId");
		Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
		model.addAttribute("object",master);
		return "/masterMessage/masterMessageDetails";
	}

	@ResponseBody
	@RequestMapping("/getMasterDetails.do")
	public List getMasterDetails(HttpServletRequest request){
		String masterId = request.getParameter("masterId");
		Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
		master.setProjectName(mainMasterProject(master.getMasterProjectList()));
		String queryHql = "from MasterMessage m where m.master.id=:masterId";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",master.getId());
		List<MasterMessage> list = baseManager.listObject(queryHql,queryMap);
		MyUser user = AuthorizationUtil.getMyUser();
		if (list != null && list.size() > 0){
			for (MasterMessage message : list){
				String queryHql1 = "from MasterMessagePraise m where m.message.id=:messageId and m.user.id=:userId";
				LinkedHashMap<String,Object> queryMap1 = new LinkedHashMap<>();
				queryMap1.put("messageId",message.getId());
				queryMap1.put("userId",user.getId());
				List<MasterMessage> praiseList = baseManager.listObject(queryHql1,queryMap1);
				if (praiseList != null && praiseList.size() > 0){
					message.setPraiseStatus("取消赞");
				}else{
					message.setPraiseStatus("赞");
				}
			}
		}
		return list;
	}

	public String mainMasterProject(List<MasterProject> masterProjects) {

		MasterProject masterProject = null;

		if (masterProjects != null && masterProjects.size() > 0) {

			for (MasterProject masterProjectTemp : masterProjects) {
				if (masterProjectTemp.getStatus().equals("1")) {
					masterProject = masterProjectTemp;
				}
			}
			if (masterProject == null) {
				masterProject = masterProjects.get(0);
			}

			return masterProject.getProject().getName();
		} else {

			return "";
		}
	}

//	@ResponseBody
//	@RequestMapping("/messageComment.do")
//	public boolean messageComment(HttpServletRequest request){
//		String msgId = request.getParameter("msgId");
//		String content = request.getParameter("content");
//		MyUser user = AuthorizationUtil.getMyUser();
//		if (user == null){
//			return false;
//		}
//		return true;
//	}

	@ResponseBody
	@RequestMapping("/workComment.do")
	public boolean messageCommented(HttpServletRequest request)throws Exception{
		String msgId = request.getParameter("msgId");
		String content = request.getParameter("content");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user == null){
			return false;
		}
		MasterMessage msg = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),msgId);
		MasterComment comment = new MasterComment();
		comment.setContent(content);
		comment.setUser(user);
		comment.setAmount(0);
		comment.setCreateDateTime(new Date());
		comment.setMasterMessage(msg);
		comment.setStatus("1");
		MasterComment fatherComment = new MasterComment();
		fatherComment.setId("0");
		comment.setFatherComment(fatherComment);
		baseManager.saveOrUpdate(MasterComment.class.getName(),comment);
		msg.setAmount(msg.getAmount()==null? 1 :msg.getAmount() + 1);
		baseManager.saveOrUpdate(MasterMessage.class.getName(),msg);
		return true;
	}

	@ResponseBody
	@RequestMapping("/commentOther.do")
	public boolean fatherCommented(HttpServletRequest request)throws Exception{
		String msgId = request.getParameter("msgId");
		String content = request.getParameter("content");
		String fatherId = request.getParameter("contentId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user == null){
			return false;
		}
		MasterMessage msg = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),msgId);
		MasterComment comment = new MasterComment();
		comment.setContent(content);
		comment.setUser(user);
		comment.setAmount(0);
		comment.setCreateDateTime(new Date());
		comment.setMasterMessage(msg);
		comment.setStatus("1");
		MasterComment fatherComment = new MasterComment();
		fatherComment.setId(fatherId);
		comment.setFatherComment(fatherComment);
		baseManager.saveOrUpdate(MasterComment.class.getName(),comment);
		msg.setAmount(msg.getAmount()==null? 1 :msg.getAmount() + 1);
		baseManager.saveOrUpdate(MasterMessage.class.getName(),msg);
		return true;
	}

	@RequestMapping("/commentUpAndDown.do")
	@ResponseBody
	public String commentUpAndDown(HttpServletRequest request) throws Exception {
		String msgId = request.getParameter("msgId");
		String commentId = request.getParameter("commentId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user.getId() == null) {
			return "false";
		}
		MasterMessage msg = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),msgId);
		MasterComment comment = (MasterComment) baseManager.getObject(MasterComment.class.getName(),commentId);
		MasterMessagePraise praise = new MasterMessagePraise();
		String oper = request.getParameter("operation");
		if (oper != null && oper.equalsIgnoreCase("up")) {
			String queryHql = "from MasterMessagePraise t where t.user.id=:userId and t.comment.id=:commentId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("commentId", commentId);
//			List<MasterWorkPraise> list = baseManager.listObject(queryHql,map);

			MasterMessagePraise p2 = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (p2 != null && p2.getId() != null)//不为null,说明已经点过赞了
			{
				return "repeat";
			}
			//防止重复点赞
			praise.setUser(user);
			praise.setCreateDateTime(new Date());
			praise.setComment(comment);
			baseManager.saveOrUpdate(MasterMessagePraise.class.getName(), praise);
			comment.setAmount(comment.getAmount() == null ? 1 : comment.getAmount() + 1);
			baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
		}

		if (oper != null && oper.equalsIgnoreCase("down")) {
			String queryHql = "from MasterMessagePraise t where t.user.id=:userId and t.comment.id=:commentId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("commentId", commentId);
			MasterMessagePraise praise1 = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
				baseManager.delete(MasterMessagePraise.class.getName(), praise1.getId());

			int Amount=0;
			if(comment.getAmount() == null){
				Amount=0;
			}else if (comment.getAmount() - 1<=0){
				Amount=0;
			}else if (comment.getAmount() - 1>=1){
				Amount = comment.getAmount() - 1;
			}
			comment.setAmount(Amount);
			baseManager.saveOrUpdate(MasterComment.class.getName(), comment);
		}
		return "true";
	}

	@RequestMapping("/saveThumbUp.do")
	@ResponseBody
	public String savaUP(HttpServletRequest request) throws Exception {
		String msgId = request.getParameter("msgId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user.getId() == null) {
			return "false";
		}
		MasterMessage msg = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),msgId);
		MasterMessagePraise praise = new MasterMessagePraise();
		String oper = request.getParameter("operation");
		if (oper != null && oper.equalsIgnoreCase("up")) {

			String queryHql = "from MasterMessagePraise t where t.user.id=:userId and t.message.id=:workId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("workId", msg.getId());
			MasterMessagePraise praise1 = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了
			{
				return "repeat";
			}



			//防止重复点赞


			praise.setUser(user);
			praise.setMessage(msg);
			praise.setCreateDateTime(new Date());
			baseManager.saveOrUpdate(MasterMessagePraise.class.getName(), praise);
			msg.setFsAmount(msg.getFsAmount() == null ? 1 : msg.getFsAmount() + 1);
			baseManager.saveOrUpdate(MasterMessage.class.getName(), msg);
		}


		if (oper != null && oper.equalsIgnoreCase("down")) {
			String queryHql = "from MasterMessagePraise t where t.user.id=:userId and t.message.id=:workId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("workId", msg.getId());
			MasterMessagePraise praise1 = (MasterMessagePraise) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (praise1 != null && praise1.getId() != null)//不为null,说明已经点过赞了，可以取消点赞
				baseManager.delete(MasterMessagePraise.class.getName(), praise1.getId());
			int FsAmount =0;
			if(msg.getFsAmount() == null){
				FsAmount =0;
			}else  if(msg.getFsAmount() - 1<=0){
				FsAmount =0;
			}else if (msg.getFsAmount() - 1>=1){
				FsAmount =msg.getFsAmount() - 1;
			}
			msg.setFsAmount(FsAmount);
			baseManager.saveOrUpdate(MasterMessage.class.getName(), msg);
		}


		return "true";
	}

	@RequestMapping("/storeWork.do")
	@ResponseBody
	public String storeWork(HttpServletRequest request) throws Exception {
		String msgId = request.getParameter("msgId");
		MasterMessageStore store = new MasterMessageStore();
		MyUser user = AuthorizationUtil.getMyUser();
		if (user.getId() == null) {
			return "false";
		}
		if (user.getId() != null) {
			String queryHql = "from MasterMessageStore t where t.user.id=:userId and t.masterMessage.id=:workId";
			LinkedHashMap<String, Object> map = new LinkedHashMap<>();
			map.put("userId", user.getId());
			map.put("workId", msgId);
			MasterMessageStore ps = (MasterMessageStore) baseManager.getUniqueObjectByConditions(queryHql, map);
			if (ps != null && ps.getId() != null){
				return "repeat" ;
			}//不为null,说明已经收藏了
		}
		store.setUser(user);
		MasterMessage work = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), msgId);
		store.setMasterMessage(work);
		store.setStatus("1");
		store.setCreateDateTime(new Date());
		baseManager.saveOrUpdate(MasterMessageStore.class.getName(), store);

		return "true";
	}


}
