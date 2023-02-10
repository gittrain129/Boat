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
			if( dept_sql.equals(" ")) {
				dept_sql = "where";
			} else {
				dept_sql += " and";
				
			}
			
						
			String sql = "select j.* "
					+ " from (select rownum rnum, "
					+ "		k.* "
					+ "	from (select empno, name, dept, email, imgsrc from member " + dept_sql + " empno not like '%ADMIN%' order by deptno asc) k "
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
			if( dept_sql.equals(" ")) {
				dept_sql = "where";
			} else {
				dept_sql += "and";
				
			}
			
			conn = ds.getConnection();
			
			String sql = "select count(*) from member " + dept_sql + " empno not like '%ADMIN%' ";
			
			
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

	public jkKim_Member chatIdFind(String id) {
		Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      jkKim_Member jk = null;
	      try {
	         conn = ds.getConnection();
	         StringBuilder sql = new StringBuilder();
	         sql.append("select empno,imgsrc from member ");
	         sql.append("where empno = ?");
	         pstmt = conn.prepareStatement(sql.toString());
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            jk = new jkKim_Member();
	            jk.setEmpno(rs.getString("empno"));
	            jk.setImgsrc(rs.getString("imgsrc"));
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	         System.out.println("chatIdFind에러");
	      }finally {
	         try {
	            if(rs!=null)
	               rs.close();
	         }catch(SQLException se) {
	            se.printStackTrace();
	         }try {
	            if(pstmt!=null)
	               pstmt.close();
	         }catch(SQLException se) {
	            se.printStackTrace();
	         }try {
	            if(conn!=null)
	               conn.close();
	         }catch(Exception e) {
	            e.printStackTrace();
	         }
	      }
	      return jk;
	   }

	public List<jkKim_Member> getMemberList(String dept_sql) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
			List<jkKim_Member> list = new ArrayList<jkKim_Member>();
			
			
			if( dept_sql.equals(" ")) {
				dept_sql = "where";
			} else {
				dept_sql += "and";
				
			}
			
			
		try {	
			conn = ds.getConnection();
		
			
			
			String sql = "select rownum, empno, name, dept, email, imgsrc from member "+ dept_sql +" empno not like '%ADMIN%' order by deptno asc ";
				
			
			
			
			pstmt = conn.prepareStatement(sql); //sql.toString()
			
			rs=pstmt.executeQuery();
			
		
			// DB에서 가져온 데이터를 VO객체에 담습니다.
			while (rs.next()) {
				jkKim_Member b = new jkKim_Member();
				b.setName(rs.getString("name"));
				b.setDept(rs.getString("dept"));
				b.setEmail(rs.getString("email"));
				b.setImgsrc(rs.getString("imgsrc"));
				b.setRownum(rs.getString("rownum"));
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

	public String getName_id(int rownum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
			List<jkKim_Member> list = new ArrayList<jkKim_Member>();
			String empno_id = "";
			System.out.println("DAO까지 넘어온 rownum = " + rownum);
			
		try {	
			conn = ds.getConnection();
		
			
			
			String sql = "select j.* "
					+" from (select rownum rnum, empno, name, dept, email, imgsrc from member  order by deptno asc) j "
					+" where j.rnum = ? ";
					
			
			
			pstmt = conn.prepareStatement(sql); //sql.toString()
			pstmt.setInt(1, rownum);
			rs=pstmt.executeQuery();
			while (rs.next()) {
				empno_id = rs.getString("empno");
						
			}
		
		
		return empno_id;
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
		return empno_id;
		
	}

	public String getImgsrc(int rownum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
			List<jkKim_Member> list = new ArrayList<jkKim_Member>();
			String imgsrc = "";
			System.out.println("DAO까지 넘어온 rownum = " + rownum);
			
		try {	
			conn = ds.getConnection();
		
			
			
			String sql = "select j.* "
					+" from (select rownum rnum, empno, name, dept, email, imgsrc from member  order by deptno asc) j "
					+" where j.rnum = ? ";
					
			
			
			pstmt = conn.prepareStatement(sql); //sql.toString()
			pstmt.setInt(1, rownum);
			rs=pstmt.executeQuery();
			while (rs.next()) {
				imgsrc = rs.getString("imgsrc");
						
			}
		
		
		return imgsrc;
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
		return imgsrc;
		
	}

	
	
	
	}
	

	

