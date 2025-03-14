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
import in.co.turf.booking.bean.TurfBean;
import in.co.turf.booking.exception.ApplicationException;
import in.co.turf.booking.exception.DuplicateRecordException;
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
@ WebServlet(name="TurfCtl",urlPatterns={"/ctl/turf"})
@MultipartConfig(maxFileSize = 16177215)
public class TurfCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;

	private static Logger log = Logger.getLogger(TurfCtl.class);
	/**
	 * Loads list and other data required to display at HTML form
	 * 
	 * @param request
	 */
	
	/**
	 * Validate input Data Entered By Turf
	 * 
	 * @param request
	 * @return
	 */
	@Override
	protected boolean validate(HttpServletRequest request) {

		log.debug("TurfCtl Method validate Started");

		boolean pass = true;

		
		if (DataValidator.isNull(request.getParameter("name"))) {
			request.setAttribute("name", PropertyReader.getValue("error.require","Name"));
			pass = false;
		} 
		
		if (DataValidator.isNull(request.getParameter("location"))) {
			request.setAttribute("location", PropertyReader.getValue("error.require","Location"));
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("description"))) {
			request.setAttribute("description", PropertyReader.getValue("error.require","Description"));
			pass = false;
		}

		
		 Part part = null;
			try {
				part = request.getPart("image");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

			if (DataValidator.isNull(fileName)) {
				request.setAttribute("image", PropertyReader.getValue("error.require", "Image"));
				pass = false;
			}

		log.debug("TurfCtl Method validate Ended");

		return pass;
	}
	/**
	 * Populates bean object from request parameters
	 * 
	 * @param request
	 * @return
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {

		log.debug("TurfCtl Method populatebean Started");

		TurfBean bean = new TurfBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));


		bean.setName(DataUtility.getString(request.getParameter("name")));

		bean.setDescription(DataUtility.getString(request.getParameter("description")));

		bean.setLocation(DataUtility.getString(request.getParameter("location")));


		populateDTO(bean, request);

		log.debug("TurfCtl Method populatebean Ended");

		return bean;
	}

	/**
	 * Contains DIsplay logics
	 */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("TurfCtl Method doGet Started");

		String op = DataUtility.getString(request.getParameter("operation"));
        // get model
        
		TurfModel model = new TurfModel();
        
		long id = DataUtility.getLong(request.getParameter("id"));
       
		if (id > 0 || op != null) {
          
            
			TurfBean bean;
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
        log.debug("TurfCtl Method doGet Ended");
	}

	

/**
 * Contains Submit logics
 */
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("TurfCtl Method doPost Started");
        String op = DataUtility.getString(request.getParameter("operation"));
        TurfModel model = new TurfModel();
        long id = DataUtility.getLong(request.getParameter("id"));
        if (OP_SAVE.equalsIgnoreCase(op)) {
            TurfBean bean = (TurfBean) populateBean(request);
            bean.setImage(ServletUtility.subImage(request, response,bean.getName()));
            try {
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

            TurfBean bean = (TurfBean) populateBean(request);
            try {
                model.delete(bean);
                ServletUtility.redirect(TRBView.TURF_LIST_CTL, request,
                        response);
                return;
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
              
                return;
            }

        } else if (OP_CANCEL.equalsIgnoreCase(op)) {
        	ServletUtility.redirect(TRBView.TURF_LIST_CTL, request, response);
        	
        }else if (OP_RESET.equalsIgnoreCase(op)) {
    		ServletUtility.redirect(TRBView.TURF_CTL, request, response);
    		return;
    }
    				
    		
        ServletUtility.forward(getView(), request, response);
        

        log.debug("TurfCtl Method doPostEnded");
	}
	/**
	 * Returns the VIEW page of this Controller
	 * 
	 * @return
	 */
	@Override
	protected String getView() {
		return TRBView.TURF_VIEW;
	}

}
