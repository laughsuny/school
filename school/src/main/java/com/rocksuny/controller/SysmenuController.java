package com.rocksuny.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rocksuny.controller.base.BaseController;
import com.rocksuny.model.Sysmenu;
import com.rocksuny.service.ISysmenuService;

/**
 * 后台菜单管理
 * @author suny 2016-7-1 18:43:52
 *	
 */
@Controller
@RequestMapping("/admin/menu")
public class SysmenuController extends BaseController{

	@Autowired
	private ISysmenuService sysmenuService;
	
	/**
	 *  删除菜单 -- 逻辑删除
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public Object delete(String id){
		try {
			sysmenuService.delete(id);
			json.put("result", "success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			json.put("result", "error");
		}
		return json;
	}
	
	/**
	 * 修改菜单
	 * @param menu 待修改菜单实体
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/update")
	public Object update(Sysmenu menu){
		try {
			sysmenuService.update(menu);
			json.put("result", "success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			json.put("result", "error");
		}
		return json;
	}
	
	/**
	 * 保存子菜单菜单
	 * @param menu 菜单实体
	 * @param parentId 父菜单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/subSave")
	public Object subSave(Sysmenu menu,String parentId){
		
		
		try {
			//根据pid获得 menu 集合
			List<Sysmenu> menus = this.sysmenuService.getMenusByPid(parentId);
			
			String id = "";
			int seq = 0;
			int layerId = 0;
			int rootId = 0;
			
			List<String> menuIdsStr = new ArrayList<String>();
			
			if(menus != null && menus.size() >0){
				
				for(Sysmenu tempmenu : menus){
					menuIdsStr.add(tempmenu.getId());
					if(tempmenu.getSeq() > seq){
						seq = tempmenu.getSeq();
					}
					layerId = tempmenu.getLayerId();
					rootId = tempmenu.getRootId();
				}
				id = getGeneratedMenuId(menuIdsStr);
				
			}else{
				
				Sysmenu parentMenu = this.sysmenuService.getMenuById(parentId);
				
				if(parentMenu != null){
					layerId = parentMenu.getLayerId() + 1;
					
					if(parentMenu.getRootId() == 0){
						rootId = Integer.parseInt(parentMenu.getId());
					}else{
						rootId = parentMenu.getRootId();
					}
					id = parentId + "01";
				}
				
			}
			
			menu.setId(id);
			menu.setPid(parentId);
			menu.setLayerId(layerId);
			menu.setRootId(rootId);
			menu.setCreateUser(1);
			menu.setSeq(seq + 1);
			menu.setCreateTime(new Date());
			menu.setStatus(1);
			
			if(menu.getUrl() == null){
				menu.setUrl("");
			}
			
			sysmenuService.save(menu);
			json.put("result", "success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			json.put("result", "error");
		}
		return json;
	}
	
	/**
	 * 保存同级菜单
	 * @param menu 菜单实体
	 * @param parentId 父菜单id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Object save(Sysmenu menu,String parentId){
		
		try {
			List<Sysmenu> menus = sysmenuService.getMenusByPid(parentId);
			String id = "";
			int seq = 0;
			int layerId = 0;
			int rootId = 0;
			List<String> menuIdsStr = new ArrayList<String>();
			
			for(Sysmenu tempmenu : menus){
				menuIdsStr.add(tempmenu.getId());
				if(tempmenu.getSeq() > seq){
					seq = tempmenu.getSeq();
				}
				layerId = tempmenu.getLayerId();
				rootId = tempmenu.getRootId();
			}
			
			id = getGeneratedMenuId(menuIdsStr);
			 
			menu.setId(id);
			menu.setPid(parentId);
			menu.setLayerId(layerId);
			menu.setRootId(rootId);
			
			
			menu.setCreateUser(1);
			menu.setSeq(seq + 1);
			menu.setCreateTime(new Date());
			menu.setStatus(1);
			
			if(menu.getUrl() == null){
				menu.setUrl("");
			}
			
			this.sysmenuService.save(menu);
			json.put("result", "success");
			json.put("newMenu", menu);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			json.put("result", "error");
			
		}
		return json;
		
	}
	
	/**
	 * 菜单管理列表页面跳转
	 * @return
	 */
	@RequestMapping("/list")
	public String list(Model model){
		List<Sysmenu> list = sysmenuService.getMenusByPid("0");
		model.addAttribute("optionList", list);
		return "/admin/menu/list";
	}
	/**
	 *  展示菜单树
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getTree")
	public Object getTree(String mainMenuId,Model model){
		
		List<Sysmenu> menus = new ArrayList<Sysmenu>();
		if(mainMenuId != null && mainMenuId.length() >0 && !mainMenuId.equals("-1")){
			menus = sysmenuService.getMenusWithSub(mainMenuId);
		}else{
			menus = sysmenuService.getMenus();
		}
		json.put("Rows", menus);
		return json;
	}
	
	/**
	 * 获得菜单id生成规则
	 * @param menuIds
	 * @return
	 */
	private static String getGeneratedMenuId(List<String> menuIdsStr){
		
		if(null != menuIdsStr && menuIdsStr.size() >0){
			
			int idLength = menuIdsStr.get(0).length();
			
			if(idLength >0 && idLength <= 19){//id长度小于20位
				
				List<Long> menuIdsLong = new ArrayList<Long>();
				
				for(String idStr:menuIdsStr){
					menuIdsLong.add(Long.parseLong(idStr));
				}
				
				long maxIdLong = -1;
				
				for(long idLong : menuIdsLong){
					if(idLong > maxIdLong){
						maxIdLong = idLong;
					}
					
				}
				maxIdLong += 1;
				
				return maxIdLong + "";
				
			}else{
				
				String tempIdStr = menuIdsStr.get(0);
				
				tempIdStr = tempIdStr.substring(0,tempIdStr.length()-3);
				
				List<String> menuIdsStrCut3 = new ArrayList<String>(); //截取menuid 后三位
				
				for(String idStr:menuIdsStr){
					menuIdsStrCut3.add(idStr.substring(idStr.length()-3, idStr.length()));
				}
				
				List<Long> menuIdsLong = new ArrayList<Long>();
				
				for(String idStr3:menuIdsStrCut3){
					menuIdsLong.add(Long.parseLong(idStr3));
				}
				
				long maxIdLong = -1;
				
				for(long idLong : menuIdsLong){
					if(idLong > maxIdLong){
						maxIdLong = idLong;
					}
					
				}
				maxIdLong += 1;
				
				return tempIdStr + maxIdLong;
				
			}
			
		}else{
			return "0";
		}
		
		
		
	}
	
	
}
