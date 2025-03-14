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
import in.co.turf.booking.bean.ManageTurfBean;
import in.co.turf.booking.bean.TurfBean;
import in.co.turf.booking.exception.ApplicationException;
import in.co.turf.booking.exception.DuplicateRecordException;
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
@ WebServlet(name="ManageTurfCtl",urlPatterns={"/ctl/manageTurf"})
public class ManageTurfCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;

	private static Logger log = Logger.getLogger(ManageTurfCtl.class);

	@Override
	protected boolean validate(HttpServletRequest request) {

		log.debug("ManageTurfCtl Method validate Started");

		boolean pass = true;

		
		if (DataValidator.isNull(request.getParameter("price"))) {
			request.setAttribute("price", PropertyReader.getValue("error.require","price"));
			pass = false;
		} 
		
		
		if (DataValidator.isNull(request.getParameter("time"))) {
			request.setAttribute("time", PropertyReader.getValue("error.require","Time"));
			pass = false;
		}

		if ("-----Select-----".equalsIgnoreCase(request.getParameter("turfId"))) {
			request.setAttribute("turfId", PropertyReader.getValue("error.require", "Turf Name"));
			pass = false;

		}
		
		if ("-----Select-----".equalsIgnoreCase(request.getParameter("status"))) {
			request.setAttribute("status", PropertyReader.getValue("error.require", "Status"));
			pass = false;

		}

		log.debug("ManageTurfCtl Method validate Ended");

		return pass;
	}
	@Override
	protected void preload(HttpServletRequest request) {
		try {
			request.setAttribute("turfList",new TurfModel().list());
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

		log.debug("ManageTurfCtl Method populatebean Started");

		ManageTurfBean bean = new ManageTurfBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));

		bean.setTurfId(DataUtility.getLong(request.getParameter("turfId")));

		bean.setPrice(DataUtility.getString(request.getParameter("price")));

		bean.setStatus(DataUtility.getString(request.getParameter("status")));

		bean.setTime(DataUtility.getString(request.getParameter("time")));


		populateDTO(bean, request);

		log.debug("ManageTurfCtl Method populatebean Ended");

		return bean;
	}

	/**
	 * Contains DIsplay logics
	 */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("ManageTurfCtl Method doGet Started");

		String op = DataUtility.getString(request.getParameter("operation"));
        // get model
        
		ManageTurfModel model = new ManageTurfModel();
        
		long id = DataUtility.getLong(request.getParameter("id"));
       
		if (id > 0 || op != null) {
          
            
			ManageTurfBean bean;
            try {
                bean = model.findByPK(id);
             
                ServletUtility.setBean(bean, request);
            
            } catch (ApplicationException e) {
                log.error(e);
            
                ServletUtility.handleException(e, request, response);
                return;
            }
        }

        ServletUtility.forward(getView(), request, response);
        log.debug("ManageTurfCtl Method doGet Ended");
	}

	

/**
 * Contains Submit logics
 */
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("ManageTurfCtl Method doPost Started");
        String op = DataUtility.getString(request.getParameter("operation"));
        ManageTurfModel model = new ManageTurfModel();
        long id = DataUtility.getLong(request.getParameter("id"));
        if (OP_SAVE.equalsIgnoreCase(op)) {
            ManageTurfBean bean = (ManageTurfBean) populateBean(request);
            
            try {
            	bean.setTurfName(new TurfModel().findByPK(bean.getTurfId()).getName());
                if (id > 0){
                    model.update(bean);
                    ServletUtility.setSuccessMessage("Data is successfully Updated", request);
                } else {
                    long pk = model.add(bean);
                    ServletUtility.setSuccessMessage("Data is successfully saved",request);
                }
              
               
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            } catch (DuplicateRecordException e) {
                ServletUtility.setBean(bean, request);
                ServletUtility.setErrorMessage(e.getMessage(), request);
            }
            ServletUtility.forward(getView(), request, response);
        } else if (OP_DELETE.equalsIgnoreCase(op)) {

        	ManageTurfBean bean = (ManageTurfBean) populateBean(request);
            try {
                model.delete(bean);
                ServletUtility.redirect(TRBView.MANAGE_TURF_LIST_CTL, request,
                        response);
                return;
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
              
                return;
            }

        } else if (OP_CANCEL.equalsIgnoreCase(op)) {
        	ServletUtility.redirect(TRBView.MANAGE_TURF_LIST_CTL, request, response);
        	
        }else if (OP_RESET.equalsIgnoreCase(op)) {
    		ServletUtility.redirect(TRBView.MANAGE_TURF_CTL, request, response);
    		return;
    }
    				
    		
        ServletUtility.forward(getView(), request, response);
        

        log.debug("ManageTurfCtl Method doPostEnded");
	}
	/**
	 * Returns the VIEW page of this Controller
	 * 
	 * @return
	 */
	@Override
	protected String getView() {
		return TRBView.MANAGE_TURF_VIEW;
	}

}
