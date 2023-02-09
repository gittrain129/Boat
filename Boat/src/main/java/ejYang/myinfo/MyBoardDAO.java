package ejYang.myinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import ejYang.board.BoardBean;

public class MyBoardDAO {
	private DataSource ds;
	
	//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public MyBoardDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex){
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}

	
	//내 글의 갯수 구하기
	public int getMyListCount(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = ds.getConnection();
			
			String sql = "SELECT SUM(c) FROM "
					+ "(select count(*) c from BOARD "
					+ "where BOARD_NAME = ?  "
					+ "UNION ALL "
					+ "select count(*) c from file_board "
					+ "where FILE_NAME = ? ) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, name);
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


	//내 글 리스트
	public List<MyBoardBean> getMyBoardList(int page, int limit, String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String board_list_sql = "SELECT * FROM ( "
				+ "SELECT rownum rnum, J.* FROM( "
				+ "SELECT BOARD_NUM, BOARD_SUBJECT, BOARD_DEPT, BOARD_NAME, BOARD_READCOUNT, BOARD_DATE, BOARD_NOTICE, NVL(CNT, 0) AS CNT  "
				+ "FROM BOARD LEFT OUTER JOIN  (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT "
				+ "												GROUP BY B_COMMENT_NUM) "
				+ "ON BOARD_NUM = B_COMMENT_NUM "
				+ "where BOARD_NAME = ?  "
				+ "UNION ALL "
				+ "SELECT FILE_NUM, FILE_SUBJECT, DEPT, FILE_NAME, FILE_READCOUNT, FILE_DATE, FILE_FILE, NVL(CNT, 0) AS CNT "
				+ "FROM file_board LEFT OUTER JOIN (SELECT F_COMMENT_NUM, COUNT(*) CNT FROM FILE_COMMENT "
				+ "												GROUP BY F_COMMENT_NUM) "
				+ "ON FILE_NUM = F_COMMENT_NUM "
				+ "where FILE_NAME = ?  "
				+ ") J "
				+ "where rownum <= ? "
				+ "ORDER BY BOARD_DATE DESC) "
				+ "where rnum>=? and rnum<=? ";
		
		List<MyBoardBean> list = new ArrayList<MyBoardBean>();
		//한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지...
		int startrow = (page - 1) * limit + 1;	//읽기 시작할 row 번호(1  11 21 31 ...
		int endrow = startrow + limit -1;		//읽을 마지막 row 번호(10 20 30 40 ...
		try {
			conn = ds.getConnection();
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			
			pstmt = conn.prepareStatement(board_list_sql);
			pstmt.setString(1, name);
			pstmt.setString(2, name);
			pstmt.setInt(3, endrow);
			pstmt.setInt(4, startrow);
			pstmt.setInt(5, endrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MyBoardBean board = new MyBoardBean();
				board.setRnum(rs.getInt("rnum"));
				board.setBoard_num(rs.getInt("board_num"));
				board.setBoard_subject(rs.getString("board_subject"));
				board.setBoard_dept(rs.getString("board_dept"));
				board.setBoard_name(rs.getString("board_name"));
				board.setBoard_readcount(rs.getInt("board_readcount"));
				board.setBoard_date(rs.getString("board_date"));
				board.setBoard_notice(rs.getString("board_notice"));
				board.setCnt(rs.getInt("cnt"));
				list.add(board);
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getMyBoardList() 에러: " + ex);
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
		return list;
	}

	
}
