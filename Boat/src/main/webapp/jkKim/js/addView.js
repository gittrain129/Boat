function go(page) {
   const dept = $("#dept").val();
   const data = `dept=${dept}&state=ajax&page=${page}`; //el이 아닌 백틱 (js에서만 사용추천)
   ajax(data);
}

function search(page){
	const name2 = $("#search").val();
	const data2 = `name2=${name2}&state=search&page=${page}`;
	ajax(data2);
	
}



function setPaging(href,digit){
   let active="";
   let gray="";
   if(href==""){ //href가 빈문자열인 경우
      if(isNaN(digit)){//이전&nbsp; 또는 다음&nbsp;
         gray="gray";
      }else{
         active="active";
      }
   }
   let output = '<li class="page-item ${active}">';
   //let anchor = "<a class='page-link " + gray + "'" + href + ">" + digit + "</a></li>";
   let anchor = `<a class='page-link ${gray}' ${href}>${digit}</a></li>`;
   output += anchor;
   return output;
}

function ajax(sdata){
   console.log(sdata)
   
   $.ajax({ 
      type : "POST",
      data : sdata,
      url : "address.jk",
      dataType : "json",
      cache : false,
      success : function(data){
         
         
         
         if (data.listcount > 0) {//총 개수가 0보다 큰 경우
            $("#cardbody").remove();
            
            let output = "<div class='row' id='cardbody'>";
            
            $(data.memberlist).each(
	
			function(index, item){
            
            output += " <div class='col-3'>"
            let dept = item.dept;
            output += "<p>" + dept + "</p>"
            output += "<div class='card'>"
            let name = item.name;
            output += "<div class='card-header'>" + name + "</div>" 
            let imgsrc = "/Boat"+item.imgsrc;
            output += "<img src="+  imgsrc + " width='100%'/>"
            output += "<div class='card-body'>"
            output += "<h5 class='card-title'>조장</h5>"
            let email = item.email;
            output += "<p class='card-text'>이메일: " + email + "</p>"
            output += " <a href='#' class='btn btn-primary'>임시메일버튼</a>"
            output += "</div>"
            output += "</div>"
            output += "</div>"
            
            
         })
         output += "</div>"
         console.log(output);
          $("#whole-body").append(output)
          
          
           $(".pagination").empty(); 
               output = "";
               
               let digit = '이전&nbsp;'
               let href="";
               if(data.page > 1){
                  href = 'href=javascript:go(' + (data.page-1) + ')';
               }
               output += setPaging(href, digit);
               
               for (let i = data.startpage; i <= data.endpage; i++){
                  digit = i;
                  href ="";
                  if ( i != data.page){
                     href = 'href=javascript:go(' + i + ')';
                  }
                  output += setPaging(href, digit);
               }
               
               digit = '&nbsp;다음&nbsp;';
               href="";
               if (data.page < data.maxpage) {
                  href = 'href=javascript:go(' + (data.page + 1) + ')';
               }
               output += setPaging(href,digit);
               
               console.log(output)
               $('.pagination').append(output);
            }//if(data.listcount>0)
                
            
         }, //success end
         error : function() {
            console.log('에러');
         }
   })//ajax end
}//function ajax end




$(function(){
 $("form").submit(function(){
      search(1); 
   });

});



$(function(){
    
   $('#dept').change(function(){
      go(1); 
   });
   
  
});



