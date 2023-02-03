package ejYang;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	private DataSource ds;
	
	//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public BoardDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex){
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}

	//글의 갯수 구하기
	public int getListCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			conn = ds.getConnection();
			
			String sql = "select count(*) from BOARD";
			pstmt = conn.prepareStatement(sql);
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

	
	public List<BoardBean> getBoardList(int page, int limit) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String board_list_sql = "select rownum rnum, j.* "
				+ "			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT "
				+ "					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT "
				+ "												GROUP BY B_COMMENT_NUM)	"
				+ "					ON BOARD_NUM = B_COMMENT_NUM "
				+ "					WHERE BOARD_NOTICE = 'Y' "
				+ "					ORDER BY BOARD_RE_REF DESC, "
				+ "					BOARD_RE_SEQ ASC "
				+ "					) j "
				+ "			where rownum<= 3 "
				+ "UNION ALL "
				+ "select*from(select rownum rnum, j.*  "
				+ "			from (SELECT BOARD.*, NVL(CNT, 0) AS CNT "
				+ "					FROM BOARD LEFT OUTER JOIN (SELECT B_COMMENT_NUM, COUNT(*) CNT FROM BOARD_COMMENT "
				+ "												GROUP BY B_COMMENT_NUM)	"
				+ "					ON BOARD_NUM = B_COMMENT_NUM "
				+ "					ORDER BY BOARD_RE_REF DESC, "
				+ "					BOARD_RE_SEQ ASC "
				+ "					) j "
				+ "			where rownum<= ?) "
				+ "where rnum >= ? and rnum <= ? ";
		
		List<BoardBean> list = new ArrayList<BoardBean>();
		//한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지...
		int startrow = (page - 1) * limit + 1;	//읽기 시작할 row 번호(1  11 21 31 ...
		int endrow = startrow + limit -1;		//읽을 마지막 row 번호(10 20 30 40 ...
		try {
			conn = ds.getConnection();
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			
			pstmt = conn.prepareStatement(board_list_sql);
			pstmt.setInt(1, endrow);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean board = new BoardBean();
				board.setBoard_num(rs.getInt("board_num"));
				board.setBoard_name(rs.getString("board_name"));
				board.setBoard_subject(rs.getString("board_subject"));
				board.setBoard_content(rs.getString("board_content"));
				board.setBoard_dept(rs.getString("board_dept"));
				board.setBoard_re_ref(rs.getInt("board_re_ref"));
				board.setBoard_re_lev(rs.getInt("board_re_lev"));
				board.setBoard_re_seq(rs.getInt("board_re_seq"));
				board.setBoard_readcount(rs.getInt("board_readcount"));
				board.setBoard_date(rs.getString("board_date"));
				board.setBoard_notice(rs.getString("board_notice"));
				board.setCnt(rs.getInt("cnt"));;
				list.add(board);
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() 에러: " + ex);
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

	
	
	//글 등록하기
	public boolean boardInsert(BoardBean board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			conn = ds.getConnection();
			
			String max_sql = "(select nvl(max(board_num),0)+1 from BOARD)";
			
			//원문글의 BOARD_RE_REF 필드는 자신의 글번호 입니다.
			String sql = "insert into board "
					+ "(BOARD_NUM, BOARD_NAME, BOARD_PASS, "
					+ "BOARD_SUBJECT, BOARD_CONTENT, BOARD_RE_REF, "
					+ "BOARD_RE_LEV, BOARD_RE_SEQ, BOARD_READCOUNT, "
					+ "BOARD_NOTICE) "
					
					+ "values(" + max_sql + ",?,?, "
					+ "			?,?," + max_sql + ","
					+ "			?,?,?,"
					+ "			?)";
			
			//새로운 글을 등록하는 부분입니다.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBoard_name());
			pstmt.setString(2, board.getBoard_pass());
			pstmt.setString(3, board.getBoard_subject());
			pstmt.setString(4, board.getBoard_content());
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);
			pstmt.setString(8, board.getBoard_notice());
			
			result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("데이터 삽입이 모두 완료되었습니다.");
				return true;
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("boardInsert() 에러: " + ex);
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
		return false;
	}

	
	
	//조회수 업데이트 - 글번호에 해당하는 조회수를 1 증가합니다.
	public void setReadCountUpdate(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "update board "
				+ "set board_readcount = board_readcount + 1 "
				+ "where board_num = ? ";
		
		try {
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("setReadCountUpdate() 에러: " + ex);
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
	}//end

	
	//글 내용 보기
	public BoardBean getDetail(int num) {
		BoardBean board=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			conn = ds.getConnection();
			
			String sql = "select*from board "
					+ "where board_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardBean();
				board.setBoard_num(rs.getInt("board_num"));
				board.setBoard_name(rs.getString("board_name"));
				board.setBoard_subject(rs.getString("board_subject"));
				board.setBoard_content(rs.getString("board_content"));
				board.setBoard_file(rs.getString("board_file"));
				board.setBoard_re_ref(rs.getInt("board_re_ref"));
				board.setBoard_re_lev(rs.getInt("board_re_lev"));
				board.setBoard_re_seq(rs.getInt("board_re_seq"));
				board.setBoard_readcount(rs.getInt("board_readcount"));
				board.setBoard_date(rs.getString("board_date"));
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getDetail() 에러: " + ex);
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
		return board;
	}//

	
	//글쓴이인지 확인 - 비밀번호로 확인합니다.
	public boolean isBoardWriter(int num, String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		String board_sql = "select board_pass from board where board_num = ? ";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(board_sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pass.equals(rs.getString("board_pass"))) {
					result = true;
				}
			}
		}catch(Exception ex) {
			System.out.println("isBoardWriter() 에러: " + ex);
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

	
	
	public boolean boardModify(BoardBean modifyboard) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "update board "
				+ "set board_subject=?, board_content=?, board_file=? "
				+ "where board_num = ? ";
		
		try {
			//context.xml에서 설정한 리소스 jdbc/OracleDB 참조하여 Connection 객체를 얻어 옵니다.
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, modifyboard.getBoard_subject());
			pstmt.setString(2, modifyboard.getBoard_content());
			pstmt.setString(3, modifyboard.getBoard_file());
			pstmt.setInt(4, modifyboard.getBoard_num());
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("성공 업데이트");
				return true;
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("boardModify() 에러: " + ex);
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
		return false;
	}

	
	//글 답변
	public int boardReply(BoardBean board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		
		//board 테이블의 글번호를 구하기 위해 board_num 컬럼의 최대값+1을 구해옵니다.
		String board_max_sql = "select max(board_num)+1 from board";
		/*
		 * 답변을 달 원문 글 그룹 번호입니다.
		 * 답변을 달게 되면 답변 글은 이 번호와 같은 관련글 번호를 갖게 처리되면서 같은 그룹에 속하게 됩니다.
		 * 글 목록에서 보여줄때 하나의 그룹으로 묶여서 출력됩니다.
		 */
		int re_ref = board.getBoard_re_ref();
		/*
		 * 답글의 깊이를 의미합니다.
		 * 원문에 대한 답글이 출력될 때 한 번 들여쓰기 처리가 되고 답글에 대한 답글은 들여쓰기가 두 번 처리되게 합니다.
		 * 원문인 경우에는 이 값이 0이고 원문의 답글은 1, 답글의 답글은 2가 됩니다. 
		 */
		int re_lev = board.getBoard_re_lev();
		
		//같은 관련 글 중에서 해당 글이 출력되는 순서입니다.
		int re_seq = board.getBoard_re_seq();
		
		try {
			conn = ds.getConnection();
			
			//트랜잭션을 이용하기 위해서 setAutoCommit을 false로 설정합니다.
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(board_max_sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
			pstmt.close();
			
			//BOARD_RE_REF, BOARD_RE_SEQ 값을 확인하여 원문 글에 답글이 달려있다면
			//달린 답글들의 BOARD_RE_SEQ값을 1씩 증가시킵니다.
			//현재 글을 이미 달린 답글보다 앞에 출려되게 하기 위해서 입니다.
			String sql = "update board "
					+ "set BOARD_RE_SEQ=BOARD_RE_SEQ + 1 "
					+ "where BOARD_RE_REF = ? "
					+ "and BOARD_RE_SEQ > ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setInt(2, re_seq);
			pstmt.executeUpdate();
			pstmt.close();
			
			//등록할 답변 글의 BOARD_RE_LEV, BOARD_RE_SEQ 값을 원문 글보다 1씩 증가시킵니다.
			re_seq = re_seq + 1;
			re_lev = re_lev + 1;
			
			sql = "		insert into board "
					+ "(board_num, board_name, board_pass, board_subject, "
					+ "board_content, board_file, board_re_ref, "
					+ "board_re_lev, board_re_seq, board_readcount) "
					+ "values(" + num + ","
					+ "		?,?,?,"
					+ "		?,?,?,"
					+ "		?,?,?)";
			
			//새로운 글을 등록하는 부분입니다.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBoard_name());
			pstmt.setString(2, board.getBoard_pass());
			pstmt.setString(3, board.getBoard_subject());
			pstmt.setString(4, board.getBoard_content());
			pstmt.setString(5, "");	//답변에는 파일을 업로드하지 않습니다.
			pstmt.setInt(6, re_ref);//원문의 글번호
			pstmt.setInt(7, re_lev);
			pstmt.setInt(8, re_seq);
			pstmt.setInt(9, 0);//board_readcount(조회수)는 0
			if(pstmt.executeUpdate() == 1) {
				conn.commit();//commit합니다.
			}else {
				conn.rollback();
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
			System.out.println("boardReply() 에러: " + ex);
			if(conn != null) {
				try {
					conn.rollback();
				}catch(SQLException e) {
					e.getMessage();
				}
			}
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
					conn.setAutoCommit(true);
					conn.close(); 	
				}catch(Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		return num;
	}

	
	//글 삭제
	public boolean boardDelete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null, pstmt2 = null;
		ResultSet rs = null;
		String select_sql = "select board_re_ref, board_re_lev, board_re_seq from board "
				+ "where board_num = ?";
		
		String board_delete_sql = "delete board "
						+ "where board_re_ref = ? "
						+ "and 	 board_re_lev >=? "
						+ "and 	 board_re_seq >=? "
						+ "and 	 board_re_seq <=( "
						+ "						nvl((select min(board_re_seq)-1 from board "
						+ "							where board_re_ref = ? "
						+ "							and   board_re_lev = ? "
						+ "							and   board_re_seq > ?), "
						+ "							(select max(board_re_seq) from board "
						+ "								where board_re_ref=? ))"
						+ "						)";
		boolean result_check = false;
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(select_sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pstmt2 = conn.prepareStatement(board_delete_sql);
				pstmt2.setInt(1, rs.getInt("board_re_ref"));
				pstmt2.setInt(2, rs.getInt("board_re_lev"));
				pstmt2.setInt(3, rs.getInt("board_re_seq"));
				pstmt2.setInt(4, rs.getInt("board_re_ref"));
				pstmt2.setInt(5, rs.getInt("board_re_lev"));
				pstmt2.setInt(6, rs.getInt("board_re_seq"));
				pstmt2.setInt(7, rs.getInt("board_re_ref"));
				
				int count=pstmt2.executeUpdate();
				
				if(count>=1)
					result_check = true;//삭제가 안된 경우에는 false를 반환합니다.
			}
		}catch(Exception ex) {
			System.out.println("boardDelete() 에러: " + ex);
			ex.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close(); 	
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
			
			try {
				if(pstmt != null)
					pstmt.close(); 	//4단계 : DB연결을 끊는다.
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
			
			try {
				if(conn != null)
					conn.close(); 	//4단계 : DB연결을 끊는다.
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
		
		return result_check;
	}

	
}
