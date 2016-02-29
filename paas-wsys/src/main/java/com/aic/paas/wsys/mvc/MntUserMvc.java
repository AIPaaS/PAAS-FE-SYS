package com.aic.paas.wsys.mvc;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aic.paas.frame.cross.bean.CSysOp;
import com.aic.paas.frame.cross.bean.CSysRole;
import com.aic.paas.frame.cross.bean.DropRecord;
import com.aic.paas.frame.cross.bean.SysOp;
import com.aic.paas.frame.cross.bean.SysOpInfo;
import com.aic.paas.frame.cross.bean.SysRole;
import com.aic.paas.frame.cross.integration.RoleAuth;
import com.aic.paas.frame.util.ComponentUtil;
import com.aic.paas.wsys.peer.MntUserPeer;
import com.binary.core.lang.Conver;
import com.binary.core.util.BinaryUtils;
import com.binary.framework.util.ControllerUtils;
import com.binary.jdbc.Page;


@Controller
@RequestMapping("/mnt/user")
public class MntUserMvc {
	
	
	
	@Autowired
	MntUserPeer mntUserPeer;
	
	
	
	@RequestMapping("/querySysRoleDropList")
    public void querySysRoleDropList(HttpServletRequest request, HttpServletResponse response, Boolean addEmpty, Boolean addAttr) {
		List<SysRole> ls = mntUserPeer.querySysRoleList(null, " ROLE_CODE ");
		List<DropRecord> data = ComponentUtil.toDropList(ls, "id", "roleName", addAttr, addEmpty);
		ControllerUtils.returnJson(request, response, data);
    }
	
	
	/**
	 * 分页查询
	 */
	@RequestMapping("/queryOpPage")
	public void queryOpPage(HttpServletRequest request, HttpServletResponse response, Integer pageNum, Integer pageSize, CSysOp cdt, String orders){
		Page<SysOp> page = mntUserPeer.queryOpPage(pageNum, pageSize, cdt, orders);
		ControllerUtils.returnJson(request, response, page);
	}
	
	
	/**
	 * 分页查询
	 */
	@RequestMapping("/queryOpByIds")
	public void queryOpByIds(HttpServletRequest request, HttpServletResponse response, String strOpIds, String orders) {
		Long[] opIds = null;
		if(!BinaryUtils.isEmpty(strOpIds)) {
			opIds = Conver.to(strOpIds.trim().split(","), Long.class);
		}
		List<SysOp> ls = null;
		if(opIds==null || opIds.length==0) {
			ls = new ArrayList<SysOp>();
		}else {
			CSysOp cdt = new CSysOp();
			cdt.setIds(opIds);
			cdt.setStatus(1); 	//只查有效用户
			if(BinaryUtils.isEmpty(orders)) orders = " OP_CODE ";
			ls = mntUserPeer.queryOpList(cdt, orders);
		}
		ControllerUtils.returnJson(request, response, ls);
	}
	
	
	/**
	 * 分页查询
	 */
	@RequestMapping("/queryOpList")
	public void queryOpList(HttpServletRequest request, HttpServletResponse response, CSysOp cdt, String orders){
		List<SysOp> ls = mntUserPeer.queryOpList(cdt, orders);
		ControllerUtils.returnJson(request, response, ls);
	}
	
	
	
	/**
	 * 保存获更新，判断主键ID[id]是否存在, 存在则更新, 不存在则插入
	 * @param record : SysOp数据记录
	 * @return 当前记录主键[id]值
	 */
	@RequestMapping("/saveOrUpdateOp")
	public void saveOrUpdate(HttpServletRequest request, HttpServletResponse response,SysOp record){
		Long id = mntUserPeer.saveOrUpdateOp(record);
		ControllerUtils.returnJson(request, response, id);
	}
	
	
	
	@RequestMapping("/removeOpById")
	public void removeOpById(HttpServletRequest request, HttpServletResponse response, Long opId) {
		Integer count = mntUserPeer.removeOpById(opId);
		ControllerUtils.returnJson(request, response, count);
	}
	
	
	
	@RequestMapping("/queryOpById")
	public void queryOpById(HttpServletRequest request, HttpServletResponse response,Long id){
		SysOp sysOp = mntUserPeer.queryOpById(id);
		ControllerUtils.returnJson(request, response, sysOp);
	}
	
	
	
	
	
	@RequestMapping("/queryOpInfoPage")
	public void queryOpInfoPage(HttpServletRequest request, HttpServletResponse response, Integer pageNum, Integer pageSize, CSysOp cdt, String orders){
		Page<SysOpInfo> page = mntUserPeer.queryOpInfoPage(pageNum, pageSize, cdt, orders);
		ControllerUtils.returnJson(request, response, page);
	}
	
	
	@RequestMapping("/setUserRoles")
	public void setUserRoles(HttpServletRequest request, HttpServletResponse response, Long opId, String strRoleIds){
		Long[] roleIds = null;
		if(!BinaryUtils.isEmpty(strRoleIds)) roleIds = Conver.to(strRoleIds.split(","), Long.class);
		mntUserPeer.setUserRoles(opId, roleIds);
		ControllerUtils.returnJson(request, response, true);
	}
	
	
	@RequestMapping("/queryRoleAuthView")
	public void queryRoleAuthView(HttpServletRequest request, HttpServletResponse response, CSysRole cdt, String orders){
		List<RoleAuth> list = mntUserPeer.queryRoleAuthView(cdt, orders);
		ControllerUtils.returnJson(request, response, list);
	}

}
