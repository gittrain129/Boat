package jkKim.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class jkKim_MemberDAO {
	
	private DataSource ds;

	
	// 생ㅅ어자에서 JNDI리소스를 참조하여 Connection객체를 얻어옵니다
	public jkKim_MemberDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("db연결 실패: " + ex);
		}
	} //생성자end
	
	public int addressview() {
		return 0;
	}

	public List<jkKim_Member> getMemberList(int page, int limit, String dept_sql) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
			List<jkKim_Member> list = new ArrayList<jkKim_Member>();
			int startrow = (page -1) * limit +1; //읽기 시작할 row번호( 1 11 21 31...
			int endrow = startrow + limit -1;	//읽을 마지막 row ( 10 20 30...
			
		try {	
			conn = ds.getConnection();
			//empno는 orderby용으로 불러만옴
			
			
			String sql = "select j.* "
					+ " from (select rownum rnum, "
					+ "		k.* "
					+ "	from (select empno, name, dept, email, imgsrc from member " + dept_sql + " order by deptno asc) k "
					+ " ) j "
					+ " where rnum >=? and rnum <=? ";
			
			
			pstmt = conn.prepareStatement(sql); //sql.toString()
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs=pstmt.executeQuery();
			
		
			// DB에서 가져온 데이터를 VO객체에 담습니다.
			while (rs.next()) {
				jkKim_Member b = new jkKim_Member();
				b.setName(rs.getString("name"));
				b.setDept(rs.getString("dept"));
				b.setEmail(rs.getString("email"));
				b.setImgsrc(rs.getString("imgsrc"));
				list.add(b);
						
			}
									
		}//try end
		catch(Exception se) {
			se.printStackTrace();
			System.out.println("getBoardList() 에러"  + se);
			
		}finally {
			try {
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				System.out.println(e.getMessage());
			}
				try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
			try {
				if(conn!=null)
					conn.close();
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
	}
		return list;
	}

	public int getListCount(String dept_sql) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result=0;
		try {
			conn = ds.getConnection();
			
			String sql = "select count(*) from member" + dept_sql;
			
			pstmt = conn.prepareStatement(sql); //sql.toString()
			rs=pstmt.executeQuery();
			
			if( rs.next()) {
				result = rs.getInt(1);
			}
									
		}//try end
		catch(Exception se) {
			se.printStackTrace();
			System.out.println("getListcount() 에러 " + se);
		}finally {
			try {
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				System.out.println(e.getMessage());
			}
				try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
			try {
				if(conn!=null)
					conn.close();
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
	}
		return result;
	}
	
	
	
}
