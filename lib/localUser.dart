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

//instanciando a posição inicial da camera
  CameraPosition _posicaoCamera = CameraPosition(
    // target: LatLng(-23.563408, -46.652535),
    target: LatLng(-19.97638, -44.0439043),
    zoom: 17,
  );

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(
        _posicaoCamera
    ));
  }

  _recuperarLocalizacaoAtual() async {
    //captura o local atual do user, localização do atual usuario
    Position position = await GeolocatorPlatform.instance.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      //posição camera recebe um cameraPosition
      _posicaoCamera = CameraPosition(
        //atualiza o CameraPosition com latitude e longitude recebida da função _recuperarLocalizacaoAtual
        //_posicaoCamera e passeada na posiçãoa tual do usuario
          target: LatLng(position.latitude, position.longitude),
        zoom: 17,
      );
      _movimentarCamera();
    });
   // print("localização atual:" + position.toString());
    //Geolocator().getCurrentPosition();
  }

  //metodo que adciona ouvinte e monitora o local do user
  _adicionarListenerLocalizacao(){
  var geolocator = Geolocator().getPositionStream;
  geolocator.get
/*  Position position = await GeolocatorPlatform.instance.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );*/
  }

  @override
  void initState() {
    super.initState();
  //  _recuperarLocalizacaoAtual();
    _adicionarListenerLocalizacao();
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
          initialCameraPosition:_posicaoCamera,
          onMapCreated: _onMapCreated,
          //possibilita visualizar o marcador especifico da sua localização, marcadro redondo
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
