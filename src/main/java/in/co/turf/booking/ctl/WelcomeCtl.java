package in.co.turf.booking.ctl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import in.co.turf.booking.exception.ApplicationException;
import in.co.turf.booking.util.DataUtility;
import in.co.turf.booking.util.PropertyReader;
import in.co.turf.booking.util.ServletUtility;
import in.co.turf.booking.bean.*;
import in.co.turf.booking.model.*;


/**
 *
 *
 * Servlet implementation class WelcomeCtl

 */


@WebServlet(name = "WelcomeCtl", urlPatterns = { "/welcome" })
public class WelcomeCtl extends BaseCtl {

	private static final long serialVersionUID = 1L;

	private static Logger log = Logger.getLogger(WelcomeCtl.class);


	/**
	 * Contains display logic
	 */
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("WelcomeCtl populateBean start");
		BookingBean bean = new BookingBean();
		// Populate search parameters from request
		bean.setTurfName(DataUtility.getString(request.getParameter("name")));
		bean.setUserName(DataUtility.getString(request.getParameter("userName")));
		log.debug("WelcomeCtl populateBean end");
		return bean;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		handleRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		handleRequest(request, response);
	}

	private void handleRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("WelcomeCtl handleRequest start");
		List<BookingBean> list;
		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));
		String op = DataUtility.getString(request.getParameter("operation"));

		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;

		BookingBean bean = (BookingBean) populateBean(request);
		BookingModel model = new BookingModel();

		try {
			UserBean uBean = (UserBean) request.getSession().getAttribute("user");
			if (uBean != null && uBean.getRoleId() == 2) { // Role ID 2 = User
				bean.setUserId(uBean.getId());
			}

			if (OP_SEARCH.equalsIgnoreCase(op) || OP_NEXT.equalsIgnoreCase(op) || OP_PREVIOUS.equalsIgnoreCase(op)) {
				if (OP_SEARCH.equalsIgnoreCase(op)) {
					pageNo = 1;
				} else if (OP_NEXT.equalsIgnoreCase(op)) {
					pageNo++;
				} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
					pageNo--;
				}
			} else if (OP_RESET.equalsIgnoreCase(op)) {
				ServletUtility.redirect(TRBView.WELCOME_CTL, request, response);
				return;
			}

			list = model.search(bean, pageNo, pageSize);
			int totalSize = model.search(bean).size();

			// Set attributes for JSP
			request.setAttribute("list", list);
			request.setAttribute("pageNo", pageNo);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("size", totalSize); // Total records count

		} catch (ApplicationException e) {
			log.error(e);
			ServletUtility.handleException(e, request, response);
			return;
		}
		ServletUtility.forward(getView(), request, response);
		log.debug("WelcomeCtl handleRequest end");
	}

	/**
	 * Returns the VIEW page of this Controller
	 *
	 * @return
	 */
	@Override
	protected String getView() {
		return TRBView.WELCOME_VIEW;
	}

}
