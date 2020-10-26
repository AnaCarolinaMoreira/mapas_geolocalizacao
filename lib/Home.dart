import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();

  //marcador criado poderia ser add aqui para exibir
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
    //cria lista que add o marcador ao mapa
    Set<Marker> marcadoresLocal = {};

    Marker marcadorShopping = Marker(
        markerId: MarkerId("marcador-shopping"),
        //-23.563408, -46.652535
        position: LatLng(-23.563408, -46.652535),
        infoWindow: InfoWindow(title: "Shopping cidade São Paulo"),
        //aletrar icon
        //por padrao o kmarcaadro vem defaultMarke
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),

        ///click no marker
        onTap: () {
          print("Shopping Clicado!!");
        },
        //adciona rotação para o mnarcador
        rotation: 45);
    Marker marcadorCartorio = Marker(
        //cria id indeficação do marcadro aqui foi definido como  string
        markerId: MarkerId("marcador-cartorio"),
        //add posição para o marcador
        //-23.563408, -46.652535
        position: LatLng(-23.563408, -46.655874),
        //add titulo e exibe titulos aos marcadores
        infoWindow: InfoWindow(title: "12 Catorio de Notas"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
      print("Cartorio Clicado!!");
    },
    );
    //add o marcador ao mapa
    marcadoresLocal.add(marcadorShopping);
    marcadoresLocal.add(marcadorCartorio);
    //atualiza o estado da pagina para carregar os marcadores

    setState(() {
      _marcadores = marcadoresLocal;
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
