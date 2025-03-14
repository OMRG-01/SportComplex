
<%@page import="in.co.turf.booking.ctl.MyProfileCtl"%>
<%@page import="in.co.turf.booking.util.DataUtility"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Profile</title>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<br>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb pink lighten-4">
			<li class="breadcrumb-item"><a class="black-text" href="<%=TRBView.WELCOME_CTL%>">Home</a></li>
			<li class="breadcrumb-item active">My Profile</li>
		</ol>
	</nav>


	<div class="container">
		<div class="row">

			<div class="col-sm-8">
				<div style="margin-top: 18px">
					<h2>
						<b>My Profile</b>
					</h2>
				</div>
				<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
				<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
				<hr>
					<form action="<%=TRBView.MY_PROFILE_CTL%>" method="post">
						<jsp:useBean id="bean" class="in.co.turf.booking.bean.UserBean"
							scope="request"></jsp:useBean>

						<input type="hidden" name="id" value="<%=bean.getId()%>">
						<input type="hidden" name="createdBy"
							value="<%=bean.getCreatedBy()%>"> <input type="hidden"
							name="modifiedBy" value="<%=bean.getModifiedBy()%>"> <input
							type="hidden" name="createdDatetime"
							value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
						<input type="hidden" name="modifiedDatetime"
							value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

							<div class="form-group">
							<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
								<label for="validationServerUsername55">Name</label> <input
									type="text" class="form-control" name="name"  value="<%=DataUtility.getStringData(bean.getName())%>">
								<div> <font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("name", request)%></font></div>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
								<label for="validationServerUsername55">User Name</label> <input
									type="text" class="form-control" name="userName"  value="<%=DataUtility.getStringData(bean.getUserName())%>">
								<div> <font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("userName", request)%></font></div>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
								<label for="validationServerUsername55">Email Id</label> <input
									type="text" class="form-control" name="emailId"  value="<%=DataUtility.getStringData(bean.getEmailId())%>">
								<div> <font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("emailId", request)%></font></div>
							</div>
						</div>

						

						<div class="form-group">
							<div class="col-md-6 mb-6 md-form" style="padding-left: 0px">
								<label for="validationServerUsername55">Mobile No</label> <input
									type="text" class="form-control" name="mobile" value="<%=DataUtility.getStringData(bean.getMobileNo())%>" >
								<div> <font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("mobile", request)%></font></div>
							</div>
						</div>
						<input type="submit" name="operation"
							class="btn btn-primary btn-sm btn-rounded"
							value="<%=MyProfileCtl.OP_SAVE%>"> or <input type="submit" name="operation" class="btn btn-primary btn-sm btn-rounded"
					value="<%=MyProfileCtl.OP_CHANGE_MY_PASSWORD%>">
					</form>

			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>




	<%@ include file="Footer.jsp"%>
</body>
</html>