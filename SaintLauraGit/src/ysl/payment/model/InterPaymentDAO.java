package ysl.payment.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterPaymentDAO {
	
	
	//////////////////////////결제///////////////////////////////////////////////////////////
	 // 1. CartNo를 통해서 상품번호와 구매수량 가져오기
	List<HashMap<String, String>> getCartInfo(String fk_email) throws SQLException;
	
	// 2. 주문번호 생성 후 주문번호를 테이블에 insert
	int setOrderNo(String orderNo) throws SQLException;  
	
	int insertEditFrm(HashMap<String, String> paraMap)throws SQLException;
		
	// 4. 주문테이블에 주문 등록
	int insertOrder(String fk_pnum, int idx_fk, String orderNo) throws SQLException;  

	// 5. 장바구니(장바구니번호) 삭제
	int deleteCart(String cartNo, int oqty, int pnum)throws SQLException;
	
	//////////////////////////주문리스트///////////////////////////////////////////////////////
	// 1. 주문반품 리스트 불러오기
	List<HashMap<String, String>> getOrderList(String idx) throws SQLException;
	
	// 2. 반품상세 연결
	String getReturnList(String orderNo) throws SQLException;
	
	// 3. 주문상세
	List<HashMap<String, String>> getOrderDetail(String orderNo) throws SQLException;
	
	// 4. 내 주문번호 가져오기
	List<String> getMyOrderNo(String idx) throws SQLException;

	/////////////////////////주문반품리스트/////////////////////////////////////////////////////
	// 반품상세리스트 알아오기
	List<HashMap<String, String>> selectOneReturn(String orderNo);
	
	
}
