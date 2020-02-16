package ysl.payment.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class PaymentDAO implements InterPaymentDAO {

	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public PaymentDAO() {

		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	// 0. 자원반환
	public void close() {
		
		try {
			if(rs != null) { rs.close(); rs = null; }
			if(pstmt != null) { pstmt.close(); pstmt = null; }
			if(conn != null) { conn.close(); conn = null; }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	
	//////////////////////////결제///////////////////////////////////////////////////////////
	 // 1. 회원의 이메일을 통해서 카트번호, 제품번호 ,주문량 알아오기 
	@Override
	public List<HashMap<String, String>> getCartInfo(String fk_email) throws SQLException {
	
		List<HashMap<String, String>> cartList = null;
				
		try {	
			conn = ds.getConnection();
		
			String sql = "  select M.email,C.fk_email, C.cartno, C.fk_pnum, C.oqty, P.price, P.pcolor, P.pname, P.pimage1 " +
						" from ysl_member M join ysl_cart C on M.email = C.fk_email  " +
						"      JOIN ysl_product P on C.fk_pnum = P.pnum " +
						" where M.email = C.fk_email and C.fk_email = ? " ;
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, fk_email);			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while(rs.next()) {
				cnt++;
				if(cnt==1) {
					cartList = new ArrayList<HashMap<String, String>>();
				}
				
		      HashMap<String, String> paraMap = new HashMap<String, String>();
		      
		      paraMap.put("cartno", rs.getString("cartno"));		  
		      paraMap.put("fk_pnum", rs.getString("fk_pnum"));
		      paraMap.put("oqty", rs.getString("oqty"));
		      paraMap.put("price", rs.getString("price"));
		      paraMap.put("pcolor", rs.getString("pcolor"));
		      paraMap.put("pname", rs.getString("pname"));
		      paraMap.put("pimage1", rs.getString("pimage1"));

		      cartList.add(paraMap);

			}
		
		}finally {
			close();
		}
		 return cartList;
	}

	// 2. 주문번호 생성 후 주문번호를 테이블에 insert
	@Override
	public int setOrderNo(String orderNo) throws SQLException {
		int n = 0;
		
		try {				
				conn = ds.getConnection();
				
				String sql = "insert into ysl_orderNo (orderNo) values(?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, orderNo);
				
				n = pstmt.executeUpdate();
								
		}finally {
			close();
		}
		return n;


  }
	// 주문회원에게 insert 
	@Override
	public int insertEditFrm(HashMap<String, String> paraMap) throws SQLException {
		
			int n = 0;
			
			try {				
					conn = ds.getConnection();
					
					String sql = "insert into ysl_orderInfo (orderInfoNo, orderNo_fk, idx_fk, shipName, shipPh, shipPost,shipAddr1, shipAddr2, shipStatus )"
							+ "values(seq_ysl_orderInfo.nextval, ?, ?, ?, ?, ?, ?, ?, default ) " ;
					pstmt = conn.prepareStatement(sql);
					

					pstmt.setString(1, paraMap.get("orderNo"));
					pstmt.setString(2, paraMap.get("fk_idx"));
					pstmt.setString(3, paraMap.get("afterEditName"));
					pstmt.setString(4, paraMap.get("afterEditHp"));
					pstmt.setString(5, paraMap.get("afterEditPost"));
					pstmt.setString(6, paraMap.get("afterEditAddr1"));
					pstmt.setString(7, paraMap.get("afterEditAddr2"));
										
					n = pstmt.executeUpdate();
									
			}finally {
				close();
			}
			return n;
	}

	
	// 4. 주문테이블에 주문 등록
	@Override
	public int insertOrder(String fk_pnum, int idx_fk, String orderNo) throws SQLException {
		
		int n = 0;
		
		try {
			
				 conn = ds.getConnection();
				 String sql = " insert into ysl_order (orderDetailNo, orderNo_fk, idx_fk, pnum_fk, orderDate, orderStatus) "
						 	+ " values (seq_order_detailNo.nextval , ? , ? , ? , default, default)";
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, orderNo);
				 pstmt.setInt(2, idx_fk);
				 pstmt.setString(3, fk_pnum);
				 
				 n = pstmt.executeUpdate();
	}finally {
		close();
	} 
		return n;
	}
	
	// 5. 장바구니(장바구니번호) 삭제와 재고량 감소 
	@Override
	public int deleteCart(String cartno, int oqty, int pnum) throws SQLException {
			int n = 0;
			
			try {
				
				 conn = ds.getConnection();
				 
				 String sql = " delete from ysl_cart where cartno = ? " ;
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, cartno);
				 				 
				 n = pstmt.executeUpdate();
				 
				 sql = " update ysl_product set pqty = (pqty - ? ) where pnum = ? " ;
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, oqty);
				 pstmt.setInt(2, pnum);
				 
				 n = pstmt.executeUpdate();
				 
				 
		}finally {
			close();
		} 
			return n;
		}
	
	
	//////////////////////////주문리스트///////////////////////////////////////////////////////
	// 1. 주문반품 리스트 불러오기
	@Override
	public List<HashMap<String, String>> getOrderList(String idx) throws SQLException {
		List<HashMap<String, String>> payList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select O.orderNo_fk as orderNo\n"+
						 "       ,max(orderDetailNo)\n"+
						 "       ,max(O.orderDate) AS orderDate\n"+
						 "       ,max(O.orderStatus) AS orderStatus\n"+
						 "       ,max(P.pname) AS pname\n"+
						 "       ,max(P.pimage1) AS pimage1\n"+
						 "       ,max(P.price) AS price\n"+
						 "from ysl_product P JOIN ysl_order O on P.pnum = O.pnum_fk\n"+
						 "where O.idx_fk = ? \n"+
						 "group by O.orderNo_fk\n"+
						 "order by orderDate desc";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, idx);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt++;
				if(cnt==1) {
					payList = new ArrayList<HashMap<String,String>>();
				}
				
				// 상품 카테고리 이름 떼오기				
				String prodGender = rs.getString("pimage1").substring(4, 5);
				String prodCategory = rs.getString("pimage1").substring(6, 8);
				
				if("F".equalsIgnoreCase(prodGender)) {
					prodGender = "female";
				}
				else if("M".equalsIgnoreCase(prodGender)) {
					prodGender = "male";
				}
				
				if("cl".equalsIgnoreCase(prodCategory)) {
					prodCategory = "clutch";
				}
				else if("cr".equalsIgnoreCase(prodCategory)) {
					prodCategory = "cross";
				}
				else if("sh".equalsIgnoreCase(prodCategory)) {
					prodCategory = "shoulder";
				}
				else if("bp".equalsIgnoreCase(prodCategory)) {
					prodCategory = "backpack";
				}
				else if("bu".equalsIgnoreCase(prodCategory)) {
					prodCategory = "business";
				}
				else if("ca".equalsIgnoreCase(prodCategory)) {
					prodCategory = "casual";
				}
				
				// 주문상태 정하기
				String orderStatus = rs.getString("orderStatus");
				
				if("1".equalsIgnoreCase(orderStatus)) {
					orderStatus = "배송접수";
				}
				else if("2".equalsIgnoreCase(orderStatus)) {
					orderStatus = "배송중";
				}
				else {
					orderStatus = "배송완료";
				}

				HashMap<String, String> payMap = new HashMap<String, String>();

				payMap.put("orderNo_fk", rs.getString("orderNo"));
				payMap.put("orderDate", rs.getString("orderDate"));
				payMap.put("orderStatus", orderStatus);
				payMap.put("pname", rs.getString("pname"));
				payMap.put("pimage1", rs.getString("pimage1"));
				payMap.put("price", rs.getString("price"));			
				payMap.put("prodGender", prodGender);	
				payMap.put("prodCategory", prodCategory);	
				
				payList.add(payMap);
				
			}			
			
		} finally {
			close();
		}
		
		return payList;
	}

	
	// 2. 반품상세 연결
	@Override
	public String getReturnList(String orderNo) throws SQLException {
		String orderDetailNo_fk = "";
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select orderNo_fk as orderNo\n"+
						 "       ,orderDetailNo\n"+
						 "from ysl_order\n"+
						 "where orderNo_fk= ? and orderStatus >3\n"+
						 "order by orderDate desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderNo);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				orderDetailNo_fk = rs.getString("orderDetailNo");
			}
			
		} finally {
			close();
		}
		
		return orderDetailNo_fk;
	}

	
	// 3. 주문상세
	@Override
	public List<HashMap<String, String>> getOrderDetail(String orderNo) throws SQLException {
		List<HashMap<String, String>> orderList = null; 
		
		try {
			conn = ds.getConnection();
			
			String sql = "select O.orderNo_fk as orderNo\n"+
						 "      ,O.orderDate AS orderDate\n"+
						 "      ,O.orderStatus AS orderStatus\n"+
						 "      ,P.pimage1 AS pimage1\n"+
						 "      ,P.pnum AS pnum\n"+
						 "      ,P.pname AS pname\n"+
						 "      ,P.pcolor AS pcolor\n"+
						 "      ,P.price AS price\n"+
						 "      ,P.psize AS psize\n"+
						 "from ysl_order O JOIN ysl_product P on P.pnum = O.pnum_fk\n"+
						 "where O.orderNo_fk = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, orderNo);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			int sum = 0;
			while(rs.next()) {
				
				cnt++;
				if(cnt==1) {
					orderList = new ArrayList<HashMap<String,String>>();
				}
								
				HashMap<String, String> orderMap = new HashMap<String, String>();
				
				orderMap.put("orderNo", rs.getString("orderNo"));
				orderMap.put("orderDate", rs.getString("orderDate"));
				
				String orderStatus = rs.getString("orderStatus");
				
				if("1".equalsIgnoreCase(orderStatus)) {
					orderStatus = "배송접수";
				}
				else if("2".equalsIgnoreCase(orderStatus)) {
					orderStatus = "배송중";
				}
				else {
					orderStatus = "배송완료";
				}
				
				orderMap.put("orderStatus", orderStatus);
				orderMap.put("pimage1", rs.getString("pimage1"));
				orderMap.put("pnum", rs.getString("pnum"));
				orderMap.put("pname", rs.getString("pname"));
				orderMap.put("pcolor", rs.getString("pcolor"));
				orderMap.put("price", rs.getString("price"));	
				orderMap.put("psize", rs.getString("psize"));
				
				sum += Integer.parseInt(rs.getString("price"));				
				String strSum = String.valueOf(sum);
				
				orderMap.put("sum", strSum); 	
				
				orderList.add(orderMap);
				
			}
			
		} finally {
			close();
		}
		
		return orderList;
	}

	
	// 4. 내 주문번호 가져오기
	@Override
	public List<String> getMyOrderNo(String idx) throws SQLException {
		List<String> orderNoList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select orderNo_fk\n"+
						 "from ysl_order\n"+
						 "where idx_fk = ? \n"+
						 "group by orderNo_fk";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, idx);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt++;
				if(cnt==1) {
					orderNoList = new ArrayList<String>();
				}
								
				orderNoList.add(rs.getString("orderNo_fk")); 
			}
			
		} finally {
			close();
		}
		
		return orderNoList;
	}

	///////////////////////// 주문반품 /////////////////////////////////////////////////////////
	
	
	// 반품상세리스트 알아오기
	@Override
	public List<HashMap<String, String>> selectOneReturn(String orderNo) {

		// System.out.println("orderNo :" + orderNo);
		List<HashMap<String, String>> returnList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select O.orderNo_fk AS orderNo\n"+
						 "      ,O.orderDetailNo AS orderDetailNo\n"+
						 "      ,R.returnDetailNo AS returnDetailNo\n"+
						 "      ,R.idx_fk AS idx\n"+
						 "      ,R.returnStatus AS returnStatus\n"+
					     "      ,P.pimage1 AS pimage1\n"+
						 "      ,P.pnum AS pnum\n"+
						 "      ,P.pname AS pname \n"+
						 "      ,P.pcolor AS pcolor\n"+
						 "      ,P.psize AS psize\n"+
						 "      ,P.price AS price\n"+
						 "from ysl_product P JOIN ysl_order O on P.pnum = O.pnum_fk \n"+
						 "        JOIN ysl_return R on O.orderDetailNo = R.orderDetailNo_fk\n"+
						 "where O.orderNo_fk =? and R.returnStatus in ('4','5','6','7')\n"+
						 "order by returnStatus";
				
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, orderNo);
			
			rs = pstmt.executeQuery();
			
			int cnt=0;
			while(rs.next()) {
				cnt++;
				if(cnt==1) {
					returnList = new ArrayList<HashMap<String,String>>();
				}
				HashMap<String,String> returnMap = new HashMap<String, String>();
				
				returnMap.put("orderNo", rs.getString("orderNo"));
				returnMap.put("orderDetailNo", rs.getString("orderDetailNo"));
				returnMap.put("returnDetailNo", rs.getString("returnDetailNo"));
				returnMap.put("idx", rs.getString("idx"));
				String returnStatus = rs.getString("returnStatus");
				
				switch (returnStatus) {
				
				case "4":
					returnStatus = "교환신청";
					break;
				case "5":
					returnStatus = "교환완료";
					break;
				case "6":
					returnStatus = "반품신청";
					break;
				case "7":
					returnStatus = "반품완료";
					break;
					
				default: 
					break;
				}
				
				returnMap.put("returnStatus", returnStatus);
				returnMap.put("pimage1", rs.getString("pimage1"));
				returnMap.put("pnum", rs.getString("pnum"));
				returnMap.put("pname", rs.getString("pname"));
				returnMap.put("pcolor", rs.getString("pcolor"));
				returnMap.put("psize", rs.getString("psize"));
				returnMap.put("price", rs.getString("price"));
				
				returnList.add(returnMap);
			};
			
		} catch(SQLException e) {
			e.printStackTrace();	
		} finally {
			close();
		}		
		
		return returnList;
	}
	
}
