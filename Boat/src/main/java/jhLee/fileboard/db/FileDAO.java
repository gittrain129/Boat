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
		
		//생성자 필드완
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
				filebo.setDEPT(rs.getString("DEPT"));
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
	public void setReadCountUpdate(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "update file_board set FILE_READCOUNT=FILE_READCOUNT+1 "
				+ "where FILE_NUM =? ";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);
			
			
			 pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("getBoardCountUpdate() 에러: " + ex);
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


	}
	public FileboBean getDetail(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FileboBean board = null;
		String sql ="select * from file_board where FILE_NUM =?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);
			
			
			 rs =  pstmt.executeQuery();
			 if(rs.next()) {
				  board = new FileboBean();
				  	board.setFILE_NUM(rs.getInt("FILE_NUM"));
					board.setFILE_NAME(rs.getString("FILE_NAME"));// 이름
					board.setFILE_PASS(rs.getInt("FILE_PASS"));// 비번
					board.setFILE_SUBJECT(rs.getString("FILE_SUBJECT"));// 제목
					board.setFILE_CONTENT(rs.getString("FILE_CONTENT"));// 내용
					board.setFILE_FILE(rs.getString("FILE_FILE"));// 파일 굳이 필요없음 지금은 웹에서 필요
					board.setFILE_FILE2(rs.getString("FILE_FILE2"));// 파일 굳이 필요없음 지금은 웹에서 필요

					// 원문의 경우 BOARD_RE_LEV,BOARD_RE_SEQ 의 필드값음 0입니다.

					board.setFILE_RE_REF(rs.getInt("FILE_RE_REF"));
					board.setFILE_RE_LEV(rs.getInt("FILE_RE_LEV"));//
					board.setFILE_RE_SEQ(rs.getInt("FILE_RE_SEQ"));// 답글번호 원글-1
					board.setFILE_READCOUNT(rs.getInt("FILE_READCOUNT"));
					board.setFILE_DATE(rs.getString("FILE_DATE"));// 날짜
					board.setDEPT(rs.getString("DEPT"));
					
					System.out.println(sql);

			 }
			 

		} catch (Exception ex) {
			System.out.println("getBoardCountUpdate() 에러: " + ex);
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
		return board;


	}
	public boolean isBoardWriter(int num, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		String board_sql = "select FILE_PASS from file_board where FILE_NUM = ? ";
		

		try {
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(board_sql);

			
			pstmt.setInt(1,num);
			rs=pstmt.executeQuery();

				if(rs.next()) {
					if(pass.equals(rs.getString("BOARD_PASS"))) {
						result = true;
					}
				}
		} catch (Exception ex) {
			System.out.println("isBoardWriter() 에러: " + ex);
			
			ex.printStackTrace();

		} finally {
			
			if (rs != null) {
				try {
					rs.close();// 꼭 닫아줘야함 ㅇㅇ
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (pstmt != null) 
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
		return result;
	}
	
	public boolean boardModify(FileboBean modifyboard) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "update file_board set FILE_SUBJECT=?, FILE_CONTENT=?, FILE_FILE = ? ,FILE_FILE2 =? "
				+ "where FILE_NUM =? ";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, modifyboard.getFILE_SUBJECT());
			pstmt.setString(2,modifyboard.getFILE_CONTENT());
			pstmt.setString(3, modifyboard.getFILE_FILE());
			pstmt.setString(4, modifyboard.getFILE_FILE2());
			pstmt.setInt(5, modifyboard.getFILE_NUM());
			int result = pstmt.executeUpdate();
			
			if(result ==1) {
				System.out.println("성공업데이트");
				return true;
			}
			

		} catch (Exception ex) {
			System.out.println("boardModify() 에러: " + ex);
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
	public List<FileboBean> getList(String dept, String search, String searchinput, String order, int page, int limit) {

		List<FileboBean>list = new ArrayList<FileboBean>();
		Connection con = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		try {
			con  = ds.getConnection();
			
			
		String sql =
		"  select * from "
		+ "				(select b.*, rownum rnum from "
		+ "					(select file_board.* , nvl(CNT ,0) "
		+ "					from file_board left outer join  "
		+ "					 				(select F_COMMENT_NUM ,count(*) as CNT from FILE_COMMENT group by F_COMMENT_NUM "
		+ "									order by  CNT desc) "
		+ "					on FILE_NUM = F_COMMENT_NUM "
		+ "					where dept = '개발팀' "
		+ "					and FILE_NAME = '이지현' "
		+ "				order by FILE_RE_REF desc "
		+ "				, FILE_READCOUNT desc )b "
		+ "				where rownum<=10 ) "
		+ "				where rnum>=1 and rnum<=10 ";
		
		
		System.out.println(sql);

		pstmt = con.prepareStatement(sql);
		//pstmt.setString(1,"%"+search_word+"%");
		
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;

		//pstmt.setInt(2, endrow);
		//pstmt.setInt(3, startrow);
		//pstmt.setInt(4, endrow);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			FileboBean m = new FileboBean();
			
			m.setDEPT(rs.getString("DEPT"));
			m.setCNT(rs.getInt("CNT"));
			m.setFILE_NUM(rs.getInt("FILE_NUM"));
			m.setFILE_NAME(rs.getString("FILE_NAME"));
			m.setFILE_SUBJECT(rs.getString("FILE_SUBJECT"));
			m.setFILE_CONTENT(rs.getString("FILE_CONTENT"));
			m.setFILE_FILE(rs.getString("FILE_FILE"));
			m.setFILE_FILE2(rs.getString("FILE_FILE2"));
			m.setFILE_RE_REF(rs.getInt("FILE_RE_REF"));
			m.setFILE_RE_LEV(rs.getInt("FILE_RE_LEV"));
			m.setFILE_RE_SEQ(rs.getInt("FILE_RE_SEQ"));
			m.setFILE_READCOUNT(rs.getInt("FILE_READCOUNT"));
			m.setFILE_DATE(rs.getString("FILE_DATE"));
			list.add(m);
		}
		System.out.println(list.size());
		
	} catch (Exception se) {
		se.printStackTrace();
		System.out.println("getList(4)에러 "+se);
	} finally {
		try {
			if (rs != null)
				rs.close();
		} catch (SQLException e) {

			System.out.println(e.getMessage());
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {

			System.out.println(e.getMessage());
		}
		try {
			if (con != null)
				con.close();
		} catch (Exception e) {

			System.out.println(e.getMessage());
		}

	}

	return list;
	}


}
