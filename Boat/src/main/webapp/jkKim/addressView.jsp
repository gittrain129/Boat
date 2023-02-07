<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <script src=${pageContext.request.contextPath}/jkKim/js/addressView2.js></script>
  <head>
 
  
    
<title>카드형식 뷰</title>

   <style>
      p { margin:20px 0px; }
      
      body {
    margin-top: 10%;
		}
		

    </style>
 
  </head>
  
  <body>
  <header>
  <jsp:include page="/sjKim/boat/header.jsp" />
  </header>
  
    <div class="container"> <!-- 카드+ 페이지 전체포함한 div -->
    
	<c:if test="${listcount > 0 }">
	
	  <!-- 부서선택 셀렉트 바-->
  <div class="rows" style="position:absolute; right:100px;">
   <select class="form-control" id="dept" >
  <option selected value="1">모든부서</option>
  <option value="2">홍보팀</option>
  <option value="3">개발팀</option>
  <option value="4">인사팀</option>
  <option value="5">기획팀</option>
  <option value="6">영업팀</option>
	</select>
	</div>
	<!-- 부서선택 셀렉트 바 끝 -->
	
	
	
  		<div id="whole-body">
      <div class="row" id="cardbody"> <!--  카드 포함한 div -->
      
      <c:forEach var="m" items="${memberlist }">
      <!-- 1인 카드 시작 -->
      
        <div class="col-3">
          <p>${m.dept }</p>
          <div class="card">
            <div class="card-header">
              ${m.name }
            </div>
            <img src=${pageContext.request.contextPath}${m.imgsrc} width="100%"/>
            <div class="card-body">
              <h5 class="card-title">조장</h5>
              <p class="card-text">이메일: ${m.email }</p>
              <a href="#" class="btn btn-primary">More</a>
              <!-- onClick 이메일로 연결하기 -->
            </div> <!-- 카드바디 3가지 끝 -->
          </div> <!--  카드헤더 끝 -->
        </div> <!-- 카드 전체 끝 -->
        <!-- 1인카드 끝 -->
        
    
        </c:forEach>
      </div>
      </div>
     
      <br>
      
      
      <div class="center-block">
		<ul class="pagination pagination-sm justify-content-center">
			<c:if test="${page <=1 }">
				<li class="page-item">
				<a class= "page-link gray">이전 &nbsp;</a></li>
			</c:if>
			<c:if test="${page >1 }">
			<li class="page-item">
				<a href="address.jk?page=${page-1 }" class="page-link">이전 &nbsp;</a></li>
			</c:if>
			
			<c:forEach var="a" begin="${startpage }" end="${endpage }">
				<c:if test="${a == page }">
					<li class="page-item active">
						<a class="page-link">${a }</a>
					</li>
				</c:if>
				<c:if test="${a !=page }">
				<li class="page-item">
					<a href="address.jk?page=${a }" class="page-link">${a }</a>
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
					<a href="address.jk?page=${page+1 }"
					class="page-link">&nbsp;다음</a>
				</li>
			</c:if>
		</ul>
	</div>
	  
    
    </c:if> <%-- <c:if test="${listcount >0 }">   end --%>
    </div>
    <%-- 회원이 없는 경우 --%>
	<c:if test="${listcount ==0 }">
		<h3 style="text-align:center">등록된 유저가 없습니다</h3>
	</c:if>
	
	<div class="container">
            <div class="row">
            <input type='text' name='search' id='search' class=" col-8 ml-3">
            <button class="btn btn-info" name='search-btn' id='search-btn'>검색</button>
         </div>
      
   </div>
   <footer>
    <jsp:include page="/sjKim/boat/footer.jsp" /> 
   </footer>
   
  </body>
  
  </html>
