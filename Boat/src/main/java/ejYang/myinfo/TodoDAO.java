package ejYang.myinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class TodoDAO {
	private DataSource ds;
	
	//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public TodoDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex){
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}

	//투두리스트 글 목록
	public JsonArray getTodoList(String t_empno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		JsonArray array = new JsonArray();
		
		String sql = "SELECT*FROM MYINFO "
				+ "WHERE T_EMPNO = ? "
				+ "AND T_GRAPH = 'N' "
				+ "ORDER BY T_DATE ";
		try {
			conn = ds.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, t_empno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				JsonObject object = new JsonObject();
				object.addProperty("t_empno", rs.getString(1));
				object.addProperty("t_content", rs.getString(2));
				object.addProperty("t_date", rs.getString(3));
				object.addProperty("t_graph", rs.getString(4));
				array.add(object);
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getTodoList() 에러: " + ex);
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
	
	
	
	
//	//투두리스트 글 목록
//	public List<TodoBean> getTodoList() {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		String sql = "SELECT*FROM MYINFO "
//				+ "ORDER BY T_DATE ";
//		
//		List<TodoBean> list = new ArrayList<TodoBean>();
//		try {
//			conn = ds.getConnection();
//			
//			pstmt = conn.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				TodoBean todo = new TodoBean();
//				todo.setT_content(rs.getString("t_content"));
//				todo.setT_date(rs.getString("t_date"));
//				todo.setT_graph(rs.getString("t_graph"));
//				list.add(todo);
//			}
//			
//		}catch(Exception ex) {
//			ex.printStackTrace();
//			System.out.println("getTodoList() 에러: " + ex);
//		}finally {
//			if(rs != null) {
//				try {
//					rs.close(); 
//				}catch(Exception e) {
//					System.out.println(e.getMessage());
//				}
//			}
//			
//			if(pstmt != null) {
//				try {
//					pstmt.close(); 
//				}catch(Exception e) {
//					System.out.println(e.getMessage());
//				}
//			}
//			
//			if(conn != null) {
//				try {
//					conn.close(); 	
//				}catch(Exception e) {
//					System.out.println(e.getMessage());
//				}
//			}
//		}
//		return list;
//	}
//
//	
//	//투두리스트 갯수
//	public int getTodoListCount() {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		int x = 0;
//		try {
//			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
//			conn = ds.getConnection();
//			
//			String sql = "select count(*) from MYINFO";
//			pstmt = conn.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			
//			if(rs.next()) {
//				x = rs.getInt(1);
//			}
//			
//		}catch(Exception ex) {
//			ex.printStackTrace();
//			System.out.println("getTodoListCount() 에러: " + ex);
//		}finally {
//			if(rs != null) {
//				try {
//					rs.close(); 
//				}catch(Exception e) {
//					System.out.println(e.getMessage());
//				}
//			}
//			
//			if(pstmt != null) {
//				try {
//					pstmt.close(); 
//				}catch(Exception e) {
//					System.out.println(e.getMessage());
//				}
//			}
//			
//			if(conn != null) {
//				try {
//					conn.close(); 	
//				}catch(Exception e) {
//					System.out.println(e.getMessage());
//				}
//			}
//		}
//		return x;
//	}

	
	//투두리스트 등록하기
		public int todoInsert(TodoBean todo) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			try {
				conn = ds.getConnection();
				
				String sql = "insert into MYINFO "
						+ "values(?, ?, sysdate, 'N') ";
				//등록은 무조건 N
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, todo.getT_empno());
				pstmt.setString(2, todo.getT_content());
				result = pstmt.executeUpdate();
				
				if(result == 1) {
					System.out.println("투두리스트 삽입이 모두 완료되었습니다.");
				}
				
			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println("todoInsert() 에러: " + ex);
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

		
		//완료 'N' -> 'Y'
		public int todocheck(String empno, String content) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			try {
				conn = ds.getConnection();
				
				String sql = "UPDATE MYINFO "
						+ "SET T_GRAPH = 'Y' "
						+ "WHERE T_EMPNO = ? "
						+ "AND T_CONTENT = ? ";
				//등록은 무조건 N
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, empno);
				pstmt.setString(2, content);
				result = pstmt.executeUpdate();
				
				if(result == 1) {
					System.out.println("선택된 투두리스트가 완료되었습니다.");
				}
				
			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println("todocheck() 에러: " + ex);
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

		
		//투두 삭제
		public int tododelete(String empno, String content) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			try {
				conn = ds.getConnection();
				
				String sql = "DELETE MYINFO "
						+ "WHERE T_EMPNO = ? "
						+ "AND T_CONTENT = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, empno);
				pstmt.setString(2, content);
				result = pstmt.executeUpdate();
				
				if(result == 1) {
					System.out.println("선택된 투두리스트가 삭제되었습니다.");
				}
				
			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println("tododelete() 에러: " + ex);
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

		
		//N 리스트
		public JsonArray getNTodoList(String t_empno) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			JsonArray array = new JsonArray();
			
			String sql = "SELECT*FROM MYINFO "
					+ "WHERE T_EMPNO = ? ";
			try {
				conn = ds.getConnection();
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, t_empno);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					JsonObject object = new JsonObject();
					object.addProperty("t_empno", rs.getString(1));
					object.addProperty("t_content", rs.getString(2));
					object.addProperty("t_date", rs.getString(3));
					object.addProperty("t_graph", rs.getString(4));
					array.add(object);
				}
				
			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println("getNTodoList() 에러: " + ex);
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

		
		//Y 리스트
		public JsonArray getYTodoList(String t_empno) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			JsonArray array = new JsonArray();
			
			String sql = "SELECT*FROM MYINFO "
					+ "WHERE T_EMPNO = ? "
					+ "AND T_GRAPH = 'Y' ";
			try {
				conn = ds.getConnection();
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, t_empno);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					JsonObject object = new JsonObject();
					object.addProperty("t_empno", rs.getString(1));
					object.addProperty("t_content", rs.getString(2));
					object.addProperty("t_date", rs.getString(3));
					object.addProperty("t_graph", rs.getString(4));
					array.add(object);
				}
				
			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println("getYTodoList() 에러: " + ex);
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

		
		//12시 전체 삭제
		public int tododeleteall(String empno) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			try {
				conn = ds.getConnection();
				
				String sql = "DELETE MYINFO "
						+ "WHERE T_EMPNO = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, empno);
				result = pstmt.executeUpdate();
				
				if(result == 1) {
					System.out.println("전체 투두리스트가 삭제되었습니다.");
				}
				
			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println("tododeleteall() 에러: " + ex);
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

}
