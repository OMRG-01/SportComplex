<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@page import="in.co.turf.booking.util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<br>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb pink lighten-4">
			<li class="breadcrumb-item"><a class="black-text" href="<%=TRBView.WELCOME_CTL%>">Home</a></li>
			<li class="breadcrumb-item active">Login</li>
		</ol>
	</nav>

	<!-- Material form subscription -->
	<div class="container">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">


				<div class="card">

					<h5 class="card-header info-color white-text text-center py-4">
						<strong>Login</strong>
					</h5>

					<!--Card content-->
					<div class="card-body px-lg-5">

						<!-- Form -->
						<form class="text-center" style="color: #757575;"
							action="<%=TRBView.LOGIN_CTL%>" method="post">
							<jsp:useBean id="bean" class="in.co.turf.booking.bean.UserBean"
								scope="request"></jsp:useBean>
							<%
								String uri = (String) request.getAttribute("uri");
							%>

							<input type="hidden" name="uri" value="<%=uri%>"> <input
								type="hidden" name="id" value="<%=bean.getId()%>"> <input
								type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
							<input type="hidden" name="modifiedBy"
								value="<%=bean.getModifiedBy()%>"> <input type="hidden"
								name="createdDatetime"
								value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
							<input type="hidden" name="modifiedDatetime"
								value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
							<p>
								<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
								<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
							</p>

							<!-- Name -->
							<div class="md-form mt-3">
								<input type="text" class="form-control" name="userName"
									value="<%=DataUtility.getStringData(bean.getUserName())%>">
								<label for="materialSubscriptionFormPasswords">User Name</label>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("userName", request)%></font>
							</div>

							<!-- E-mai -->
							<div class="md-form">
								<input type="password" class="form-control" name="password"
									value="<%=DataUtility.getStringData(bean.getPassword())%>">
								<label for="materialSubscriptionFormEmail">Password</label> <font
									color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("password", request)%></font>
							</div>

							<!-- Sign in button -->

							<input type="submit" name="operation"
								class="btn btn-outline-info btn-rounded btn-block z-depth-0 my-4 waves-effect"
								value="<%=LoginCtl.OP_SIGN_IN%>"> or <input type="submit"
								name="operation"
								class="btn btn-outline-info btn-rounded btn-block z-depth-0 my-4 waves-effect"
								value="<%=LoginCtl.OP_SIGN_UP%>"> <br>
							<br> 

						</form>
						<!-- Form -->

					</div>

				</div>
				<!-- Material form subscription -->
				<div class="col-sm-3"></div>
			</div>
		</div>
	</div>
	<br>
	<%@ include file="Footer.jsp"%>
</body>
</html>