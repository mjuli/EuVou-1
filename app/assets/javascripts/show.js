function initMap() {
  var lat1 = document.getElementById('lat').value;
  var lon1 = document.getElementById('lon').value;
  
  var myLatLng = {lat: parseFloat(lat1), lng: parseFloat(lon1)};

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