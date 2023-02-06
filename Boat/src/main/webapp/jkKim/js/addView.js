function go(page) {
   const dept = $("#dept").val();
   const data = `dept=${dept}&state=ajax&page=${page}`; //el이 아닌 백틱 (js에서만 사용추천)
   ajax(data);
}



function ajax(sdata){
   console.log(sdata)
   
   $.ajax({ //줄보기로 개수 바꾸면 그거에 맞게 새로고침안하고 변하게 하기 위해서 ajax쓴다.
      type : "POST",
      data : sdata,
      url : "adress.jk",
      dataType : "json",
      cache : false,
      success : function(data){
         $("#deptvalue").val(data.limit);
         
            
         }, //success end
         error : function() {
            console.log('에러');
         }
   })//ajax end
}//function ajax end


$(function(){
    
   $('#dept').change(function(){
      go(1); //보여줄 페이지를 1페이지로 설정
   });
});



