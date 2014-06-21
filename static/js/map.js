$(document).ready(function() {

  var socket = io();
  mapLoad = 0;
  var markers = [];
  function initialize() {
    var mapOptions = {
      zoom: 10,
      center: new google.maps.LatLng(40.7903, -73.9597)
    };
    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    socket.on('gps', function(data){
      console.log(data.number, (location.hash).slice(1));
      if (data.number == (location.hash).slice(1)){
        var myLatLng = new google.maps.LatLng(data.lat, data.lon);
        if (mapLoad === 0){
          map.setCenter(myLatLng);
          mapLoad = 1;
        }
        var marker = new google.maps.Marker({
            position: myLatLng,
            map: map
        });
        markers.push(marker);
      }
    });

    $('.clear').click(function(){
      for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
      }
    });
  }

  google.maps.event.addDomListener(window, 'load', initialize);

});
