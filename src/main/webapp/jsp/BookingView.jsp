
<%@page import="in.co.turf.booking.ctl.ManageTurfCtl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="in.co.turf.booking.util.HTMLUtility"%>
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
<title>Book Turf</title>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<br>
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb pink lighten-4">
			<li class="breadcrumb-item"><a class="black-text"
				href="<%=TRBView.WELCOME_CTL%>">Home</a></li>
			<li class="breadcrumb-item active">Book Turf</li>
		</ol>
	</nav>


	<div class="container">
		<div class="row">

			<div class="col-sm-8">
				<div style="margin-top: 18px">
					<h2>
						<b>Book Turf</b>
					</h2>
				</div>
				<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
				<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
				<hr>
				<form action="<%=TRBView.BOOKING_CTL%>" method="post">
					<jsp:useBean id="bean"
						class="in.co.turf.booking.bean.BookingBean" scope="request"></jsp:useBean>

					<input type="hidden" name="id" value="<%=bean.getId()%>"> <input
						type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
					<input type="hidden" name="modifiedBy"
						value="<%=bean.getModifiedBy()%>"> <input type="hidden"
						name="createdDatetime"
						value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
					<input type="hidden" name="modifiedDatetime"
						value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

					<%
						List list = (List) request.getAttribute("turfList");
					%>

					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">Turf Name</label>
							<%=HTMLUtility.getList1("turfId", String.valueOf(bean.getTurfId()), list)%>
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("turfId", request)%></font>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">Slot Name</label>
							<%=HTMLUtility.getList("slotId", String.valueOf(bean.getSlotId()), list1)%>
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("slotId", request)%></font>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">Date</label> <input
								type="text" class="form-control" name="date"
								value="<%=DataUtility.getDateString(bean.getDate())%>">
							<div>
								<font color="red" style="font-size: 13px"><%=ServletUtility.getErrorMessage("date", request)%></font>
							</div>
						</div>
					</div>

					<input type="submit" name="operation"
						class="btn btn-primary btn-sm btn-rounded"
						value="<%=ManageTurfCtl.OP_SAVE%>"> or <input type="submit"
						name="operation" class="btn btn-primary btn-sm btn-rounded"
						value="<%=ManageTurfCtl.OP_RESET%>">
				</form>

			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>




	<%@ include file="Footer.jsp"%>
</body>
</html>