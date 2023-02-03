package jkKim;

public class jkKim_ActionForward {

	private boolean redirect=false;
	private String path=null;
	
	public String getPath() {
		return path;
	}
	public void setPath(String string) {
		path=string;
	}
	public jkKim_ActionForward() {
		
	}
	//프로퍼티 타입이 boolean인 경우 get대신 is를 붙일수 있습니다
	public boolean isRedirect() {
		return redirect;
	}
	
	public void setRedirect(boolean b) {
		redirect = b;
	}
}
