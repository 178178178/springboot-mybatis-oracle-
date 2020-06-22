package org.fh.mobile.fhim;

import java.util.List;

import org.fh.controller.base.BaseController;
import org.fh.entity.PageData;
import org.fh.service.fhim.FriendsService;
import org.fh.util.Jurisdiction;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 说明：好友管理(手机端)
 * 作者：FH Admin Q313596790
 * 官网：www.fhadmin.org
 */
@Controller
@RequestMapping(value="/mobfriends")
public class MobFriendsController extends BaseController {
	
	@Autowired
	private FriendsService friendsService;
	
	/**去添加好友页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd()throws Exception{
		return "mobile/im/friends_add";
	}
	
	/**添加好友检索
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/search")
	public String search(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");						//关键词检索条件
		if(Tools.notEmpty(keywords))pd.put("keywords", keywords.trim());
		pd.put("USERNAME", Jurisdiction.getUsername());					//不检索自己
		List<PageData>	varList = friendsService.listAllToSearch(pd);
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "mobile/im/friends_add";
	}
}
