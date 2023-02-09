<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
 <script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>
<title>Insert title here</title>

  <style>
  	
  
  	.chat_pop {z-index:-50; position:fixed; right:0%; top:40%; padding:30px; background:#A8C0D6; 
  			  border-radius:5px; position: absolute; transform: translate(-50%,-50%); padding: 0px;}
  
  	.layerPopup div {display : inline;}
  	
  	.layerPopup::before {display: block; content: ""; position: fixed; left: 0; top: 0; 
  						 width: 100%; height: 100%;  z-index: -100}
  	
  	
  	
  	
  	
  	* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

#whole-chat-box{
width:100%;
background-color: #A8C0D6;


 display:flex;

    flex-direction: column-reverse;

    overflow-y:auto;

    height:500px;
    
    

}


sage {
    padding: 40px 0;
    
    background-color: #A8C0D6;
}
#message{
	width:460px;
}
.message .chat {
    display: flex;
    align-items: flex-start;
    padding: 20px;
}

.message .chat .icon {
    position: relative;
    overflow: hidden;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: #eee;
}

.message .chat .icon i {
    position: absolute;
    top: 10px;
    left: 50%;
    font-size: 2.5rem;
    color: #aaa;
    transform: translateX(-50%);
}

.message .chat .textbox {
    position: relative;
    display: inline-block;
    max-width: calc(100% - 70px);
    padding: 10px;
    margin-top: 7px;
    font-size: 13px;
    border-radius: 10px;
}

.message .chat .textbox::before {
    position: absolute;
    display: block;
    top: 0;
    font-size: 1.5rem;
}

.message .ch1 .textbox {
    margin-left: 20px;
    background-color: #ddd;
}

.message .ch1 .textbox::before {
    left: -15px;
    content: "◀";
    color: #ddd;
}

.message .ch2 {
    flex-direction: row-reverse;
}

.message .ch2 .textbox {
    margin-right: 20px;
    background-color: #F9EB54;
}

.message .ch2 .textbox::before {
    right: -15px;
    content: "▶";
    color: #F9EB54;
}
  </style>

</head>

<body>

<div>

<button onclick="window.open('chatView.jsp','BoaTalk','width=400, height=490, location=no, status=no, scrollbars=yes')">채팅뷰 (window.open)열기</button>
<a href="chat.jk" onclick="window.open(this.href, '_blank', 'width=500, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no'); return false;">
     ${id }</a>
<button onclick="window.open('Sender.jsp','BoaTalk','width=400, height=450, location=no, status=no, scrollbars=yes')">채팅뷰 (window.open)열기</button>
</div>

<div>
<button type="button" class="address">주소록 창으로 가기</button>
</div>
<div class="layerPopup" id="layerPopup">
<div class='chat_pop' id='chat_pop'>

</div>
</div>
<script src="${pageContext.request.contextPath}/jkKim/js/jkKim_inout.js"></script>			
			<div class="dropdown_inout">						
               <select id="inout" name="inout" onchange="select_inout()" required autofocus>
               		<option value="" selected disabled hidden>출근현황</option>
				    <option style= "background-color: #18a8f1" value="출근">출근</option>
				    <option style= "background-color: #f5de16" value="외출">외출</option>
				    <option style= "background-color: #ff5858" value="퇴근">퇴근</option>
				</select>
	        </div>
	        
	        
	        
	        
	       
 <script type="text/javascript" id="chat_script">


 
 
function start_chat() {
 		
                var lastPeerId = null;
                var peer = null; // own peer object
                var conn = null;
                var recvIdInput = document.getElementById("receiver-id");
                var status = document.getElementById("status");
                var message = document.getElementById("message");
                
                var sendMessageBox = document.getElementById("sendMessageBox");
                var sendButton = document.getElementById("sendButton");
                var clearMsgsButton = document.getElementById("clearMsgsButton");
                var connectButton = document.getElementById("connect-button");
               

              
                function initialize() {
                   
                    peer = new Peer(null, {
                        debug: 2
                    });

                    peer.on('open', function (id) {
                       
                        if (peer.id === null) {
                            console.log('Received null id from peer open');
                            peer.id = lastPeerId;
                        } else {
                            lastPeerId = peer.id;
                        }

                        console.log('ID: ' + peer.id);
                    });
                    peer.on('connection', function (c) {
                        
                        c.on('open', function() {
                            c.send("Sender does not accept incoming connections");
                            setTimeout(function() { c.close(); }, 500);
                        });
                    });
                    peer.on('disconnected', function () {
                        status.innerHTML = "Connection lost. Please reconnect";
                        console.log('Connection lost. Please reconnect');

                       
                        peer.id = lastPeerId;
                        peer._lastServerId = lastPeerId;
                        peer.reconnect();
                    });
                    peer.on('close', function() {
                        conn = null;
                        status.innerHTML = "Connection destroyed. Please refresh";
                        console.log('Connection destroyed');
                    });
                    peer.on('error', function (err) {
                        console.log(err);
                        alert('' + err);
                    });
                };

              
                function join() {
                        if (conn) {
                        conn.close();
                    }

                  
                    conn = peer.connect(recvIdInput.value, {
                        reliable: true
                    });

                    conn.on('open', function () {
                        status.innerHTML = "Connected to: " + conn.peer;
                        console.log("Connected to: " + conn.peer);

                       
                        var command = getUrlParam("command");
                        if (command)
                            conn.send(command);
                    });
               
                    conn.on('data', function (data) {
                        addyourMessage2("<span class=\"peerMsg\">Peer:</span> " + data);
                    });
                    conn.on('close', function () {
                        status.innerHTML = "Connection closed";
                    });
                };

           
                function getUrlParam(name) {
                    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
                    var regexS = "[\\?&]" + name + "=([^&#]*)";
                    var regex = new RegExp(regexS);
                    var results = regex.exec(window.location.href);
                    if (results == null)
                        return null;
                    else
                        return results[1];
                };

                
                 function signal(sigName) {
                    if (conn && conn.open) {
                        conn.send(sigName);
                        console.log(sigName + " signal sent");
                        addMessage(sigName);
                    } else {
                        console.log('Connection is closed');
                    }
                }

                

                function addMessage(msg) {
                    var now = new Date();
                    var h = now.getHours();
                    var m = addZero(now.getMinutes());
                    var s = addZero(now.getSeconds());

                    if (h > 12)
                        h -= 12;
                    else if (h === 0)
                        h = 12;

                    function addZero(t) {
                        if (t < 10)
                            t = "0" + t;
                        return t;
                    };
                    message.innerHTML = message.innerHTML + ("<br><div class=\"chat ch2\"><div class=\"icon\"><i class=\"fa-solid fa-user\"></i></div><div class=\"textbox\">" + msg +"</div>");
                };
                
                function addyourMessage2(msg) {
                    var now = new Date();
                    var h = now.getHours();
                    var m = addZero(now.getMinutes());
                    var s = addZero(now.getSeconds());

                    if (h > 12)
                        h -= 12;
                    else if (h === 0)
                        h = 12;

                    function addZero(t) {
                        if (t < 10)
                            t = "0" + t;
                        return t;
                    };
                    message.innerHTML = message.innerHTML + ("<br><div class=\"chat ch1\"><div class=\"icon\"><i class=\"fa-solid fa-user\"></i></div><div class=\"textbox\">" + msg +"</div>");
                }

                function clearMessages() {
                    message.innerHTML = "";
                    addMessage("Msgs cleared");
                };

               
                sendMessageBox.addEventListener('keypress', function (e) {
                    var event = e || window.event;
                    var char = event.which || event.keyCode;
                    if (char == '13')
                        sendButton.click();
                });
                
                sendButton.addEventListener('click', function () {
                    if (conn && conn.open) {
                        var msg = sendMessageBox.value;
                        sendMessageBox.value = "";
                        conn.send(msg);
                        console.log("Sent: " + msg);
                        addMessage("<span class=\"selfMsg\">Self: </span> " + msg);
                    } else {
                        console.log('Connection is closed');
                    }
                });

                
                clearMsgsButton.addEventListener('click', clearMessages);
                // Start peer connection on click
                connectButton.addEventListener('click', join);

               
                initialize();
            };
            
inout.addEventListener('change', function(){
	
	chat_pop.innerHTML = " <table class='display' id='whole-chat-box'> ";
	chat_pop.innerHTML += "<tr><td class='title'>Status:</td></tr>";
	chat_pop.innerHTML += "<tr><td>";
	chat_pop.innerHTML += " <span style='font-weight: bold'>연결할ID: </span>";
	chat_pop.innerHTML += "<input type='text' id='receiver-id' title='Input the ID'>";
	chat_pop.innerHTML += "<button id='connect-button'>Connect</button>";
	chat_pop.innerHTML += "</td></tr>";
	chat_pop.innerHTML += "<tr><td>";
	chat_pop.innerHTML += "<div class='message' id='message'>";
	chat_pop.innerHTML += " <div class='chat ch1'>";
	chat_pop.innerHTML += "<div class='icon'><i class='fa-solid fa-user'></i></div>";
	chat_pop.innerHTML += "<div class='textbox' id='your_box'>안녕하세요.</div>";
	chat_pop.innerHTML += "</div>";
	chat_pop.innerHTML += "</div></td></tr>";
	chat_pop.innerHTML += "<tr><td>";
	chat_pop.innerHTML += " <input type='text' id='sendMessageBox' placeholder='Enter a message...'  />";
	chat_pop.innerHTML += "<button type='button' id='sendButton'>Send</button>";
	chat_pop.innerHTML += " <button type='button' id='clearMsgsButton'>Clear Msgs (Local)</button>";
	chat_pop.innerHTML += "</td></tr><tr>";
	chat_pop.innerHTML += "<td><div id='status' class='status'></div></td>";
	chat_pop.innerHTML += " </tr></table>";
	
	start_chat();
	
});
         </script>	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
</body>
</html>