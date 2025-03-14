
<%@page import="in.co.turf.booking.ctl.TurfCtl"%>
<%@page import="in.co.turf.booking.ctl.MyProfileCtl"%>
<%@page import="in.co.turf.booking.util.DataUtility"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Turf</title>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<br>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb pink lighten-4">
			<li class="breadcrumb-item"><a class="black-text" href="<%=TRBView.WELCOME_CTL%>">Home</a></li>
			<li class="breadcrumb-item active">Turf</li>
		</ol>
	</nav>


	<div class="container">
		<div class="row">

			<div class="col-sm-8">
				<div style="margin-top: 18px">
					<h2>
						<b>Add Turf</b>
					</h2>
				</div>
				<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
				<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
				<hr>
					<form action="<%=TRBView.TURF_CTL%>" method="post" enctype="multipart/form-data">
						<jsp:useBean id="bean" class="in.co.turf.booking.bean.TurfBean"
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
								<label for="validationServerUsername55">Location</label> <input
									type="text" class="form-control" name="location"  value="<%=DataUtility.getStringData(bean.getLocation())%>">
								<div> <font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("location", request)%></font></div>
							</div>
						</div>
						
						<div class="form-group">
						<div class="col-md-9 mb-4 md-form" style="padding-left: 0px">
							<textarea id="form7" class="md-textarea form-control" rows="3"
								name="description"><%=DataUtility.getStringData(bean.getDescription())%></textarea>
							<label for="form7">Description</label>
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("description", request)%></font>
							</div>
						</div>
					</div>
					
						<div class="form-group">
							<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
								 <input
									type="file" class="form-control" name="image"  value="<%=DataUtility.getStringData(bean.getImage())%>">
								<div> <font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("image", request)%></font></div>
							</div>
						</div>
					
						<input type="submit" name="operation"
							class="btn btn-primary btn-sm btn-rounded"
							value="<%=TurfCtl.OP_SAVE%>"> or <input type="submit" name="operation" class="btn btn-primary btn-sm btn-rounded"
					value="<%=TurfCtl.OP_RESET%>">
					</form>

			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>




	<%@ include file="Footer.jsp"%>
</body>
</html>