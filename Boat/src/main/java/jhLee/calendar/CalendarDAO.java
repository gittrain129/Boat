package jhLee.calendar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CalendarDAO {
	
	private DataSource ds;


	public CalendarDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB연결 실패 :" + ex);
			return;
		}
		
	}
	public int insert(Calendarbean cal) {
		

		// TODO Auto-generated method stub
		return 0;
	}

	public int saveall(Calendarbean cal) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			con = ds.getConnection();

			
			String sql = "insert into boat_Calendar "
					+ "	values(cal_seq.nextval,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1,cal.getEvent_name() );
			pstmt.setString(2,cal.getStart_date());
			pstmt.setString(3,cal.getEnd_date());
			pstmt.setString(4,cal.getAllday());

			result = pstmt.executeUpdate();


			if(result ==1) {
				System.out.println("데이터 삽입이 모두완료되었습니다.");
			}
		} catch (Exception ex) {
			System.out.println("saveall() 에러: " + ex);
			
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

		return result;

	}
	public boolean caldelelte(String title) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "delete from boat_Calendar where title = ? ";
		
		boolean result_check = false;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, title);
			
			int count =pstmt.executeUpdate();
			
				if(count>=1)
					result_check=true;//삭제가 안된 경우에는false반환
			
			
		}catch(Exception ex) {
			System.out.println("caldelelte()에러:"+ex);
			
		}finally {
			if (pstmt!= null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		return result_check;
	}
	public List<Calendarbean> getCalList() {
		//		public List<Calendarbean> getCalList(empno) {


		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from  boat_Calendar ";
		//String sql = "select * from  boat_Calendar where empno = ? ";
		
		List<Calendarbean> list = new ArrayList<Calendarbean>();
		
		try {
			con = ds.getConnection();

			pstmt = con.prepareStatement(sql);

			//pstmt.setInt(1, empno);
			rs = pstmt.executeQuery();

			while (rs.next()) {// 더이상 읽을 데이터가 없을때까지 반복
				Calendarbean cal = new Calendarbean();// 각각의 컬럼 값을넣음

				cal.setAllday(rs.getString("event_name"));
				cal.setAllday(rs.getString("start_date"));
				cal.setAllday(rs.getString("end_date"));
				cal.setAllday(rs.getString("allday"));
				
				list.add(cal);
			}
			return list;

		} catch (Exception ex) {
			System.out.println("getCalList() 에러: " + ex);
			
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
