package in.co.turf.booking.bean;

public class ManageTurfBean extends BaseBean {

	private long turfId;
	private String turfName;
	private String price;
	private String time;
	private String status;
	
	
	
	
	public long getTurfId() {
		return turfId;
	}

	public void setTurfId(long turfId) {
		this.turfId = turfId;
	}

	public String getTurfName() {
		return turfName;
	}

	public void setTurfName(String turfName) {
		this.turfName = turfName;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String getKey() {
		return String.valueOf(id);
	}

	@Override
	public String getValue() {
		return time;
	}

}
