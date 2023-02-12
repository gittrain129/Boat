<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
   
  
<style>

* {
min-wight: 1200px;
}


div.logo{
	position: absolute;
    top: 0;
    margin-top:10px;
    left: 40px;
    z-index: 100;
    width: 10%;
    height: 28px;
    padding-top: 10px;
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
	z-index:10;
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
    float: right;
    top: 0;
    right: 20px;
    display: inline-block;
    text-decoration: none;
    color: black;
    text-align: right;
    font-size: 15px;
    
}

.login_header > div {
	padding:7px;
	font-size: 16px;
	font-weight: bold;
}

.menu01 a {
	width: 200px;
	text-decoration: none;
	color: black;
}

.dept01 a:nth-child(1) {font-weight: bold}
.dept01 a:nth-child(2) {font-weight: bold}
.dept01 a:nth-child(3) {font-weight: bold}

.dept01 a:nth-child(1):hover {color:#18a8f1}
.dept01 a:nth-child(2):hover {color: #18a8f1}
.dept01 a:nth-child(3):hover {color: #18a8f1}

.logo{z-index: 1}

.login_header > .dropdown_inout {
			display: inline-block;
            background: none;
            border-radius: 10px;
            border: black;
            margin-top: 15px;
}

.login_header > .dropdown_inout select{				
				border-radius: 10px;
				background-color: #f5de16;
                color:black;
                font-weight: 500;
                text-align-last: center;             
}

.login_nav {
	display: inline-block;
	text-decoration: none;
	color: black !important;
	font-weight: bold;
	font-size: 14px;
	margin-bottom:0;
}

li.login-item {
	text-decoration: none;
	color:black !important;
}


</style>
 <link rel="stylesheet" href="jhLee/css/heder.css">
 <script src="${pageContext.request.contextPath}/jhLee/js/header.js"></script>
<script src="${pageContext.request.contextPath}/sjKim/js/header.js"></script>
<input type="hidden" id="headerloginid" value="${empno}" name="headerloginid">

 		<div class="logo">       		
			<a href="${pageContext.request.contextPath}/index.jsp">
				<img src="${pageContext.request.contextPath}/sjKim/image/main_logo.jpg" style="float:left; width: 120px; height: 120px;">
			</a>					
		</div>
		
        <div class="topMenu">
        
            <ul class="menu01">
            
                <li><a href="${pageContext.request.contextPath}/map.cal" target="_self"><span>회사소개</span></a>
                    <ul class="dept01">
                    	<a href="${pageContext.request.contextPath}/map.cal" target="_self">
                        	<li id="nop">오시는길</li>
                        </a>
                        <li id="nop">&nbsp;</li>
                        <li id="nop">&nbsp;</li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/MyInfo.my" target="_self"><span>내 정보</span></a>
                    <ul class="dept01">
                    	<a href="${pageContext.request.contextPath}/MyInfo.my" target="_self">
                        	<li id="nop">내 정보 보기</li>
                        </a>
                        <a href="${pageContext.request.contextPath}/MyBoardList.my" target="_self">
                        	<li id="nop">내 &nbsp;글 &nbsp;보기</li>
                        </a>
                        <a href="${pageContext.request.contextPath}/MySchedule.my" target="_self">
                        	<li id="nop">내 할일 보기</li>
                        </a>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/BoardList.bo" target="_self"><span>게시판</span></a>
                    <ul class="dept01">
                    	<a href="${pageContext.request.contextPath}/BoardList.bo" target="_self">
                       		<li id="nop">업무 게시판</li>
                       	</a>
                       	<a href="${pageContext.request.contextPath}/FileBoardList.filebo" target="_self">
                       		<li id="nop">자료 게시판</li>
                        </a>
                        <li id="nop">&nbsp;</li>
                        
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/project_calendarstart.cal" target="_self"><span>공유업무</span></a>
                    <ul class="dept01">
                    	<a href="${pageContext.request.contextPath}/project_calendarstart.cal" target="_self">
                        	<li id="nop">캘린더</li>
                        </a>
                        <a href="${pageContext.request.contextPath}/jkKim/address.jk" target="_self">
                        	<li id="nop">주소록</li>
                        </a>
                         <li id="nop">&nbsp;</li>
                    </ul>
                </li>
				<li>
					<img src="${pageContext.request.contextPath}/sjKim/image/boat_icon.png" >
					<a href="${pageContext.request.contextPath}/jkKim/chat.jk" onclick="window.open(this.href, '_blank', 'width=400, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no'); return false;">
					<span>대화하기</span>
					</a>
                    <ul class="dept01">
                   <a href="${pageContext.request.contextPath}/jkKim/chat.jk" onclick="window.open(this.href, '_blank', 'width=400, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no'); return false;">
     					<li id="nop">채팅수신</li>
     				</a>
					<a href="${pageContext.request.contextPath}/jkKim/Sender_chat.jk" onclick="window.open(this.href, '_blank', 'width=400, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no'); return false;">
     				   	<li id="nop">채팅발신</li>
     				</a>
                    	<li id="nop">&nbsp;</li>
                    </ul>
                </li>
            </ul>
        </div>
        
        
        <div class="login_header">	
         	<div class="login_button">
		    	<ul class="login_nav" style="display: flex;">
		    		<c:if test="${!empty empno}">
		     	    	<li class="login-item" ><a class="login-link" style="color:black;">${empno}님이 로그인 되었습니다.</a></li>
		     	    	<li class="login-item" ><a class="login-link" style="color:black;"href="${pageContext.request.contextPath}/memberUpdate.net">&nbsp;| 정보수정 |</a></li>
		     	    	<c:if test="${empno=='ADMIN'}">
		     	    		<li class="login-item"><a class="login-link" style="color:black" href="${pageContext.request.contextPath}/jkKim/adminView.jk">&nbsp;관리자 |</a></li>
		     	    	</c:if>
		     			<li class="login-item"><a class="login-link" style="color:black;" href="${pageContext.request.contextPath}/logout.net">&nbsp;로그아웃</a></li>
		     		</c:if>
		     		
		     		<c:if test="${empty empno}">
		      			<li class="login-item"><a class="login-link" style="color:black;" href="${pageContext.request.contextPath}/login.net" target="_self">로그인 |&nbsp;</a></li> 
		      			<li class="login-item"><a class="login-link" style="color:black;" href="${pageContext.request.contextPath}/join.net" target="_self">회원가입</a></li> 
		      		</c:if>
		      		
		   	   </ul>
		    </div>
		  
			
		<script src="${pageContext.request.contextPath}/sjKim/js/inout.js"></script>			
		<script src="${pageContext.request.contextPath}/ejYang/js/myinfo.js"></script>			
			<div class="dropdown_inout">						
               <select id="inout" name="inout" onchange="select_inout()" style="border-color:transparent;" required autofocus>
               		<option value="" selected disabled hidden>출근현황</option>
				    <option style= "background-color: #18a8f1" value="출근" id="works">출근</option>
	                <option style= "background-color: #f5de16" value="외출" id="outs">외출</option>
	                <option style= "background-color: #ff5858" value="퇴근" id="leave">퇴근</option>
				</select>
	        </div>
		     
	       
		</div> 
