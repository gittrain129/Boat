<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
  <head>
  <jsp:include page="header_test.jsp"/>
    <meta charset="utf-8">
    <title>카드형식 뷰</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <style>
      p { margin:20px 0px; }
    </style>
  </head>
  <body>
  <!-- 부서선택 셀렉트 바-->
  <div class="rows" style="position:absolute; right:100px;">
  <span> 검색 </span>
  <select class="form-select" aria-label="Default select example" id="dept_value">
  <option selected>부서명</option>
  <option value="1">모두보기</option>
  <option value="2">홍보팀</option>
  <option value="3">개발팀</option>
  <option value="4">인사팀</option>
  <option value="5">기획팀</option>
  <option value="6">영업팀</option>
	</select>
	</div>
	<!-- 부서선택 셀렉트 바 끝 -->
	
	
    <div class="container">
      <div class="row">
      <!-- 1인 카드 시작 -->
        <div class="col-3">
          <p>개발팀</p>
          <div class="card">
            <div class="card-header">
              김정근1
            </div>
            <img src="/Boat/jkKim/image/image_sample.png" width="100%"/>
            <div class="card-body">
              <h5 class="card-title">조장</h5>
              <p class="card-text">이메일: geo_webhard@naver.com</p>
              <a href="#" class="btn btn-primary">More</a>
              <!-- onClick 이메일로 연결하기 -->
            </div> <!-- 카드바디 3가지 끝 -->
          </div> <!--  카드헤더 끝 -->
        </div> <!-- 카드 전체 끝 -->
        <!-- 1인카드 끝 -->
        
          <!-- 1인 카드 시작 -->
        <div class="col-3">
          <p>홍보팀</p>
          <div class="card">
            <div class="card-header">
              김정근2
            </div>
            <img src="/Boat/jkKim/image/image_sample.png" width="100%"/>
            <div class="card-body">
              <h5 class="card-title">조장</h5>
              <p class="card-text">이메일: geo_webhard@naver.com</p>
              <a href="#" class="btn btn-primary">More</a>
            </div> <!-- 카드바디 3가지 끝 -->
          </div> <!--  카드헤더 끝 -->
        </div> <!-- 카드 전체 끝 -->
        <!-- 1인카드 끝 -->
        
             <!-- 1인 카드 시작 -->
        <div class="col-3">
          <p>인사팀</p>
          <div class="card">
            <div class="card-header">
              김정근3
            </div>
            <img src="/Boat/jkKim/image/image_sample.png" width="100%"/>
            <div class="card-body">
              <h5 class="card-title">조장</h5>
              <p class="card-text">이메일: geo_webhard@naver.com</p>
              <a href="#" class="btn btn-primary">More</a>
            </div> <!-- 카드바디 3가지 끝 -->
          </div> <!--  카드헤더 끝 -->
        </div> <!-- 카드 전체 끝 -->
        <!-- 1인카드 끝 -->
        
              <!-- 1인 카드 시작 -->
        <div class="col-3">
          <p>기획팀</p>
          <div class="card">
            <div class="card-header">
              김정근4
            </div>
            <img src="${pageContext.request.contextPath}image/image_sample.png" width="100%"/>
            <div class="card-body">
              <h5 class="card-title">조장</h5>
              <p class="card-text">이메일: geo_webhard@naver.com</p>
              <a href="#" class="btn btn-primary">More</a>
            </div> <!-- 카드바디 3가지 끝 -->
          </div> <!--  카드헤더 끝 -->
        </div> <!-- 카드 전체 끝 -->
        <!-- 1인카드 끝 -->
        
              <!-- 1인 카드 시작 -->
        <div class="col-3">
          <p>영업팀</p>
          <div class="card">
            <div class="card-header">
              김정근5
            </div>
            <img src="${pageContext.request.contextPath}/image/image1.png" width="100%"/>
            <div class="card-body">
              <h5 class="card-title">조장</h5>
              <p class="card-text">이메일: geo_webhard@naver.com</p>
              <a href="#" class="btn btn-primary">More</a>
            </div> <!-- 카드바디 3가지 끝 -->
          </div> <!--  카드헤더 끝 -->
        </div> <!-- 카드 전체 끝 -->
        <!-- 1인카드 끝 -->
        
      </div>
    </div>
  </body>
</html>
