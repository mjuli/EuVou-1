$(document).ready(function() {
	var mapOptions = {
		center: { lat: -5.779264899999999, lng: -35.200902600000006 },
		zoom: 13,
		scrollwheel: false
	};

	if ($('.latitude').val() != '') {
			mapOptions.center.lat = parseFloat($('.latitude').val());
			mapOptions.center.lng = parseFloat($('.longitude').val());
			mapOptions.zoom = 17;
  }
		
  var map = new google.maps.Map(document.getElementById('map'),
    mapOptions);

  var input = $(".location")[0];

  // Create the autocomplete helper, and associate it with
  // an HTML text input box.
  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map,
		position: mapOptions.center
  });
	
	if ($('.latitude').val() != '') {
		marker.setVisible(true);
	}
	
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
  });

  // Get the full place details when the user selects a place from the
  // list of suggestions.
  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      return;
    }

    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);
    }

    // Set the position of the marker using the place ID and location.
    marker.setPlace(/** @type {!google.maps.Place} */ ({
      placeId: place.place_id,
      location: place.geometry.location
    }));
		console.log(place);
		 $('.location').val(place.formatted_address);
		 $('.place').val(place.name);	
		 $('.latitude').val(place.geometry.location.lat());
     $('.longitude').val(place.geometry.location.lng());
    
		marker.setVisible(true);

  });
});
