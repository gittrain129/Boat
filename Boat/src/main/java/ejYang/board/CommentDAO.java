package ejYang.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class CommentDAO {
	private DataSource ds;
	
	//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public CommentDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex){
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}

	//글의 개수 구하기
	public int getListCount(int comment_board_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			conn = ds.getConnection();
			
			String sql = "select count(*) from BOARD_COMMENT "
					+ "where B_COMMENT_NUM = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, comment_board_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = rs.getInt(1);
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러: " + ex);
		}finally {
			if(rs != null) {
				try {
					rs.close(); 
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close(); 
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
			
			if(conn != null) {
				try {
					conn.close(); 	
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		return x;
	}

	 
	public JsonArray getCommentList(int comment_board_num, int state) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sort="asc";//등록순
		if(state==2) {
			sort="desc";//최신순
		}
		String sql = "select B_C_NUM, B_C_ID, B_CONTENT, B_REG_DATE, B_COMMENT_RE_LEV, "
				+ "			 B_COMMENT_RE_SEQ, B_COMMENT_RE_REF, MEMBER.memberfile "
				+ "from BOARD_COMMENT join MEMBER "
				+ "on	 	BOARD_COMMENT.B_C_ID = MEMBER.EMPNO "
				+ "where 	B_COMMENT_NUM = ? "
				+ "order by B_COMMENT_RE_REF "+sort+", "
				+ "			B_COMMENT_RE_SEQ asc";
		JsonArray array = new JsonArray();
		try {
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			conn = ds.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, comment_board_num);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				JsonObject object = new JsonObject();
				object.addProperty("b_c_num", rs.getInt(1));
				object.addProperty("b_c_id", rs.getString(2));
				object.addProperty("b_content", rs.getString(3));
				object.addProperty("b_reg_date", rs.getString(4));
				object.addProperty("b_comment_re_lev", rs.getInt(5));
				object.addProperty("b_comment_re_seq", rs.getInt(6));
				object.addProperty("b_comment_re_ref", rs.getInt(7));
				object.addProperty("memberfile", rs.getString(8));
				array.add(object);
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getCommentList() 에러: " + ex);
		}finally {
			if(rs != null) {
				try {
					rs.close(); 
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close(); 
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
			
			if(conn != null) {
				try {
					conn.close(); 	
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		return array;
	}

	
	//댓글 등록하기
	public int commentsInsert(Comment c) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			conn = ds.getConnection();
			
			String sql = "insert into BOARD_COMMENT "
					+ "values(BOARD_COM_SEQ.nextval, ?, ?, sysdate, ?,?,?, BOARD_COM_SEQ.nextval)";
			
			//새로운 글을 등록하는 부분입니다.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c.getB_c_id());
			pstmt.setString(2, c.getB_content());
			pstmt.setInt(3, c.getB_comment_num());
			pstmt.setInt(4, c.getB_comment_re_lev());
			pstmt.setInt(5, c.getB_comment_re_seq());
			
			result = pstmt.executeUpdate();
			if(result == 1) 
				System.out.println("데이터 삽입이 완료되었습니다.");
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("commentsInsert() 에러: " + ex);
		}finally {
			
			if(pstmt != null) {
				try {
					pstmt.close(); 
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
			
			if(conn != null) {
				try {
					conn.close(); 	
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		return result;
	}

	
	
	public int commentUpdate(Comment co) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result=0;
		String sql = "update BOARD_COMMENT set B_CONTENT=? "
				+ "where B_C_NUM = ? ";
		try {
			conn = ds.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, co.getB_content());
			pstmt.setInt(2, co.getB_c_num());
			
			result=pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("데이터 수정 되었습니다.");
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("commentUpdate() 에러: " + ex);
		}finally {
			
			if(pstmt != null) {
				try {
					pstmt.close(); 
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
			
			if(conn != null) {
				try {
					conn.close(); 	
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		return result;
	}

	
	
	
	public int commentsDelete(int b_c_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			
			String sql = "delete BOARD_COMMENT "
					+ "where B_C_NUM = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_c_num);
			result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("데이터 삭제 되었습니다.");
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("commentsDelete() 에러: " + ex);
		}finally {
			
			if(pstmt != null) {
				try {
					pstmt.close(); 
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
			
			if(conn != null) {
				try {
					conn.close(); 	
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		return result;
	}
	
	

	public int commentsReply(Comment c) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			StringBuilder update_sql=new StringBuilder();
			update_sql.append("update BOARD_COMMENT ");
			update_sql.append("set   B_COMMENT_RE_SEQ = B_COMMENT_RE_SEQ +1 ");
			update_sql.append("where B_COMMENT_RE_REF = ? ");
			update_sql.append("and   B_COMMENT_RE_SEQ > ? ");
			pstmt = conn.prepareStatement(update_sql.toString());
			pstmt.setInt(1, c.getB_comment_re_ref());
			pstmt.setInt(2, c.getB_comment_re_seq());
			pstmt.executeUpdate();
			pstmt.close();
			
			String sql = "insert into BOARD_COMMENT "
					+ "values(BOARD_COM_SEQ.nextval, ?, ?, sysdate, ?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c.getB_c_id());
			pstmt.setString(2, c.getB_content());
			pstmt.setInt(3, c.getB_comment_num());
			pstmt.setInt(4, c.getB_comment_re_lev()+1);
			pstmt.setInt(5, c.getB_comment_re_seq()+1);
			pstmt.setInt(6, c.getB_comment_re_ref());
			result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("reply 삽입 완료되었습니다.");
				conn.commit();
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("commentsDelete() 에러: " + ex);
			try {
				conn.rollback();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}finally {
			
			if(pstmt != null) {
				try {
					pstmt.close(); 
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
			
			if(conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close(); 	
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		return result;
	}

}
