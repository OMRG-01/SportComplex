package in.co.turf.booking.ctl;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import in.co.turf.booking.bean.BaseBean;
import in.co.turf.booking.bean.TurfBean;
import in.co.turf.booking.exception.ApplicationException;
import in.co.turf.booking.model.TurfModel;
import in.co.turf.booking.util.DataUtility;
import in.co.turf.booking.util.PropertyReader;
import in.co.turf.booking.util.ServletUtility;

/**
 * Servlet implementation class TurfListCtl
 */

/**

 */
@WebServlet(name = "TurfListCtl", urlPatterns = { "/ctl/turfList" })
public class TurfListCtl extends BaseCtl {
	private static Logger log = Logger.getLogger(TurfListCtl.class);

	/**
	 * Populates bean object from request parameters
	 * 
	 * @param request
	 * @return
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("TurfListCtl populateBean method start");
		TurfBean bean = new TurfBean();

		bean.setName(DataUtility.getString(request.getParameter("name")));

		bean.setLocation(DataUtility.getString(request.getParameter("location")));

		log.debug("TurfListCtl populateBean method end");
		return bean;
	}

	/**
	 * Contains Display logics
	 */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("TurfListCtl doGet Start");
		List list = null;

		int pageNo = 1;

		int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));

		TurfBean bean = (TurfBean) populateBean(request);

		String op = DataUtility.getString(request.getParameter("operation"));

		String ids = request.getParameter("ids");

		TurfModel model = new TurfModel();
		try {

			if (ids != null) {
				TurfBean deletebean = new TurfBean();

				deletebean.setId(DataUtility.getInt(ids));
				model.delete(deletebean);

				ServletUtility.setSuccessMessage("Data Deleted Successfully", request);
			}

			list = model.search(bean, pageNo, pageSize);

			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("No record found ", request);
			}
				
			ServletUtility.setSize(model.search(bean).size(), request);
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);
		} catch (ApplicationException e) {
			log.error(e);
			ServletUtility.handleException(e, request, response);
			return;
		}
		log.debug("TurfListCtl doPOst End");
	}

	/**
	 * Contains Submit logics
	 */
	@Override

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.debug("TurfListCtl doPost Start");

		List list = null;
		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;

		TurfBean bean = (TurfBean) populateBean(request);

		String op = DataUtility.getString(request.getParameter("operation"));
		// get the selected checkbox ids array for delete list

		String[] ids = request.getParameterValues("ids");

		TurfModel model = new TurfModel();
		try {

			if (OP_SEARCH.equalsIgnoreCase(op) || "Next".equalsIgnoreCase(op) || "Previous".equalsIgnoreCase(op)) {

				if (OP_SEARCH.equalsIgnoreCase(op)) {
					pageNo = 1;
				} else if (OP_NEXT.equalsIgnoreCase(op)) {
					pageNo++;
				} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
					pageNo--;
				}

			} else if (OP_DELETE.equalsIgnoreCase(op)) {
				pageNo = 1;
				if (ids != null && ids.length > 0) {
					TurfBean deletebean = new TurfBean();
					for (String id : ids) {
						deletebean.setId(DataUtility.getInt(id));
						model.delete(deletebean);
					}
					ServletUtility.setSuccessMessage("Data Deleted Successfully", request);
				} else {
					ServletUtility.setErrorMessage("Select at least one record", request);
				}
			} else if (OP_RESET.equalsIgnoreCase(op)) {
				ServletUtility.redirect(TRBView.TURF_LIST_CTL, request, response);
				return;

			}else if(OP_NEW.equalsIgnoreCase(op)) {
				ServletUtility.redirect(TRBView.TURF_CTL, request, response);
				return;
			}

			list = model.search(bean, pageNo, pageSize);

			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("No record found ", request);
			}
			ServletUtility.setSize(model.search(bean).size(), request);
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);

		} catch (ApplicationException e) {
			log.error(e);
			ServletUtility.handleException(e, request, response);
			return;
		}
		log.debug("TurfListCtl doGet End");

	}

	/**
	 * Returns the VIEW page of this Controller
	 * 
	 * @return
	 */
	@Override
	protected String getView() {
		return TRBView.TURF_LIST_VIEW;
	}
}
