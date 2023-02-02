<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>BoaTalk</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

a {
    text-decoration: none;
}
table{
width:100%;
background-color: #A8C0D6;

}
.message {
    padding: 40px 0;
    background-color: #A8C0D6;
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
      
     <table class="display">
            <tr>
                <td class="title">Status:</td>
            </tr>
           <tr>
           <td>
		<div class="message" id="message">
        		<div class="chat ch1">
            		<div class="icon"><i class="fa-solid fa-user"></i></div>
            		<div class="textbox" id="your_box">안녕하세요.</div>
        			</div>
        		<div class="chat ch2">
            		<div class="icon"><i class="fa-solid fa-user"></i></div>
            		<div class="textbox" id="my_box">안녕하세요</div>
        		</div>
        		
		</div>
		</td>		
        </tr>
         <tr>
                <td>
                    <input type="text" id="sendMessageBox" placeholder="Enter a message..." autofocus="true" />
                    <button type="button" id="sendButton">전송</button>
                    <button type="button" id="clearMsgsButton">Clear Msgs (Local)</button>
                </td>
         </tr>
         <tr>
         <td>
               <div id="receiver-id" style="font-weight: bold;" title="Copy this ID to the input on send.html.">ID:</div>
         </td>
         </tr>
         <tr>
         <td><div id="status" class="status"></div></td>
         </tr>
     </table>
     
     
     <script type="text/javascript">
            (function () {

                var lastPeerId = null;
                var peer = null; // Own peer object
                var peerId = null;
                var conn = null;
                var recvId = document.getElementById("receiver-id");
                var status = document.getElementById("status");
                var message = document.getElementById("message");
               // var receiverMessage = document.getElementById("my_box"); //내 메세지
                //var senderMessage = document.getElementById("your_box"); //받은 메세지
                var standbyBox = document.getElementById("standby");
                var goBox = document.getElementById("go");
                var fadeBox = document.getElementById("fade");
                var offBox = document.getElementById("off");
                var sendMessageBox = document.getElementById("sendMessageBox");
                var sendButton = document.getElementById("sendButton");
                var clearMsgsButton = document.getElementById("clearMsgsButton");

                /**
                 * Create the Peer object for our end of the connection.
                 *
                 * Sets up callbacks that handle any events related to our
                 * peer object.
                 */
                 function initialize() {
                    // Create own peer object with connection to shared PeerJS server
                    peer = new Peer(null, {
                        debug: 2
                    });
                    
					
					
                    peer.on('open', function (id) {
                        // Workaround for peer.reconnect deleting previous id
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
                        // Allow only a single connection
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

                        // Workaround for peer.reconnect deleting previous id
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

                /**
                 * Triggered once a connection has been achieved.
                 * Defines callbacks to handle incoming data and connection events.
                 */
                function ready() {
                    conn.on('data', function (data) {
                        console.log("Data recieved");
                        var cueString = "<span class=\"cueMsg\">Cue: </span>";
                        switch (data) {
                            case 'Go':
                                go();
                                addMessage(cueString + data);
                                break;
                            case 'Fade':
                                fade();
                                addMessage(cueString + data);
                                break;
                            case 'Off':
                                off();
                                addMessage(cueString + data);
                                break;
                            case 'Reset':
                                reset();
                                addMessage(cueString + data);
                                break;
                            default:
                                addMessage("<span class=\"peerMsg\">Peer: </span>" + data);
                                break;
                        };
                    });
                    conn.on('close', function () {
                        status.innerHTML = "Connection reset<br>Awaiting connection...";
                        conn = null;
                    });
                }

                function go() {
                    standbyBox.className = "display-box hidden";
                    goBox.className = "display-box go";
                    fadeBox.className = "display-box hidden";
                    offBox.className = "display-box hidden";
                    return;
                };

                function fade() {
                    standbyBox.className = "display-box hidden";
                    goBox.className = "display-box hidden";
                    fadeBox.className = "display-box fade";
                    offBox.className = "display-box hidden";
                    return;
                };

                function off() {
                    standbyBox.className = "display-box hidden";
                    goBox.className = "display-box hidden";
                    fadeBox.className = "display-box hidden";
                    offBox.className = "display-box off";
                    return;
                }

                function reset() {
                    standbyBox.className = "display-box standby";
                    goBox.className = "display-box hidden";
                    fadeBox.className = "display-box hidden";
                    offBox.className = "display-box hidden";
                    return;
                };

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
                    
                   
        		
                }

                function clearMessages() {
                	message.innerHTML = "";
                    addMessage("Msgs cleared");
                }

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

                initialize();
            })();
        </script>
     
     
     
     
     
     
     
</body>
</html>