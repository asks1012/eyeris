import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as addr;
import 'package:geolocator/geolocator.dart';

class LocationFind extends StatelessWidget {
  LocationFind({Key? key}) : super(key: key);

  final Location location = Location();

  Future<String> locationTracking() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return "Please Enable location Services.";
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    location.changeSettings();
    _locationData = await location.getLocation();

    location.enableBackgroundMode(enable: true);

    List<addr.Placemark> placemarks = await addr.placemarkFromCoordinates(
        _locationData.latitude!, _locationData.longitude!);
    // ignore: prefer_interpolation_to_compose_strings
    var address = placemarks[0].locality.toString() +
        ", " +
        placemarks[0].subAdministrativeArea.toString() +
        '\n' +
        "PIN- " +
        placemarks[0].postalCode.toString();
    return address;
  }

  var uoh_lat = 17.4567;
  var uoh_long = 78.3264;
  void isUnderRadius() {
    var dist = Geolocator.distanceBetween(
        uoh_lat, uoh_long, 20.221850953225395, 85.73454860746622);
    if (dist > 10000) {
      print("Person is far away.");
    }
    // ignore: prefer_interpolation_to_compose_strings
    print("Distance is " + dist.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Loction Recorded At'),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
                future: locationTracking(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as String;
                      return Text(data);
                    }
                    return const Text("location can't be produces");
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ]),
      actions: <Widget>[
        FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
