package ysl.product.model;

public class ProductVO {

	private int    pnum;            // 제품번호
	private String pname;           // 제품명
	private String pcategory_fk;    // 카테고리코드
	private String pimage1;         // 제품이미지1
	private String pimage2;         // 제품이미지2
	private String pimage3;         // 제품이미지3
	private String pimage4;         // 제품이미지4
	private int    pqty;            // 제품 재고량
	private int    price;           // 제품 정가
	private String pcontent;        // 제품설명
	private String pcolor;			// 제품 색
	private String psize;			// 제품 크기
	private String pmaterial;		// 제품 재질
	private String pspec;           // "YSL"
	
	private int totalPrice;         // 판매당시의 제품판매가 * 주문량
	 
	public ProductVO() { }
 
	public ProductVO(int pnum, String pname, String pcategory_fk, String pimage1, String pimage2, String pimage3,
			String pimage4, int pqty, int price, String pcontent, String pcolor, String psize,
			String pmaterial, String pspec ) {
		super();
		this.pnum = pnum; 
		this.pname = pname;
		this.pcategory_fk = pcategory_fk;
		this.pimage1 = pimage1;
		this.pimage2 = pimage2;
		this.pimage3 = pimage3;
		this.pimage4 = pimage4;
		this.pqty = pqty;
		this.price = price;
		this.pcontent = pcontent;
		this.pcolor = pcolor;
		this.psize = psize;
		this.pmaterial = pmaterial;
		this.pspec = pspec;
	}

	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPcategory_fk() {
		return pcategory_fk;
	}

	public void setPcategory_fk(String pcategory_fk) {
		this.pcategory_fk = pcategory_fk;
	}

	public String getPimage1() {
		return pimage1;
	}

	public void setPimage1(String pimage1) {
		this.pimage1 = pimage1;
	}

	public String getPimage2() {
		return pimage2;
	}

	public void setPimage2(String pimage2) {
		this.pimage2 = pimage2;
	}

	public String getPimage3() {
		return pimage3;
	}

	public void setPimage3(String pimage3) {
		this.pimage3 = pimage3;
	}

	public String getPimage4() {
		return pimage4;
	}

	public void setPimage4(String pimage4) {
		this.pimage4 = pimage4;
	}

	public int getPqty() {
		return pqty;
	}

	public void setPqty(int pqty) {
		this.pqty = pqty;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPspec() {
		return pspec;
	}

	public void setPspec(String pspec) {
		this.pspec = pspec;
	}

	public String getPcontent() {
		return pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getPcolor() {
		return pcolor;
	}

	public void setPcolor(String pcolor) {
		this.pcolor = pcolor;
	}

	public String getPsize() {
		return psize;
	}

	public void setPsize(String psize) {
		this.psize = psize;
	}

	public String getPmaterial() {
		return pmaterial;
	}

	public void setPmaterial(String pmaterial) {
		this.pmaterial = pmaterial;
	}

	/////////////////////////////////////////////////
	// *** 제품의 총판매가(실제판매가 * 주문량) 구해오기 ***
	public void setTotalPrice(int oqty) {   
	// int oqty 이 주문량이다.
	
	totalPrice = price * oqty; // 판매당시의 제품판매가 * 주문량
	
	}
	
	public int getTotalPrice() {
	return totalPrice;
	}
	
	
	
	
}