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
import in.co.turf.booking.bean.ManageTurfBean;
import in.co.turf.booking.exception.ApplicationException;
import in.co.turf.booking.model.ManageTurfModel;
import in.co.turf.booking.util.DataUtility;
import in.co.turf.booking.util.PropertyReader;
import in.co.turf.booking.util.ServletUtility;



/**
 * Servlet implementation class ManageTurfListCtl
 */

/**

 */
@WebServlet(name = "ManageTurfListCtl", urlPatterns = { "/ctl/manageTurfList" })
public class ManageTurfListCtl extends BaseCtl {
	private static Logger log = Logger.getLogger(ManageTurfListCtl.class);

	/**
	 * Populates bean object from request parameters
	 * 
	 * @param request
	 * @return
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("ManageTurfListCtl populateBean method start");
		ManageTurfBean bean = new ManageTurfBean();

		bean.setTurfName(DataUtility.getString(request.getParameter("name")));

		log.debug("ManageTurfListCtl populateBean method end");
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
		log.debug("ManageTurfListCtl doGet Start");
		List list = null;

		int pageNo = 1;

		int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));

		ManageTurfBean bean = (ManageTurfBean) populateBean(request);

		String op = DataUtility.getString(request.getParameter("operation"));

		String ids = request.getParameter("ids");

		ManageTurfModel model = new ManageTurfModel();
		try {
			
			if (ids != null ) {
				ManageTurfBean deletebean = new ManageTurfBean();
				
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
		log.debug("ManageTurfListCtl doPOst End");
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
		
		log.debug("ManageTurfListCtl doPost Start");
		
		
		List list = null;
		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;
		
		ManageTurfBean bean = (ManageTurfBean) populateBean(request);
		
		String op = DataUtility.getString(request.getParameter("operation"));
		// get the selected checkbox ids array for delete list
		
		String[] ids = request.getParameterValues("ids");
		
		ManageTurfModel model = new ManageTurfModel();
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
					ManageTurfBean deletebean = new ManageTurfBean();
					for (String id : ids) {
						deletebean.setId(DataUtility.getInt(id));
						model.delete(deletebean);
					}
					ServletUtility.setSuccessMessage("Data Deleted Successfully", request);
				} else {
					ServletUtility.setErrorMessage("Select at least one record", request);
				}
			} else if (OP_RESET.equalsIgnoreCase(op)) {
				ServletUtility.redirect(TRBView.MANAGE_TURF_LIST_CTL, request, response);
				return;

			}else if(OP_NEW.equalsIgnoreCase(op)) {
				ServletUtility.redirect(TRBView.MANAGE_TURF_CTL, request, response);
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
		log.debug("ManageTurfListCtl doGet End");

	}

	/**
	 * Returns the VIEW page of this Controller
	 * 
	 * @return
	 */
	@Override
	protected String getView() {
		return TRBView.MANAGE_TURF_LIST_VIEW;
	}
}
