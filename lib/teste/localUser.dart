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
    /*  Set<Marker> marcadoresLocal = {};

    Marker marcadorShopping = Marker(
        markerId: MarkerId("marcador-shopping"),

        position: LatLng(-23.563408, -46.652535),
        infoWindow: InfoWindow(title: "Shopping cidade São Paulo"),

        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),

        onTap: () {
          print("Shopping Clicado!!");
        },

        rotation: 45);
    Marker marcadorCartorio = Marker(

      markerId: MarkerId("marcador-cartorio"),

      position: LatLng(-23.563408, -46.655874),

      infoWindow: InfoWindow(title: "12 Catorio de Notas"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
      print("Cartorio Clicado!!");
    },
    );

    marcadoresLocal.add(marcadorShopping);
    marcadoresLocal.add(marcadorCartorio);

    setState(() {
      _marcadores = marcadoresLocal;
    });*/

    /* Set<Polygon> listaPolygon = {};

    Polygon polygon1 = Polygon(
        //necessario sempre definir o id do poly
        polygonId: PolygonId("polygon1"),
        //cor do preenchimento
        //  fillColor: Colors.green,
        fillColor: Colors.green,
        //cor da borda
        strokeColor: Colors.red,
        //largura da borda
        strokeWidth: 10,
        //cria os pontos definifdo pra criação do polygono
        points: [
          LatLng(-23.561816, -46.652044),
          LatLng(-23.563625, -46.653642),
          LatLng(-23.564786, -46.652226),
          //forma um poligon quadrado
          LatLng(-23.563085, -46.650531),
        ],
        //chamado para que se possa usar o onTap,e seu valor deev ser true
        consumeTapEvents: true,
        onTap: () {
          print("Clicado na areá marcada");
        },
      //define quem fica no topo da pilha, define qual item fica sobre qual
      //quanto maoir zindex do item mas no topo ele fica,
        zIndex: 1,
        );
    Polygon polygon2 = Polygon(
        polygonId: PolygonId("polygon2"),
        fillColor: Colors.purple,
        strokeColor: Colors.orange,
        strokeWidth: 10,
        points: [
          LatLng(-23.561629, -46.653031),
          LatLng(-23.565189, -46.651872),
          LatLng(-23.562032, -46.650831),
        ],
        consumeTapEvents: true,
        onTap: () {
          print("Clicado na areá marcada");
        },
        zIndex: 0,
        );

    listaPolygon.add(polygon1);
    listaPolygon.add(polygon2);
    setState(() {
      _polygons = listaPolygon;
    });*/
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
