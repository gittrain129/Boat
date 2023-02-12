function select_inout(){
    var color = $("#inout option:checked").css("color");
    var bgcolor = $("#inout option:checked").css("background-color");
    $("#inout").css("color",color);		
    $("#inout").css("background-color",bgcolor);			
}