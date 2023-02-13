<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
  <head>
  <title>관리자모아보기</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <script src=${pageContext.request.contextPath}/jkKim/js/adminView.js></script>
 <style>
 
#dept{
 width: 150px;

 
 }
  body> p { margin:20px 0px; }
      
      
      
      body {
    margin-top: 10%;
		}
 
#ori-email-tag:hover{
cursor:pointer;
text-decoration:underline; color:#8600E4
}

#onclickpart1:hover{
cursor:pointer;
opacity:0.6;
}
#onclickpart2:hover{
cursor:pointer;
opacity:0.6;
}
#onclickpart3:hover{
cursor:pointer;
opacity:0.6;
}
 
 </style>

  <jsp:include page="/sjKim/boat/header.jsp" />
  </head>
  
  <body>
 
    <div class="container"> <!-- 카드+ 페이지 전체포함한 div -->
    
	<c:if test="${listcount > 0 }">
	

	
	
	
  		<div id="whole-body">
      <div class="row" > <!--  카드 포함한 div -->

	  <!-- 부서선택 셀렉트 바-->
  <div id="blocking" style=width:15%;>
   <select class="form-control" id="dept" >
  <option selected value="1">모든부서</option>
  <option value="2">홍보팀</option>
  <option value="3">개발팀</option>
  <option value="4">인사팀</option>
  <option value="5">기획팀</option>
  <option value="6">영업팀</option>
	</select>	
	</div>
	
	<div class="container" id="search_body2" style="width:50%; position:relative; left:315px;">
            <div class="row">
            <input type='text' name='search' id='search' class=" col-8 ml-3">
            <button class="btn btn-info" name='search-btn' id='search-btn'>검색</button>
         </div>
      
   </div>
	
	<!-- 부서선택 셀렉트 바 끝 -->

     <div class="row" id="cardbody">
      <c:forEach var="m" items="${memberlist }">
      <!-- 1인 카드 시작 -->
      
        <div class="col-3" id="bodybody">
          <p> </p>
          <div class="card">
          
            <div class="card-header" onclick="send_empno2()" id="onclickpart1">
              ${m.dept }
            </div>
            <img src=${pageContext.request.contextPath}${m.imgsrc} id="onclickpart2" onclick="send_empno2()" onerror="this.src='${pageContext.request.contextPath}/image/ano.png'" style="object-fit:cover;" />
            <div class="card-body">
              <h5 class="card-title" id="onclickpart3" onclick="send_empno2()" >${m.name }</h5>
              <p class="card-text" id="ori-email-tag" onclick="send_empno()" style="z-index:50;">이메일: ${m.email }</p>
              <form name="empnoform" id="email-tag" method="post"  action="${pageContext.request.contextPath}/email.ne" style="display:none">
              <input type=radio id="empno" name="empno" style="display:none" value=${m.empno } checked></input>
              </form>
              <form name="empnoform2" id="empno-tag" method="post"  action="${pageContext.request.contextPath}/memberInfo.net" style="display:none">
              <input type=radio id="empno" name="empno" style="display:none" value=${m.empno } checked></input>
              </form>
              <!-- <a href="#" class="btn btn-primary">More</a>  -->
              <!-- onClick 이메일로 연결하기 -->
            </div> <!-- 카드바디 3가지 끝 -->
          </div> <!--  카드헤더 끝 -->
        </div> <!-- 카드 전체 끝 -->
        <!-- 1인카드 끝 -->
        
    
        </c:forEach>
        </div>
      </div>
      </div>
     
      <br>
      
      
      <div class="center-block" >
		<ul class="pagination justify-content-center">
			<c:if test="${page <=1 }">
				<li class="page-item">
				<a class= "page-link gray">이전 &nbsp;</a></li>
			</c:if>
			<c:if test="${page >1 }">
			<li class="page-item">
				<a href="adminView.jk?page=${page-1 }" class="page-link">이전 &nbsp;</a></li>
			</c:if>
			
			<c:forEach var="a" begin="${startpage }" end="${endpage }">
				<c:if test="${a == page }">
					<li class="page-item active">
						<a class="page-link">${a }</a>
					</li>
				</c:if>
				<c:if test="${a !=page }">
				<li class="page-item">
					<a href="adminView.jk?page=${a }" class="page-link">${a }</a>
				</li>
				</c:if>		
			</c:forEach>
			
			<c:if test="${page>= maxpage }">
				<li class="page-item">
					<a class="page-link gray">&nbsp;다음</a>
				</li>
			</c:if>
			<c:if test="${page < maxpage }">
				<li class="page-item">
					<a href="adminView.jk?page=${page+1 }"
					class="page-link">&nbsp;다음</a>
				</li>
			</c:if>
		</ul>
	</div>
	   
    
    </c:if> <%-- <c:if test="${listcount >0 }">   end --%>
     <br>
	    <br>
	    <br>
    </div>
    <%-- 회원이 없는 경우 --%>
	<c:if test="${listcount ==0 }">
		<h3 style="text-align:center">등록된 유저가 없습니다</h3>
	</c:if>
	
	
   <footer>
    <jsp:include page="/sjKim/boat/footer.jsp" /> 
   </footer>
   
     <script>
   function send_empno(){
	   document.getElementById('email-tag').submit();
	  
	}
   
   function send_empno2(){
	   document.getElementById('empno-tag').submit();
	  
	}
   
   
   </script>
   
  </body>
  
  </html>
