var CurrentId = "";

/** 初始化 **/
function init() {
	initData(function() {
		initComponent();
		initListener();
		initFace();
		if(!CU.isEmpty(CurrentId)) {
			queryInfo();
		}
	});
}

/** 初始化页面、内存等基本数据 **/
function initData(cb) {
	CurrentId = PRQ.get("id");
	if(CU.isEmpty(CurrentId)) CurrentId = "";
	if(CU.isFunction(cb))cb();
}

/** 初始化组件 **/
function initComponent() {

	
}

/** 对组件设置监听 **/
function initListener() {
	$("#form_op").submit(function(e){
	    e.preventDefault();
	    submitForm();
	});
	RS.setAjaxLodingButton("btn_submit");
}

/** 初始化界面 **/
function initFace() {
	
}
function queryInfo(){
	RS.ajax({url:"/mnt/user/queryOpById",ps:{id:CurrentId},cb:function(result) {
		PU.setFormData(result, "form_op");
		$("#loginPasswd2").val(result.loginPasswd);
		var status = result.status;
		$("#status1").prop("checked", status==1);
		$("#status0").prop("checked", status==0);
	}});
}

/**提交表单**/
function submitForm(){
	var bean = PU.getFormData("form_op");
	bean.status = $("#status1").prop("checked")?1:0;
	if(CU.isEmpty(CurrentId) && CU.isEmpty(bean.loginPasswd)) {
		CC.showMsg({msg:"请输入登录密码!"});
		return ;
	}
	if((!CU.isEmpty(bean.loginPasswd)||!CU.isEmpty(bean.loginPasswd2)) && bean.loginPasswd!=bean.loginPasswd2) {
		CC.showMsg({msg:"两次密码输入不一致!"});
		return ;
	}
	if(CU.isEmpty(bean.loginPasswd)) delete bean.loginPasswd;
	
	if(!CU.isEmpty(CurrentId)) bean.id = CurrentId;
	
	RS.ajax({url:"/mnt/user/saveOrUpdateOp",ps:bean,cb:function(rs) {
		CurrentId = rs;
		var url = ContextPath+"/dispatch/mc/10101";
		window.location = url;
	}});
}



