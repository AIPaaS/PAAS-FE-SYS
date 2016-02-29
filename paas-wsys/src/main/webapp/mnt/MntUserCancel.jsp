<%@ page contentType="text/html; charset=utf-8"%>

<%
String ContextPath = request.getContextPath();
%>

<jsp:include page="/layout/jsp/head.jsp"></jsp:include>



<div class="row">
	<div class="col-lg-12">
		<div class="main-box clearfix">
			<div class="filter-block pull-left">
				<div class="form-group pull-left">
					<div class="form-group pull-left">
						&nbsp;&nbsp;&nbsp;用户代码:
					</div>
					<div class="form-group pull-left">
						<input type="text" name="cdtOpCode" id="cdtOpCode" class="form-control" style="width:160px;">
					</div>
					<div class="form-group pull-left">
						用户姓名:
					</div>
					<div class="form-group pull-left">
						<input type="text" name="cdtOpName" id="cdtOpName" class="form-control" style="width:160px;">
					</div>
				</div>
				<button class="btn btn-primary pull-left" id="btn_query"><i class="fa fa-search fa-lg"></i> 查询</button>
			</div>
			
		</div>
	</div>
</div>

<!-- 正文 -->

<div class="row">
	<div class="col-lg-12">
		<div class="main-box clearfix">
			<div class="main-box-body clearfix">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th class="text-center">用户代码</th>
								<th class="text-center">用户姓名</th>
								<th class="text-center">手机号</th>
								<th class="text-center">邮箱地址</th>
								<th class="text-center">状态</th>
								<th class="text-center">注销</th>
							</tr>
						</thead>
						<tbody id="tabList">
							
						</tbody>
					</table>
				</div>
				<div class="row-fluid">
					<div class="col-lg-6">
						<label>
							每页
								<select name="selPageSize"  class="pagination" id="grid_pageSize" >
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20" selected>20</option>
									<option value="25">25</option>
									<option value="30">30</option>
									<option value="40">40</option>
									<option value="50">50</option>
								</select>
							条记录
						</label>
					</div>
					<div class="col-lg-6">
						<div class="pagination pull-right" id="pagination_box">
							<ul id="ul_pagination" class="pagination-sm"></ul>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>



<script id="tabList-tmpl" type="text/x-jquery-tmpl">
	{{each(i,row) data}}
		<tr>
			<td class="text-center">{{= row.opCode}}</td>
			<td class="text-center">{{= row.opName}}</td>
			<td class="text-center">{{= row.mobileNo}}</td>
			<td class="text-center">{{= row.emailAdress}}</td>
			<td class="text-center">{{html PU.getDropValue("V_SYS_OP_STATUS",row.status,true)}}</td>
			<td class="text-center">
				<a id="a_remove_{{= row.id}}" href="###" class="table-link danger" title="注销用户">
					<span class="fa-stack">
						<i class="fa fa-square fa-stack-2x"></i>
						<i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
					</span>
				</a>
			</td>
		</tr>
{{/each}}
</script>






<jsp:include page="/layout/jsp/footer.jsp"></jsp:include>
