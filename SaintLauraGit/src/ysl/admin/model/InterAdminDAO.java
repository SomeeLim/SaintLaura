package ysl.admin.model;

import java.sql.SQLException;
import java.util.*;

public interface InterAdminDAO {
	
	
	// 1. 고객리스트
	List<HashMap<String, String>> getAdminCustomerList(HashMap<String, String> customerMap) throws SQLException;
	
	// 2. 고객 상세페이지
	HashMap<String, String> getAdminCustomerDetail(String idx) throws SQLException;
	
	// 3. 총 페이지 수
	int getTotalPage(HashMap<String, String> customerMap) throws SQLException;
	
	// 4. 고객 탈퇴 업데이트
	int updateMemberStatus(String status, String idx) throws SQLException;
	
	
}
