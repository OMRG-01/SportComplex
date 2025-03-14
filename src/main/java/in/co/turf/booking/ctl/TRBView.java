package in.co.turf.booking.ctl;

public interface TRBView {
	
	public String APP_CONTEXT = "/Turf-Booking";

	public String LAYOUT_VIEW = "/BaseLayout.jsp";
	public String PAGE_FOLDER = "/jsp";

	public String NEW_PAGE_FOLDER = "/jsp";
	public String JAVA_DOC_VIEW = APP_CONTEXT + "/doc/index.html";

	public String ERROR_VIEW = PAGE_FOLDER + "/Error.jsp";

	
	

	
	public String USER_REGISTRATION_VIEW = NEW_PAGE_FOLDER + "/UserRegistrationView.jsp";
	
	

	
	public String LOGIN_VIEW = NEW_PAGE_FOLDER + "/LoginView.jsp";
	
	public String TURF_VIEW = NEW_PAGE_FOLDER + "/TurfView.jsp";
	
	public String TURF_LIST_VIEW = NEW_PAGE_FOLDER + "/TurfListView.jsp";
	
	public String MANAGE_TURF_VIEW = NEW_PAGE_FOLDER + "/ManageTurfView.jsp";
	public String MANAGE_TURF_LIST_VIEW = NEW_PAGE_FOLDER + "/ManageTurfListView.jsp";
	
	public String BOOKING_VIEW = NEW_PAGE_FOLDER + "/BookingView.jsp";
	public String BOOKING_LIST_VIEW = NEW_PAGE_FOLDER + "/BookingListView.jsp";
	
	public String USER_LIST_VIEW = NEW_PAGE_FOLDER + "/UserListView.jsp";
	
	public String PAYMENT_VIEW = NEW_PAGE_FOLDER + "/PaymentView.jsp";
	
	public String WELCOME_VIEW = NEW_PAGE_FOLDER + "/Welcome.jsp";
	public String CHANGE_PASSWORD_VIEW = NEW_PAGE_FOLDER + "/ChangePasswordView.jsp";
	public String MY_PROFILE_VIEW = NEW_PAGE_FOLDER + "/MyProfileView.jsp";
	public String FORGET_PASSWORD_VIEW = NEW_PAGE_FOLDER + "/ForgetPasswordView.jsp";

	public String ERROR_CTL = "/ctl/ErrorCtl";
	
	
	
	
	public String USER_REGISTRATION_CTL = APP_CONTEXT + "/newUser";
	
	
	public String LOGIN_CTL = APP_CONTEXT + "/login";
	
	public String CONTECT_CTL = APP_CONTEXT + "/contact";
	
	public String WELCOME_CTL = APP_CONTEXT + "/welcome";
	
	public String TURF_CTL = APP_CONTEXT + "/ctl/turf";
	public String TURF_LIST_CTL = APP_CONTEXT + "/ctl/turfList";
	
	public String MANAGE_TURF_CTL = APP_CONTEXT + "/ctl/manageTurf";
	public String MANAGE_TURF_LIST_CTL = APP_CONTEXT + "/ctl/manageTurfList";
	
	
	public String BOOKING_CTL = APP_CONTEXT + "/ctl/booking";
	public String BOOKING_LIST_CTL = APP_CONTEXT + "/ctl/bookingList";
	
	public String USER_LIST_CTL = APP_CONTEXT + "/ctl/userList";
	
	public String LOGOUT_CTL = APP_CONTEXT + "/login";
	public String CHANGE_PASSWORD_CTL = APP_CONTEXT + "/ctl/changePassword";
	public String MY_PROFILE_CTL = APP_CONTEXT + "/ctl/updateProfile";
	public String FORGET_PASSWORD_CTL = APP_CONTEXT + "/forgetPassword";
	public String MARKSHEET_MERIT_LIST_CTL = APP_CONTEXT + "/ctl/MarksheetMeritListCtl";



}
