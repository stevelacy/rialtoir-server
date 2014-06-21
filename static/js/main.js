$(document).ready(function() {

	var socket = io();
	
  $('.items .item .button.panic').click(function(){
    var id = $(this).data('id');
    socket.emit('panic', {id: id});
  });
  $('.items .item .button.gps').click(function(){
    var id = $(this).data('id');
    socket.emit('gps', {id: id});
  });
});
