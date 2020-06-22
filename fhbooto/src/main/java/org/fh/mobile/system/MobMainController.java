package org.fh.mobile.system;


import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.fh.controller.base.BaseController;
import org.fh.entity.PageData;
import org.fh.entity.system.User;
import org.fh.service.system.FHlogService;
import org.fh.service.system.UsersService;
import org.fh.util.Const;
import org.fh.util.DateUtil;
import org.fh.util.IniFileUtil;
import org.fh.util.Jurisdiction;
import org.fh.util.PathUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 说明：登录成功访问后台的处理类(手机端)
 * 作者：FH Admin Q313596790
 * 官网：www.fhadmin.org
 */
@Controller
@RequestMapping("/mobmain")
public class MobMainController extends BaseController {
	
	@Autowired
    private UsersService usersService;
	@Autowired
    private FHlogService FHLOG;
	
	/**登录进来第一个访问的方法,初始用户权限以及缓存
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/index")
	public String loginPage(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);						//读取session中的用户信息(单独用户信息)
		if (user != null) {
			User userr = (User)session.getAttribute(Const.SESSION_USERROL);				//读取session中的用户信息(含角色信息)
			if(null == userr){
				user = usersService.getUserAndRoleById(user.getUSER_ID());				//通过用户ID读取用户信息和角色信息
				session.setAttribute(Const.SESSION_USERROL, user);						//存入session	
			}else{
				user = userr;
			}
			String USERNAME = user.getUSERNAME();
			session.setAttribute(Const.SESSION_USERNAME, USERNAME);						//放入用户名到session
			session.setAttribute(Const.SESSION_U_NAME, user.getNAME());					//放入用户姓名到session
			this.setRemortIP(USERNAME);					//更新登录IP
			if(null == session.getAttribute(Const.SKIN)){//用户皮肤
				model.addAttribute("SKIN", user.getSKIN()); 	
				session.setAttribute(Const.SKIN, user.getSKIN());
			}else {
				model.addAttribute("SKIN", session.getAttribute(Const.SKIN));
			}
			model.addAttribute("pd", pd);
			model.addAttribute("user", user);
		}else{
			return "mobile/login";	//session失效后跳转登录页面
		}
		return "mobile/im/index";
	}
	
	/** 更新登录用户的IP
	 * @param USERNAME 用户名
	 * @throws Exception
	 */
	public void setRemortIP(String USERNAME) throws Exception {  
		PageData pd = new PageData();
		HttpServletRequest request = this.getRequest();
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {  
			ip = request.getRemoteAddr();  
	    }else{
	    	ip = request.getHeader("x-forwarded-for");  
	    }
		pd.put("LAST_LOGIN",DateUtil.getTime().toString());
		pd.put("USERNAME", USERNAME);
		pd.put("IP", ip);
		usersService.saveIP(pd);
	}  
	
	/**
	 * 用户注销
	 * @param session
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/logout")
	public String logout(Model model) throws Exception{
		String USERNAME = Jurisdiction.getUsername();	//当前登录的用户名
		this.removeSession(USERNAME);					//清缓存
		Subject subject = SecurityUtils.getSubject(); 	//shiro销毁登录
		subject.logout();
		Session session = Jurisdiction.getSession();
		if(null == session.getAttribute(Const.SYSNAME)){
			String infFilePath = PathUtil.getClasspath()+Const.SYSSET;										//配置文件路径
			String sysName = IniFileUtil.readCfgValue(infFilePath, "SysSet1", Const.SYSNAME, "FH Admin");	//系统名称
			session.setAttribute(Const.SYSNAME, sysName);
		}
		FHLOG.save(USERNAME, "手机端退出系统");				//记录日志
		return "mobile/login";
	}
	
	/**
	 * 清理session
	 */
	public void removeSession(String USERNAME){
		Session session = Jurisdiction.getSession();	//以下清除session缓存
		session.removeAttribute(Const.SESSION_USER);
		session.removeAttribute(Const.SESSION_USERNAME);
		session.removeAttribute(Const.SESSION_U_NAME);
		session.removeAttribute(Const.SESSION_USERROL);
		session.removeAttribute(Const.SKIN);
	}

}
