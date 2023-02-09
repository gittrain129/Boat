//*** 데이터 빈(DataBean) 클래스 작성 ***
package ejYang.myinfo;

public class MyBoardBean {
	private int		rnum;			//페이징 처리 글번호
	private int		board_num;		//글번호
	private String	board_subject;	//글 제목
	private String	board_dept;		//글 내용
	private String	board_name;		//글 작성자
	private int		board_readcount;//글의 조회수
	private String	board_date;		//작성 날짜
	private String	board_notice;	//공지사항/파일명(카테고리 판단)
	private int		cnt;			//댓글
	
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_subject() {
		return board_subject;
	}
	public void setBoard_subject(String board_subject) {
		this.board_subject = board_subject;
	}
	public String getBoard_dept() {
		return board_dept;
	}
	public void setBoard_dept(String board_dept) {
		this.board_dept = board_dept;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public int getBoard_readcount() {
		return board_readcount;
	}
	public void setBoard_readcount(int board_readcount) {
		this.board_readcount = board_readcount;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date.substring(0,10);
	}
	public String getBoard_notice() {
		return board_notice;
	}
	public void setBoard_notice(String board_notice) {
		this.board_notice = board_notice;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
}
