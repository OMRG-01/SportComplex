
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
			<li class="breadcrumb-item active">Change Password</li>
		</ol>
	</nav>


	<div class="container">
		<div class="row">

			<div class="col-sm-8">
				<div style="margin-top: 18px">
					<h2>
						<b>Change Password</b>
					</h2>
				</div>
				<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
				<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
				<hr>
					<form action="<%=TRBView.CHANGE_PASSWORD_CTL%>" method="post">
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
								<label for="validationServerUsername55">Old Password</label> <input
									type="text" class="form-control" name="oldPassword"  value=<%=DataUtility
                    .getString(request.getParameter("oldPassword") == null ? ""
                            : DataUtility.getString(request
                                    .getParameter("oldPassword")))%>>
								<div> <font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("oldPassword", request)%></font></div>
							</div>
						</div>

						<div class="form-row">
							<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
								<label for="validationServer015">Password</label> <input
									type="password" class="form-control" name="newPassword" value=<%=DataUtility.getString(request.getParameter("newPassword") == null ? ""
                            : DataUtility.getString(request.getParameter("newPassword")))%>>
								<div><font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("newPassword", request)%></font></div>
							</div>
							<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
								<label for="validationServer025">Confirm Password</label> <input
									type="password" class="form-control" name="confirmPassword" value=<%=DataUtility.getString(request
                    .getParameter("confirmPassword") == null ? "" : DataUtility
                    .getString(request.getParameter("confirmPassword")))%> >
								<div><font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("confirmPassword", request)%></font></div>
							</div>

						</div>
						
						<input type="submit" name="operation"
							class="btn btn-primary btn-sm btn-rounded"
							value="<%=MyProfileCtl.OP_SAVE%>"> or <input type="submit" name="operation" class="btn btn-primary btn-sm btn-rounded"
					value="<%=MyProfileCtl.OP_CHANGE_MY_PROFILE%>">
					</form>

			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>




	<%@ include file="Footer.jsp"%>
</body>
</html>