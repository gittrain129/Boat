package jkKim.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class jkKim_MemberDAO {
	
	private DataSource ds;

	// 생ㅅ어자에서 JNDI리소스를 참조하여 Connection객체를 얻어옵니다
	public jkKim_MemberDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("db연결 실패: " + ex);
		}
	} //생성자end
	
	public int addressview() {
		return 0;
	}

	public List<jkKim_Member> getMemberList(int page, int limit) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getListCount() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	
	
}
