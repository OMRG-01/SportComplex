<%@page import="in.co.turf.booking.util.HTMLUtility"%>
<%@page import="java.util.HashMap"%>
<%@page import="in.co.turf.booking.ctl.UserRegistrationCtl"%>
<%@page import="in.co.turf.booking.util.DataUtility"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
<script type="text/javascript">
	//Material Select Initialization
	$(document).ready(function() {
		$('.mdb-select').materialSelect();
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
			<li class="breadcrumb-item active">User Registration</li>
		</ol>
	</nav>


	<div class="container">
		<div class="row">

			<div class="col-sm-8">
				<div style="margin-top: 18px">
					<h2>
						<b>User Registration</b>
					</h2>
				</div>
				<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
				<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
				<hr>
				<form action="<%=TRBView.USER_REGISTRATION_CTL%>" method="post">
					<jsp:useBean id="bean" class="in.co.turf.booking.bean.UserBean"
						scope="request"></jsp:useBean>

					<input type="hidden" name="id" value="<%=bean.getId()%>"> <input
						type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
					<input type="hidden" name="modifiedBy"
						value="<%=bean.getModifiedBy()%>"> <input type="hidden"
						name="createdDatetime"
						value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
					<input type="hidden" name="modifiedDatetime"
						value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">Name</label> <input
								type="text" class="form-control" name="name"
								value="<%=DataUtility.getStringData(bean.getName())%>">
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("name", request)%></font>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">User Name</label> <input
								type="text" class="form-control" name="userName"
								value="<%=DataUtility.getStringData(bean.getUserName())%>">
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("userName", request)%></font>
							</div>
						</div>
					</div>

					<div class="form-row">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServer015">Password</label> <input
								type="password" class="form-control" name="password"
								value="<%=DataUtility.getStringData(bean.getPassword())%>">
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("password", request)%></font>
							</div>
						</div>
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServer025">Confirm Password</label> <input
								type="password" class="form-control" name="confirmPassword"
								value="<%=DataUtility.getStringData(bean.getConfirmPassword())%>">
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("confirmPassword", request)%></font>
							</div>
						</div>

					</div>

					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">Email Id</label> <input
								type="text" class="form-control" name="emailId"
								value="<%=DataUtility.getStringData(bean.getEmailId())%>">
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("emailId", request)%></font>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-6 mb-6 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">Mobile No</label> <input
								type="text" class="form-control" name="mobile"
								value="<%=DataUtility.getStringData(bean.getMobileNo())%>">
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("mobile", request)%></font>
							</div>
						</div>
					</div>
					<%
						HashMap<String, String> map = new HashMap<String, String>();
					map.put("Male", "Male");
					map.put("Female", "Female");
					%>

					<div class="form-group">
						<div class="col-md-6 mb-6 md-form" style="padding-left: 0px">
							<%=HTMLUtility.getList("gender", String.valueOf(bean.getGender()), map)%>
							<label class="mdb-main-label">Gender</label>
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("gender", request)%></font>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-9 mb-4 md-form" style="padding-left: 0px">
							<textarea id="form7" class="md-textarea form-control" rows="3"
								name="address"><%=DataUtility.getStringData(bean.getAddress())%></textarea>
							<label for="form7">Address</label>
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("address", request)%></font>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-9 mb-4 md-form" style="padding-left: 0px">
						
						<div class="file-field">
    <div class="btn btn-primary btn-sm float-left">
      <span>Choose file</span>
      <input type="file">
    </div>
  </div>
						
						
						</div>
						</div>
					
					 <input
						type="submit" name="operation"
						class="btn btn-primary btn-sm btn-rounded"
						value="<%=UserRegistrationCtl.OP_SIGN_UP%>"> or <input
						type="submit" name="operation"
						class="btn btn-primary btn-sm btn-rounded"
						value="<%=UserRegistrationCtl.OP_RESET%>">
				</form>

			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>




	<%@ include file="Footer.jsp"%>
</body>
</html>