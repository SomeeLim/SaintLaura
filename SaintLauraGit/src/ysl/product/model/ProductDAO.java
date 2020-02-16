package ysl.product.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class ProductDAO implements InterProductDAO {
	
	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	 
	// 생성자
	public ProductDAO(){
		
		try { 
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	} // end of ProductDAO() ~~~~~~~~~~ 
	 
	public void close() {
		try {
			if(rs    != null)	rs.close();
			if(pstmt != null)	pstmt.close();
			if(conn  != null)	conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // end of close() ~~~~~~~~~~
	
	// 제품번호 채번 해오기
	@Override
	public int getPnumOfProduct() throws SQLException {
			
		int pnum = 0;
			
		try {
			conn = ds.getConnection();
				 
			String sql = " select seq_ysl_product_pnum.nextval AS PNUM " +
						      " from dual ";
						   
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
				 			 
			rs.next();
			pnum = rs.getInt("PNUM");
			
		} finally {
				close();
		}
			
		return pnum;
	}
	
	//// 관리자
	
	
	// 제품 등록
	@Override
	public int uploadProduct(ProductVO pvo) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "insert into ysl_product (pnum, pname, pcategory_fk, pimage1, pimage2, pimage3, pimage4, pqty, price, pcontent, pcolor, psize, pmaterial, pspec)" +
						 "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, pvo.getPnum());
			pstmt.setString(2, pvo.getPname());
			pstmt.setString(3, pvo.getPcategory_fk());
			pstmt.setString(4, pvo.getPimage1());
			pstmt.setString(5, pvo.getPimage2());
			pstmt.setString(6, pvo.getPimage3());
			pstmt.setString(7, pvo.getPimage4());
			pstmt.setInt(8, pvo.getPqty());
			pstmt.setInt(9, pvo.getPrice());
			pstmt.setString(10, pvo.getPcontent());
			pstmt.setString(11, pvo.getPcolor());
			pstmt.setString(12, pvo.getPsize());
			pstmt.setString(13, pvo.getPmaterial());
			pstmt.setString(14, pvo.getPspec());
			
			result = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		return result;
	}

	
	// 제품 테이블에서 삭제
	@Override
	public int deleteProdfromTab(String pnum) throws SQLException {
		int result = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "delete from ysl_product where pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pnum);
			
			result = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		return result;
	}

	
	// 제품검색
	@Override
	public List<HashMap<String, String>> getSearchList(HashMap<String, String> searchMap) throws SQLException {
		List<HashMap<String, String>> searchProdList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rno, pnum, pname, price, PCATEGORY_FK, PIMAGE1, PCOLOR \n" + 
						 "from(select rownum as rno, pnum, pname, price, PCATEGORY_FK, PIMAGE1, PCOLOR\n"+
						 "from ysl_product\n"+
						 "where pnum > 0\n";
			
			// 1. 검색어
			if(!"".equalsIgnoreCase(searchMap.get("searchProduct"))) {
				
				String searchProduct = searchMap.get("searchProduct");				
				sql += "      and ( pname like '%'|| '"+searchProduct+"' || '%' or pnum like '%'|| '"+searchProduct+"' || '%' )\n";
				
			}
			
			// 2. 카테고리
			if(!"".equalsIgnoreCase(searchMap.get("searhProdCat"))) {
				
				String searhProdCat = searchMap.get("searhProdCat");			
				
				if("여성".equalsIgnoreCase(searhProdCat)) {
					sql += "      and pcategory_fk between 100000 and 300000\n";
				}
				else if("남성".equalsIgnoreCase(searhProdCat)) {
					sql += "      and pcategory_fk between 400000 and 600000\n";
				}								
			}
						 
			// 3. 상세카테고리
			if(!"".equalsIgnoreCase(searchMap.get("searchProdCatDetail"))) {
				String searchProdCatDetail = searchMap.get("searchProdCatDetail");
				System.out.println(searchProdCatDetail); 
				switch (searchProdCatDetail) {
				case "크로스":
					sql += "      and pcategory_fk = 100000\n";
					break;
				case "숄더":
					sql += "      and pcategory_fk = 200000\n";
					break;
				case "클러치":
					sql += "      and pcategory_fk = 300000\n";
					break;
				case "백팩":
					sql += "      and pcategory_fk = 400000\n";
					break;
				case "캐쥬얼":
					sql += "      and pcategory_fk = 500000\n";
					break;
				case "비즈니스":
					sql += "      and pcategory_fk = 600000\n";
					break;
				default:
					break;
				}
			}
			
			// 4. 컬러
			if(!"".equalsIgnoreCase(searchMap.get("searhProdColor"))) {
				String searhProdColor = searchMap.get("searhProdColor");
				
				switch (searhProdColor) {
				case "BLACK":
					sql += "      and pcolor like '%'|| 'BLACK' || '%' \n";
					break;
				case "WHITE":
					sql += "      and (pcolor like '%'|| 'WHITE' || '%' or pcolor like '%'|| 'BLANC' || '%')\n";
					break;
				case "GOLD":
					sql += "      and pcolor like '%'|| 'GOLD' || '%' \n";
					break;
				case "PINK":
					sql += "      and pcolor like '%'|| 'PINK' || '%' \n";
					break;
				case "BLUE":
					sql += "      and (pcolor like '%'|| 'BLUE' || '%' or pcolor like '%'|| 'NAVY' || '%')\n";
					break;
				case "GREEN":
					sql += "      and (pcolor like '%'|| 'GREEN' || '%' or pcolor like '%'|| 'KHAKI' || '%')\n";
					break;
				case "RED":
					sql += "      and (pcolor like '%'|| 'RED' || '%' or pcolor like '%'|| 'BURGUNDY' || '%')\n";
					break;
				case "BROWN":
					sql += "      and (pcolor like '%'|| 'BROWN' || '%' or pcolor like '%'|| 'BEIGE' || '%'"+
						   " 	  or pcolor like '%'|| 'SAND' || '%' or pcolor like '%'|| 'NATURAL' || '%')\n";
					break;
				default:
					break;
				}
				
			}
			
			sql += ") where rno between ? and ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchMap.get("searhStartNo"));
			pstmt.setString(2, searchMap.get("searhEndNo"));
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt++;
				if(cnt==1) {
					searchProdList = new ArrayList<HashMap<String,String>>();
				}
				
				HashMap<String, String> resultMap = new HashMap<String, String>();
				resultMap.put("pnum", rs.getString("pnum"));
				resultMap.put("pname", rs.getString("pname"));
				resultMap.put("price", rs.getString("price"));
				resultMap.put("pcategory_fk", rs.getString("pcategory_fk"));
				resultMap.put("pimage1", rs.getString("pimage1"));
				resultMap.put("searhStartNo", String.valueOf((Integer.parseInt(searchMap.get("searhEndNo"))+1)));
				resultMap.put("pcolor", rs.getString("pcolor"));
				
				searchProdList.add(resultMap);				
			}
			
		} finally {
			close();
		}
		
		return searchProdList;
	}



}
