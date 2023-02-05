
<%--
http://localhost:8089/Boat/jhLee/calendar.jsp

http://localhost:8089/Boat/project_calendarallSave.cal

http://localhost:8089/Boat/project_calendarallSave.cal
http://localhost:8089/Boat/project_calendarallSave.cal


 --%>
 
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
 
  <meta charset='utf-8' />
  <!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

  <!-- jquery CDN -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  
<!--   <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.0/index.global.min.js'></script> -->
  

  <!-- fullcalendar CDN -->
  
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
 
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
  
  <!-- bootstrap -->
  <link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet'>
<link href='https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.css' rel='stylesheet'>

 
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js" integrity="sha512-42PE0rd+wZ2hNXftlM78BSehIGzezNeQuzihiBCvUEB3CVxHvsShF86wBWwQORNxNINlBPuq7rG4WWhNiTVHFg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- the moment-to-fullcalendar connector. must go AFTER the moment lib -->

<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/moment@6.1.1/index.global.min.js'></script>
 
 <link rel ="${pageContext.request.contextPath}/jhLee/css/calendar.css">
 <script>
 var calendar =null;
 //import { Calendar } from '@fullcalendar/core';

	    $(document).ready(function(){
	      // calendar element 취득
	      var calendarEl = $('#calendar')[0];
	      
	      //드래그앤 드롭가능  -> 추후 삭제 예정
	      var Draggable = FullCalendar.Draggable;
	      
	      var containerEl = document.getElementById('external-events');
	      var calendarEl = document.getElementById('calendar');
	      var checkbox = document.getElementById('drop-remove');
	      //db모든 데이터 가져옴
	      val all_events = null;
	      all_events = loadingEvents();
	      
	      //드래그앤 드롭가능  -> 추후 삭제 예정
	      
	      new Draggable(containerEl, {
	          itemSelector: '.fc-event',
	          eventData: function(eventEl) {
	            return {
	              title: eventEl.innerText
	            };
	          }
	        });
	      //드래그앤 드롭가능  -> 추후 삭제 예정
	      
	      
	      
	      
	      // full-calendar 생성하기
	      calendar = new FullCalendar.Calendar(calendarEl, {
	    	  titleFormat: { // will produce something like "Tuesday, September 18, 2018"
	    		    month: 'long',
	    		    year: 'numeric',
	    		  },
	    		  views: {
	    			   /* dayGrid: {
	    			    	 month: 'long',
	    		    		    year: 'numeric',
	    		    		    day: '2-digit',
	    		    		    weekday: 'long'
	    			    }*/
  			    }
	    			    ,
	    	  //themeSystem: 'bootstrap',
	    	
	    	  
	        height: '600px', // calendar 높이 설정
	        expandRows: true, // 화면에 맞게 높이 재설정
//당장 필요 없음 (final)	     
	        //slotMinTime: '08:00', // Day 캘린더에서 시작 시간
	        //slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
	        
	        headerToolbar: {
	            left: 'prev,next today',
	            center: 'title',
 //(final)     right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
 				right : '',
	          },
	          
	          editable: true, //재수정여부 가능
	        //drop으로 update 해야함
	          droppable: true,
	          
	          drop: function(info) {
	            // is the "remove after drop" checkbox checked?
	            if (checkbox.checked) {
	              // if so, remove the element from the "Draggable Events" list
	              info.draggedEl.parentNode.removeChild(info.draggedEl);
	            }
	          },
	          //월간 달력으로 시작합니다.
	          initialView: 'dayGridMonth',
	          editable: true, // 수정 가능?
	          selectable: true, // 달력 일자 드래그 설정가능
	          nowIndicator: true, // 현재 시간 마크
	          dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
	          locale: 'ko', // 한국어 설정
	          eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
	              console.log(obj);
	          	console.log('이벤트 추가함');
	          	
	          	
	            },
	            eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
	              console.log(obj);
	          	console.log('이벤트 수정함');
	            
	            },
	            eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
	              console.log(obj);
	          	console.log('이벤트 삭제함');
	            
	            },
	            select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
	              var title = prompt('일정추가:');
	             var start =  moment(start).format('YYYY/MM/DD');
	              var end = moment(end).format('YYYY/MM/DD');
	              if (title) {
	                calendar.addEvent({
	                  title: title,
	                  start: arg.start,
	                  end: arg.end,
	                  allDay: arg.allDay,
	                  Boolean//?
	                		  }  )
	              
	              }
	              calendar.unselect();//뭔지모르겠다
	            },   eventClick: function (arg) {

	            	            if (confirm("삭제하시겠습니까?")) {
	            		 arg.event.remove();
	            	      /*         $.ajax({
	            	                type: "POST",
	            	                url: "${pageContext.request.contextPath}/project_calendardelete.cal",
	            	                contentType: "application/json; charset=utf-8",
									data : arg,
	            	                dataType: "json",
	            	                success: function (result) {
	            	                  console.log("삭제완료");
	            	                 // arg.event.remove();
	            	                }
	            	})//ajax 끝 */
	            	}else{
	            		console.log('삭제 실패');
	            	}
	            }
     });
     calendar.render();
   });//캘린더 객체 선언 끝
	    
   	function loadingEvents(){
   		$.ajax({
   			type:'POST',
   			url:'${pageContext.request.contextPath}/project_calendarshow.cal',
   			dataType:"json",
   			async:true,
   			success:function(rdata){
   				console.log('이벤트디비저장완료.');
   			},
   			error:function(request,status,error){},
   			complete:function(){}
   		}) 
	   
   }
   
	    
	    //전체 이벤트 뽑아냄(그달의 전체 이벤트)
	    //뽑을때 각각 데이터로 뽑아냄
	    function cal_data(allEvent){
	     	 for(var i=0; i<allEvent.length;i++){
		   		 var obj = new Object();
		   		 
		   		 obj.title = allEvent[i]._def.title; //이벤트 명칭
		   		 obj.allday =allEvent[i]._def.allDay; //하루종일 이벤트인지 알려주는boolean값
		   		 obj.start = allEvent[i]._instance.range.start//시작날짜 및 시간
		   		 obj.end = allEvent[i]._instance.range.end//마침 날짜 및 시간
		   		 
	    		}
	     	return obj
	      }
	    
	    //전체 버튼 누르면 저장됨
	    function allSave(){
	   	 var allEvent =	 calendar.getEvents();
	   	 console.log(allEvent);
	   	 alert("전체 이벤트 저장합니다.");
	   	 console.log("전체 이벤트 저장합니다.");
	   	 
	    let obj = cal_data(allEvent);
	   	 savedata(obj);
	   	 }
	   	 
	    
	    //이벤트 db저장 ajax
	    function savedata(jsondata){
	   		$.ajax({
	   			type:'POST',
	   			url:'${pageContext.request.contextPath}/project_calendarallSave.cal',
	   			data:jsondata,
	   			dataType:"json",
	   			async:true,
	   			success:function(rdata){
	   				console.log('모든 데이터 저장하였습니다.');
	   			},
	   			error:function(request,status,error){},
	   			complete:function(){}
	   		}) 
	    }//save data끝
	    
 </script>
</head>

<body>

<%-- 추후 삭제 예정 --%>
 <div id = drag_wrap>
	 <div id='external-events'>
	    <p>
	      <strong>드래그앤드롭</strong>
	    </p>
	
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 1</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 2</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 3</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 4</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 5</div>
	    </div>
	
	    <p>
	      <input type='checkbox' id='drop-remove' />
	      <label for='drop-remove'>드롭제거</label>
	    </p>
	  </div>
  </div>
  <%-- 추후 삭제 예정 --%>
  
  
  
  <%--전체 저장 버튼 누르면 월간 페이지 전체 저장 가능--%>
 <div id = "cal_save_wrap">
 <button id ="cal_save" onclick="allSave();">전체 저장</button>
 </div>
 
 <div id = cal_wrap>
 	<div id='calendar'></div>
 </div>
 <script>

 </script>
</body>
</html>