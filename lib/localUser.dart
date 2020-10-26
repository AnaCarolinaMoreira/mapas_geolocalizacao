import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalUser extends StatefulWidget {
  @override
  _LocalUserState createState() => _LocalUserState();
}

class _LocalUserState extends State<LocalUser> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _marcadores = {};

  //criado    polygons
  Set<Polygon> _polygons = {};

  //Criando polylines
  Set<Polyline> _polylines = {};

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

    Set<Polyline> listaPolylines = {};
    Polyline polyline = Polyline(
      //toda polyline deve possuir um id
      polylineId: PolylineId("polyline"),
      //defini cor da linha
      color: Colors.red,
      //largura da linha
      width: 20,
      //aletrar o formato do inico da linha
      startCap: Cap.roundCap,
      //aletrar o formato do final da linha
      endCap: Cap.roundCap,
      //aletrar o formato do meio da linha, canto da linha, encontro das linhas
      jointType: JointType.bevel,
      points: [
        LatLng(-23.561816, -46.652044),
        LatLng(-23.563625, -46.653642),
        LatLng(-23.564786, -46.652226),
      ] ,
      consumeTapEvents: true,
      onTap: (){print("Clicado na area da linha");},
    );
    listaPolylines.add(polyline);
    setState(() {
      _polylines = listaPolylines;
    });
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
            target: LatLng(-23.563408, -46.652535),
            zoom: 17,
          ),
          onMapCreated: _onMapCreated,
          markers: _marcadores,
          polygons: _polygons,
          polylines: _polylines,
        ),
      ),
    );
  }
}
