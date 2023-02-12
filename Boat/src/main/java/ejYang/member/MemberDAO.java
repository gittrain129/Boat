package ejYang.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class MemberDAO {
	private DataSource ds;
	
	//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public MemberDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex){
			System.out.println("DB 연결 실패 : " + ex);
		}
	}


	public Member member_info(String empno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Member m = null;
		try {
			conn = ds.getConnection();
			
			String select_sql = "select*from MEMBER where EMPNO = ?";
			pstmt = conn.prepareStatement(select_sql.toString());
			pstmt.setString(1, empno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				m = new Member();
				m.setEmpno(rs.getString(1));
				m.setDept(rs.getString(2));
				m.setDeptno(rs.getInt(3));
				m.setPassword(rs.getString(4));
				m.setPwcheck(rs.getString(5));
				m.setName(rs.getString(6));
				m.setJumin(rs.getString(7));
				m.setAddress(rs.getString(8));
				m.setPost(rs.getInt(9));
				m.setGender(rs.getString(10));
				m.setEmail(rs.getString(11));
				m.setPone(rs.getInt(12));
				m.setMemberfile(rs.getString(13));
				m.setImgsrc(rs.getString(14));
				m.setRegister_date(rs.getString(15));
				m.setIntro(rs.getString(16));
				m.setAge(rs.getInt(17));
			}
			
		}catch(Exception se) {
			se.printStackTrace();
			System.out.println("member_info() 에러:" + se);
		}finally {
			
			try {
				if(rs != null)
					rs.close(); 
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
			
			try {
				if(pstmt != null)
					pstmt.close(); 
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
			
			try {
				if(conn != null)
					conn.close(); 	
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return m;
	}
	
	


}
