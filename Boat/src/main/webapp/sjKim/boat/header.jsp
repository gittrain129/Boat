<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
<style>



div.logo{
	position: absolute;
    top: 0;
    margin-top:15px;
    left: 40px;
    z-index: 100;
    width: 10%;
    height: 28px;
    padding-top: 15px;
}


li {
	list-style: none; 
}

                       
.topMenu {
	position: absolute;
	top:0;
	width: 70%; 
	margin-top: 40px;
	margin-bottom: 20px; 
	text-align: center; 
	height: 40px; 
	left:10%;
	}
	
.topMenu:after {
	content: ""; 
	display: block; 
	clear: both; 
	 
	}
	
.menu01>li {

	float: left; 
	width: 20%; 
	line-height: 40px; 
	}
	
.menu01 span {
	font-size: 20px; 
	font-weight: bold; 
	}

.point {
	left:120px;
	
}
            
.dept01 {	
	position: absolute; 
	top: 60px; 
	display: none; 
	width: 20%; 
	 padding: 20px 0; 
	 border-bottom: 1px solid #ccc; 
	 background: #fff;
	}
            
#nop {
	float: none; 
	}
            
.none:after {
	content: ""; 
	display: block; 
	clear: both; 
	}

.menu01 img {
 width:25px;
 height:25px;
}	

.login_header{
	position: absolute;
	top:0;
	width:10%;
	right: 20px;
	margin-top: 62px;
	display:flex;
	width:250px;	
}

.login_header > div {
padding:7px;
}

a {
	width: 200px;
	text-decoration: none;
	color: black;
}

</style>

<script src="../js/header.js"></script>

 		<div class="logo">       		
			<a href="https://localhost8088">
				<img src="../image/main_logo.jpg" style="float:left; width: 120px; height: 120px;">
			</a>					
		</div>
		
        <div class="topMenu">
        
            <ul class="menu01">
            
                <li><span>회사소개</span>
                    <ul class="dept01">
                    	<a href="https://www.naver.com" target="_self">
                        	<li id="nop">오시는길</li>
                        </a>
                        <li id="nop">&nbsp;</li>
                        <li id="nop">&nbsp;</li>
                    </ul>
                </li>
                <li><span>내 정보</span>
                    <ul class="dept01">
                    	<a href="https://www.naver.com" target="_self">
                        	<li id="nop">내 정보 보기</li>
                        </a>
                        <a href="https://www.naver.com" target="_self">
                        	<li id="nop">내 &nbsp;글 &nbsp;보기</li>
                        </a>
                        <a href="https://www.naver.com" target="_self">
                        	<li id="nop">내 할일 보기</li>
                        </a>
                    </ul>
                </li>
                <li><span>게시판</span>
                    <ul class="dept01">
                    	<a href="https://www.naver.com" target="_self">
                       		<li id="nop">업무 게시판</li>
                       	</a>
                       	<a href="https://www.naver.com" target="_self">
                       		<li id="nop">자료 게시판</li>
                        </a>
                        <li id="nop">&nbsp;</li>
                        
                    </ul>
                </li>
                <li><span>공유업무</span>
                    <ul class="dept01">
                    	<a href="https://www.naver.com" target="_self">
                        	<li id="nop">캘린더</li>
                        </a>
                        <a href="https://www.naver.com" target="_self">
                        	<li id="nop">주소록</li>
                        </a>
                         <li id="nop">&nbsp;</li>
                    </ul>
                </li>
				<li>
					<img src="../image/boat_icon.png" >
					<a href="https://www.naver.com" target="_self">
					<span>대화하기</span>
					</a>
                    <ul class="dept01">
                    	<li id="nop">&nbsp;</li>
                    	<li id="nop">&nbsp;</li>
                    	<li id="nop">&nbsp;</li>
                    </ul>
                </li>
            </ul>
        </div>
        
        
        <div class="login_header">	
        	<div class="login_button">
        	<a href="https://www.naver.com" target="_black">
				<span>로그인</span>	
			</a>
			</div>
			<div class="join_button">
        	<a href="https://www.naver.com" target="_black">
				<span>회원가입</span>	
			</a>
			</div>
			<div class="status_button">						
                <li><button>출근</button></li>
                <li><button>퇴근</button></li>
                <li><button>외출</button></li>
	        </div>
		</div> 
