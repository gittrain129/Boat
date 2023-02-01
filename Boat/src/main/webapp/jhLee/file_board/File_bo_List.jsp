<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="boardlist.css">
    <title>자료게시판 목록보기</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
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
                    <th>번호</th>
                    <th>제목</th>
                    <th>부서</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일자</th>
                    <th>자료</th>

                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>5</td>
                    <td><a href="#">자료입니다<span>new</span></a></td>
                    
                    <td>홍보부</td>
                    <td>홍길동</td>
                    <td>0</td>
                    <td>230131</td>
                    <td><span>fileimage</span>&nbsp;&nbsp;<span>fileimage2</span></td>


                </tr>
                <tr>
                    <td>4</td>
                    <td><a href="#">자료입니다<span>new</span></a></td>
                    
                    <td>홍보부</td>
                    <td>홍길동</td>
                    <td>0</td>
                    <td>230131</td>
                    <td><span>fileimage</span>&nbsp;&nbsp;<span>fileimage2</span></td>


                </tr>
                <tr>
                    <td>3</td>
                    <td><a href="#">자료입니다<span>new</span></a></td>
                    <td>홍보부</td>
                    <td>홍길동</td>
                    <td>0</td>
                    <td>230131</td>
                    <td><span>fileimage</span>&nbsp;&nbsp;<span>fileimage2</span></td>

                </tr>
                <tr>
                    <td>2</td>
                    <td><a href="#">자료입니다<span>new</span></a></td>
                    <td>홍보부</td>
                    <td>홍길동</td>
                    <td>0</td>
                    <td>230131</td>
                    <td><span>fileimage</span>&nbsp;&nbsp;<span>fileimage2</span></td>


                </tr>
                <tr>
                    <td>1</td>
                    <td><a href="#">자료입니다<span>new</span></a></td>
                    <td>홍보부</td>
                    <td>홍길동</td>
                    <td>0</td>
                    <td>230131</td>
                    <td><span>fileimage</span>&nbsp;&nbsp;<span>fileimage2</span></td>
                </tr>
            </tbody>
        </table>
        <div class="File_board_page">


        </div>
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
   
    
    <button type="button" class="btn btn-light">글쓰기</button>
</div>
    </div>
</body>
</html>