package jhLee.calendar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CalendarDAO {

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

			
			String sql = "insert into boat_Calendar \r\n"
					+ "	values(cal_seq.nextval,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1,cal.get.getId() );
			pstmt.setString(2,co.getContent());
			pstmt.setInt(3,co.getComment_board_num() );
			pstmt.setInt(4,co.getComment_re_lev());
			pstmt.setInt(5,co.getComment_re_seq());

			result = pstmt.executeUpdate();


			if(result ==1) {
				System.out.println("데이터 삽입이 모두완료되었습니다.");
			}
		} catch (Exception ex) {
			System.out.println("commentsInsert() 에러: " + ex);
			
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

}
