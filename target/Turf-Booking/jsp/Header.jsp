
<%@page import="in.co.turf.booking.ctl.LoginCtl"%>
<%@page import="in.co.turf.booking.ctl.TRBView"%>
<%@page import="in.co.turf.booking.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Google Fonts -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<!-- Bootstrap core CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Material Design Bootstrap -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css"
	rel="stylesheet">

<!-- JQuery -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

<style type="text/css">
.md-select {
	background-color: transparent;
	border: none;
	border-bottom: 1px solid #bdbdbd;
	border-radius: 0;
	outline: 0;
	height: 2.1rem;
	width: 100%;
	font-size: 1rem;
	-webkit-box-shadow: none;
	box-shadow: none;
	-webkit-box-sizing: content-box;
	box-sizing: content-box;
	-webkit-transition: all .3s;
	transition: all .3s;
}

.md-select:active {
	border-bottom: 1px solid #4285F4;
	-webkit-box-shadow: 0 1px 0 0 #4285F4;
	box-shadow: 0 1px 0 0 #4285F4;
}
</style>
</head>
<body>
	<!--Main Navigation-->
	<header>

		<%
			UserBean userBean = (UserBean) session.getAttribute("user");

		boolean userLoggedIn = userBean != null;

		String welcomeMsg = "Hi, ";

		if (userLoggedIn) {
			welcomeMsg += userBean.getName();
		} else {
			welcomeMsg += "Guest";
		}
		%>

		<nav class="navbar navbar-expand-lg navbar-dark default-color">
			<a class="navbar-brand" href="#"><strong
				style="font-family: cursive; color: darkgreen;">Turf
					Booking System</strong></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active"><a class="nav-link" href="<%=TRBView.WELCOME_CTL%>">Home
							<span class="sr-only">(current)</span>
					</a></li>

					<%
						if (userLoggedIn) {
					%>
					<%
						if (userBean.getRoleId() == 1) {
					%>


					<li class="nav-item"><a class="nav-link"
						href="<%=TRBView.USER_LIST_CTL%>">View User</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">Turf</a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="<%=TRBView.TURF_CTL%>">Add
								Turf</a> <a class="dropdown-item" href="<%=TRBView.TURF_LIST_CTL%>">Turf
								List</a>
						</div></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">Manage Turf</a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="<%=TRBView.MANAGE_TURF_CTL%>">Manage
								Turf</a> <a class="dropdown-item"
								href="<%=TRBView.MANAGE_TURF_LIST_CTL%>"> Manage Turf List</a>
						</div></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=TRBView.BOOKING_LIST_CTL%>">View Booking</a></li>
					<%
						} else if (userBean.getRoleId() == 2) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="<%=TRBView.TURF_LIST_CTL%>">Check Turf</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=TRBView.MANAGE_TURF_LIST_CTL%>">Check Availability</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=TRBView.BOOKING_CTL%>">Book Turf</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=TRBView.BOOKING_LIST_CTL%>">Booking History</a></li>

					<%
						}
					%>

					<%
						} else {
					%>


					<li class="nav-item"><a class="nav-link" href="#">AboutUs</a>
					</li>

					<li class="nav-item"><a class="nav-link" href="#">Contact</a>
					</li>

					<%
						}
					%>
				</ul>
				<ul class="navbar-nav nav-flex-icons">
					<%
						if (userLoggedIn) {
					%>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"><%=welcomeMsg%></a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="<%=TRBView.MY_PROFILE_CTL%>">My
								Profile</a> <a class="dropdown-item"
								href="<%=TRBView.CHANGE_PASSWORD_CTL%>">Change Password</a> <a
								class="dropdown-item"
								href="<%=TRBView.LOGIN_CTL%>?operation=<%=LoginCtl.OP_LOG_OUT%>">Logout</a>
						</div></li>
					<%
						} else {
					%>
					<li class="nav-item"><a class="nav-link"
						href="<%=TRBView.LOGIN_CTL%>">SignIn</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=TRBView.USER_REGISTRATION_CTL%>">SignUp</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</nav>

	</header>
	<!--Main Navigation-->
</body>
</html>

