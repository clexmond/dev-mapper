$(function() {

  // Parse KML
  var kmlParser = new geoXML3.parser({
    map: map,
    createPolygon: createPolygon,
    createPolyline: createPolyline,
    suppressInfoWindows: true
  });
  kmlParser.parse('AtlantaDevelopment.kml');

  // Override createPolygon to handle filtering
  function createPolygon(placemark, doc) {
    var poly;

    poly = kmlParser.createPolygon(placemark, doc);
    poly = extendPolyShapes(placemark, poly);

    return poly;
  }

  // Override createPolyline to handle filtering
  function createPolyline(placemark, doc) {
    var poly;

    poly = kmlParser.createPolyline(placemark, doc);
    poly = extendPolyShapes(placemark, poly);

    return poly;
  }

  // Parse out AtlantaDev info, extend object and setup listeners to open blog pages
  // The atlantaDev object is built from the input on Google Maps. This needs to be entered
  // in the "plain text" mode.
  function extendPolyShapes(placemark, poly) {
    var info = {};

    try {
      info = { atlantaDev: JSON.parse($(placemark.description).text()) };
    } catch(e) {
      info = { atlantaDev: {} };
    } finally {
      $.extend(poly, info);
    }

    if (poly.atlantaDev.url) {
      google.maps.event.addListener(poly, 'click', function(e) {
        $('#info-frame').attr('src', poly.atlantaDev.url);
        $('#info').slideDown();
        $('#map-toggle').show();
      });
    }

    return poly;
  }

  // Add listener for map toggle
  $('#map-toggle').click(function(e) {
    $('#info').slideUp();
    $('#map-toggle').hide();
  });

  // Add filter listeners
  $('#map-controls .filter').click(function(e) {
    $.each(kmlParser.docs[0].gpolylines, function(i, poly) {
      poly.setOptions({ strokeColor: 'ff0000' });
      console.log(poly);
    });
    console.log($(e.currentTarget).data('filter'));
  });

  $('#filter-transit').click(function(e) {
    $.each(kmlParser.docs[0].gpolygons, function(i, poly) {
      if (!poly.atlantaDev.tags || !$.inArray('building')) {
        poly.setMap(null);
      }
    });
    $.each(kmlParser.docs[0].gpolylines, function(i, poly) {
      // console.log(poly);
    });
  });
});
