package org.fh.mobile.fhim;

import java.util.List;

import org.fh.controller.base.BaseController;
import org.fh.entity.PageData;
import org.fh.service.fhim.QgroupService;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/** 
 * 说明：群组
 * 创建人：FH Q313596790
 * 修改时间：2018-10-7
 */
@Controller
@RequestMapping(value="/mobqgroup")
public class MobQgroupController extends BaseController {
	
	@Autowired
	private QgroupService qgroupService;
	
	/**去添加群页面(好友面板中检索页)
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd()throws Exception{
		return "mobile/im/qgroup_add";
	}
	
	/**群检索
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/search")
	public String search(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(Tools.notEmpty(keywords)) pd.put("keywords", keywords.trim());
		List<PageData>	varList = qgroupService.searchListAll(pd);
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "mobile/im/qgroup_add";
	}
	
}
