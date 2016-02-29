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
						&nbsp;&nbsp;&nbsp;角色:
					</div>
					<div class="form-group pull-left">
						<select id="roleId" class="form-control" style="width:160px;">
						</select>
					</div>
				</div>
				<button id="btn_query" class="btn btn-primary"><i class="fa fa-search fa-lg"></i> 查询</button>
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
								<th class="text-left" width="300">角色</th>
								<th class="text-left">菜单</th>
							</tr>
						</thead>
						<tbody id="tabList">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>




<script id="tabList-tmpl" type="text/x-jquery-tmpl">
{{each(i,row) data}}
		<tr>
			<td class="text-left" style="border-top:1px solid #ff0000;vertical-align:top;"><i class="fa fa-user-md" ></i> {{= row.role.roleName}}</td>
			<td class="text-left" style="border-top:1px solid #ff0000;">{{html getRoleAuthHtml(row.roots)}}</td>
		</tr>
{{/each}}
</script>



<jsp:include page="/layout/jsp/footer.jsp"></jsp:include>
