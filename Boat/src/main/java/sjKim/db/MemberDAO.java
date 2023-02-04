package sjKim.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private DataSource ds;
	
	//생성자에게 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public MemberDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}
	 
	public int isId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		int result = -1; //DB에 해당 id가 없습니다.
		try {
			conn = ds.getConnection();
			
			String sql = "select id from member where id=?";
			// PreparedStatement 객체 얻기
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				result = 0;  //DB에 해당 id가 있습니다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (conn != null)
				try {			
					conn.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			
			}//finally end
			return result;
	} //isId end

	public int insert(Member m) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			System.out.println("getConnection : insert()");
			
			// PreparedStatement 객체 얻기
			pstmt = conn.prepareStatement(
					"insert into member (id, password, name, age, gender, email) "
					+"values (?,?,?,?,?,?)");
	
			pstmt.setString(1, m.getId());
			pstmt.setString(2, m.getPassword());
			pstmt.setString(3, m.getName());
			pstmt.setInt(4, m.getAge());
			pstmt.setString(5, m.getGender());
			pstmt.setString(6, m.getEmail());
			
			result = pstmt.executeUpdate(); //삽입 성공시 result는 1
			
		//primary key 제약조건 위반했을 경우 발생하는 에러
		} catch(java.sql.SQLIntegrityConstraintViolationException e) {
			result = -1;
			System.out.println("멤버 아이디 중복 에러입니다.");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {				
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
		}
		return result;
	}//insert end

	public int isId(String id, String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		int result = -1; //아이디가 존재하지 않습니다.
		try {
			conn = ds.getConnection();
			
			String sql = "select id, password from member where id=?";
			// PreparedStatement 객체 얻기
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				if(rs.getString(2).equals(pass)) {
					result = 1;	//아이디와 비밀번호 일치하는 경우
				}else {
					result = 0;  //비밀번호가 일치하지 않는 경우
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (conn != null)
				try {			
					conn.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			
			}//finally end
			return result;

	}

	public Member member_info(String id) {
		Member m = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			
			String sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				m = new Member();
				m.setId(rs.getString(1));
				m.setPassword(rs.getString(2));
				m.setName(rs.getString(3));
				m.setAge(rs.getInt(4));
				m.setGender(rs.getString(5));
				m.setEmail(rs.getString(6));
				m.setMemberfile(rs.getString(7));
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (con != null)
				try {			
					con.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			
			}
		return m;
	}

	
	
	
	public int update(Member m) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			con = ds.getConnection();
			
			String sql = "update member set name = ?, age = ?, gender = ?, email = ?, memberfile = ? "
					   + " where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m.getName());
			pstmt.setInt(2, m.getAge());
			pstmt.setString(3, m.getGender());
			pstmt.setString(4, m.getEmail());
			pstmt.setString(5, m.getMemberfile());
			pstmt.setString(6, m.getId());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (con != null)
				try {			
					con.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			
			}
		return result;
	}

	
	
	public int getListCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("select count(*) from member where id != 'admin'");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러: " + ex);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (con != null)
				try {			
					con.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			
			}
		return x;
	}
	
	
	
	public List<Member> getList(int page, int limit) {
		List<Member> list = new ArrayList<Member>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			
			String sql = "select * "
					   + " from (select b.*, rownum rnum"
					   + " 		 from(select * from member "
					   + "			   where id != 'admin'"
					   + "			   order by id) b"
					   + "		 where rownum <= ? "
					   + 		")"
					   + "	where rnum >= ? and rnum <= ?";
			pstmt = con.prepareStatement(sql);
			//한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지 ...
			int startrow = (page - 1) * limit + 1;
							// 읽기 시작할 row 번호(1 11 21 31 ...
			int endrow = startrow + limit - 1;
							// 읽을 마지막 row 번호(10 20 30 40 ...
			pstmt.setInt(1, endrow);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member m = new Member();
				m.setId(rs.getString("id"));
				m.setPassword(rs.getString(2));
				m.setName(rs.getString(3));
				m.setAge(rs.getInt(4));
				m.setGender(rs.getString(5));
				m.setEmail(rs.getString(6));
				list.add(m);				
			}
			
		}catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("List<Member> getList() 에러: " + ex);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (con != null)
				try {			
					con.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			
			}
		return list ;
	}

	
	
	
	public int getListCount(String field, String value) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			con = ds.getConnection();
			String sql = "select count(*) from member "
					   + "where id != 'admin' "
					   + " and " + field + " like ?"; //and name like '%홍길동%'
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+value+"%");  //'%a%'
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러: " + ex);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (con != null)
				try {			
					con.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			
			}
		return x;
	}

	public List<Member> getList(String field, String value, int page,int limit) {
		List<Member> list = new ArrayList<Member>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			
			String sql = "select * "
					   + " from (select b.*, rownum rnum"
					   + " 		 from(select * from member "
					   + "			   where id != 'admin'"
					   + "			   and " + field + " like ? "
					   + "			   order by id) b"
					   + "		 where rownum <= ? "
					   + 		")"
					   + "	where rnum between ? and ?";
			
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+value+"%");
			
			//한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지 ...
			int startrow = (page - 1) * limit + 1;
							// 읽기 시작할 row 번호(1 11 21 31 ...
			int endrow = startrow + limit - 1;
							// 읽을 마지막 row 번호(10 20 30 40 ...
			
			pstmt.setInt(2, endrow);
			pstmt.setInt(3, startrow);
			pstmt.setInt(4, endrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member m = new Member();
				m.setId(rs.getString("id"));
				m.setPassword(rs.getString(2));
				m.setName(rs.getString(3));
				m.setAge(rs.getInt(4));
				m.setGender(rs.getString(5));
				m.setEmail(rs.getString(6));
				list.add(m);				
			}
			
		}catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("List<Member> getList() 에러: " + ex);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (con != null)
				try {			
					con.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			
			}
		return list ;
	}
	
	
}//main end
