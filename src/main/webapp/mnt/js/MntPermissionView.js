
var space = 40;


function init() {
	initData(function() {
		initComponent();
		initListener();
		initFace();
		query();
	});
	
}


function initData(cb) {
	RS.ajax({url:"/mnt/user/querySysRoleDropList",ps:{addEmpty:true, addAttr:true},cb:function(result) {
		DROP["DV_SYS_ROLE_CODE"] = result;
		var selhtml = PU.getSelectOptionsHtml("DV_SYS_ROLE_CODE");
		$("#roleId").html(selhtml);
		if(CU.isFunction(cb))cb();
	}});
}
function initComponent() {
}
function initListener() {
	$("#btn_query").bind("click",function(){query();});
	$("#roleId").bind("change",function(){query();});
}
function initFace() {
}

function query(){
	$("#tabList").html("");
	var roleId = $("#roleId").val();
	var orders = "ROLE_CODE,ID";
	
	var ps = {id:roleId,orders:orders};
	
	RS.ajax({url:"/mnt/user/queryRoleAuthView",ps:ps,cb:function(rs) {
		$('#tabList-tmpl').tmpl({data:rs}).appendTo("#tabList");
	}});
}


function getRoleAuthHtml(roots) {
	if(CU.isEmpty(roots)) {
		return "<font color='blue'>无权限</font>";
	}
	
	var buff = [];
	for(var i=0; i<roots.length; i++) {
		var node = roots[i];
		getAuthNodeHtml(1, node, buff);
	}
	return buff.join("");
}


function getAuthNodeHtml(lvl, node, buff) {
	if(CU.isEmpty(node)) return ;
	buff.push("<span style='padding-left:"+((lvl-1)*space)+"px;'>&nbsp;</span>");
	buff.push("<i class='fa "+node.menu.menuImg+"'></i> <span>"+node.menu.menuName+"</span>");
	buff.push("<br>");
	var childs = node.children;
	if(!CU.isEmpty(childs)) {
		for(var i=0; i<childs.length; i++) {
			getAuthNodeHtml(lvl+1, childs[i], buff);
		}
	}
}


