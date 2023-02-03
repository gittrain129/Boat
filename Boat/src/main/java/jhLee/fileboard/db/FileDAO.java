package jhLee.fileboard.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FileDAO {
	private DataSource ds;


	public FileDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB연결 실패 :" + ex);
			return;
		}
	}
	public int getListcount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;

		try {
			con = ds.getConnection();
			String sql = "select count(*) from file_board";
			pstmt = con.prepareStatement(sql);
			System.out.println(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}

		} catch (Exception e) {
			System.out.println("getListCount()에러: " + e);
			System.out.println(e.getMessage());
			e.getStackTrace();
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
				} catch (SQLException e) {

					System.out.println(e.getMessage());
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception e) {

					System.out.println(e.getMessage());
				}

		}

		return x;

	}
	public List<FileBean> getBoardList(int page, int limit) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		/*
		 * page : 페이지 limit :페이지 당 목록의 수 board_re_ref desc ,board_re_seqasc에 의한 정렬한 것을
		 * 조건절에 맞는 rnum의 범위만큼 가져오는 쿼리문입니다.
		 */
		String board_list_sql = " SELECT * FROM (select rownum rnum, j.* from ("
							+ " select board.*, nvl(CNT ,0) CNT "
							+ "from board left outer join (select comment_board_num,count(*) CNT  "
							+ "							from comm " 
							+ "							group by comment_board_num) "
							+ "					on board_num = comment_board_num " 
							+ "order by board_re_ref desc, " 
							+ "board_re_seq asc)j"
							+ " 				where rownum<=? ) "
							+ "WHERE rnum>=? and rnum<=?";

		System.out.println(board_list_sql);

		List<BoardBean> list = new ArrayList<BoardBean>();
		
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;

		try {
			con = ds.getConnection();

			pstmt = con.prepareStatement(board_list_sql);

			pstmt.setInt(1, endrow);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);
			rs = pstmt.executeQuery();

			while (rs.next()) {// 더이상 읽을 데이터가 없을때까지 반복
				FileBean filebo = new FileBean();// 각각의 컬럼 값을넣음

				filebo.setBOARD_NUM(rs.getInt("BOARD_NUM"));
				filebo.setBOARD_NAME(rs.getString("BOARD_NAME"));// 이름
				filebo.setBOARD_SUBJECT(rs.getString("BOARD_SUBJECT"));// 제목
				filebo.setBOARD_CONTENT(rs.getString("BOARD_CONTENT"));// 내용
				filebo.setBOARD_FILE(rs.getString("BOARD_FILE"));
				filebo.setBOARD_RE_REF(rs.getInt("BOARD_RE_REF"));
				filebo.setBOARD_RE_LEV(rs.getInt("BOARD_RE_LEV"));//
				filebo.setBOARD_RE_SEQ(rs.getInt("BOARD_RE_SEQ"));// 답글번호 원글-1
				filebo.setBOARD_RE_READCOUNT(rs.getInt("BOARD_READCOUNT"));
				filebo.setBOARD_DATE(rs.getString("BOARD_DATE"));// 날짜
				filebo.setCNT(rs.getInt("cnt"));
				list.add(filebo);// 각각의 로우를 넣음
			}
			return list;

		} catch (Exception ex) {
			System.out.println("getBoardList() 에러: " + ex);
			
			ex.printStackTrace();

		} finally {
			if (rs != null)
			try {
					rs.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			if (pstmt != null) {
			try {
					pstmt.close();// 꼭 닫아줘야함 ㅇㅇ
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			if (con != null)
			try {
					con.close();// 꼭 닫아줘야함 ㅇㅇ

			} catch (Exception e) {
				e.printStackTrace();
			}

			}
		}

		return list;

	}

}
