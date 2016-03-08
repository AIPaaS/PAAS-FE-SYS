<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.binary.core.util.BinaryUtils"%>

<%
String ContextPath = request.getContextPath();
%>

<jsp:include page="/layout/jsp/head.jsp"></jsp:include>


<!-- 正文 -->
<div class="main-box">
	<header class="main-box-header clearfix"> </header>
	<div class="main-box-body clearfix">
		<form class="form-horizontal" role="form" id="form_op">
			<div class="form-group">
				<label for="opCode" class="col-lg-2 control-label">用户代码<font color="red">*</font>:</label>
				<div class="col-lg-5">
					<input type="text" name="opCode" class="form-control" id="opCode" required pattern="([0-9]|[a-zA-Z]|[_]|[-]){1,40}" placeholder="必填">
				</div>
				<div class="col-lg-5">
					<span>1-40位字母、数字或下划线的组合</span>
				</div>
			</div>			
			<div class="form-group">
				<label for="opName" class="col-lg-2 control-label">用户姓名<font color="red">*</font>:</label>
				<div class="col-lg-5">
					<input type="text" name="opName" class="form-control" id="opName" required pattern=".{1,20}" placeholder="必填">
				</div>
				<div class="col-lg-5">
					<span>1-20位</span>
				</div>
			</div>
			<div class="form-group">
				<label for="loginPasswd" class="col-lg-2 control-label">登录密码<font color="red">*</font>:</label>
				<div class="col-lg-5">
					<input type="password" name="loginPasswd" class="form-control" id="loginPasswd" pattern=".{6,32}"  required placeholder="">
				</div>
				<div class="col-lg-5">
					<span>6-32位</span>
				</div>
			</div>
			<div class="form-group">
				<label for="loginPasswd2" class="col-lg-2 control-label">密码确认<font color="red">*</font>:</label>
				<div class="col-lg-5">
					<input type="password" name="loginPasswd2" class="form-control" id="loginPasswd2" pattern=".{6,32}"  required placeholder="">
				</div>
				<div class="col-lg-5">
				</div>
			</div>
			<div class="form-group">
				<label for="emailAddress" class="col-lg-2 control-label">邮箱地址<font color="red">*</font>:</label>
				<div class="col-lg-5">
					<input type="email" name="emailAdress" class="form-control" id="emailAdress" required pattern=".{1,40}"  placeholder="">
				</div>
				<div class="col-lg-5">
					<span>示例:example@email.com</span>
				</div>
			</div>
			<div class="form-group">
				<label for="mobileNo" class="col-lg-2 control-label">手机号:</label>
				<div class="col-lg-5">
					<input type="text" name="mobileNo" class="form-control" id="mobileNo" maxlength="11" pattern="(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$" required="required" placeholder="">
				</div>
				<div class="col-lg-5">
				</div>
			</div>
			<div class="form-group">
				<label class="col-lg-2 control-label">状态:</label>
				<div class="col-lg-5">
					<input type="radio" id="status1" name="status" placeholder="" checked><label for="status1">&nbsp;正常</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" id="status0" name="status" placeholder=""><label for="status0">&nbsp;停用</label>
				</div>
				<div class="col-lg-5">
					<span></span>
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10">
					<button type="submit" id="btn_submit" class="btn btn-success">提交</button>
				</div>
			</div>
		</form>
	</div>
</div>

<jsp:include page="/layout/jsp/footer.jsp"></jsp:include>
