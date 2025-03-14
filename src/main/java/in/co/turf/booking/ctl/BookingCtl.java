package in.co.turf.booking.ctl;

import java.io.IOException;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.log4j.Logger;

import in.co.turf.booking.bean.BaseBean;
import in.co.turf.booking.bean.BookingBean;
import in.co.turf.booking.bean.ManageTurfBean;
import in.co.turf.booking.bean.TurfBean;
import in.co.turf.booking.bean.UserBean;
import in.co.turf.booking.exception.ApplicationException;
import in.co.turf.booking.exception.DuplicateRecordException;
import in.co.turf.booking.model.BookingModel;
import in.co.turf.booking.model.ManageTurfModel;
import in.co.turf.booking.model.TurfModel;
import in.co.turf.booking.util.DataUtility;
import in.co.turf.booking.util.DataValidator;
import in.co.turf.booking.util.PropertyReader;
import in.co.turf.booking.util.ServletUtility;

/**
 * Servlet implementation class TurfCtl
 */

/**

 */
@WebServlet(name = "BookingCtl", urlPatterns = { "/ctl/booking" })
public class BookingCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;

	private static Logger log = Logger.getLogger(BookingCtl.class);

	@Override
	protected boolean validate(HttpServletRequest request) {

		log.debug("BookingCtl Method validate Started");

		boolean pass = true;

		if ("-----Select-----".equalsIgnoreCase(request.getParameter("turfId"))) {
			request.setAttribute("turfId", PropertyReader.getValue("error.require", "Turf Name"));
			pass = false;

		}

		if ("-----Select-----".equalsIgnoreCase(request.getParameter("time"))) {
			request.setAttribute("time", PropertyReader.getValue("error.require", "Slot Time"));
			pass = false;

		}

		String op = DataUtility.getString(request.getParameter("operation"));
		if (OP_MAKE_PAYMENT.equalsIgnoreCase(op)) {
			pass = true;
		}

		if (DataValidator.isNull(request.getParameter("date"))) {

			if (OP_MAKE_PAYMENT.equalsIgnoreCase(op)) {
				pass = true;
			} else {
				request.setAttribute("date", PropertyReader.getValue("error.require", "Date"));
				pass = false;
			}

		}

		log.debug("BookingCtl Method validate Ended");

		return pass;
	}

	@Override
	protected void preload(HttpServletRequest request) {
		try {
			request.setAttribute("turfList", new TurfModel().list());
			ManageTurfBean mBean=new ManageTurfBean();
			long slot=DataUtility.getLong(request.getParameter("slotId"));
			if(slot>0) {
				mBean.setTurfId(slot);
			}
			request.setAttribute("slotList", new ManageTurfModel().search(mBean));
		} catch (ApplicationException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Populates bean object from request parameters
	 * 
	 * @param request
	 * @return
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {

		log.debug("BookingCtl Method populatebean Started");

		BookingBean bean = new BookingBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));

		bean.setTurfId(DataUtility.getLong(request.getParameter("turfId")));

		bean.setSlotId(DataUtility.getLong(request.getParameter("slotId")));

		bean.setDate(DataUtility.getDate(request.getParameter("date")));

		populateDTO(bean, request);

		log.debug("BookingCtl Method populatebean Ended");

		return bean;
	}

	/**
	 * Contains DIsplay logics
	 */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("BookingCtl Method doGet Started");

		String op = DataUtility.getString(request.getParameter("operation"));
		// get model

		BookingModel model = new BookingModel();

		long id = DataUtility.getLong(request.getParameter("id"));

		if (id > 0 || op != null) {

			BookingBean bean;
			try {
				bean = model.findByPK(id);

				ServletUtility.setBean(bean, request);
				ServletUtility.forward(getView(), request, response);
			} catch (ApplicationException e) {
				log.error(e);

				ServletUtility.handleException(e, request, response);
				return;
			}
			
		}

		
		ServletUtility.forward(getView(), request, response);
		log.debug("BookingCtl Method doGet Ended");
	}

	/**
	 * Contains Submit logics
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("BookingCtl Method doPost Started");
		String op = DataUtility.getString(request.getParameter("operation"));
		BookingModel model = new BookingModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		try {
			if (OP_MAKE_PAYMENT.equalsIgnoreCase(op)) {
				BookingBean bean = (BookingBean) request.getSession().getAttribute("bBean");

				long pk = model.add(bean);
				ManageTurfBean mBean = new ManageTurfModel().findByPK(bean.getSlotId());
				mBean.setStatus("UnAvailable");
				new ManageTurfModel().update(mBean);
				ServletUtility.setSuccessMessage("Turf Booked successfully", request);
				ServletUtility.setBean(bean, request);
				ServletUtility.forward(getView(), request, response);
			} else if (OP_DELETE.equalsIgnoreCase(op)) {

				BookingBean bean = (BookingBean) populateBean(request);
				try {
					model.delete(bean);
					ServletUtility.redirect(TRBView.MANAGE_TURF_LIST_CTL, request, response);
					return;
				} catch (ApplicationException e) {
					log.error(e);
					ServletUtility.handleException(e, request, response);

					return;
				}

			} else if (OP_CANCEL.equalsIgnoreCase(op)) {
				ServletUtility.redirect(TRBView.MANAGE_TURF_LIST_CTL, request, response);

			} else if (OP_RESET.equalsIgnoreCase(op)) {
				ServletUtility.redirect(TRBView.MANAGE_TURF_CTL, request, response);
				return;
			} else if (OP_SAVE.equalsIgnoreCase(op)) {
				BookingBean bean = (BookingBean) populateBean(request);
				UserBean uBean = (UserBean) request.getSession().getAttribute("user");
				TurfBean tBean = new TurfModel().findByPK(bean.getTurfId());
				ManageTurfBean mBean = new ManageTurfModel().findByPK(bean.getSlotId());
				bean.setAmount(mBean.getPrice());
				bean.setTime(mBean.getTime());
				bean.setTurfLocation(tBean.getLocation());
				bean.setUserName(uBean.getName());
				bean.setMobileNo(uBean.getMobileNo());
				bean.setTurfName(tBean.getName());
				bean.setUserId(uBean.getId());
				request.getSession().setAttribute("bBean", bean);
				ServletUtility.forward(TRBView.PAYMENT_VIEW, request, response);
				return;
			}else {
				ServletUtility.setBean((BookingBean) populateBean(request), request);
			}

		} catch (ApplicationException e) {
			log.error(e);
			ServletUtility.handleException(e, request, response);
			return;
		} catch (DuplicateRecordException e) {

			ServletUtility.setErrorMessage(e.getMessage(), request);
		}
		
		

		ServletUtility.forward(getView(), request, response);

		log.debug("BookingCtl Method doPostEnded");
	}

	/**
	 * Returns the VIEW page of this Controller
	 * 
	 * @return
	 */
	@Override
	protected String getView() {
		return TRBView.BOOKING_VIEW;
	}

}
