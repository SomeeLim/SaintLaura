package ysl.payment.model;

public class PaymentVO {
	
	private int orderDetailNo;  // 주문번호 시퀀스 넘버 
	private String orderNo_fk;  // 주문번호 
	private int idx_fk;			// 회원번호 
	private int pnum_fk;		// 제품넘버			
	private String shipName; 	// 주문자이름			업데이트 
	private String shipPh;		// 주문자 핸드폰번호		업데이트 
	private String shipPost; 	// 주문자 우편번호  		업데이트 
	private String shipAddr1;	// 주문자 주소1			업데이트 
	private String shipAddr2;	// 주문자주소2			업데이트 
	private String orderDate;	// 주문날짜
	private String orderStatus; // 주문유무 주문시 1이 들어감 
	private String orderNo;
		
	public PaymentVO() { }
	
	public PaymentVO(int orderDetailNo, String orderNo_fk, int idx_fk, int pnum_fk, String shipName, String shipPh, String shipPost,
			String shipAddr1, String shipAddr2, String orderDate, String orderStatus) {
		
		
		this.orderDetailNo = orderDetailNo;
		this.orderNo_fk = orderNo_fk;
		this.idx_fk = idx_fk;
		this.pnum_fk = pnum_fk;
		this.shipName = shipName;
		this.shipPh = shipPh;
		this.shipPost = shipPost;
		this.shipAddr1 = shipAddr1;
		this.shipAddr2 = shipAddr2;
		this.orderDate = orderDate;
		this.orderStatus = orderStatus;
	}
	
	
	public int getOrderDetailNo() {
		return orderDetailNo;
	}
	
	public void setOrderDetailNo(int orderDetailNo) {
		this.orderDetailNo = orderDetailNo;
	}
	
	public String getOrderNo_fk() {
		return orderNo_fk;
	}
	
	public void setOrderNo_fk(String orderNo_fk) {
		this.orderNo_fk = orderNo_fk;
	}
	
	public int getIdx_fk() {
		return idx_fk;
	}
	
	public void setIdx_fk(int idx_fk) {
		this.idx_fk = idx_fk;
	}
	
	public int getPnum_fk() {
		return pnum_fk;
	}

	public void setPnum_fk(int pnum_fk) {
		this.pnum_fk = pnum_fk;
	}

	public String getShipName() {
		return shipName;
	}
	
	public void setShipName(String shipName) {
		this.shipName = shipName;
	}
	
	public String getShipPh() {
		return shipPh;
	}
	
	public void setShipPh(String shipPh) {
		this.shipPh = shipPh;
	}
	
	public String getShipPost() {
		return shipPost;
	}
	
	public void setShipPost(String shipPost) {
		this.shipPost = shipPost;
	}
	
	public String getShipAddr1() {
		return shipAddr1;
	}
	
	public void setShipAddr1(String shipAddr1) {
		this.shipAddr1 = shipAddr1;
	}
	
	public String getShipAddr2() {
		return shipAddr2;
	}
	
	public void setShipAddr2(String shipAddr2) {
		this.shipAddr2 = shipAddr2;
	}
	
	public String getOrderDate() {
		return orderDate;
	}
	
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	
	public String getOrderStatus() {
		return orderStatus;
	}
	
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	

}
