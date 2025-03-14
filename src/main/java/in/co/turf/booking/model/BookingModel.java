package in.co.turf.booking.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import in.co.turf.booking.bean.BookingBean;
import in.co.turf.booking.bean.TurfBean;
import in.co.turf.booking.exception.ApplicationException;
import in.co.turf.booking.exception.DatabaseException;
import in.co.turf.booking.exception.DuplicateRecordException;
import in.co.turf.booking.exception.RecordNotFoundException;
import in.co.turf.booking.util.JDBCDataSource;


public class BookingModel {
	private static Logger log = Logger.getLogger(BookingModel.class);

	public Integer nextPK() throws DatabaseException {
		log.debug("Model nextPK Started");
		Connection conn = null;
		int pk = 0;

		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(ID) FROM Booking");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				pk = rs.getInt(1);
			}
			rs.close();

		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new DatabaseException("Exception : Exception in getting PK");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model nextPK End");
		return pk + 1;
	}


	public long add(BookingBean bean) throws ApplicationException, DuplicateRecordException {

		Connection conn = null;
		int pk = 0;


		try {
			conn = JDBCDataSource.getConnection();
			pk = nextPK();
			conn.setAutoCommit(false); // Begin transaction
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Booking VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, pk);
			pstmt.setString(2, bean.getTurfName());
			pstmt.setString(3, bean.getTime());
			pstmt.setString(4, bean.getUserName());
			pstmt.setString(5, bean.getMobileNo());
			pstmt.setString(6, bean.getTurfLocation());
			pstmt.setDate(7,new java.sql.Date(bean.getDate().getTime()));
			pstmt.setString(8, bean.getAmount());
			pstmt.setLong(9,bean.getUserId());
			pstmt.setString(10, bean.getCreatedBy());
			pstmt.setString(11, bean.getModifiedBy());
			pstmt.setTimestamp(12, bean.getCreatedDatetime());
			pstmt.setTimestamp(13, bean.getModifiedDatetime());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception ex) {
				ex.printStackTrace();
				throw new ApplicationException("Exception : add rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception : Exception in add Turf");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		return pk;
	}

	public void delete(BookingBean bean) throws ApplicationException {

		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			conn.setAutoCommit(false); // Begin transaction
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM Booking WHERE ID=?");
			pstmt.setLong(1, bean.getId());
			pstmt.executeUpdate();
			conn.commit(); // End transaction
			pstmt.close();

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception ex) {
				throw new ApplicationException("Exception : Delete rollback exception " + ex.getMessage());
			}
			throw new ApplicationException("Exception : Exception in delete Turf");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}

	}


	public BookingBean findByName(String name) throws ApplicationException {
		log.debug("Model findByLogin Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM Booking WHERE Turf_NAME=?");
		BookingBean bean = null;
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new BookingBean();
				bean.setId(rs.getLong(1));
				bean.setTurfName(rs.getString(2));
				bean.setTime(rs.getString(3));
				bean.setUserName(rs.getString(4));
				bean.setMobileNo(rs.getString(5));
				bean.setTurfLocation(rs.getString(6));
				bean.setDate(rs.getDate(7));
				bean.setAmount(rs.getString(8));
				bean.setUserId(rs.getLong(9));
				bean.setCreatedBy(rs.getString(10));
				bean.setModifiedBy(rs.getString(11));
				bean.setCreatedDatetime(rs.getTimestamp(12));
				bean.setModifiedDatetime(rs.getTimestamp(13));
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting Turf by login");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model findByLogin End");
		return bean;
	}



	public BookingBean findByPK(long pk) throws ApplicationException {
		log.debug("Model findByPK Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM Booking WHERE ID=?");
		BookingBean bean = null;
		Connection conn = null;

		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			pstmt.setLong(1, pk);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new BookingBean();
				bean.setId(rs.getLong(1));
				bean.setTurfName(rs.getString(2));
				bean.setTime(rs.getString(3));
				bean.setUserName(rs.getString(4));
				bean.setMobileNo(rs.getString(5));
				bean.setTurfLocation(rs.getString(6));
				bean.setDate(rs.getDate(7));
				bean.setAmount(rs.getString(8));
				bean.setUserId(rs.getLong(9));
				bean.setCreatedBy(rs.getString(10));
				bean.setModifiedBy(rs.getString(11));
				bean.setCreatedDatetime(rs.getTimestamp(12));
				bean.setModifiedDatetime(rs.getTimestamp(13));
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting Turf by pk");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model findByPK End");
		return bean;
	}

    public List<BookingBean> getBookingsByUserId(long userId) {
        List<BookingBean> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = JDBCDataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM bookings WHERE user_id = ? ORDER BY date DESC");
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BookingBean bean = new BookingBean();
                bean.setId(rs.getLong("id"));
                bean.setTurfName(rs.getString("turf_name"));
                bean.setTime(rs.getString("slot_time"));
                bean.setTurfLocation(rs.getString("location"));
                bean.setDate(rs.getDate("date"));
                bean.setAmount(rs.getString("amount"));
                list.add(bean);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCDataSource.closeConnection(conn);
        }
        return list;
    }




	public List search(BookingBean bean) throws ApplicationException {
		return search(bean, 0, 0);
	}



	public List search(BookingBean bean, int pageNo, int pageSize) throws ApplicationException {
		log.debug("Model search Started");
		StringBuffer sql = new StringBuffer("SELECT * FROM Booking WHERE 1=1");

		if (bean != null) {
			if (bean.getId() > 0) {
				sql.append(" AND id = " + bean.getId());
			}
			if (bean.getUserId() > 0) {
				sql.append(" AND user_Id = " + bean.getUserId());
			}
			if (bean.getTurfName() != null && bean.getTurfName().length() > 0) {
				sql.append(" AND Turf_name like '" + bean.getTurfName() + "%'");
			}
			if (bean.getUserName() != null && bean.getUserName().length() > 0) {
				sql.append(" AND USER_NAME like '" + bean.getUserName() + "%'");
			}
			
		}
		if (pageSize > 0) {
			pageNo = (pageNo - 1) * pageSize;
			sql.append(" Limit " + pageNo + ", " + pageSize);
		}
		ArrayList list = new ArrayList();
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				bean = new BookingBean();
				bean.setId(rs.getLong(1));
				bean.setTurfName(rs.getString(2));
				bean.setTime(rs.getString(3));
				bean.setUserName(rs.getString(4));
				bean.setMobileNo(rs.getString(5));
				bean.setTurfLocation(rs.getString(6));
				bean.setDate(rs.getDate(7));
				bean.setAmount(rs.getString(8));
				bean.setUserId(rs.getLong(9));
				bean.setCreatedBy(rs.getString(10));
				bean.setModifiedBy(rs.getString(11));
				bean.setCreatedDatetime(rs.getTimestamp(12));
				bean.setModifiedDatetime(rs.getTimestamp(13));
				list.add(bean);
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in search Turf");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}
		log.debug("Model search End");
		return list;
	}



	public List list() throws ApplicationException {
		return list(0, 0);
	}


	public List list(int pageNo, int pageSize) throws ApplicationException {
		log.debug("Model list Started");
		ArrayList list = new ArrayList();
		StringBuffer sql = new StringBuffer("select * from Booking");
		if (pageSize > 0) {
			pageNo = (pageNo - 1) * pageSize;
			sql.append(" limit " + pageNo + "," + pageSize);
		}
		Connection conn = null;
		try {
			conn = JDBCDataSource.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				BookingBean bean = new BookingBean();
				bean.setId(rs.getLong(1));
				bean.setTurfName(rs.getString(2));
				bean.setTime(rs.getString(3));
				bean.setUserName(rs.getString(4));
				bean.setMobileNo(rs.getString(5));
				bean.setTurfLocation(rs.getString(6));
				bean.setDate(rs.getDate(7));
				bean.setAmount(rs.getString(8));
				bean.setUserId(rs.getLong(9));
				bean.setCreatedBy(rs.getString(10));
				bean.setModifiedBy(rs.getString(11));
				bean.setCreatedDatetime(rs.getTimestamp(12));
				bean.setModifiedDatetime(rs.getTimestamp(13));
				list.add(bean);
			}
			rs.close();
		} catch (Exception e) {
			log.error("Database Exception..", e);
			throw new ApplicationException("Exception : Exception in getting list of Turfs");
		} finally {
			JDBCDataSource.closeConnection(conn);
		}

		log.debug("Model list End");
		return list;

	}

	

}
