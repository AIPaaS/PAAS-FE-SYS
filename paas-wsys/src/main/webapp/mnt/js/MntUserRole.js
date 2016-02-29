
var CurrDataMap = {};
var ParamPageNum = 1;

var RolesMap = {};


function init() {
	initData(function() {
		initComponent();
		initListener();
		initFace();
		query();
	});
	
}


function initData(cb) {
	ParamPageNum = PRQ.get("pageNum");
	if(CU.isEmpty(ParamPageNum)) ParamPageNum = 1;
	
	RS.ajax({url:"/mnt/user/querySysRoleDropList",ps:{addEmpty:false, addAttr:true},cb:function(rs) {
		DROP["DV_SYS_ROLE"] = rs;
		for(var i=0; i<rs.length; i++) {
			RolesMap[rs[i].code] = rs[i].name;
		}
		if(CU.isFunction(cb)) cb();
	}});
}
function initComponent() {
}
function initListener() {
	$("#cdtOpCode").bind("keyup", doCdtTFKeyUp);
	$("#cdtOpName").bind("keyup", doCdtTFKeyUp);
	
	$("#btn_query").bind("click",function(){query(1);});
	$("#grid_pageSize").bind("change",function(){query(1);});
}
function initFace() {
}


/** 执行条件文本框回车查询 **/
function doCdtTFKeyUp(e) {
	if(e.keyCode === 13) query();
}


function query(pageNum){
	if(CU.isEmpty(pageNum)) pageNum = 1;
	
	delete CurrDataMap;
	CurrDataMap = {};
	$("#tabList").html("");
	$("#ul_pagination").remove();
	$("#pagination_box").html('<ul id="ul_pagination" class="pagination-sm"></ul>');
	
	var pageSize = $("#grid_pageSize").val();
	var opCode = $("#cdtOpCode").val();
	var opName = $("#cdtOpName").val();
	var orders = "OP_CODE";
	
	var ps = {pageNum:pageNum,pageSize:pageSize,opCode:opCode,opName:opName,orders:orders};
	RS.ajax({url:"/mnt/user/queryOpInfoPage",ps:ps,cb:function(r) {
		if(!CU.isEmpty(r)) {
			var data = r.data;
			for(var i=0; i<data.length; i++) {
				CurrDataMap["key_"+data[i].op.id] = data[i];
			}
			ParamPageNum = r.pageNum;
			
			$("#ul_pagination").twbsPagination({
		        totalPages: r.totalPages?r.totalPages:1,
		        visiblePages: 7,
		        startPage: r.pageNum,
		        first:"首页",
		        prev:"上一页",
		        next:"下一页",
		        last:"尾页",
		        onPageClick: function (event, page) {
		        	query(page);
		        }
		    	
		    });
			$('#tabList-tmpl').tmpl(r).appendTo("#tabList");
			
			for(var i=0;i<data.length;i++){
				$("#a_assign_role_"+data[i].op.id).editable({
					showbuttons:"bottom",
					display:false,
			        source:RolesMap,
					url: function (pps) {
						return submitRoles(pps.pk, pps.value);
					}
				});
			}
		}
	}});
	
}


function getRoleNames(roleIds) {
	if(typeof(roleIds)=="string") roleIds = roleIds.split(",");
	if(CU.isEmpty(roleIds)) return "";
	
	var names = [];
	for(var i=0; i<roleIds.length; i++) {
		var item = CU.getDropItemRecord("DV_SYS_ROLE", roleIds[i]);
		if(CU.isEmpty(item)) continue ;
		names.push(item.name);
	}
	
	return names.join("，");
}





function submitRoles(opId, roleIds) {
	var strRoleIds = CU.isEmpty(roleIds) ? "" : roleIds.join(",");
	return PU.submitEditable({url:"/mnt/user/setUserRoles",ps:{opId:opId, strRoleIds:strRoleIds},cb:function(result) {
		query(ParamPageNum);
	}});
}


