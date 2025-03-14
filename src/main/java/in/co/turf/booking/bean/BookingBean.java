package in.co.turf.booking.bean;

import java.util.Date;

public class BookingBean extends BaseBean {

	private String turfName;
	private String time;
	private String userName;
	private String mobileNo;
	private String turfLocation;
	private Date date;
	private String amount;
	private long userId;
	private long slotId;
	private long turfId;
	
	
	
	
	
	
	public long getTurfId() {
		return turfId;
	}

	public void setTurfId(long turfId) {
		this.turfId = turfId;
	}

	public long getSlotId() {
		return slotId;
	}

	public void setSlotId(long slotId) {
		this.slotId = slotId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getTurfName() {
		return turfName;
	}

	public void setTurfName(String turfName) {
		this.turfName = turfName;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getTurfLocation() {
		return turfLocation;
	}

	public void setTurfLocation(String turfLocation) {
		this.turfLocation = turfLocation;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	@Override
	public String getKey() {
		return null;
	}

	@Override
	public String getValue() {
		return null;
	}

	
}
