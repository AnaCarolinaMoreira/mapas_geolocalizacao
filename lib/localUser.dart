import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalUser extends StatefulWidget {
  @override
  _LocalUserState createState() => _LocalUserState();
}

class _LocalUserState extends State<LocalUser> {
  Completer<GoogleMapController> _controller = Completer();

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(-19.97638, -44.0439043),
      zoom: 16,
      tilt: 0,
      bearing: 45,
    )));
  }

  _recuperarLocalizacaoAtual() async {
    //captura o local atual do user
    Position position = await GeolocatorPlatform.instance.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print("localização atual:" + position.toString());
    //Geolocator().getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _recuperarLocalizacaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas e Geolocalização"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.done),
        onPressed: _movimentarCamera,
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            // target: LatLng(-23.563408, -46.652535),
            target: LatLng(-19.97638, -44.0439043),
            zoom: 17,
          ),
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
}
