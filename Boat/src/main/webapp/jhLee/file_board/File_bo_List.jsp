<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head> 
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="jhLee/css/filelist.css">
    
    <title>자료게시판 목록보기</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="herder.jsp"/>
</head>
<body>
    <div class="container">
    <div class = "File_board_list_wrap">
        <div class="File_board_Title">
            <Strong>자료실 게시판</Strong>
            <p>자료실 게시판 입니다.</p>

        </div>
       
        
        <input class ="search" type="text">
        <div class="btn-group search">
            <button type="button" class="btn btn-secondary">검색옵션</button>
            <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">
            </button>
            
            
            <div class="dropdown-menu">
                <a class="dropdown-item" href="#">작성자</a>
                <a class="dropdown-item" href="#">제목</a>
            </div>
        </div>

        <table class="File_board_list">
            <caption>자료 게시판 목록</caption>
            <thead>
	             <tr>
				    <th colspan="4">File 게시판 - list</th>
		    		<th colspan="3">
		    			<span>글 개수 : ${listcount}</span>
		    		</th>
			  </tr> 
                <tr>
                    <th><div>번호</div></th>
                    <th><div>제목</div></th>
                    <th><div>부서</div></th>
                    <th><div>작성자</div></th>
                    <th><div>조회수</div></th>
                    <th><div>작성일자</div></th>
                    <th><div>자료</div></th>
                </tr>
            </thead>
            <tbody>
            	<c:set var = "num" value ="${listcount-(page-1)*limit }"/>
				<c:forEach var="b" items="${boardlist}">
				<tr>
					<td><%--번호 --%>
					<c:out value="${num}"/><%--num출력 --%>
					<c:set var ="num" value="${num-1}"/><%--num =num-1의 의미 --%>
					</td>
					<td><%--제목 --%>
					
					<div>
						<c:if test ="${b.FILE_RE_LEV !=0}"><%--답글인 경우 --%>
			
						<c:forEach var ="a" begin="0" end="${b.FILE_RE_LEV*2}" step="1">
							&nbsp;
						</c:forEach>
						<img alt="들여쓰기" src="image/line.gif">
					</c:if>
			
						<c:if test="${b.FILE_RE_LEV==0}"><%--원문인 경우 --%>
							&nbsp;
						</c:if>
					
						<a href ="FileBoadrdDetailAction.filebo?num=${b.FILE_NUM}">
							<c:if test="${b.FILE_SUBJECT.length()>=20}">
								<c:out value="${b.FILE_SUBJECT.substring(0,20)}..."/>
							</c:if>
						<c:if test="${b.FILE_SUBJECT.length()<20}">
							<c:out value="${b.FILE_SUBJECT}"/>
						</c:if>
						</a>[${b.CNT}]
					</div><%--제목 --%>
				</td>
			
				<td><div>${b.FILE_NAME}</div></td>
				<td><div>${b.FILE_READCOUNT}</div></td>
				<td><div>${b.FILE_DATE}</div></td>
				<td><div class = "file1">${b.FILE_FILE}</div><div class = "file1">${b.FILE_FILE2}</div></td>
				</tr>
				</c:forEach>
            	
            </tbody>
        </table>
        
    
     

       <div class="File_board_page">


   <p class="paging">
   	<c:if test="${page<=1}">
     <a href="#" class="btnPage gray"><img src="jhLee/image/pre.png" alt="이전10개" width="10px"></a>
   	</c:if>
   	<c:if test="${page>1}">
     <a href="FileBoardList.filebo?page=${page-1}" class="btnPage"><img src="jhLee/image/pre.png" alt="이전10개" width="10px"></a>
   	</c:if>
   	
 
   	<c:forEach var="a" begin="${startpage}" end="${endpage}">
   		<c:if test="${a==page}">
     		<span class="num"><a href="#" class="firstItem">${a}</a> </span> 
   		</c:if>
   		<c:if test="${a !=page}">
     		<span class="num"><a href="BoardList.bo?page=${a}" class="">${a}</a> </span> 
   		</c:if>
   		</c:forEach>
   	
   	<c:if test="${page>=maxpage }">
     <a href="#" class="btnPage gray"><img src="jhLee/image/next.png" alt="다음10개" /></a>
   	</c:if>
   	<c:if test="${page<maxpage}">
	     <a href="FileBoardList.filebo?page=${page+1}" class="btnPage"><img src="jhLee/image/next.png" alt="다음10개" /></a>
   	</c:if>
   </p>
   
        </div>
   <%--게시글이 없는 경우 --%>
	<c:if test="${listcount==0}">
		<h3 style="text-align: center">등록된 글이 없습니다.</h3>
	</c:if>
		   <!-- <div class="bt_wrap">
            <div class="form-group">
                <select class="form-control" id="sel1" name="sellist1">
                <option value="">최신순 </option>
                <option value="">조회순 </option>
                <option value="">댓글순 </option>
            </select>
        </div>
    </div> -->
    <div class="btntwo">
 
    <div class="btn-group">
        <button type="button" class="btn btn-secondary">부서별</button>
        <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">
        </button>
        
   
        <div class="dropdown-menu">
            <a class="dropdown-item" href="#">홍보부</a>
            <a class="dropdown-item" href="#">기획부</a>
            <a class="dropdown-item" href="#">마케팅부</a>
        </div>
    </div>
        <div class="btn-group">
            <button type="button" class="btn btn-secondary">정렬</button>
            <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">
            </button>
            
            <div class="dropdown-menu">
                <a class="dropdown-item" href="#">최신순</a>
                <a class="dropdown-item" href="#">조회순</a>
                <a class="dropdown-item" href="#">댓글순</a>
            </div>
        </div>
		<button type="button" class="btn btn-info float-right">글 쓰 기</button>
		</div><%-- btntwoend --%>

		</div>   
 </div>
 <script>
 
 $(function() {
		const text = $("button:last-child").text()
		console.log(text)
		$("button:last-child").click(function() {

			location.href = "FileBoardWrite.filebo";
		})


	})
 </script>
</body>
</html>