package ysl.admin.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.*;
import javax.sql.*;

import my.util.MyUtil;

public class AdminDAO implements InterAdminDAO {
	
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성
	public AdminDAO() {
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 0. 자원반납
	public void close() {
		
		try {
			if(rs!=null) { rs.close(); rs=null;}
			if(pstmt!=null) { pstmt.close(); pstmt=null;}
			if(conn!=null) { conn.close(); conn=null;}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	
	// 1. 고객리스트
	@Override
	public List<HashMap<String, String>> getAdminCustomerList(HashMap<String, String> customerMap) throws SQLException {
		
		List<HashMap<String, String>> customerList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select rno , idx, email, name, hp1, hp2, hp3, status\n"+
						 "from\n"+
						 "(\n"+
						 "select rownum as rno , idx, email, name, hp1, hp2, hp3, status\n"+
						 "from\n"+
						 "(\n"+
						 "select idx,email, name, hp1, hp2, hp3, status\n"+
						 "from ysl_member \n"+
						 "where status in (1,0)\n";
						 
			
			String searchType = customerMap.get("searchType");
			String searchWord = customerMap.get("searchWord");
			String memberType = customerMap.get("memberType");
			int currentShowPageNo = Integer.parseInt(customerMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(customerMap.get("sizePerPage"));
			
			if(searchWord!=null && !searchWord.trim().isEmpty()) {
				sql += "and "+searchType+" like '%'||'" +searchWord+ "'||'%' \n";				
			}
			
			if(!("2".equals(memberType))) {
				sql += "and status = "+memberType+" \n";
			}
			
			/*
			// 검색어 입력후 탈퇴회원검색
			if(searchWord!=null && !searchWord.trim().isEmpty()) {
				sql += "where "+searchType+" like '%'||'" +searchWord+ "'||'%' \n";
				
				if(!("2".equals(memberType))) {
					sql += "and status = "+memberType+" \n";
				}
				
			}
			
			// 검색어 남아있는 상태에서 탈퇴회원검색
			if(searchWord==null && searchWord.trim().isEmpty()) {
				if(!("2".equals(memberType))) {
					sql += "where status = "+memberType+" \n";
				}
				
			}
			
			// 바로 탈퇴회원 검색
			if(!("2".equals(memberType))) {
				sql += "where status = "+memberType+" \n";
			}*/

						
			sql += "order by idx desc\n"+
				   ") V\n"+
				   ") T\n"+
				   "where T.rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);	
			
			pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage-1));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			
			rs =  pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt++;
				if(cnt==1) {
					customerList =  new ArrayList<HashMap<String,String>>();
				}
				
				HashMap<String, String> listMap = new HashMap<String, String>();
				
				listMap.put("idx", rs.getString("idx") );
				listMap.put("email", rs.getString("email") );
				listMap.put("name", rs.getString("name") );
				listMap.put("hp1", rs.getString("hp1"));
				listMap.put("hp2", rs.getString("hp2") );
				listMap.put("hp3", rs.getString("hp3") );
				
				String status = rs.getString("status");
						
				if(status.equals("1")) {
					status = "회원";
				}
				else if(status.equals("0")) {
					status = "탈퇴"; 
				}
									
				listMap.put("status", status);
				
				customerList.add(listMap);
				
			}
			
		} finally {
			close();
		}
		
		return customerList;
	}

	
	// 2. 고객상세페이지
	@Override
	public HashMap<String, String> getAdminCustomerDetail(String idx) throws SQLException {
		
		HashMap<String, String> detailMap = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select idx, email, name, post, addr1, addr2, hp1, hp2, hp3, gender, birthday, registerday, status\n"+
						 "from ysl_member\n"+
						 "where idx = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, idx);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				detailMap = new HashMap<String, String>();
				
				detailMap.put("idx", rs.getString("idx"));
				detailMap.put("email", rs.getString("email"));
				detailMap.put("name", rs.getString("name"));
				detailMap.put("post", rs.getString("post"));
				detailMap.put("addr1", rs.getString("addr1"));
				detailMap.put("addr2", rs.getString("addr2"));
				detailMap.put("hp1", rs.getString("hp1"));
				detailMap.put("hp2", rs.getString("hp2"));
				detailMap.put("hp3", rs.getString("hp3"));
				
				String gender = rs.getString("gender");
				
				if("1".equals(gender)) {
					gender = "남성";
				} else {
					gender = "여성";
				}
				
				detailMap.put("gender", gender);
				detailMap.put("birthday", rs.getString("birthday"));
				detailMap.put("registerday", rs.getString("registerday"));
				
				String status = rs.getString("status");
				
				if(status.equals("1")) {
					status = "회원";
				}
				else if(status.equals("0")) {
					status = "탈퇴"; 
				}
									
				detailMap.put("status", status);
				
				
			}
			
			
			
		} finally {
			close();
		}
		
		return detailMap;
		
	}

	
	// 3. 총 페이지 수
	@Override
	public int getTotalPage(HashMap<String, String> customerMap) throws SQLException {
		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/10) as totalPage\n"+
						 "from ysl_member\n"+
						 "where status in (1,0)";
			
			String searchType = customerMap.get("searchType");
			String searchWord = customerMap.get("searchWord");
			String memberType = customerMap.get("memberType");
			
			if(searchWord!=null && !searchWord.trim().isEmpty()) {
				sql += "and "+searchType+" like '%'||'" +searchWord+ "'||'%' \n";				
			}
			
			if(!("2".equals(memberType))) {
				sql += "and status = "+memberType+" \n";
			}
			
			sql += "order by idx desc\n";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalPage = rs.getInt("totalPage"); 
			}
			
		} finally {
			close();
		}
		
		return totalPage;
	}

	
	// 4. 고객 탈퇴 업데이트
	@Override
	public int updateMemberStatus(String status, String idx) throws SQLException {
		int result = 0;
		
		try {
			
			conn=ds.getConnection();
			
			String sql = "update ysl_member set status = ? \n"+
						 "where idx = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			if("0".equals(status)) {
				pstmt.setString(1, "1");
			}
			else if("1".equals(status)) {
				pstmt.setString(1, "0");
			}
			pstmt.setString(2, idx); 
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}
}
	