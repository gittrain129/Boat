<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
 
  <meta charset='utf-8' />
  <!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

  <!-- jquery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.0/index.global.min.js'></script>
  <!-- fullcalendar CDN 
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>-->
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
  <link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet'>
<link href='https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.css' rel='stylesheet'>
<jsp:include page="${pageContext.request.contextPath}/headfoot/herder.jsp"/>

 <style>
  /* body 스타일 */
  body {
    margin-top: 40px;
    font-size: 14px;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  }
  /* 드래그 박스의 스타일 */
  #drag_wrap {
    position: fixed;
    left: 20px;
    top: 20px;
    width: 100px;
    padding: 0 10px;
    border: 1px solid #ccc;
    background: #eee;
    text-align: left;
    margin-top : 100px;
  }
  #external-events h4 {
    font-size: 16px;
    margin-top: 0;
    padding-top: 1em;
  }
  #external-events .fc-event {
    margin: 3px 0;
    cursor: move;
  }
 
  #external-events p {
    margin: 1.5em 0;
    font-size: 11px;
    color: #666;
  }
 
  #external-events p input {
    margin: 0;
    vertical-align: middle;
  }

  #cal_wrap {
    margin-left: 200px;
  }
 
  #calendar1 {
    max-width: 1100px;
    margin: 0 auto;
  }
  #cal_save_wrap{
  text-align:right;  display: block;
  margin : 20px;
  }
  #cal_save{
  width : 120px; height : 40px; background-color : blue; color : white; 
  font-size:17px; cursor:pointer; margin-botton: 50px;
}
</style>
 <script>
 var calendar =null;
	    $(document).ready(function(){
	      // calendar element 취득
	      var calendarEl = $('#calendar')[0];
	      var Draggable = FullCalendar.Draggable;
	      
	      var containerEl = document.getElementById('external-events');
	      var calendarEl = document.getElementById('calendar');
	      var checkbox = document.getElementById('drop-remove');
	      
	      //드래그앤 드롭가능
	      new Draggable(containerEl, {
	          itemSelector: '.fc-event',
	          eventData: function(eventEl) {
	            return {
	              title: eventEl.innerText
	            };
	          }
	        });
	      // full-calendar 생성하기
	      calendar = new FullCalendar.Calendar(calendarEl, {
	    	  themeSystem: 'bootstrap',
	    	 /*  close: 'fa-times',
	    	  prev: 'fa-chevron-left',
	    	  next: 'fa-chevron-right',
	    	  prevYear: 'fa-angle-double-left',
	    	  nextYear: 'fa-angle-double-right', */
	    	  
	        height: '700px', // calendar 높이 설정
	        expandRows: true, // 화면에 맞게 높이 재설정
	        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
	        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
	        headerToolbar: {
	            left: 'prev,next today',
	            center: 'title',
	            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
	          },
	          editable: true, //재수정여부 가능
	          droppable: true, // this allows things to be dropped onto the calendar
	          drop: function(info) {
	            // is the "remove after drop" checkbox checked?
	            if (checkbox.checked) {
	              // if so, remove the element from the "Draggable Events" list
	              info.draggedEl.parentNode.removeChild(info.draggedEl);
	            }
	          },
	          initialView: 'dayGridMonth',
	          editable: true, // 수정 가능?
	          selectable: true, // 달력 일자 드래그 설정가능
	          nowIndicator: true, // 현재 시간 마크
	          dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
	          locale: 'ko', // 한국어 설정
	          eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
	              console.log(obj);
	            },
	            eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
	              console.log(obj);
	            },
	            eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
	              console.log(obj);
	            },
	            select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
	              var title = prompt('일정추가:');
	              if (title) {
	                calendar.addEvent({
	                  title: title,
	                  start: arg.start,
	                  end: arg.end,
	                  allDay: arg.allDay,
	                  Boolean
	                })
	              }
	              calendar.unselect();
	            }
     });
     calendar.render();
   });
	    //전체 이벤트 뽑아냄
	    function allSave(){
	   	 var allEvent =	 calendar.getEvents();
	   	 console.log(allEvent);
	   	 
	   	 var events = new Array();
	   	 
	   	 for(var i=0; i<allEvent.length;i++){
	   		 var obj = new Object();
	   		 
	   		 obj.title = allEvent[i]._def.title; //이벤트 명칭
	   		 obj.allday =allEvent[i]._def.allDay; //하루종일 이벤트인지 알려주는boolean값
	   		 obj.start = allEvent[i]._instance.range.start//시작날짜 및 시간
	   		 obj.end = allEvent[i]._instance.range.end//마침 날짜 및 시간
	   		 
	   		 events.push(obj);
	   	 }
	   	 //json형으로 변환함.
	   	 var jsondata = JSON.stringify(events);
	   	 console.log(jsondata);
	   	 
	   	 savedata(jsondata);
	    }
	    
	    function savedata(jsondata){
	   		$.ajax({
	   			type:'POST',
	   			url:'${pageContext.request.contextPath}/project_calendar',
	   			data:{"alldata":jsondata},
	   			dataType:"json",
	   			async:true,
	   			success:function(rdata){
	   				
	   				
	   			},
	   			error:function(request,status,error){},
	   			complete:function(){}
	   		}) 
	   	 
	    }
	    
 </script>
</head>

<body>
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