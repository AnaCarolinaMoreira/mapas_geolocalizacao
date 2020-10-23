import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(-23.562436, -46.655005),
      zoom: 16,
      tilt: 0,
      bearing: 45,
    )));
  }

  _carregarMarcadores() {
    Marker marcadorShopping = Marker(
        markerId: MarkerId("marcador-shopping"),
      position: LatLng(-23.563370,-46.652923),
    );
  }

  @override
  void initState() {
    super.initState();
    _carregarMarcadores();
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
            target: LatLng(-23.562436, -46.655005),
            zoom: 16,
          ),
          onMapCreated: _onMapCreated,
          //exibe marcadores no mapa definidos
          markers: _marcadores,
        ),
      ),
    );
  }
}
