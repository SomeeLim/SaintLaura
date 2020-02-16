package ysl.product.model;

import java.sql.SQLException;
import java.util.*;

public interface InterProductDAO {
	
	// 제품번호 채번 해오기
	int getPnumOfProduct() throws SQLException;

	////////////////////////////////////////////////////////////
	
	// 제품 등록
	int uploadProduct(ProductVO pvo) throws SQLException;
	
	// 제품 테이블 삭제
	int deleteProdfromTab(String pnum) throws SQLException;
	
	// 제품검색
	List<HashMap<String, String>> getSearchList(HashMap<String, String> searchMap) throws SQLException;

}
