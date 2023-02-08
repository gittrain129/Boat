function getId(signal){
	const data = `state=ajax`;
	
}

$(function(){
	   $(window).on("load",function(){
		alert('ㅎㅇ');
		
		 		
                initialize();
		
		
})
});

var lastPeerId = null;
                var peer = null; // Own peer object
                var peerId = null;
                var conn = null;
                var recvId = document.getElementById("receiver-id");
                var status = document.getElementById("status");
                var message = document.getElementById("message");
               // var receiverMessage = document.getElementById("my_box"); //내 메세지
                //var senderMessage = document.getElementById("your_box"); //받은 메세지
              
               
                var sendMessageBox = document.getElementById("sendMessageBox");
                var sendButton = document.getElementById("sendButton");
                var clearMsgsButton = document.getElementById("clearMsgsButton");



function initialize() {
                    
                    peer = new Peer('jkKim', {
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
                        recvId.innerHTML = "ID: " + peer.id;
                        status.innerHTML = "Awaiting connection...";
                    });
                    peer.on('connection', function (c) {
                        // 한번에 한명만 연결되게함
                        if (conn && conn.open) {
                            c.on('open', function() {
                                c.send("Already connected to another client");
                                setTimeout(function() { c.close(); }, 500);
                            });
                            return;
                        }

                        conn = c;
                        console.log("Connected to: " + conn.peer);
                        status.innerHTML = "Connected";
                        ready();
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
                }; //initialize end


               
function ready() {
                    conn.on('data', function (data) {
                        addyourMessage("<span class=\"peerMsg\">Peer:</span> " + data);
                    });
                    conn.on('close', function () {
                        status.innerHTML = "Connection reset<br>Awaiting connection...";
                        conn = null;
                    });
                } //reday() end

                

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
                    //message.innerHTML = "<br><span class=\"msg-time\">" + h + ":" + m + ":" + s + "</span>  -  " + msg + message.innerHTML;
                    //message.innerHTML = ("<br><div class=\"chat ch2\"><div class=\"icon\"><i class=\"fa-solid fa-user\"></i></div><div class=\"textbox\">" +msg + message.innerHTML +"</div>");
                    message.innerHTML = message.innerHTML + ("<br><div class=\"chat ch2\"><div class=\"icon\"><i class=\"fa-solid fa-user\"></i></div><div class=\"textbox\">" + msg +"</div>");
                   
                } //addmessage() end

                
                
                
                //다른사람 채팅창용 펑션
function addyourMessage(msg) {
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
                    //message.innerHTML = "<br><span class=\"msg-time\">" + h + ":" + m + ":" + s + "</span>  -  " + msg + message.innerHTML;
                    //message.innerHTML = ("<br><div class=\"chat ch2\"><div class=\"icon\"><i class=\"fa-solid fa-user\"></i></div><div class=\"textbox\">" +msg + message.innerHTML +"</div>");
                    message.innerHTML = message.innerHTML + ("<br><div class=\"chat ch1\"><div class=\"icon\"><i class=\"fa-solid fa-user\"></i></div><div class=\"textbox\">" + msg +"</div>");
                    
                } //addyourmessage(end)
                
                 
                
function clearMessages() {
                	message.innerHTML = "";
                    history.go(0);
                    
                } //clear messages end
                
            
                

                // Listen for enter in message box
                sendMessageBox.addEventListener('keypress', function (e) {
                    var event = e || window.event;
                    var char = event.which || event.keyCode;
                    if (char == '13')
                        sendButton.click();
                });
                // Send message
                sendButton.addEventListener('click', function () {
                    if (conn && conn.open) {
                        var msg = sendMessageBox.value;
                        sendMessageBox.value = "";
                        conn.send(msg);
                        console.log("Sent: " + msg)
                        addMessage("<span class=\"selfMsg\">Self: </span>" + msg);
                    } else {
                        console.log('Connection is closed');
                    }
                });

                // Clear messages box
                clearMsgsButton.addEventListener('click', clearMessages);
				
              
                	


