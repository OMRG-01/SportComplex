<%@page import="in.co.turf.booking.ctl.BookingCtl"%>
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
			<li class="breadcrumb-item active">Payment</li>
		</ol>
	</nav>


	<div class="container">
		<div class="row">

			<div class="col-sm-8">
				<div style="margin-top: 18px">
					<h2>
						<b>Payment</b>
					</h2>
				</div>
				<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
				<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
				<hr>
				<form action="<%=TRBView.BOOKING_CTL%>" method="post">
					
					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">Card No</label> <input
								type="text" class="form-control" name=""
								value="">
							<div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">Card Holder Name</label> <input
								type="text" class="form-control" name=""
								value="">
							<div>
							</div>
						</div>
					</div>

					<div class="form-row">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServer015">Month</label> <input
								type="text" class="form-control" name=""
								value="">
							<div>
							</div>
						</div>
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServer025">Year</label> <input
								type="text" class="form-control" name=""
								value="">
							<div>
							</div>
						</div>

					</div>

					<div class="form-group">
						<div class="col-md-6 mb-3 md-form" style="padding-left: 0px">
							<label for="validationServerUsername55">CVV</label> <input
								type="text" class="form-control" name=""
								value="">
							<div>
							</div>
						</div>
					</div>
					<input type="submit" name="operation"
						class="btn btn-primary btn-sm btn-rounded"
						value="<%=BookingCtl.OP_MAKE_PAYMENT%>">
						</form>

			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>




	<%@ include file="Footer.jsp"%>
</body>
</html>