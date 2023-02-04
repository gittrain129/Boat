package jhLee.fileboard.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
	public List<FileboBean> getfileBoardList(int page, int limit) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		/*
		 * page : 페이지 limit :페이지 당 목록의 수 board_re_ref desc ,board_re_seqasc에 의한 정렬한 것을
		 * 조건절에 맞는 rnum의 범위만큼 가져오는 쿼리문입니다.
		 */
		String file_board_list_sql = "SELECT * FROM (select rownum rnum, j.* from ( "
				+ "							 select file_board.*, nvl(CNT ,0) CNT "
				+ "							from file_board left outer join (select F_COMMENT_NUM,count(*) CNT  "
				+ "														from FILE_COMMENT "
				+ "														group by F_COMMENT_NUM) "
				+ "												on FILE_NUM = F_COMMENT_NUM "
				+ "							order by FILE_RE_REF desc, "
				+ "							FILE_RE_SEQ asc)j "
				+ "							 				where rownum<=? ) "
				+ "							WHERE rnum>=? and rnum<=? ";

		System.out.println(file_board_list_sql);

		List<FileboBean> list = new ArrayList<FileboBean>();
		
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;

		try {
			con = ds.getConnection();

			pstmt = con.prepareStatement(file_board_list_sql);

			pstmt.setInt(1, endrow);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);
			rs = pstmt.executeQuery();

			while (rs.next()) {// 더이상 읽을 데이터가 없을때까지 반복
				FileboBean filebo = new FileboBean();// 각각의 컬럼 값을넣음

				filebo.setFILE_NUM(rs.getInt("FILE_NUM"));
				filebo.setFILE_NAME(rs.getString("FILE_NAME"));// 이름
				filebo.setFILE_SUBJECT(rs.getString("FILE_SUBJECT"));// 제목
				filebo.setFILE_CONTENT(rs.getString("FILE_CONTENT"));// 내용
				filebo.setFILE_FILE(rs.getString("FILE_FILE"));
				filebo.setFILE_FILE2(rs.getString("FILE_FILE2"));
				filebo.setFILE_RE_REF(rs.getInt("FILE_RE_REF"));
				filebo.setFILE_RE_LEV(rs.getInt("FILE_RE_LEV"));//
				filebo.setFILE_RE_SEQ(rs.getInt("FILE_RE_SEQ"));// 답글번호 원글-1
				filebo.setFILE_READCOUNT(rs.getInt("FILE_READCOUNT"));
				filebo.setFILE_DATE(rs.getString("FILE_DATE"));// 날짜
				filebo.setCNT(rs.getInt("CNT"));
				list.add(filebo);// 각각의 로우를 넣음
			}
			return list;

		} catch (Exception ex) {
			System.out.println("getfileBoardList() 에러: " + ex);
			
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
	public boolean fileboardInsert(FileboBean filedata) {

			Connection con = null;
			PreparedStatement pstmt = null;
			int result = 0;

			try {
				con = ds.getConnection();

				String max_sql = "(select nvl(max(FILE_NUM),0)+1 from file_board)";
				
				String sql = "insert into file_board "
						+ "(FILE_NUM , "
						+ "	FILE_NAME , "
						+ "	FILE_PASS, "
						+ "	FILE_SUBJECT,	"
						+ "	FILE_CONTENT ,	"
						+ "	FILE_FILE , "
						+ "	FILE_FILE2 ,	"
						+ "	FILE_RE_REF ,	"
						+ "	FILE_RE_LEV ,	"
			 			+ "	FILE_RE_SEQ , "
						+ "	FILE_READCOUNT, "
						+ " DEPT,"
						+ "FILE_DATE"
						
						+ "	) "
						+ "values ("+max_sql+",?,?,?,?,?,?,"+max_sql+",?,?,?,"+"'"+filedata.getDEPT()+"'"+",sysdate)";
				
				pstmt = con.prepareStatement(sql);
				System.out.println(sql);
				System.out.println(filedata.getDEPT());
				
				pstmt.setString(1, filedata.getFILE_NAME());
				pstmt.setInt(2, filedata.getFILE_PASS());
				pstmt.setString(3, filedata.getFILE_SUBJECT());
				pstmt.setString(4, filedata.getFILE_CONTENT());
				pstmt.setString(5, filedata.getFILE_FILE());
				pstmt.setString(6,filedata.getFILE_FILE2());
				pstmt.setInt(7, 0);
				pstmt.setInt(8, 0);
				pstmt.setInt(9, 0);

				result = pstmt.executeUpdate();


				if(result ==1) {
					System.out.println("데이터 삽입이 모두완료되었습니다.");
					return true;
				}
			} catch (Exception ex) {
				System.out.println("fileboardInsert() 에러: " + ex);
				
				ex.printStackTrace();

			} finally {
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

			return false;

		}
}
