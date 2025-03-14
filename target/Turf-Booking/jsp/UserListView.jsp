<%@page import="in.co.turf.booking.ctl.UserListCtl"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User List</title>
<style type="text/css">
table.dataTable thead .sorting:after, table.dataTable thead .sorting:before,
	table.dataTable thead .sorting_asc:after, table.dataTable thead .sorting_asc:before,
	table.dataTable thead .sorting_asc_disabled:after, table.dataTable thead .sorting_asc_disabled:before,
	table.dataTable thead .sorting_desc:after, table.dataTable thead .sorting_desc:before,
	table.dataTable thead .sorting_desc_disabled:after, table.dataTable thead .sorting_desc_disabled:before
	{
	bottom: .5em;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('#dtBasicExample').DataTable();
		$('.dataTables_length').addClass('bs-select');
	});
	$(window).on('load', function() {
		$('#mdb-preloader').delay(1000).fadeOut(300);
	});
</script>
</head>
<body>

	<%@ include file="Header.jsp"%>
	<br>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb pink lighten-4">
			<li class="breadcrumb-item"><a class="black-text"
				href="<%=TRBView.WELCOME_CTL%>">Home</a></li>
			<li class="breadcrumb-item active">User List</li>
		</ol>
	</nav>
	

	<div style="margin-top: 18px; margin-left: 50px">
		<h2>
			<b>User List</b>
		</h2>
		<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
		<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
	</div>
	<hr>
	<form action="<%=TRBView.USER_LIST_CTL%>" method="post"
		class="form-inline d-flex justify-content-center md-form form-sm active-purple active-purple-2 mt-2">
		<div class="container">
			<div class="row">
				<div class="col-sm-4">
					<i class="fas fa-search" aria-hidden="true"></i> <input
						class="form-control form-control-sm ml-3 w-75" type="text"
						placeholder="Search By  Name" name="name"
						aria-label="Search"
						value="<%=ServletUtility.getParameter("name", request)%>">
				</div>
				<div class="col-sm-4">
					<i class="fas fa-search" aria-hidden="true"></i> <input
						class="form-control form-control-sm ml-3 w-75" type="text"
						placeholder="Search By Email Id" name="emailId" aria-label="Search"
						value="<%=ServletUtility.getParameter("emailId", request)%>">
				</div>
				<div class="col-sm-4">
					<input class="btn btn-outline-primary btn-md m-0 waves-effect"
						type="submit" name="operation" aria-label="Search"
						value="<%=UserListCtl.OP_SEARCH%>"> Or <input
						class="btn btn-outline-primary btn-md m-0 waves-effect"
						type="submit" name="operation" aria-label="Search"
						value="<%=UserListCtl.OP_RESET%>">
				</div>
			</div>
		</div>




		<!--Table-->
		<table id="tablePreview"
			class="table table-hover table-striped table-bordered">
			<!--Table head-->
			<thead>
				<tr>
					<th>#</th>
					<th>Name</th>
					<th>Email Id</th>
					<th>Mobile No</th>
					<th>Address</th>
				</tr>
			</thead>
			<!--Table head-->
			<!--Table body-->
			<tbody>
				<%
					int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;
				int size = ServletUtility.getSize(request);
				UserBean bean = null;
				List list = ServletUtility.getList(request);
				Iterator<UserBean> iterator = list.iterator();
				while (iterator.hasNext()) {
					bean = iterator.next();
				%>
				<tr>
					
					<th scope="row"><%=index++%></th>
					<td><%=bean.getName()%></td>
					<td><%=bean.getEmailId()%></td>
					<td><%=bean.getMobileNo()%></td>
					<td><%=bean.getAddress()%></td>
					
				</tr>
				<%
					}
				%>
			</tbody>
			<!--Table body-->
		</table>
		<br>

		<table class="table  table-responsive-md btn-table">
			<tbody>
				<tr>
					<td><input type="submit" name="operation"
						class="btn btn-outline-primary btn-sm m-0 waves-effect"
						value="<%=UserListCtl.OP_PREVIOUS%>"
						<%=(pageNo == 1) ? "disabled" : ""%>></td>

					

					<td><input type="submit" name="operation"
						class="btn btn-outline-primary btn-sm m-0 waves-effect"
						value="<%=UserListCtl.OP_NEXT%>"
						<%=((list.size() < pageSize) || size == pageNo * pageSize) ? "disabled" : ""%>></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
			type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	<!--Table-->

	<%@ include file="Footer.jsp"%>
</body>
</html>