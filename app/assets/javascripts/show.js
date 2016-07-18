function initMap() {
  var myLatLng = {lat: -5.811419, lng: -35.203328};

  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: myLatLng
  });

  var marker = new google.maps.Marker({
    position: myLatLng,
    map: map,
    title: 'Evento'
  });
}