<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>BoaTalk -- Sender</title>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>
     
<style>
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
       
        <table class="control">
            <tr>
                <td class="title">Status:</td>
            </tr>
            <tr>
                <td>
                    <span style="font-weight: bold">연결할ID: </span>
                    <input type="text" id="receiver-id" title="Input the ID">
                    <button id="connect-button">Connect</button>
                </td>
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
                    <input type="text" id="sendMessageBox" placeholder="Enter a message..."  />
                    <button type="button" id="sendButton">Send</button>
                    <button type="button" id="clearMsgsButton">Clear Msgs (Local)</button>
                </td>
            </tr>
            <tr>
                <td><div id="status" class="status"></div></td>
            </tr>
            
        </table>


        <script type="text/javascript">
            (function () {

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
                var cueString = "<span class=\"cueMsg\">Cue: </span>";

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
                    });
                    peer.on('connection', function (c) {
                        // Disallow incoming connections
                        c.on('open', function() {
                            c.send("Sender does not accept incoming connections");
                            setTimeout(function() { c.close(); }, 500);
                        });
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
                 * Create the connection between the two Peers.
                 *
                 * Sets up callbacks that handle any events related to the
                 * connection and data received on it.
                 */
                function join() {
                    // Close old connection
                    if (conn) {
                        conn.close();
                    }

                    // Create connection to destination peer specified in the input field
                    conn = peer.connect(recvIdInput.value, {
                        reliable: true
                    });

                    conn.on('open', function () {
                        status.innerHTML = "Connected to: " + conn.peer;
                        console.log("Connected to: " + conn.peer);

                        // Check URL params for comamnds that should be sent immediately
                        var command = getUrlParam("command");
                        if (command)
                            conn.send(command);
                    });
                    // Handle incoming data (messages only since this is the signal sender)
                    conn.on('data', function (data) {
                        addyourMessage2("<span class=\"peerMsg\">Peer:</span> " + data);
                    });
                    conn.on('close', function () {
                        status.innerHTML = "Connection closed";
                    });
                };

                /**
                 * Get first "GET style" parameter from href.
                 * This enables delivering an initial command upon page load.
                 *
                 * Would have been easier to use location.hash.
                 */
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

                /**
                 * Send a signal via the peer connection and add it to the log.
                 * This will only occur if the connection is still alive.
                 */
                 function signal(sigName) {
                    if (conn && conn.open) {
                        conn.send(sigName);
                        console.log(sigName + " signal sent");
                        addMessage(cueString + sigName);
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
                    //message.innerHTML = "<br><span class=\"msg-time\">" + h + ":" + m + ":" + s + "</span>  -  " + msg + message.innerHTML;
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
                    //message.innerHTML = "<br><span class=\"msg-time\">" + h + ":" + m + ":" + s + "</span>  -  " + msg + message.innerHTML;
                    //message.innerHTML = ("<br><div class=\"chat ch2\"><div class=\"icon\"><i class=\"fa-solid fa-user\"></i></div><div class=\"textbox\">" +msg + message.innerHTML +"</div>");
                    message.innerHTML = message.innerHTML + ("<br><div class=\"chat ch1\"><div class=\"icon\"><i class=\"fa-solid fa-user\"></i></div><div class=\"textbox\">" + msg +"</div>");
                }

                function clearMessages() {
                    message.innerHTML = "";
                    addMessage("Msgs cleared");
                };

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
                        console.log("Sent: " + msg);
                        addMessage("<span class=\"selfMsg\">Self: </span> " + msg);
                    } else {
                        console.log('Connection is closed');
                    }
                });

                // Clear messages box
                clearMsgsButton.addEventListener('click', clearMessages);
                // Start peer connection on click
                connectButton.addEventListener('click', join);

                // Since all our callbacks are setup, start the process of obtaining an ID
                initialize();
            })();
        </script>
    </body>
</html>